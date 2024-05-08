Unit ssLameLoader;



Interface
Uses Windows, Classes;



{$IFDEF FPC}
 {$mode delphi}{$H+}
{$ENDIF}




Type
 TlxLoaderInternalExportItem = record
  Name  : string;
  Index : Cardinal;
  VA    : Cardinal;
 End;

 TlxLoaderInternalExportList = Array Of TlxLoaderInternalExportItem;




Type
 TlxLibraryLoader = class
 Protected
  FHandle : Cardinal;
  FSize   : Cardinal;
  FName   : String;
  FExport : TlxLoaderInternalExportList;
  FEntryA : Function(H:HMODULE; dwReason: DWord; lpvReserved:Pointer):Boolean;stdcall;
 Public
  Function    ExportByName(const FunctionName:String):Pointer;
  Function    ExportByOrd(IndexOrd:Cardinal):Pointer;
  //
  Procedure   LoadFromStream(Stream:TStream);
  Procedure   LoadFromFile(const AFileName:String);
  //
  Procedure   Attach;
  Procedure   Detach;
  Procedure   Clear;
  //
  Constructor Create;
  Destructor  Free;
  //
  Property    ExportList:TlxLoaderInternalExportList Read FExport;
  Property    Handle:Cardinal Read FHandle;
  Property    LibraryName:String Read FName;
  Property    ModuleSize:Cardinal Read FSize;
 End;







Type
 TnxLibraryLoader = class
 private
  FHandle : Pointer;
  FSize   : Int64;
 public
  Procedure LoadFromMemory(const AMemory : Pointer; const ASize:Int64);
  Procedure LoadFromFile(const AFileName : string);
  Procedure Clear;
  Constructor Create;
  Destructor  Free;
 end;







implementation
uses SysUtils;




{===============================PROCEDURE==================================}

Procedure TnxLibraryLoader.LoadFromMemory(const AMemory : Pointer; const ASize:Int64);
begin

end;

{===============================PROCEDURE==================================}

Procedure TnxLibraryLoader.LoadFromFile(const AFileName : string);
var
 Buffer : TMemoryStream;
begin
 Clear;
 Buffer:=TMemoryStream.Create;
 try
  LoadFromMemory(Buffer.Memory, Buffer.Size);
 finally
  Buffer.Free;
 end;
end;

{===============================PROCEDURE==================================}

Procedure TnxLibraryLoader.Clear;
begin
 If Assigned(FHandle) Then VirtualFree(FHandle, 0, MEM_RELEASE);
end;

{===============================PROCEDURE==================================}

Constructor TnxLibraryLoader.Create;
begin
 Clear;
end;

{===============================PROCEDURE==================================}

Destructor TnxLibraryLoader.Free;
begin
 Clear;
end;

{===============================PROCEDURE==================================}

Function hookGetModuleFileNameW(hModule: HINST; lpFilename: PWideChar; nSize: DWORD): DWORD; stdcall;
begin
 Result:=GetModuleFileNameW(hModule, lpFilename, nSize);
 If Result>0 Then Exit;
 Result:=GetModuleFileNameW(0, lpFilename, nSize);
end;

{===============================PROCEDURE==================================}

Function hookGetProcAddress(hModule: HMODULE; lpProcName: LPCSTR): FARPROC; stdcall;
begin
 Result:= GetProcAddress(hModule, lpProcName);
 If Result=GetProcAddress(GetModuleHandle(PChar(kernel32)), 'GetModuleFileNameW')
  Then Result:=@hookGetModuleFileNameW;
end;

{===============================PROCEDURE==================================}

Function ThreadLibraryAttach(Param:TlxLibraryLoader):Integer;stdcall;
begin
 Result:=0;
 Try
  Param.FEntryA(Cardinal(Param.FHandle), DLL_PROCESS_ATTACH, nil);
 Except
   Result:=-1;
 End;
end;

{===============================PROCEDURE==================================}

Procedure TlxLibraryLoader.Detach;
Begin
 If (FHandle=0) or (not Assigned(FEntryA)) Then Exit;
 FEntryA(Integer(FHandle), DLL_PROCESS_DETACH, NIL);
End;

{===============================PROCEDURE==================================}

Procedure TlxLibraryLoader.Attach;
Var
 T,E,D  : Cardinal;
Begin
 If (FHandle=0) or (not Assigned(FEntryA)) Then Exit;
 T:=CreateThread(nil, 0, @ThreadLibraryAttach, Self, 0, D);
 While True Do
  Begin
   GetExitCodeThread(T,E);
   If E<>STILL_ACTIVE Then Break Else Sleep(1);
  End;
End;

{===============================PROCEDURE==================================}

Function TlxLibraryLoader.ExportByOrd(IndexOrd:Cardinal):Pointer;
Var
 I : Integer;
 E : TlxLoaderInternalExportItem;
Begin
 Result:=NIL;
 If Length(FExport)=0 Then Exit;
 For I:=Low(FExport) To High(FExport) Do
  Begin
   E:=FExport[I];
   If E.Index=IndexOrd Then Exit(Pointer(E.VA+Cardinal(FHandle)));
  End;
End;

{===============================PROCEDURE==================================}

Function TlxLibraryLoader.ExportByName(const FunctionName:String):Pointer;
Var
 I : Integer;
 E : TlxLoaderInternalExportItem;
Begin
 Result:=NIL;
 If Length(FExport)=0 Then Exit;
 For I:=Low(FExport) To High(FExport) Do
  Begin
   E:=FExport[I];
   If SameText(E.Name, FunctionName)=True Then Exit(Pointer(E.VA+Cardinal(FHandle)));
  End;
End;

{===============================PROCEDURE==================================}

Procedure TlxLibraryLoader.LoadFromStream(Stream : TStream);
Var
 MZ     : TImageDosHeader;
 NT     : TImageNtHeaders;
 Sec    : TImageSectionHeader;
 mzPos, zPos  : Int64;
 MaxRead, I, J : Integer;
 B : Byte;
 rProcessRelocs : Boolean;
 rRelocVA : Cardinal;
 rSec : TImageSectionHeader;
 Reloc  : packed Record
  VA   : Cardinal;
  Size : Cardinal;
 End;
 RelocData : Word;
 DeltaReloc : Cardinal;
 iSec : TImageSectionHeader;
 iPorcessImport : Boolean;
 ImportDir : TImageImportDescriptor;
 iImportVA, iIATva : Cardinal;
 iLibrary : Cardinal;
 iName : string;
 eExportItem : TlxLoaderInternalExportItem;
 eNameTable   : Cardinal;
 eOrdTable    : Integer;
 eVATable     : Cardinal;
 eOfsPtr      : Cardinal;
 eIED         : TImageExportDirectory;
 eSec         : TImageSectionHeader;
 eExportVA    : Cardinal;
 eProcessExport : Boolean;
 // hooks
 H1, H2 : Cardinal;
 P : Cardinal;
Begin
 Clear;
 H1:=Cardinal(GetProcAddress(GetModuleHandle(PChar(kernel32)), 'GetModuleFileNameW'));
 H2:=Cardinal(GetProcAddress(GetModuleHandle(PChar(kernel32)), 'GetProcAddress'));
 mzPos:=Stream.Position;
 Stream.ReadBuffer(MZ, SizeOf(MZ));
 Stream.Position:= mzPos + MZ._lfanew;
 Stream.ReadBuffer(NT, SizeOf(NT));
 FSize:=NT.OptionalHeader.SizeOfImage;
 FHandle:=Cardinal(VirtualAlloc(nil, FSize, MEM_COMMIT, PAGE_EXECUTE_READWRITE));
 Stream.Position:=mzPos;
 Stream.ReadBuffer(Pointer(FHandle)^, NT.OptionalHeader.SizeOfHeaders);
 Stream.Position:=mzPos + MZ._lfanew + NT.FileHeader.SizeOfOptionalHeader+
                  4 {SizeOfSignature} + SizeOf(NT.FileHeader);
 rRelocVA:=NT.OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_BASERELOC].VirtualAddress;
 iImportVA:=NT.OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_IMPORT].VirtualAddress;
 eExportVA:=NT.OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_EXPORT].VirtualAddress;
 rProcessRelocs:=False;
 iPorcessImport:=False;
 eProcessExport:=False;

 For I:=1 To NT.FileHeader.NumberOfSections Do
  Begin
   Stream.ReadBuffer(Sec, SizeOf(Sec));

   If rRelocVA<>0 then
    begin
     If (rRelocVA>=Sec.VirtualAddress) and (rRelocVA<=Sec.VirtualAddress+Sec.Misc.VirtualSize) then
      begin
       If (Sec.SizeOfRawData>0) and (Sec.PointerToRawData>0) then
        begin
         rProcessRelocs:=True;
         rSec:=Sec;
        end;
      end;
    end;

   If iImportVA<>0 then
    begin
     If (iImportVA>=Sec.VirtualAddress) and (iImportVA<=Sec.VirtualAddress+Sec.Misc.VirtualSize) then
      begin
       If (Sec.SizeOfRawData>0) and (Sec.PointerToRawData>0) then
        begin
         iPorcessImport:=True;
         iSec:=Sec;
        end;
      end;
    end;

   If eExportVA<>0 then
    begin
     If (eExportVA>=Sec.VirtualAddress) and (eExportVA<=Sec.VirtualAddress+Sec.Misc.VirtualSize) then
      begin
       If (Sec.SizeOfRawData>0) and (Sec.PointerToRawData>0) then
        begin
         eProcessExport:=True;
         eSec:=Sec;
        end;
      end;
    end;

   If (Sec.SizeOfRawData<>0) and (Sec.PointerToRawData<>0) Then
    Begin
     zPos:=Stream.Position;
     If mzPos+Sec.PointerToRawData<Stream.Size Then
      Begin
       Stream.Position:=mzPos+Sec.PointerToRawData;
       MaxRead:=Sec.SizeOfRawData;
       If Stream.Position+MaxRead>Stream.Size Then MaxRead:=Stream.Size-Stream.Position;
       If MaxRead>Sec.Misc.VirtualSize Then MaxRead:=Sec.Misc.VirtualSize;
       If MaxRead>0 Then
        Stream.ReadBuffer(Pointer(FHandle+Sec.VirtualAddress)^, MaxRead);
      End;
     Stream.Position:=zPos;
    End;
  End;
 DeltaReloc:=FHandle-NT.OptionalHeader.ImageBase;
 If rProcessRelocs = True Then
  Begin
   Try
    zPos:=rSec.PointerToRawData+(rRelocVA-rSec.VirtualAddress);
    Stream.Position:=zPos;
    While True do
     begin
      if Stream.Position-zPos>=NT.OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_BASERELOC].Size
       Then Break;
      Stream.ReadBuffer(Reloc, SizeOf(Reloc));
      MaxRead:=(Reloc.Size-SizeOf(Reloc)) div 2;
      For I:=1 To MaxRead Do
       begin
        Stream.ReadBuffer(RelocData, 2);
        If RelocData and $F000 <> 0 Then
         Inc(PCardinal(FHandle+Reloc.VA+(RelocData and $0FFF))^, DeltaReloc);
       end;
     end;
   Except
   end;
  End;
 If iPorcessImport = True then
  begin
   iIATva:=NT.OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_IAT].VirtualAddress;
   If iIATva<>0 Then iIATva:=iIATva+FHandle;
   If NT.OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_BOUND_IMPORT].VirtualAddress=0 Then
    iIATva:=0;

   Try
    Stream.Position:=iSec.PointerToRawData+(iImportVA-iSec.VirtualAddress);
    While True do
     begin
      Stream.ReadBuffer(ImportDir,SizeOf(ImportDir));
      If ImportDir.Name=0 Then Break;

      zPos:=Stream.Position;
      Stream.Position:=ImportDir.Name-iSec.VirtualAddress+iSec.PointerToRawData;
      iName:='';
      While True Do
       Begin
        Stream.ReadBuffer(B, 1);
        If B=0 Then Break;
        iName:=iName + Chr(B);
       End;
      iLibrary:=LoadLibrary(PChar(iName));
      If ImportDir.TimeDateStamp<>$FFFFFFFF Then
       mzPos:=ImportDir.FirstThunk-iSec.VirtualAddress+iSec.PointerToRawData
      Else
       mzPos:=ImportDir.Characteristics-iSec.VirtualAddress+iSec.PointerToRawData;

      While True Do
       Begin
        Stream.Position:=mzPos;
        Stream.ReadBuffer(I ,4);
        If I=0 Then Break;

        If (I And $80000000)<>0 Then
         Begin
          P:=Cardinal(GetProcAddress(iLibrary, PChar(I And $FFFF)));
         End
        Else
         Begin
          Stream.Position:=Cardinal(I)-iSec.VirtualAddress+iSec.PointerToRawData+2;
          iName:='';
          While True Do
           Begin
            Stream.ReadBuffer(B, 1);
            If B=0 Then Break;
            iName:=iName + Chr(B);
           End;
          P:=Cardinal(GetProcAddress(iLibrary, PChar(iName)));
         End;
        If P=H1 Then P:=Cardinal(@hookGetModuleFileNameW);
        If P=H2 Then P:=Cardinal(@hookGetProcAddress);
        PCardinal(mzPos-iSec.PointerToRawData+FHandle+iSec.VirtualAddress)^:=P;
        If iIATva>0 Then
         begin
          PCardinal(iIATva)^:=P;
          Inc(iIATva, 4);
         end;
        Inc(mzPos,4);
       End;
      Stream.Position:=zPos;
     End;
   Except
   end;
  end;
 If eProcessExport = True then
  begin
   Try
    Stream.Position:=eSec.PointerToRawData+(eExportVA-eSec.VirtualAddress);
    Stream.ReadBuffer(eIED, SizeOf(eIED));
    If eIED.Name<>0 Then
     Begin
      Stream.Position:=eIED.Name-eSec.VirtualAddress+eSec.PointerToRawData;
      FName:='';
      While True do
       begin
        Stream.ReadBuffer(B, 1);
        If B=0 Then Break;
        FName:=FName+Chr(B);
       end;
     End;
    If eIED.NumberOfNames<>0 Then
     Begin
      eNameTable:=Cardinal(eIED.AddressOfNames);
      eOrdTable :=Cardinal(eIED.AddressOfNameOrdinals);
      eVATable:=Cardinal(eIED.AddressOfFunctions);

      For I:=0 To eIED.NumberOfNames-1 Do
       Begin
        Stream.Position:=eNameTable-eSec.VirtualAddress+eSec.PointerToRawData;
        Stream.ReadBuffer(eOfsPtr, 4);
        Stream.Position:=eOfsPtr-eSec.VirtualAddress+eSec.PointerToRawData;
        iName:='';
        While True do
         begin
          Stream.ReadBuffer(B, 1);
          If B=0 Then Break;
          iName:=iName+Chr(B);
         end;
        Inc(eNameTable,4);
        SetLength(FExport, Length(FExport)+1);
        J:=High(FExport);
        FExport[J].Name:=iName;
        Stream.Position:=eOrdTable-eSec.VirtualAddress+eSec.PointerToRawData;
        Stream.ReadBuffer(RelocData, 2);
        FExport[J].Index:=RelocData+eIED.Base;
        Inc(eOrdTable,2);
        Stream.Position:=eVATable+(FExport[J].Index-eIED.Base)*4-eSec.VirtualAddress+eSec.PointerToRawData;
        Stream.ReadBuffer(FExport[J].VA, 4);
       End;
     End;
   Except
   end;
  end;


 FEntryA:=Pointer(NT.OptionalHeader.AddressOfEntryPoint+Cardinal(FHandle));
End;

{===============================PROCEDURE==================================}

Procedure TlxLibraryLoader.LoadFromFile(const AFileName:String);
Var
 Stream: TStream;
Begin
 Clear;
 If FileExists(AFileName)=False Then Exit;
 Stream := TFileStream.Create(AFileName, fmOpenRead or fmShareDenyWrite);
 Try
   LoadFromStream(Stream);
 Finally
   Stream.Free;
 End;
End;

{===============================PROCEDURE==================================}

Procedure TlxLibraryLoader.Clear;
Begin
 If FHandle<>0 Then VirtualFree(Pointer(FHandle), 0, MEM_RELEASE);
 SetLength(FExport, 0);
 FHandle:=0;
 FSize:=0;
 FEntryA:=NIL;
 FName:='';
End;

{===============================PROCEDURE==================================}

Constructor TlxLibraryLoader.Create;
Begin
 Clear;
End;

{===============================PROCEDURE==================================}

Destructor TlxLibraryLoader.Free;
Begin
 Clear;
End;

{===============================PROCEDURE==================================}





End.


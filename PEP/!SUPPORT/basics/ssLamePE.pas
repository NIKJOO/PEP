Unit ssLamePE;




Interface
Uses Windows, SysUtils, Classes, System.Generics.Collections;




Type
 TSectionFlag = (lsfPacked, lsfDelete, lsfZero, lsfMarker, lsfCopy);
 TSectionFlags = Set Of TSectionFlag;

 


Type
 TpxExeSection = Class (TMemoryStream)   
 Protected
  FUData1   : Int64;
  FFlag     : TSectionFlags;
  //
  Function    GetName:String;
  Procedure   SetName(const V:String);
  Function    GetVS:UInt64;
  Procedure   SetVS(V:UInt64);
  Function    GetVA:UInt64;
  Procedure   SetVA(V:UInt64);
 Public
  Header      :TImageSectionHeader;
  Function    ReadByte: Byte;
  Function    ReadWord: Word;
  Function    ReadInt : Integer;
  Function    ReadCardinal :Cardinal;
  Function    ReadInt64 :Int64;
  Function    ReadPCharZ:String;
  Procedure   WriteRandom(Sz:Integer);
  Procedure   WriteZero(Sz:Integer);
  Procedure   WriteByte(B:Byte);
  Procedure   WriteWord(W:Word);
  Procedure   WriteInt(I:Integer);
  Procedure   WriteInt64(I64:Int64);
  Procedure   WriteAnsiString(const S:AnsiString);
  Function    CanReadBytes(nSize:Integer):Boolean;
  Procedure   Zero;
  Procedure   Random;
  Function    VirtualOfs:Int64;
  Procedure   Align(A:Integer);
  Constructor Create;
  Property    UserData : Int64 Read FUData1 Write FUData1;
  Property    Name     : String Read GetName Write SetName;
  Property    VA       : UInt64 Read GetVA Write SetVA;
  Property    VSize    : UInt64  Read GetVS Write SetVS;
  Property    Flags    : TSectionFlags Read FFlag Write FFlag;
 End;








Type
 TpxWindowsImportFunction = Class
  ByOrdinal : Boolean;
  Name      : String;
  Ordinal   : Int64;
  Ofs       : Int64;   
  OfsSection: TpxExeSection;
  OfsVA     : UInt64; 
  User      : Int64;  
  BoundIAT  : Int64;
 End;


Type
 TpxWindowsImportLibrary = Class
 private
  Type
   TpxWindowsImportFunctions = TList<TpxWindowsImportFunction>;
 public
  Tag  : Int64; 
  Data : Int64; 
  Name : String;
  List : TpxWindowsImportFunctions;
  Procedure Clear;
  Constructor Create;
  Destructor Free;
 End;



Type
 TpxWindowsPEExportFunction = Record
  Name  : String;
  Ord   : UInt64;
  VA    : UInt64;
  User  : UInt64; 
  OfsVA : UInt64; 
 End;
 TpxWindowsPEExportList = Array Of TpxWindowsPEExportFunction;





Type
 TpxWindowsPERelocation = Record
  RelocType  : Int64;
  Relocation : UInt64;
 end;





Type
 TpxExeLoader = Class
 Protected
  Type
   TpxWindowsRelocationTable = TList<TpxWindowsPERelocation>;
   TpxWindowsSections = TList<TpxExeSection>;
   TpxWindowsImport = TList<TpxWindowsImportLibrary>;
  Var
   FSections   : TpxWindowsSections;
   FImport     : TpxWindowsImport;
   FImportSize : Int64;
   FImportOfs  : Int64;
   FIAT        : Int64;
   FIATSize    : Int64;
   FExport     : TpxWindowsPEExportList;
   FExportOfs  : Int64;
   FExportName : String;

   FSImportSection   : TpxExeSection;
   FSExportSection   : TpxExeSection;
   FSResourceSection : TpxExeSection;
   FSRelocSection    : TpxExeSection;
   FSEntrySection    : TpxExeSection;
   FCodeSection      : TpxExeSection;

   FSaveOverlay      : Boolean;
   FOverlayOffset    : Int64;
   FOverlay          : TMemoryStream;
   FRelocations : TpxWindowsRelocationTable;

  Procedure   LoadImportTable(FillIt:Boolean=False; FillRandom:Boolean=False);
  Procedure   LoadExportTable(ZeroIt:Boolean=False);
  Procedure   LoadRelocTable;
 Public
  MZ         : TImageDosHeader;
  NT         : TImageNtHeaders;
  NT64       : TImageNtHeaders64;
  ExportEntry: TImageExportDirectory;
  Procedure   ClearExportTable(RndItem:Boolean=False); 
  Function    ExportByName(const Name:String):UInt64; 
  Function    ExportByOrd(Ord:UInt64):UInt64;  
  Procedure   ClearImportTable(RndItem:Boolean=False); 
  Function    ImportByVA(VA:UInt64):TpxWindowsImportFunction; 
  Function    FindImportLibrary(const Name:String):TpxWindowsImportLibrary;overload; 
  Function    FindImportLibrary(Fun:TpxWindowsImportFunction):TpxWindowsImportLibrary;overload; 
  Function    ImportFunctionCount:Integer; 
  Function    RelocInVA(AInstructionVA, AInstructionSz: UInt64):Integer; 
  Procedure   StripReloc(ASetHeaderFlag:Boolean=True); 
  Function    DataEntry(aEntry:Integer):TImageDataDirectory; 
  Procedure   SetDataEntry(aEntry:Integer; const inData:TImageDataDirectory); 
  Function    CopyResourcesData(M:TStream):Integer; 
  //
  Function    IsLibrary:Boolean; 
  Function    IsNET:Boolean; 
  Function    IsX64:Boolean; 
  Function    ModuleBase:UInt64; 
  Function    ModuleSize:UInt64; 
  Function    SecAligment:UInt64; 
  Function    FirstSection:TpxExeSection; 
  Function    LastSection:TpxExeSection;  
  Function    SectionByVA(VA:UInt64):TpxExeSection; 
  Function    VAInSection(VA:UInt64):TpxExeSection; 
  Function    SectionIndex(SecObject:TpxExeSection):Integer; 
  Function    SectionByName(const Name:String):TpxExeSection; 
  Function    NewSection:TpxExeSection; 
  Procedure   OptimizeSections; 
  Procedure   AlignSections; 
  Procedure   DeleteSection(const Name:String);overload; 
  Procedure   AlignSection(Sec: TpxExeSection); 
  Procedure   PreloadMudule(nMem:Pointer; wSectionData:Boolean=False); 
  Procedure   LoadFromStream(Stream:TStream); 
  Procedure   SaveToStream(Stream:TStream); 
  Procedure   SaveToFile(const AFileName:String); 
  Procedure   LoadFromFile(const AFileName:String); 
  Procedure   Clear;         
  Constructor Create;        
  Destructor  Free;          

  Property    CodeSection:TpxExeSection Read FCodeSection;
  Property    ImportSection:TpxExeSection Read FSImportSection;
  Property    ExportSection:TpxExeSection Read FSExportSection;
  Property    ResourceSection:TpxExeSection Read FSResourceSection;
  Property    RelocSection:TpxExeSection Read FSRelocSection;
  Property    EntrySection:TpxExeSection Read FSEntrySection;
  //
  Property    IAT:Int64 Read FIAT;
  Property    IATSize:Int64 Read FIATSize;
  Property    ExportList:TpxWindowsPEExportList Read FExport;
  Property    ExportName:String Read FExportName;
  Property    ExportOfs:Int64 Read FExportOfs;
  Property    ImportOfs:Int64 Read FImportOfs;
  // overlay
  Property    Overlay : TMemoryStream Read FOverlay;
  Property    OverlayRAWOffset : Int64 Read FOverlayOffset;
  Property    SaveOverlay:Boolean Read FSaveOverlay Write FSaveOverlay;
  //
  property    Relocations : TpxWindowsRelocationTable read FRelocations;
  property    Sections : TpxWindowsSections Read FSections;
  property    Import : TpxWindowsImport Read FImport;
 End;







 

const
 IMAGE_DLLCHARACTERISTICS_NO_SEH =  $0400;












Implementation
Uses ssMemory, ssLameCrypt, Math;


Const
 Const_DosStub : Array[0..56] of Byte=
 (
  $0E, $1F, $BA, $0E, $00, $B4, $09, $CD, $21, $B8, $01, $4C, $CD, $21, $54, $68,
  $69, $73, $20, $70, $72, $6F, $67, $72, $61, $6D, $20, $63, $61, $6E, $6E, $6F,
  $74, $20, $62, $65, $20, $72, $75, $6E, $20, $69, $6E, $20, $44, $4F, $53, $20,
  $6D, $6F, $64, $65, $2E, $0D, $0A, $24, $00
  );



{===============================PROCEDURE==================================}

Procedure TpxWindowsImportLibrary.Clear;
Var
 I : Integer;
begin
 For I:=0 To List.Count-1 Do List[I].Free;
 List.Clear;
end;

{===============================PROCEDURE==================================}

Constructor TpxWindowsImportLibrary.Create;
begin
 List:= TpxWindowsImportFunctions.Create;
 Clear;
end;

{===============================PROCEDURE==================================}

Destructor TpxWindowsImportLibrary.Free;
begin
 Clear;
 List.Free;
end;

{===============================PROCEDURE==================================}

Function TpxExeLoader.ExportByOrd(Ord:UInt64):UInt64;
Var
 I : Integer;
 E : TpxWindowsPEExportFunction;
Begin
 Result:=0;
 If Length(FExport)=0 Then Exit;
 For I:=Low(FExport) To High(FExport) Do
  Begin
   E:=FExport[I];
   If E.Ord=Ord Then  Exit(E.VA);
  End;
End;

{===============================PROCEDURE==================================}

Function TpxExeLoader.ExportByName(const Name:String):UInt64;
Var
 I : Integer;
 E : TpxWindowsPEExportFunction;
Begin
 Result:=0;
 If Length(FExport)=0 Then Exit;
 For I:=Low(FExport) To High(FExport) Do
  Begin
   E:=FExport[I];
   If SameText(E.Name,Name)=True Then  Exit(E.VA);
  End;
End;

{===============================PROCEDURE==================================}

Function TpxExeLoader.ImportByVA(VA:UInt64):TpxWindowsImportFunction;
Var
 I,J : Integer;
 F : TpxWindowsImportFunction;
Begin
 Result:=NIL;
 For I:=0 to FImport.Count-1 Do
  Begin
   For J:=0 To FImport[I].List.Count-1 Do
    Begin
     F:=FImport[I].List[J];
     If VA=F.OfsVA Then
      Begin
       Result:=F;
       Exit;
      End;
    End;
  End;
End;

{===============================PROCEDURE==================================}

Function TpxExeLoader.ImportFunctionCount:Integer;
Var
 I,J : Integer;
 L : TpxWindowsImportLibrary;
Begin
 Result:=0;
 For I:=0 To FImport.Count-1 Do
  Begin
   L:=FImport[I];
   For J:=0 To L.List.Count-1 Do Inc(Result);
  End;
end;

{===============================PROCEDURE==================================}

Function TpxExeLoader.NewSection:TpxExeSection;
Var
 Last:TpxExeSection;
Begin
 Result:=TpxExeSection.Create;
 Last:=LastSection;
 FSections.Add(Result);
 Result.Header.Characteristics:=IMAGE_SCN_MEM_EXECUTE or IMAGE_SCN_MEM_WRITE or IMAGE_SCN_MEM_READ;
 If Last=NIL Then Exit;
 Result.VA:=Last.VA+Last.Header.Misc.VirtualSize;
 If IsX64 = False Then Result.VA:=vxAlignOffset(Result.VA,NT.OptionalHeader.SectionAlignment)
  else Result.VA:=vxAlignOffset(Result.VA,NT64.OptionalHeader.SectionAlignment);
End;

{===============================PROCEDURE==================================}

Function TpxExeLoader.FirstSection:TpxExeSection;
Begin
 Result:=FSections.First;
End;

{===============================PROCEDURE==================================}

Function TpxExeLoader.LastSection:TpxExeSection;
Begin
 Result:=FSections.Last;
End;

{===============================PROCEDURE==================================}

Function TpxExeLoader.SectionByVA(VA:UInt64):TpxExeSection;
Var
 I : Integer;
Begin
 For I:=0 To FSections.Count-1 Do
  Begin
   If FSections[I].VA=VA Then Exit(FSections[I]);
  End;
 Result:=NIL;
End;

{===============================PROCEDURE==================================}

Function TpxExeLoader.VAInSection(VA:UInt64):TpxExeSection;
Var
 I:Integer;
Begin
 Result:=NIL;
 If FSections.Count=0 Then Exit;
 Result:=SectionByVA(VA);
 If Result<>NIL Then Exit;
 For I:=0 To FSections.Count-1 Do
  Begin
   Result:=FSections[I];
   If (VA>=Result.VA) And (VA<=Result.VA+Result.VSize) Then Exit;
  End;
 Result:=NIL;
End;

{===============================PROCEDURE==================================}

Function TpxExeLoader.RelocInVA(AInstructionVA, AInstructionSz: UInt64):Integer;
Var
 I, Z:Integer;
begin
 For I:=0 to FRelocations.Count-1 do
  begin
   Z:= FRelocations[I].Relocation - AInstructionVA;
   If (Z<0) or (Z>AInstructionSz) Then Continue;
   Exit(I);
  end;
 Result:=-1;
end;

{===============================PROCEDURE==================================}

Function TpxExeLoader.SectionByName(const Name:String):TpxExeSection;
Var
 I : Integer;
Begin
 Result:=NIL;
 If FSections.Count=0 Then Exit;
 For I:=0 To FSections.Count-1 Do
  Begin
   Result:=FSections[I];
   If SameText(Result.Name,Name) Then Exit;
  End;
 Result:=NIL;
End;

{===============================PROCEDURE==================================}

Function TpxExeLoader.SectionIndex(SecObject:TpxExeSection):Integer;
Begin
 Result:=-1;
 If FSections.Count=0 Then Exit;
 For Result:=0 To FSections.Count-1 Do
  If SecObject=FSections[Result] Then Exit;
 Result:=-1; 
End;

{===============================PROCEDURE==================================}

Function TpxExeLoader.DataEntry(aEntry:Integer):TImageDataDirectory;
Begin
 If IsX64 = False Then
  Result:=NT.OptionalHeader.DataDirectory[aEntry]
 Else
  Result:=NT64.OptionalHeader.DataDirectory[aEntry];
End;

{===============================PROCEDURE==================================}

Procedure TpxExeLoader.SetDataEntry(aEntry:Integer; const inData:TImageDataDirectory);
begin
 If IsX64 = False Then NT.OptionalHeader.DataDirectory[aEntry]:=inData
  Else NT64.OptionalHeader.DataDirectory[aEntry]:=inData;
end;

{===============================PROCEDURE==================================}

Procedure TpxExeLoader.DeleteSection(const Name:String);
Var
 S:TpxExeSection;
 I:Integer;
begin
 S:=SectionByName(Name);
 If S=NIL Then Exit;
 I:=SectionIndex(S);
 S.Free;
 If I<>-1 Then FSections.Delete(I);
end;

{===============================PROCEDURE==================================}

Procedure TpxExeLoader.SaveToFile(const AFileName:String);
Var
 Stream: TStream;
Begin
 Stream := TFileStream.Create(AFileName,fmCreate);
 Try
   SaveToStream(Stream);
 Finally
   Stream.Free;
 End;
End;

{===============================PROCEDURE==================================}

Procedure TpxExeLoader.LoadFromFile(const AFileName:String);
Var
 Stream: TStream;
Begin
 Clear;
 If FileExists(AFileName)=False Then Exit;
 Stream := TFileStream.Create(AFileName,fmOpenRead or fmShareDenyWrite);
 Try
   LoadFromStream(Stream);
 Finally
   Stream.Free;
 End;
End;

{===============================PROCEDURE==================================}

Procedure TpxExeLoader.LoadFromStream(Stream:TStream);
Var
 StartPos,FixPos :Int64;
 I        : Integer;
 S        : TpxExeSection;
 Max      : Integer;
 Entry    : TImageDataDirectory;
 LastOver : Int64;
Begin
 Clear;
 StartPos:=Stream.Position;
 Stream.ReadBuffer(MZ,SizeOf(MZ));
 If MZ.e_magic<>IMAGE_DOS_SIGNATURE Then
  Raise Exception.Create(IntToHex(MZ.e_magic,0)+'<!=!>'+IntToHex(IMAGE_DOS_SIGNATURE,0));
 Stream.Position:=Stream.Position-SizeOf(MZ)+MZ._lfanew;
 Stream.ReadBuffer(NT,SizeOf(NT));
 If NT.Signature<>IMAGE_NT_SIGNATURE Then
  Raise Exception.Create(IntToHex(NT.Signature,8)+'<!=!>'+IntToHex(IMAGE_NT_SIGNATURE,8));

 If NT.OptionalHeader.Magic=IMAGE_NT_OPTIONAL_HDR64_MAGIC Then
  begin
   Stream.Position:=Stream.Position-SizeOf(NT);
   Stream.ReadBuffer(NT64,SizeOf(NT64));
   Stream.Position:=StartPos+MZ._lfanew+NT64.FileHeader.SizeOfOptionalHeader+
                    4 {SizeOfSignature} + SizeOf(NT64.FileHeader);
  end
 Else
   Stream.Position:=StartPos+MZ._lfanew+NT.FileHeader.SizeOfOptionalHeader+
                    4 {SizeOfSignature} + SizeOf(NT.FileHeader);
 LastOver:=-1;
 If NT.FileHeader.NumberOfSections<>0 Then
  For I:=1 To NT.FileHeader.NumberOfSections Do
   Begin
     S:=TpxExeSection.Create;
     Stream.ReadBuffer(S.Header,SizeOf(S.Header));
     // If S.Header.VirtualAddress=0 Then Break;
     If (S.Header.SizeOfRawData<>0) And (S.Header.PointerToRawData<>0) Then
      Begin
       FixPos:=Stream.Position;
       If StartPos+S.Header.PointerToRawData<Stream.Size Then
        Begin
         Stream.Position:=StartPos+S.Header.PointerToRawData;
         Max:=S.Header.SizeOfRawData;
         If Stream.Position+Max>Stream.Size Then Max:=Stream.Size-Stream.Position;
         If Max>0 Then S.CopyFrom(Stream,Max);
        End;
       S.Position:=0;
       LastOver:=Stream.Position;
       Stream.Position:=FixPos;
      End;
     FSections.Add(S);
   End;

 If (FSaveOverlay=True) and (FSections.Count<>0) Then
  Begin
   If LastOver=-1 Then
    begin
     If IsX64 = False Then
      LastOver:=NT.OptionalHeader.SizeOfHeaders+StartPos
     else
      LastOver:=NT64.OptionalHeader.SizeOfHeaders+StartPos;
     If LAstOver=0 Then LastOver:=-1;
    end;
   If (LastOver<>-1) and (LastOver<Stream.Size) Then
    Try // to load overlay
     FOverlayOffset:=LastOver;
     Stream.Position:=FOverlayOffset;
     FOverlay.CopyFrom(Stream,Stream.Size-Stream.Position);
    Except
    End;
  End;

 // import
 Entry:=DataEntry(IMAGE_DIRECTORY_ENTRY_IMPORT);
 If (Entry.VirtualAddress<>0) Then
   FSImportSection:=VAInSection(Entry.VirtualAddress);


 // iat
 Entry:=DataEntry(IMAGE_DIRECTORY_ENTRY_IAT);
 If (Entry.VirtualAddress<>0) Then
  Begin
   FIAT:=Entry.VirtualAddress;
   FIATSize:=Entry.Size;
  End;

 // export
 Entry:=DataEntry(IMAGE_DIRECTORY_ENTRY_EXPORT);
 If (Entry.VirtualAddress<>0)Then
   FSExportSection:=VAInSection(Entry.VirtualAddress);


 // resources
 Entry:=DataEntry(IMAGE_DIRECTORY_ENTRY_RESOURCE);
 If (Entry.VirtualAddress<>0) Then
   FSResourceSection:=VAInSection(Entry.VirtualAddress);


 // relocs
 Entry:=DataEntry(IMAGE_DIRECTORY_ENTRY_BASERELOC);
 If (Entry.VirtualAddress<>0) Then
   FSRelocSection:=VAInSection(Entry.VirtualAddress);


 // entry
 If IsX64 = False then
  begin
   FSEntrySection:=VAInSection(NT.OptionalHeader.AddressOfEntryPoint);
   FCodeSection:=VAInSection(NT.OptionalHeader.BaseOfCode);
  end
 Else
  begin
   FSEntrySection:=VAInSection(NT64.OptionalHeader.AddressOfEntryPoint);
   FCodeSection:=VAInSection(NT64.OptionalHeader.BaseOfCode);
  end;
 If FCodeSection=NIL Then FCodeSection:=FSEntrySection;
 

 Try
  LoadImportTable;
 Except
  // nothing if import is bad
 End;

 Try
  LoadExportTable;
 Except
  // nothing if import is bad
 End;

 Try
  LoadRelocTable;
 Except
  // nothing if import is bad
 End;
End;

{===============================PROCEDURE==================================}

Function TpxExeLoader.FindImportLibrary(const Name:String):TpxWindowsImportLibrary;
Var
 I:Integer;
Begin
 Result:=NIL;
 For I:=0 To FImport.Count-1 Do
  Begin
   Result:=FImport[I];
   If SameText(Name,Result.Name)=True Then Exit;
  End;
 Result:=NIL;
End;

{===============================PROCEDURE==================================}

Function TpxExeLoader.FindImportLibrary(Fun:TpxWindowsImportFunction):TpxWindowsImportLibrary;
Var
 I,J : Integer;
 F   : TpxWindowsImportFunction;
Begin
 Result:=NIL;
 For I:=0 To FImport.Count-1 Do
  Begin
   Result:=FImport[I];
   For J:=0 To Result.List.Count-1 Do
    begin
     F:=Result.List[J];
     If (F.Ofs=Fun.Ofs) and (F.OfsVA=Fun.OfsVA) Then Exit;
    end;
  End;
 Result:=NIL;
end;

{===============================PROCEDURE==================================}

Procedure TpxExeLoader.ClearImportTable(RndItem:Boolean=False);
Begin
 LoadImportTable(True,RndItem);
End;

{===============================PROCEDURE==================================}

Procedure TpxExeLoader.ClearExportTable(RndItem:Boolean=False);
Begin
 LoadExportTable(RndItem);
End;

{===============================PROCEDURE==================================}

Procedure TpxExeLoader.LoadRelocTable;
Var
 zPos : Int64;
 I, MaxRead : Integer;
 Reloc  : packed Record
  VA   : Cardinal;
  Size : Cardinal;
 End;
 RelocsSize: UInt64;
 RelocData : Word;
 TheReloc : TpxWindowsPERelocation;
begin
 FRelocations.Clear;
 If RelocSection = nil Then Exit;
 RelocSection.Position:=DataEntry(IMAGE_DIRECTORY_ENTRY_BASERELOC).VirtualAddress-
    RelocSection.VA;
 zPos:=RelocSection.Position;
 RelocsSize:=DataEntry(IMAGE_DIRECTORY_ENTRY_BASERELOC).Size;
 While True do
  begin
   If RelocSection.Position-zPos>=RelocsSize Then Break;
   If RelocSection.CanReadBytes(SizeOf(Reloc))=False Then Break;
   RelocSection.ReadBuffer(Reloc, SizeOf(Reloc));
   MaxRead:=(Reloc.Size-SizeOf(Reloc)) div 2;
   For I:=1 To MaxRead Do
    begin
     If RelocSection.CanReadBytes(2)=False Then Break;
     RelocSection.ReadBuffer(RelocData, 2);
     case Integer(RelocData shr 12) of
      0 {IMAGE_REL_BASED_ABSOLUTE}: Continue; // padding
      3 {IMAGE_REL_BASED_HIGHLOW}:
       begin
        TheReloc.RelocType:=4;
        TheReloc.Relocation:=Reloc.VA+(RelocData and $FFF);
       end;
      10 {IMAGE_REL_BASED_DIR64}:
       begin
        TheReloc.RelocType:=8;
        TheReloc.Relocation:=Reloc.VA+(RelocData and $FFF);
       end;
      Else Continue; // ignore all other
     end;
     FRelocations.Add(TheReloc);
    end;
  end;
end;

{===============================PROCEDURE==================================}

Procedure TpxExeLoader.LoadExportTable(ZeroIt:Boolean=False);
Var
 I, J : Integer;
 NameTable   : Integer;
 OrdTable    : Integer;
 VATable     : Integer;
 OfsPtr      : Integer;
Begin
 FExportOfs:=0;
 ZeroMemory(@ExportEntry, SizeOf(ExportEntry));
 If ExportSection=NIL Then Exit;
 FExportOfs:=DataEntry(IMAGE_DIRECTORY_ENTRY_EXPORT).VirtualAddress-
    ExportSection.VA;
 ExportSection.Position:=FExportOfs;

 ExportSection.Read(ExportEntry, SizeOf(ExportEntry));

 If ExportEntry.Name<>0 Then
  Begin
   ExportSection.Position:=ExportEntry.Name-ExportSection.VA;
   FExportName:=ExportSection.ReadPCharZ;
  End;

 If ExportEntry.NumberOfNames<>0 Then
  Begin
   NameTable:=Integer(ExportEntry.AddressOfNames);
   OrdTable :=Integer(ExportEntry.AddressOfNameOrdinals);
   VATable:=Integer(ExportEntry.AddressOfFunctions);

   For I:=0 To ExportEntry.NumberOfNames-1 Do
    Begin
     SetLength(FExport, Length(FExport)+1);
     J:=High(FExport);
     ExportSection.Position:=NameTable-ExportSection.VA;
     OfsPtr:=ExportSection.ReadInt;
     ExportSection.Position:=OfsPtr-ExportSection.VA;
     FExport[J].Name:=ExportSection.ReadPCharZ;

     Inc(NameTable,4);
     ExportSection.Position:=OrdTable-ExportSection.VA;
     FExport[J].Ord:=ExportSection.ReadWord+ExportEntry.Base;
     Inc(OrdTable,2);
     ExportSection.Position:=VATable+(FExport[J].Ord-ExportEntry.Base)*4-ExportSection.VA;
     FExport[J].OfsVA:=ExportSection.VirtualOfs;
     FExport[J].VA:=ExportSection.ReadInt;
    End;
  End;
End;

{===============================PROCEDURE==================================}

Procedure TpxExeLoader.LoadImportTable(FillIt:Boolean=False; FillRandom:Boolean=False);
Label SkipNameEnum;
Var
 PImportLibrary  : TpxWindowsImportLibrary;
 PImportFunction : TpxWindowsImportFunction;
 ImportItem      : TImageImportDescriptor;
 S               : String;
 B               : Byte;
 Ofs, L          : UInt64;
 LSection, ISection : TpxExeSection;
 xRead, K, P, CounterOfIAT, ImportIterator : Int64;
Begin
 FImportOfs:=0;
 If ImportSection=NIL Then Exit;

 FImportOfs:=DataEntry(IMAGE_DIRECTORY_ENTRY_IMPORT).VirtualAddress-
             ImportSection.VA;
 FImportSize:=DataEntry(IMAGE_DIRECTORY_ENTRY_IMPORT).Size;
 ImportSection.Position:=FImportOfs;

 while True do
  Begin
   ZeroMemory(@ImportItem, SizeOf(ImportItem));
   xRead:=ImportSection.Read(ImportItem, SizeOf(ImportItem));
   If FillIt=True Then
    begin
     ImportSection.Position:=ImportSection.Position-xRead;
     If FillRandom=True Then ImportSection.WriteRandom(xRead)
      Else ImportSection.WriteZero(xRead);
    end;

   If xRead=0 Then Break; 
   If (ImportItem.Characteristics=0) and (ImportItem.OriginalFirstThunk=0) and
      (ImportItem.TimeDateStamp=0) and (ImportItem.ForwarderChain=0) and
      (ImportItem.Name=0) and (ImportItem.FirstThunk=0) Then Break; //zero item
   If ImportItem.Name=0 Then ImportItem.Name:=ImportSection.VA;

   K:=ImportSection.Position;

   LSection:=VAInSection(ImportItem.Name);
   If LSection = nil Then Continue; // WTF?
   LSection.Position:=ImportItem.Name-LSection.VA;
   S:='';
   While True Do
    Begin
     B:=0; 
     xRead:=LSection.Read(B, 1);

     If FillIt=True Then
      begin
       LSection.Position:=LSection.Position-xRead;
       If FillRandom=True Then LSection.WriteRandom(xRead)
        Else LSection.WriteZero(xRead);
      end;

     If B=0 Then Break;
     S:=S+Chr(B);
    End;

   If FillIt=False Then
   Begin
    PImportLibrary:=FindImportLibrary(S);
    If PImportLibrary=NIL Then
     Begin
      PImportLibrary:=TpxWindowsImportLibrary.Create;
      PImportLibrary.Name:=S;
      FImport.Add(PImportLibrary);
     End;
   End Else PImportLibrary:=NIL;


   Ofs:=ImportItem.OriginalFirstThunk;


   ISection:=VAInSection(Ofs);
   If ISection=nil Then
    begin
     Ofs:=ImportItem.FirstThunk;
     ISection:=VAInSection(Ofs);
     If ISection=nil Then Goto SkipNameEnum;
    end;
   Ofs:=Ofs-ISection.VA;
   CounterOfIAT:=0;
   If ImportItem.FirstThunk<>0 Then CounterOfIAT:=ImportItem.FirstThunk;

   While True Do
    Begin
     ISection.Position:=Ofs;

     L:=0;

     If IsX64 = False Then xRead:=ISection.Read(L, 4)
      Else xRead:=ISection.Read(L, 8);

     If FillIt=True Then
      begin
       ISection.Position:=ISection.Position-xRead;
       If FillRandom=True Then ISection.WriteRandom(xRead)
        Else ISection.WriteZero(xRead);
      end;                            
     If L=0 Then Break;

     PImportFunction:=TpxWindowsImportFunction.Create;

     If CounterOfIAT<>0 Then
      begin
       PImportFunction.BoundIAT:=CounterOfIAT;
       If IsX64=False Then Inc(CounterOfIAT,4) Else Inc(CounterOfIAT,8);
      end;

     PImportFunction.OfsSection:=ISection;
     PImportFunction.Ofs:=Ofs;
     PImportFunction.OfsVA:=Ofs+ISection.VA;

     P:=IMAGE_ORDINAL_FLAG32;
     If IsX64 Then P:=IMAGE_ORDINAL_FLAG64;
     If (L And P)<>0 Then
      Begin
       PImportFunction.ByOrdinal:=True;
       PImportFunction.Ordinal:=L And $FFFF;
      End
     Else
      Begin
       PImportFunction.ByOrdinal:=False;
       PImportFunction.Ordinal:=0;

       LSection:=VAInSection(L);
       If LSection=nil then
        begin
         PImportFunction.ByOrdinal:=True;
         PImportFunction.Ordinal:=L; // what a ?
        end
       else
        begin
         P:=LSection.Position;
         LSection.Position:=L-LSection.VA+2;
         S:='';
         While True Do
          Begin

           B:=0;
           xRead:=LSection.Read(B, 1);

           If FillIt=True Then
            begin
             LSection.Position:=LSection.Position-xRead;
             If FillRandom=True Then LSection.WriteRandom(xRead)
              Else LSection.WriteZero(xRead);
            end;
           If B=0 Then Break;
           S:=S+Chr(B);
          End;
         PImportFunction.Name:=S;
         LSection.Position:=P;
        end;
      End;

     If FillIt = False Then PImportLibrary.List.Add(PImportFunction);

     If IsX64 = False then Inc(Ofs,4) Else Inc(Ofs, 8);
    End;
   SkipNameEnum:
    ImportSection.Position:=K;
  End;
End;

{===============================PROCEDURE==================================}

Procedure TpxExeLoader.OptimizeSections;
Var
 I,K : Integer;
 S   : TpxExeSection;
 B   : Byte;
Begin
 If FSections.Count=0 Then Exit;
 For I:=0 To FSections.Count-1 Do
  Begin
   S:=FSections[I];
   If S.Size=0 Then Continue;
   For K:=S.Size DownTo 1 Do
    Begin
     S.Position:=K-1;
     B:=S.ReadByte;
     If B<>0 Then Break;
    End;
   S.Size:=K;
  End;
End;

{===============================PROCEDURE==================================}

Procedure TpxExeLoader.AlignSections;
Var
 I : Integer;
 S : TpxExeSection;
Begin
 If FSections.Count=0 Then Exit;
 For I:=0 To FSections.Count-1 Do
  Begin
   S:=FSections[I];
   AlignSection(S);
  End;
end;

{===============================PROCEDURE==================================}

Function TpxExeLoader.CopyResourcesData(M:TStream):Integer;
Var
 Entry : TImageDataDirectory;
 Restore : Int64;
Begin
 Result:=0;
 If FSResourceSection=NIL Then Exit;
 Entry:=DataEntry(IMAGE_DIRECTORY_ENTRY_RESOURCE);
 Entry.VirtualAddress:=Entry.VirtualAddress-FSResourceSection.VA;
 If Entry.Size>Entry.VirtualAddress+FSResourceSection.Size Then
  Entry.Size:=FSResourceSection.Size-Entry.VirtualAddress;
 If (Entry.Size=0) or (Entry.Size>FSResourceSection.Size) Then Exit;
 Result:=Entry.Size;
 Restore:=FSResourceSection.Position;
 FSResourceSection.Position:=Entry.VirtualAddress;
 M.CopyFrom(FSResourceSection,Entry.Size);
 FSResourceSection.Position:=Restore;
End;

{===============================PROCEDURE==================================}

Function TpxExeLoader.ModuleBase:UInt64;
Begin
 If IsX64 = False Then Result:=NT.OptionalHeader.ImageBase
  Else Result:=NT64.OptionalHeader.ImageBase;
End;

{===============================PROCEDURE==================================}

Function TpxExeLoader.IsLibrary:Boolean;
Begin
 If IsX64 = False Then
  begin
 If (NT.FileHeader.Characteristics And IMAGE_FILE_DLL)=IMAGE_FILE_DLL Then
  Result:=True Else Result:=False;
  end
 Else
  begin
   If (NT64.FileHeader.Characteristics And IMAGE_FILE_DLL)=IMAGE_FILE_DLL Then
    Result:=True Else Result:=False;
  end;
End;

{===============================PROCEDURE==================================}

Function TpxExeLoader.IsX64:Boolean;
Begin
 If (NT.FileHeader.Machine = $8664) or
    (NT.OptionalHeader.Magic = IMAGE_NT_OPTIONAL_HDR64_MAGIC) Then
  Result:=True Else Result:=False;
End;

{===============================PROCEDURE==================================}

Function TpxExeLoader.IsNET:Boolean;
begin
 If FindImportLibrary('mscoree.dll')<>nil Then Exit(True) Else Exit(False);
end;

{===============================PROCEDURE==================================}

Function TpxExeLoader.ModuleSize:UInt64;
Begin
 If IsX64 = False Then Result:=NT.OptionalHeader.SizeOfImage
  Else Result:=NT64.OptionalHeader.SizeOfImage;
End;

{===============================PROCEDURE==================================}

Function TpxExeLoader.SecAligment:UInt64;
begin
 Result:=NT.OptionalHeader.SectionAlignment;
end;

{===============================PROCEDURE==================================}

Procedure TpxExeLoader.StripReloc(ASetHeaderFlag:Boolean=True);
Begin
  If ASetHeaderFlag = True Then
     NT.FileHeader.Characteristics:=NT.FileHeader.Characteristics or IMAGE_FILE_RELOCS_STRIPPED;
   NT.OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_BASERELOC].VirtualAddress:=0;
   NT.OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_BASERELOC].Size:=0;
End;

{===============================PROCEDURE==================================}

Procedure TpxExeLoader.AlignSection(Sec: TpxExeSection);
Var
 AL : UInt64;
begin
 If Sec.Header.Misc.VirtualSize=0 Then Sec.Header.Misc.VirtualSize:=Sec.Size;
 AL:=NT.OptionalHeader.SectionAlignment;
 Sec.Header.Misc.VirtualSize:=vxAlignOffset(Sec.Header.Misc.VirtualSize, AL);
end;

{===============================PROCEDURE==================================}

Procedure TpxExeLoader.PreloadMudule(nMem:Pointer; wSectionData:Boolean=False);
Var
 I,P   : Integer;
 S     : TpxExeSection;
 nSize : UInt64;
 PMZ   : PImageDosHeader;
 PNT   : PImageNtHeaders;
 PNT64 : PImageNtHeaders64;
 nOfs  : Pointer;
 Sz64  : Int64;
Begin
 nSize:=ModuleSize;
 ZeroMemory(nMem,nSize);
 PMZ:=nMem;
 PMZ.e_magic:=MZ.e_magic;
 PMZ._lfanew:=MZ._lfanew;

 If IsX64 = False then
  begin
   PNT:=vxPtr(PMZ, PMZ._lfanew);
   PNT.Signature:=NT.Signature;

   PNT.OptionalHeader.Magic:=NT.OptionalHeader.Magic;
   PNT.OptionalHeader.MajorOperatingSystemVersion:=NT.OptionalHeader.MajorOperatingSystemVersion;
   PNT.OptionalHeader.MinorOperatingSystemVersion:=NT.OptionalHeader.MinorOperatingSystemVersion;
   PNT.OptionalHeader.MajorSubsystemVersion:=NT.OptionalHeader.MajorSubsystemVersion;
   PNT.OptionalHeader.MinorSubsystemVersion:=NT.OptionalHeader.MinorSubsystemVersion;
   PNT.OptionalHeader.Win32VersionValue:=NT.OptionalHeader.Win32VersionValue;
   PNT.OptionalHeader.SizeOfImage:=NT.OptionalHeader.SizeOfImage;
   PNT.OptionalHeader.Subsystem:=NT.OptionalHeader.Subsystem;

   PNT.OptionalHeader.AddressOfEntryPoint:=NT.OptionalHeader.AddressOfEntryPoint;

   PNT.OptionalHeader.SizeOfStackReserve:=NT.OptionalHeader.SizeOfStackReserve;
   PNT.OptionalHeader.SizeOfStackCommit:=NT.OptionalHeader.SizeOfStackCommit;
   PNT.OptionalHeader.SizeOfHeapReserve:=NT.OptionalHeader.SizeOfHeapReserve;
   PNT.OptionalHeader.SizeOfHeapCommit:=NT.OptionalHeader.SizeOfHeapCommit;

   PNT.OptionalHeader.NumberOfRvaAndSizes:=NT.OptionalHeader.NumberOfRvaAndSizes;
   PNT.OptionalHeader.DataDirectory:=NT.OptionalHeader.DataDirectory;
   If wSectionData=True Then
    Begin
     PNT.FileHeader.NumberOfSections:=NT.FileHeader.NumberOfSections;
     P:=Integer(PNT)+NT.FileHeader.SizeOfOptionalHeader+
                    4 {SizeOfSignature} + SizeOf(NT.FileHeader);
    End Else P:=0;
  end;



 If FSections.Count<>0 Then
  For I:=0 To FSections.Count-1 Do
   Begin
    S:=FSections[I];
    If wSectionData=True Then
     Begin
      CopyMemory(Pointer(P),@S.Header,SizeOf(S.Header));
      Inc(P,SizeOf(S.Header));
     End;

    nOfs:=vxPtr(nMem, S.VA);
    S.Position:=0;
    Sz64:=S.Size;
    If S.VSize<Sz64 Then Sz64:=S.VSize;
    
    S.ReadBuffer(nOfs^,Sz64);
   End;
End;

{===============================PROCEDURE==================================}

Procedure TpxExeLoader.SaveToStream(Stream:TStream);
Var
 StartPos,FixPos,DataPos,DataFix : Int64;
 ImgSize,CodeSize,iDataSize,uDataSize : Int64;
 SecAlign, FileAlign : UInt64;
 I:Integer;
 S:TpxExeSection;
 RndB : Byte;
Begin
 CodeSize:=0;
 iDataSize:=0;
 uDataSize:=0;
 ImgSize:=0;
 
 StartPos:=Stream.Position;

 If (MZ._lfanew=0) or (MZ._lfanew<SizeOf(MZ)+SizeOf(Const_DosStub)) Then
  MZ._lfanew:=SizeOf(MZ)+SizeOf(Const_DosStub);
 

 Stream.WriteBuffer(MZ,SizeOf(MZ));
 Stream.WriteBuffer(Const_DosStub,SizeOf(Const_DosStub));

 RndB:=0;
 While Stream.Position<>StartPos+MZ._lfanew Do Stream.WriteBuffer(RndB, 1);

   NT.OptionalHeader.FileAlignment:=$200;
   NT.FileHeader.NumberOfSections:=FSections.Count;
   NT.FileHeader.SizeOfOptionalHeader:=SizeOf(NT.OptionalHeader);
   FixPos:=Stream.Position;
   Stream.WriteBuffer(NT,SizeOf(NT));
   SecAlign:=NT.OptionalHeader.SectionAlignment;
   FileAlign:=NT.OptionalHeader.FileAlignment;

 If FSections.Count<>0 Then
  Begin
   For I:=0 To FSections.Count-1 Do
    Begin
     S:=FSections[I];
     Stream.WriteBuffer(S.Header,SizeOf(S.Header));
     Inc(ImgSize, vxAlignOffset(S.Header.Misc.VirtualSize,SecAlign));
     If (S.Header.Characteristics And IMAGE_SCN_MEM_EXECUTE) <> 0 Then
      Begin
       Inc (CodeSize, vxAlignOffset(S.Header.Misc.VirtualSize,FileAlign));
      End
     Else
      If (S.Header.Characteristics And IMAGE_SCN_CNT_INITIALIZED_DATA) <> 0 Then
        Inc (iDataSize, vxAlignOffset(S.Header.Misc.VirtualSize,FileAlign))
      Else
       If (S.Header.Characteristics And IMAGE_SCN_CNT_UNINITIALIZED_DATA) <> 0 Then
          Inc (uDataSize, vxAlignOffset(S.Header.Misc.VirtualSize,FileAlign));
    End;
   // Write section data 
   DataPos:=vxAlignOffset(Stream.Position,FileAlign);

   RndB:=0;
   While Stream.Position<>DataPos Do Stream.WriteBuffer(RndB, 1);


   For I:=0 To FSections.Count-1 Do
    Begin
     S:=FSections[I];
     DataFix:=vxAlignOffset(Stream.Position,FileAlign);

     If S.Size<>0 Then
      Begin
       RndB:=0;
       While Stream.Position<>DataFix Do Stream.WriteBuffer(RndB, 1);

       S.Header.PointerToRawData:=DataFix+StartPos;
       S.Header.SizeOfRawData:=S.Size;
       Stream.Position:=DataFix;
       Stream.WriteBuffer(S.Memory^,S.Size);
      End
     Else
      Begin
       S.Header.PointerToRawData:=0;  // DataFix   loader change this to 0
       S.Header.SizeOfRawData:=0;
      End;
    End;

   If (FSaveOverlay=True) and (FOverlay.Size<>0) Then
    Begin
     FOverlayOffset:=vxAlignOffset(Stream.Position,FileAlign);
     Stream.Position:=FOverlayOffset;
     Stream.WriteBuffer(FOverlay.Memory^,FOverlay.Size); 
    End;

   Stream.Position:=FixPos;

   If IsX64 = False then
    begin
     NT.OptionalHeader.SizeOfHeaders:=DataPos-StartPos;
     NT.OptionalHeader.SizeOfImage:=
        vxAlignOffset(ImgSize +NT.OptionalHeader.SizeOfHeaders,SecAlign);
     Stream.WriteBuffer(NT,SizeOf(NT));
    end
   Else
    begin
     NT64.OptionalHeader.SizeOfHeaders:=DataPos-StartPos;
     NT64.OptionalHeader.SizeOfImage:=
        vxAlignOffset(ImgSize +NT64.OptionalHeader.SizeOfHeaders,SecAlign);
     Stream.WriteBuffer(NT64,SizeOf(NT64));
    end;


   For I:=0 To FSections.Count-1 Do
    Begin
     S:=FSections[I];
     Stream.WriteBuffer(S.Header,SizeOf(S.Header));
    End;
  End;
End;

{===============================PROCEDURE==================================}

Procedure TpxExeLoader.Clear;
Var
 I : Integer;
Begin
 FSImportSection   :=NIL;
 FSExportSection   :=NIL;
 FSResourceSection :=NIL;
 FSRelocSection    :=NIL;
 FSEntrySection    :=NIL;
 FCodeSection      :=NIL;

 FOverlay.Clear;
 FOverlayOffset:=-1;
 FSaveOverlay:=True;

 FExportName:='';
 FExportOfs:=0;
 FImportOfs:=0;
 FImportSize:=0;
 FillChar(MZ,SizeOf(MZ),0);
 FillChar(NT,SizeOf(NT),0);
 FillChar(NT64,SizeOf(NT64),0);
 FIAT:=0;
 FIATSize:=0;

 FRelocations.Clear;
 SetLength(FExport, 0);
 For I:=0 To FImport.Count-1 Do FImport[I].Free;
 FImport.Clear;

 For I:=0 To FSections.Count-1 Do FSections[I].Free;
 FSections.Clear;
End;

{===============================PROCEDURE==================================}

Constructor TpxExeLoader.Create;
Begin
 FRelocations:=TpxWindowsRelocationTable.Create;
 FSections:=TpxWindowsSections.Create;
 FOverlay:=TMemoryStream.Create;
 FImport:=TpxWindowsImport.Create;
 Clear;
 FSaveOverlay:=True;
End;

{===============================PROCEDURE==================================}

Destructor TpxExeLoader.Free;
Begin
 Clear;
 FOverlay.Free;
 FSections.Free;
 FRelocations.Free;
 FImport.Free;
End;

{===============================PROCEDURE==================================}

Function TpxExeSection.GetName:String;
Var
 A : AnsiString;
Begin
 SetLength(A,8);
 Move(Header.Name[0], A[1],8);
 Result:=Trim(A);
End;

{===============================PROCEDURE==================================}

Procedure TpxExeSection.SetName(const V:String);
Var
 R : AnsiString;
Begin
 FillChar(Header.Name[0],SizeOf(Header.Name),0);
 If V='' Then Exit;
 R:=Copy(V, 1, 7);
 Move(R[1],Header.Name[0], Length(R));
End;

{===============================PROCEDURE==================================}

Function TpxExeSection.ReadByte  :Byte;
Begin
 ReadBuffer(Result,1);
End;

{===============================PROCEDURE==================================}

Function TpxExeSection.ReadWord  :Word;
Begin
 ReadBuffer(Result,2);
End;

{===============================PROCEDURE==================================}

Function TpxExeSection.ReadInt   :Integer;
Begin
 ReadBuffer(Result,4);
End;

{===============================PROCEDURE==================================}

Function TpxExeSection.ReadCardinal :Cardinal;
begin
 ReadBuffer(Result,4);
end;

{===============================PROCEDURE==================================}

Function TpxExeSection.ReadInt64 :Int64;
Begin
 ReadBuffer(Result,8);
End;

{===============================PROCEDURE==================================}

Function TpxExeSection.ReadPCharZ:String;
Var
 B : Byte;
Begin
 Result:='';
 While True Do
  Begin
   If CanReadBytes(1)=False Then Break;
   B:=ReadByte;
   If B=0 Then Break;
   Result:=Result+Chr(B);
  End;
End;

{===============================PROCEDURE==================================}

Function TpxExeSection.CanReadBytes(nSize:Integer):Boolean;
begin
 Result:=True;
 If Position+nSize>Size Then Result:=False;
end;

{===============================PROCEDURE==================================}

Procedure TpxExeSection.WriteByte(B:Byte);
Begin
 WriteBuffer(B,1);
End;

{===============================PROCEDURE==================================}

Procedure TpxExeSection.WriteRandom(Sz:Integer);
begin
 While Sz<>0 Do
  begin
   WriteByte(System.Random(MaxByte));
   Sz:=Sz-1;
  end;
end;

{===============================PROCEDURE==================================}

Procedure TpxExeSection.WriteZero(Sz:Integer);
begin
 While Sz<>0 Do
  begin
   WriteByte(0);
   Sz:=Sz-1;
  end;
end;

{===============================PROCEDURE==================================}

Procedure TpxExeSection.WriteAnsiString(const S:AnsiString);
Var
 L:Integer;
Begin
 L:=Length(S);
 If L=0 Then Exit;
 WriteBuffer(S[1], L);
end;

{===============================PROCEDURE==================================}

Procedure TpxExeSection.WriteWord(W:Word);
Begin
 WriteBuffer(W,2);
End;

{===============================PROCEDURE==================================}

Procedure TpxExeSection.WriteInt(I:Integer);
Begin
 WriteBuffer(I,4);
End;

{===============================PROCEDURE==================================}

Procedure TpxExeSection.WriteInt64(I64:Int64);
Begin
 WriteBuffer(I64,8);
End;

{===============================PROCEDURE==================================}

Constructor TpxExeSection.Create;
Begin
 inherited Create;
 FillChar(Header,SizeOf(Header),0);
End;

{===============================PROCEDURE==================================}

Function  TpxExeSection.GetVS:UInt64;
Begin
 Result:=Header.Misc.VirtualSize;
End;

{===============================PROCEDURE==================================}

Procedure TpxExeSection.SetVS(V:UInt64);
Begin
 Header.Misc.VirtualSize:=V;
End;

{===============================PROCEDURE==================================}

Function TpxExeSection.GetVA:UInt64;
Begin
 Result:=Header.VirtualAddress;
End;

{===============================PROCEDURE==================================}

Procedure TpxExeSection.SetVA(V:UInt64);
Begin
 Header.VirtualAddress:=V;
End;

{===============================PROCEDURE==================================}

Procedure TpxExeSection.Zero;
Begin
 If Size<>0 Then FillChar(Memory^,Size,0);
End;

{===============================PROCEDURE==================================}

Procedure TpxExeSection.Align(A:Integer);
begin
 While (Size mod A <>0) do WriteByte(0);
end;

{===============================PROCEDURE==================================}

Procedure TpxExeSection.Random;
Var
 P:Int64;
Begin
 If Size=0 Then Exit;
 Randomize;
 P:=Position;
 While Position<>Size Do
  WriteByte(System.Random(255));
 Position:=P;
End;

{===============================PROCEDURE==================================}

Function TpxExeSection.VirtualOfs:Int64;
Begin
 Result:=Header.VirtualAddress+Position;
End;

{===============================PROCEDURE==================================}




End.

unit ProtectUnit;

(*     ===========================================   *)
(*     =====  Copyright by SetiSoft (c) Tech =====   *)
(*     =====       All rights reserved !     =====   *)
(*     =====          2003  -  2013          =====   *)
(*     ===========================================   *)
(*     =====    Internet: www.setisoft.com   =====   *)
(*     =====    E-Mail: setisoft@gmail.com   =====   *)
(*     ===========================================   *)

//     -------------------------------------------   //
//      This source code is a part of PEP project    //
//     -------------------------------------------   //


interface
Uses Classes, ssLameLoader, ssLameCrypt, ssStore;


// TODO:[M] Enable or Disable [DEBUG]
{-$UNDEF DEBUG}



{--$DEFINE DBG}
{$DEFINE Unsafe35VirtualMachine}


Const
 // [ version info ]
 ProgramVer    = 4;
 ProgramSubVer = 2;
 ProgramSP     = '.2 ';
 // [ help files ]
 fnGStore   = 'store.in';
 fnHelp_en  = 'help\index.htm';



Var
  Path   : String   = '';
  GStore : TMemoryStore = nil;








Type
 TFileProject = Record
  FileName      : String;
  AppName       : String;
  AppVer        : String;
  HomePage      : String;
  AllowMsg      : Boolean;
  AntiDebug     : Boolean;
  SameSize      : Boolean;
  AntiDump      : Boolean;
  StolenRC      : Boolean;
  RequestAdminR : Boolean;
  MsgDbg        : String;
  MsgSKey       : String;
  MsgEDate      : String;
  MsgNotAdmin   : String;
  ExitIfNoKey   : Boolean;
  ExpiredDate   : TDateTime;
  PurchasePage  : String;
  PrivateKey    : TameRSAKey;
  PublicKey     : TameRSAKey;
  PrivateRC4    : TameRSABytes;
  nagDialog     : String;
  nagLicenseID  : String;
  nagActivateKey: String;
  nagText       : String;
  nagHelp       : String;
  nagOK         : String;
  nagBuy        : String;
  nagUserName   : String;
  StdNAG        : Boolean;
  BlackList     : String;
  ProjectFile   : String; 
  UseExecLimit : Boolean;
  ExecLimit : Integer;
  UseOneCopy : Boolean;
  HwidMode : Integer;
  MsgCrCfail    : string;
  MsgCopyLimit  : string;
  MsgClockMan   : string;
  MsgTECount    : string;
  MsgTDCount    : string;
  MsgExecLimit  : string;
  UseDayLimit  : Boolean;
  DayLimit     : Integer;
  UseExecCount : Boolean;
  ExecCount    : Integer;
  kgO1 : string;
  kgO2 : string;
  kgO3 : string;
  kgO4 : string;
  kgO5 : string;
  kgO6 : string;
  kgO7 : string;
  kgO8 : string;
  DisableCompression : Boolean;
  IncreaseFileSize   : Boolean;
  nagBackColor : Cardinal;
  nagFontColor : Cardinal;
  nagTextAlign : Integer;
  nagDelay     : Integer;
  licKeyPath : string;
 End;








Type
 TLogProcedure=Procedure(const T:String);

Function ProtectFile(Option:TFileProject;Log:TLogProcedure):Integer;
Function ppFile(Option:TFileProject;Log:TLogProcedure):Integer;


implementation
Uses Windows, SysUtils, Math, StrUtils, ssLamePE, ssMemory, ssVM, HandleUnit
     {$ifdef Unsafe35VirtualMachine},Unsafe35vm, ssLamePCode{$endif};



Var
  UserHooks : TStringList;
  ResHooks  : TStringList;
  ppiHooks  : TStringList;
  InvisibleLibrarys : TStringList;





{===============================PROCEDURE==================================}

Function ProtectFile(Option:TFileProject;Log:TLogProcedure):Integer;
Var
 Mem : TvxMemoryStream;
 FasmLibrary : TlxLibraryLoader;
begin
 FasmLibrary:=TlxLibraryLoader.Create;
 Mem:=TvxMemoryStream.Create(GStore.VarBuf(0,7), GStore.VarSize(0,7));
 FasmLibrary.LoadFromStream(Mem);
 Mem.Free;
 FasmLibrary.Attach;
 Fasm:=FasmLibrary.ExportByName('aline');
 Dasm:=vxAllocMem(GStore.VarSize(0,1));
 Move(GStore.VarBuf(0,1)^, Dasm^, GStore.VarSize(0,1));
 Result:=ppFile(Option, Log);
 vxFreeMem(Dasm);
 FasmLibrary.Detach;
 FasmLibrary.Free;
end;

{===============================PROCEDURE==================================}

Function ppFile(Option:TFileProject;Log:TLogProcedure):Integer;
Var
 C64 : TConstQWord;
 I64, J64 : Int64;
 C32 : TConstDWord;
 Origin, Resources, pepLibrary : TpxExeLoader;
 Code, Section, Bss, Lss : TpxExeSection;
 SectionSet : TList;
 TlsSectionData64 : TImageTLSDirectory64;
 TlsOriginData64  : TImageTLSDirectory64;
 TlsSectionData32 : TImageTLSDirectory32;
 TlsOriginData32  : TImageTLSDirectory32;
 TheReloc : TpxWindowsPERelocation;
 varTlsCopy, varTempLEP : TCodeTreeItem;
 varTLSData, varCRYPTO_STOP   : TCodeTreeItem;
 vaStaticIni, vaEngineRelocs  : TCodeTreeItem;
 vaVirtualDLL : TCodeTreeItem;
 vaStolenPCode, vaStolenChain : TCodeTreeItem;
 Tree : TCodeTree;
 imageVA : TConstQWord;
 vapepLoader : TConstQWord;
 AsmMode : TUniAsmMode;
 Stream  : TMemoryStream;
 Statica : TMemoryStore;
 VirtualDLLva : TConstQWord;
 ResourceSnap : TList;
 Lines, Tables : TMemoryStoreIntArray;
 LoaderInfoTable : TLoaderInfoTable;
 BytesArray : TameRSABytes;
 iFunction : TpxWindowsImportFunction;
 iLibrary  : TpxWindowsImportLibrary;
 ImportItem : TImageImportDescriptor;
 ImportName, ImportOrd : String;
 vaKernelLibraryName,vaAVScanner : TConstQWord;
 xRndArray, xRndArray2 : TvxArray;
 BlackList : TStringList;
 Buf : Pointer;
 UFM, XFM : TUniversalAsmLanguage;
 ufReg1, ufReg2, ufReg3, ufReg4, ufReg5 : String;
 StolenHolder : TProcedureHolder;
 HoldItem : PHolderItem;
 VirtualTable : TMemoryStream;
 VirtualItem : TVirtualTableItem;
 valueIsReloc : Boolean;
 I, K, J, Size : Integer;
 rndI, rndJ : Integer;
 ApplicationUNC : TConstQWord;
 CorXorConst : Int64;
 {$ifdef Unsafe35VirtualMachine}
 PCodeCmd : PvmCmd;
 VMACmd   : TvmCmd;
 {$endif}
Begin
 If Trim(Option.AppName)='' Then Option.AppName:='Unknown';
 If Trim(Option.AppVer)='' Then Option.AppVer:='1.0';
 Randomize;
 ImportName:=Option.FileName+'.bak';
 Log(Language.ui(36)+' ('+ExtractFileName(ImportName)+')');
 If FileExists(ImportName)=True Then DeleteFile(ImportName);
 CopyFile(PChar(Option.FileName),PChar(ImportName),False);
 Log('');
 Log(' - '+DateTimeToStr(Now));

Try
 Origin:=TpxExeLoader.Create;
 Origin.LoadFromFile(Option.FileName);

 ResourceSnap:=TList.Create;
 CreateResourceSnapShort(Option.FileName, ResourceSnap);
 AsmMode:=uaX32;
  Origin.MZ._lfanew:=RandomFrom([$80, $100]);
  With Origin.NT Do
     Begin
      FileHeader.NumberOfSections:=RandomRange($FF,MaxWord);
      FileHeader.TimeDateStamp:=Random(MaxInt)+1;
      FileHeader.PointerToSymbolTable:=Random(MaxInt)+1;
      FileHeader.NumberOfSymbols:=Random(MaxInt)+1;
      OptionalHeader.MajorLinkerVersion:=Random(9)+1;
      OptionalHeader.MinorLinkerVersion:=Random(99)+1;
      OptionalHeader.NumberOfRvaAndSizes:=RandomRange(255,MaxLongint);
      OptionalHeader.SizeOfHeapReserve:=
         vxAlignOffset(RandomRange(OptionalHeader.SizeOfHeapReserve, 2*OptionalHeader.SizeOfHeapReserve), $1000);
      OptionalHeader.SizeOfHeapCommit:=
         vxAlignOffset(RandomRange(OptionalHeader.SizeOfHeapCommit, 2*OptionalHeader.SizeOfHeapCommit), $1000);
      OptionalHeader.SizeOfStackReserve:=
         vxAlignOffset(RandomRange(OptionalHeader.SizeOfStackReserve, 2*OptionalHeader.SizeOfStackReserve), $1000);
      OptionalHeader.SizeOfStackCommit:=
         vxAlignOffset(RandomRange(OptionalHeader.SizeOfStackCommit, 2*OptionalHeader.SizeOfStackCommit), $1000);
      OptionalHeader.CheckSum:=0;
      OptionalHeader.MajorImageVersion:=Random(9)+1;
      OptionalHeader.MinorImageVersion:=Random(99)+1;
   end;
 

  CorXorConst:=RandomRange(MAXWORD, MaxInt);
  ZeroMemory(@LoaderInfoTable, SizeOf(LoaderInfoTable));
  imageVA:=Origin.ModuleBase;
  LoaderInfoTable.ib:=imageVA;

 I64:=$20000; 
 If Origin.ModuleSize<I64 Then
  begin
   Bss:=Origin.NewSection;
   Bss.Header.Characteristics:= IMAGE_SCN_MEM_EXECUTE;
   Bss.Header.Misc.VirtualSize:=vxAlignOffset(I64-Origin.ModuleSize,Origin.SecAligment);
  end;

  Bss:=NIL;


 Statica:=TMemoryStore.Create;
 Statica.VarW[0,0]  := Trim(Option.AppName+' '+Option.AppVer);
 ImportName:=Trim(UpperCase(WideUpperCase(Option.AppName)));
 ImportName:=ReplaceText(ImportName, ' ', '');
 ApplicationUNC:=ameStringCrC(ImportName);
 Statica.VarC64[0,1]:= ApplicationUNC;
 Statica.VarW[0,2]  := Option.HomePage;
 Statica.VarW[0,3]  := Option.PurchasePage;
 Statica.VarB[0,4]  := Option.RequestAdminR;
 Statica.VarB[0,5]  := Option.UseExecLimit;
 Statica.VarC64[0,6]:= Option.ExecLimit * 1000; 
 Statica.VarB[0,7]  := Option.UseOneCopy;   
 Statica.VarI64[0,8]:= Option.HwidMode;
 Statica.VarC64[0,9]:=DateTimeToUnix(Now)-86400; 
 Statica.VarC64[0,10]:=0;
 If Option.ExpiredDate<>0 Then
  Statica.VarC64[0,10] := DateTimeToUnix(Option.ExpiredDate); 
 Statica.VarW[0,11] := 'license.bin';
 Statica.VarB[0,12] := Option.ExitIfNoKey;
 Statica.VarB[0,13] := Option.UseDayLimit;
 Statica.VarI64[0,14] := Option.DayLimit;
 Statica.VarB[0,15]   := Option.UseExecCount;
 Statica.VarI64[0,16] := Option.ExecCount;
 Statica.VarB[0,17] := Option.AntiDebug;  
 rc4key(BytesArray, 1024); 
 Statica.WriteBinary(0, 18, @BytesArray[0], Length(BytesArray));
 rc4freekey(BytesArray);
 If Origin.IsX64 = False Then Statica.VarC64[0,19]:=Origin.NT.OptionalHeader.AddressOfEntryPoint
  Else Statica.VarC64[0,19]:=Origin.NT64.OptionalHeader.AddressOfEntryPoint; // { + }
 {%CUT-BEGIN%}
 {%CUT-END%}
 SetLength(BytesArray, 0);
  ufReg1:='';
  For I:=1 To Length(Option.AppName) Do
   begin
    If CharInSet(Option.AppName[I], ['A'..'Z'])=True Then
     ufReg1:=ufReg1+Option.AppName[I];
   end;
  If Length(ufReg1)<2 Then ufReg1:=ufReg1+StringOfChar('N',2);
  If Length(ufReg1)>2 Then ufReg1:=Copy(ufReg1, 1, 2);
  Statica.VarW[0,21]:=Trim(ufReg1);  
  ufReg1:='';
  For I:=1 To Length(Option.AppVer) Do
   begin
    If CharInSet(Option.AppVer[I], ['0'..'9'])=True Then
     ufReg1:=ufReg1+Option.AppVer[I];
   end;
  If Length(ufReg1)<2 Then ufReg1:=ufReg1+StringOfChar('0',2);
  If Length(ufReg1)>2 Then ufReg1:=Copy(ufReg1, 1, 2);
  Statica.VarW[0,21]:=Statica.VarW[0,21] + Trim(ufReg1); 
 Statica.VarB[0,22]:=Option.StdNAG; 
 {%CUT-BEGIN%}
 {%CUT-END%}
 ufReg1:=RandomChar+RandomChar+IntToStr(RandomRange(MaxInt div 2, MaxInt)); 
 Statica.VarC64[0,26] :=ameStringCrC(UpperCase('/'+ufReg1));
 Statica.VarW[0,27]:=Trim(Option.licKeyPath);
 Statica.VarW[1,0]  :=RandomChar+RandomChar+IntToStr(RandomRange(MaxInt div 2, MaxInt))+
                      RandomChar+'.' +RandomChar+RandomChar+RandomChar; 
 Statica.VarW[1,1]  :=RandomChar+RandomChar+IntToStr(RandomRange(MaxInt div 2, MaxInt))+
                      RandomChar+'.' +RandomChar+RandomChar+RandomChar; 
 Statica.VarW[1,2]:=Trim(Option.nagDialog);
 Statica.VarW[1,3]:=Trim(Option.nagLicenseID);
 Statica.VarW[1,4]:=Trim(Option.nagActivateKey);
 Statica.VarW[1,5]:=Option.nagText;
 Statica.VarW[1,6]:=Trim(Option.nagHelp);
 Statica.VarW[1,7]:=Trim(Option.nagOK);
 Statica.VarW[1,8]:=Trim(Option.nagBuy);
 Statica.VarW[1,9]:=Trim(Option.nagUserName);
 Statica.VarC64[1,10]:=Option.nagBackColor;
 Statica.VarC64[1,11]:=Option.nagFontColor;
 If nlCount(Option.nagText)>10 Then Statica.VarI64[1,12]:=1
  Else Statica.VarI64[1,12]:=0;
 Statica.VarI64[1,13]:=Option.nagTextAlign;
 Statica.VarI64[1,14]:=Abs(Option.nagDelay);
  If Option.HomePage<>'' Then
   Statica.VarW[2,0]:=Format('Please, visit: %s to get support.', [Option.HomePage])
  Else Statica.VarW[2,0]:='';
  If Option.AllowMsg Then
   begin
    Statica.VarW[2,1]:=Trim(Option.MsgDbg);           
    Statica.VarW[2,2]:=Trim(Option.MsgEDate);         
    Statica.VarW[2,3]:=Trim(Option.MsgSKey);        
    Statica.VarW[2,4]:=Trim(Option.MsgNotAdmin);     
    Statica.VarW[2,5]:=Trim(Option.MsgCrCfail);     
    Statica.VarW[2,6]:=Trim(Option.MsgExecLimit);
    Statica.VarW[2,7]:=Trim(Option.MsgCopyLimit);
    Statica.VarW[2,8]:=Trim(Option.MsgClockMan);
    Statica.VarW[2,9]:=Trim(Option.MsgTECount);
    Statica.VarW[2,10]:=Trim(Option.MsgTDCount);
   end;
 BlackList:=TStringList.Create;
 BlackList.Text:=Option.BlackList;
 If BlackList.Count>0 Then
  begin
   For I:=0 To BlackList.Count-1 Do
    begin
     J:=Pos(black_delim, BlackList[I]);
     K:=PosEx(black_delim, BlackList[I], J+1);
     ImportName:=Trim(Copy(BlackList[I], K+Length(black_delim), MaxInt));
     ImportName:=UpperCase(ImportName);
     If ImportName='' Then Continue;
     Statica.VarC64[7, I]:=ameStringCrC(ImportName);
    end;
  end;
 BlackList.Free;

 Statica.VarC64[6,1]:=Origin.NT.OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_COM_DESCRIPTOR].VirtualAddress;
 Statica.VarC64[6,2]:=Origin.NT.OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_COM_DESCRIPTOR].Size;
 pepLibrary:=TpxExeLoader.Create;

 Stream:=TvxMemoryStream.Create(GStore.VarBuf(0, -19), GStore.VarSize(0, -19));
 pepLibrary.LoadFromStream(Stream);
 Stream.Free;
 Code:=Origin.NewSection;
 Code.Header.Characteristics:= $E0000040;   
 Code.Flags:=[lsfMarker];
 Tree:=TCodeTree.Create(Code.VA+imageVA);
 VirtualDLLva:=Code.VA+imageVA;
 If pepLibrary.IsX64 = False Then LoaderInfoTable.sea:= Code.VA+pepLibrary.NT.OptionalHeader.AddressOfEntryPoint
  else LoaderInfoTable.sea:= Code.VA+pepLibrary.NT64.OptionalHeader.AddressOfEntryPoint;
 LoaderInfoTable.lib:= Code.VA;
 LoaderInfoTable.iat:= LoaderInfoTable.lib+pepLibrary.DataEntry(IMAGE_DIRECTORY_ENTRY_IMPORT).VirtualAddress;
 LoaderInfoTable.xwin:=32;

 Buf:=AllocMem(pepLibrary.ModuleSize);
 pepLibrary.PreloadMudule(Buf);
 If pepLibrary.RelocSection<>nil Then
  vxRandom(Pointer(Cardinal(Buf)+pepLibrary.RelocSection.VA),pepLibrary.RelocSection.VSize);
 If pepLibrary.ExportSection<>nil Then
  vxRandom(Pointer(Cardinal(Buf)+pepLibrary.ExportSection.VA),pepLibrary.ExportSection.VSize);
 vxRandom(Buf, pepLibrary.FirstSection.VA);  
 vaVirtualDLL:=Tree.Add(Buf, pepLibrary.ModuleSize);
 FreeMem(Buf);
 Tree.Align16;
 For I:=0 To pepLibrary.Relocations.Count-1 do
  begin
   TheReloc:=pepLibrary.Relocations[I];
   TheReloc.Relocation:=TheReloc.Relocation+(VirtualDLLva-imageVA);
   pepLibrary.Relocations[I]:=TheReloc;
  end;

 If (Origin.RelocSection<>NIL) Then
  begin
   Origin.RelocSection.Size:=0; 
   If Origin.IsLibrary = False Then  Origin.StripReloc (True)
    Else Origin.StripReloc (False)
  end;

 If Origin.ImportSection<>NIL Then
  Begin
   valueIsReloc:=False; 

   Statica.AllocSection(Origin.Import.Count, Lines, MaxWord);
   Statica.WriteArray(9,0,Lines); 
   SetLength(xRndArray, Origin.Import.Count);
   For I:=0 To Origin.Import.Count-1 Do
    xRndArray[I]:=Origin.Import[I];

   I64:=Low(Lines);
   For I:=0 To Origin.Import.Count-1 Do
    Begin
     iLibrary:=vxArrayRandomExclude(xRndArray);
     Statica.VarW[Lines[I64], 0]:=iLibrary.Name;
     SetLength(xRndArray2, iLibrary.List.Count);
     For J:=0 To iLibrary.List.Count-1 Do  xRndArray2[J]:=iLibrary.List[J];

     Statica.AllocSection(iLibrary.List.Count, Tables, MaxWord);
     Statica.WriteArray(Lines[I64], 1, Tables);
     rndI:=Low(Tables);

     For J:=0 To iLibrary.List.Count-1 Do
      Begin
       iFunction:=vxArrayRandomExclude(xRndArray2); 
       iFunction.User:=0;


       Statica.VarC64[Tables[rndI], 20]:=iFunction.OfsVA;  // DIRECT ACCESS
       If (iFunction.BoundIAT<>0) Then
        Statica.VarC64[Tables[rndI], 19]:=iFunction.BoundIAT;  // DIRECT ACCESS FUNC

       If iFunction.ByOrdinal=True Then
        begin
         Statica.VarI64[Tables[rndI], 1]:=1;
         Statica.VarI64[Tables[rndI], 2]:=iFunction.Ordinal;
        end
       Else
        begin
         Statica.VarI64[Tables[rndI], 1]:=0;
         Statica.VarW[Tables[rndI], 2]:=iFunction.Name;
        end;

  
       Statica.VarC64[Tables[rndI], 3]:=iFunction.User;
       Inc(rndI);
      End;
     Inc(I64);
    End;
   vxFreeArray(xRndArray);
   vxFreeArray(xRndArray2);
   SetLength(Lines, 0);
   SetLength(Tables, 0);


   Origin.ClearImportTable(False);
 End;


 SectionSet:=TList.Create;
 VirtualTable:=TMemoryStream.Create;

 If Origin.CodeSection<>NIL Then SectionSet.Add(Origin.CodeSection);
 If (Origin.EntrySection<>NIL) and (Origin.CodeSection<>Origin.EntrySection)
   Then SectionSet.Add(Origin.EntrySection);
 Lss:=TpxExeSection.Create;
 Lss.Write(vaVirtualDLL.Buffer^, vaVirtualDLL.Size);
 Lss.VA:=vaVirtualDLL.VA-imageVA;
 Lss.VSize:=Lss.Size;
 SectionSet.Add(Lss);
 If SectionSet.Count<>0 Then
  For K:=SectionSet.Count-1 DownTo 0 Do
    Begin
     Section:=SectionSet[K];

     Section.Position:=0;
     While True Do
      Begin

         I:=FindData(Section,@BeginVM,SizeOf(BeginVM));
         If I=-1 Then Break;
         Section.Position:=I;
         J:=FindData(Section,@EndVM,SizeOf(EndVM));
         If J=-1 Then Break;
         Section.Position:=I;
         Section.WriteRandom(SizeOf(BeginVM));
         Section.Position:=J;
         Section.WriteRandom(SizeOf(EndVM));
         Inc(I, SizeOf(BeginVM));



       ZeroMemory(@VirtualItem, SizeOf(VirtualItem));
       VirtualItem.VA:=I+Section.VA;
       Size:=J-I;
       VirtualItem.Sz:=Size;
       If Section=Lss Then VirtualItem.SysFlag:=1;
        VirtualTable.WriteBuffer(VirtualItem, SizeOf(VirtualItem));
      End;
    End;

 Lss.UserData:=SectionSet.IndexOf(Lss);
 SectionSet.Delete(Lss.UserData);





 {$ifdef Unsafe35VirtualMachine}
 SectionSet:=TList.Create;
 VirtualTable:=TMemoryStream.Create;

 If Origin.CodeSection<>NIL Then SectionSet.Add(Origin.CodeSection);
 If (Origin.EntrySection<>NIL) and (Origin.CodeSection<>Origin.EntrySection)
   Then SectionSet.Add(Origin.EntrySection);

 Lss:=TpxExeSection.Create;
 Lss.Write(vaVirtualDLL.Buffer^, vaVirtualDLL.Size);
 Lss.VA:=vaVirtualDLL.VA-imageVA;
 Lss.VSize:=Lss.Size;
 SectionSet.Add(Lss);

 If SectionSet.Count<>0 Then
  For K:=SectionSet.Count-1 DownTo 0 Do
    Begin
     Section:=SectionSet[K];
     Section.Position:=0;
     While True Do
      Begin

         I:=FindData(Section,@markBeginVMX32,SizeOf(markBeginVMX32));
         If I=-1 Then Break;
         Section.Position:=I;
         J:=FindData(Section,@markEndVMX32,SizeOf(markEndVMX32));
         If J=-1 Then Break;
         Section.Position:=I;
         Section.WriteRandom(SizeOf(markBeginVMX32));
         Section.Position:=J;
         Section.WriteRandom(SizeOf(markEndVMX32));
         Inc(I, SizeOf(markBeginVMX32));


       ZeroMemory(@VirtualItem, SizeOf(VirtualItem));
       VirtualItem.VA:=I+Section.VA;
       Size:=J-I;
       VirtualItem.Sz:=Size;
       If Section=Lss Then VirtualItem.SysFlag:=1;
        VirtualItem.AllowVM:=True;
        VirtualTable.WriteBuffer(VirtualItem, SizeOf(VirtualItem));
      End;
    End;

 Lss.UserData:=SectionSet.IndexOf(Lss);
 SectionSet.Delete(Lss.UserData);
 {$endif}


 Origin.Sections.Add(Lss);
 If VirtualTable.Size<>0 Then
  begin
   VirtualTable.Position:=0;
   J:=VirtualTable.Size div SizeOf(VirtualItem); 
   For I:=0 To J-1 Do
    begin
     VirtualTable.ReadBuffer(VirtualItem, SizeOf(VirtualItem));
     Section:=Origin.VAInSection(VirtualItem.VA);
     Try
      StolenHolder:=TProcedureHolder.Create;
      StolenHolder.Hold(Pointer(TConstQWord(Section.Memory)+VirtualItem.VA-Section.VA),
                        VirtualItem.VA, VirtualItem.Sz);
      Tree.Align8;

      Size:=32;
      Buf:=AllocMem(Size);
      SetLength(xRndArray, StolenHolder.Count);
      For K:=0 To StolenHolder.Count-1 Do
       begin
        HoldItem:=StolenHolder[K];
        vxRandom(Buf, Size);
        vaStolenPCode:=Tree.Add(Buf, Size);
        xRndArray[K]:=vaStolenPCode;
        Section.Position:=VirtualItem.VA-Section.VA+HoldItem.Offset;
        Section.WriteRandom(HoldItem.Size);
       end;
      FreeMem(Buf);


      For K:=0 To StolenHolder.Count-1 Do
       begin
        HoldItem:=StolenHolder[K];
        HoldItem.UserData:=vxArrayRandomExclude(xRndArray);
       end;
      vxFreeArray(xRndArray);

      For K:=0 To StolenHolder.Count-1 Do
       begin
        HoldItem:=StolenHolder[K];
        valueIsReloc:=False;
        If VirtualItem.SysFlag=1 then
         begin

          I64:=pepLibrary.RelocInVA(VirtualItem.VA+HoldItem.Offset,HoldItem.Size);
          If I64<>-1 Then
           begin
            valueIsReloc:=True;
            If HoldItem.Relative=True Then pepLibrary.Relocations.Delete(I64);
           end;
         end
        Else
         begin
          If (Origin.IsLibrary = True)  Then
           begin
            I64:=Origin.RelocInVA(VirtualItem.VA+HoldItem.Offset,HoldItem.Size);
            If I64<>-1 Then
             begin
              valueIsReloc:=True;
              If HoldItem.Relative=True Then Origin.Relocations.Delete(I64);
             end;
           end;
         end;

        vaStolenPCode:=Pointer(HoldItem.UserData);

        If HoldItem.Relative=True Then
         begin
          UFM:=TUniversalAsmLanguage.Create(Fasm);
          UFM.AsmMode:=AsmMode;
          I64:=0;
          rndI:=0;
          case HoldItem.RelativeType Of
           0:
             begin

              If HoldItem.Size = 5 Then
               begin
                If PInteger(@HoldItem.Data[2])^<>0 Then
                 begin
                  If Origin.IsX64=False Then
                   UFM.wrCall(vaStolenPCode.VA+UFM.Position, HoldItem.FarAddress+imageVA)
                  Else
                   UFM.wrCall(vaStolenPCode.VA+UFM.Position-imageVA, HoldItem.FarAddress);
                 end
                else
                 UFM.uni('call $+5');
               end;
              If (HoldItem.Size = 6) or (HoldItem.Size = 2) Then
               UFM.WriteBuffer(HoldItem.Data[1], HoldItem.Size);
             end;
           1:
             begin
              //
             end;
           2,3:
             begin
              If HoldItem.Size = 2 Then
               begin
                If HoldItem.Data[2] = 0 Then I64:=1;
                If I64 = 0 Then
                 begin
                  If HoldItem.Data[1]<>$EB Then
                   UFM.uni(['db 0x%s', 'db 0x5'], [IntToHex(HoldItem.Data[1], 2)])
                  Else rndI:=1;
                  I64:=2;
                 end;
               end;
              If HoldItem.Size = 6 Then
               begin
                UFM.uni(['db 0x%s', 'db 0x5'],[IntToHex(HoldItem.Data[2]-$10, 2)]);
                I64:=2;
               end;
             end;
          end;

          If rndI=0 Then
           begin
            If K=StolenHolder.Count-1 {last} Then
             begin
               UFM.wrJmp(vaStolenPCode.VA+UFM.Position,
                         VirtualItem.VA+imageVA+HoldItem.Offset+HoldItem.Size+
                         SizeOf(EndVM));
             end
            Else
             begin
              vaStolenChain:=Pointer(StolenHolder[K+1].UserData);
              If Origin.IsX64=False Then
               UFM.wrJmp(vaStolenPCode.VA+UFM.Position, vaStolenChain.VA)
              Else
               UFM.wrJmp(vaStolenPCode.VA+UFM.Position-imageVA, vaStolenChain.VA-imageVA);
             end;
           end;
          If I64 = 2 then
           begin
            If (HoldItem.Size >= 5) then
             begin
              If StolenHolder.ItemByOfs(HoldItem.FarAddress-VirtualItem.VA)<>NIL Then
               begin
                vaStolenChain:=Pointer(StolenHolder.ItemByOfs(HoldItem.FarAddress-VirtualItem.VA).UserData);
                If Origin.IsX64=False Then
                 UFM.wrJmp(vaStolenPCode.VA+UFM.Position, vaStolenChain.VA)
                else
                 UFM.wrJmp(vaStolenPCode.VA+UFM.Position-imageVA, vaStolenChain.VA-imageVA);
               end
              Else
               begin
                UFM.wrJmp(vaStolenPCode.VA+UFM.Position, HoldItem.FarAddress+imageVA);
               end;
             end
            Else
             begin
              If (StolenHolder.ItemByOfs(HoldItem.ShortAddress)<>NIL) Then
               begin
                vaStolenChain:=Pointer(StolenHolder.ItemByOfs(HoldItem.ShortAddress).UserData);
                If Origin.IsX64=False Then
                 UFM.wrJmp(vaStolenPCode.VA+UFM.Position, vaStolenChain.VA)
                else
                 UFM.wrJmp(vaStolenPCode.VA+UFM.Position-imageVA, vaStolenChain.VA-imageVA);
               end
              else
               begin
                If Origin.IsX64=False Then
                 UFM.wrJmp(vaStolenPCode.VA+UFM.Position, HoldItem.FarAddress+imageVA+5{why?marker?})
                else
                 UFM.wrJmp(vaStolenPCode.VA+UFM.Position-imageVA, HoldItem.FarAddress-imageVA);
               end;
             end;
           end;

          CopyMemory(vaStolenPCode.Buffer, UFM.Memory, UFM.Size);
          UFM.Free;
          Continue;
         end;

        UFM:=TUniversalAsmLanguage.Create(Fasm);
        UFM.AsmMode:=AsmMode;
        If (VirtualItem.AllowVM=True) and (valueIsReloc=False) Then
         begin
          PCodeCmd:=Code2PCode(HoldItem);
          If PCodeCmd<>NIL Then
           begin
            {$ifdef dbg}
             Log('- vm 0x'+IntToHex(HoldItem.Offset,8));
            {$endif}
            vaStolenChain:=Tree.Add(nil, 0);
            XFM:=TUniversalAsmLanguage.Create();
            XFM.AsmMode:=AsmMode;

            If PCodeCmd.Variant = votUndefined Then
             begin
              XFM.Size:=SizeOf(VMACmd)*3 + 16 + 1;
              vxRandom(XFM.Memory, XFM.Size);
              vxRandom(@VMACmd,SizeOf(VMACmd));
              VMACmd.Variant:=votSetVMA;
              VMACmd.UP:=vaStolenChain.VA+SizeOf(VMACmd)*3; {virtual buf}
              XFM.WriteBuffer(VMACmd,SizeOf(VMACmd));
             end
            Else
             begin
              XFM.Size:=SizeOf(VMACmd)*2;
              vxRandom(XFM.Memory, XFM.Size);
             end;
            XFM.WriteBuffer(PCodeCmd^,SizeOf(PCodeCmd^));
            vxRandom(PCodeCmd,SizeOf(PCodeCmd^));
            PCodeCmd.Variant:=votCommand;
            PCodeCmd.Cmd:=voEnd;
            XFM.WriteBuffer(PCodeCmd^,SizeOf(PCodeCmd^));


            Tree.UpdateBuffer(vaStolenChain, XFM.Memory, XFM.Size);
            XFM.Free;
            UFM.wrPush(vaStolenChain.VA, umStatic);
            UFM.wrCall(vaStolenPCode.VA+UFM.Position,VirtualDLLva+
                       pepLibrary.ExportByName('vmRunPCode'));
            Dispose(PCodeCmd);
           end
          Else
           begin
            UFM.WriteBuffer(HoldItem.Data[1], HoldItem.Size);
           end;
         end
        Else
         begin
          UFM.WriteBuffer(HoldItem.Data[1], HoldItem.Size);
         end;
        If valueIsReloc=True Then
         begin
          If VirtualItem.SysFlag=1 then
           begin
            I64:=pepLibrary.RelocInVA(VirtualItem.VA+HoldItem.Offset,HoldItem.Size);
            C64:=pepLibrary.Relocations[I64].Relocation-(VirtualItem.VA+HoldItem.Offset);

            TheReloc:=pepLibrary.Relocations[I64];
            TheReloc.Relocation:=vaStolenPCode.VA+UFM.Position-HoldItem.Size-imageVA+C64;
            pepLibrary.Relocations[I64]:=TheReloc;
           end
          else
           begin
            I64:=Origin.RelocInVA(VirtualItem.VA+HoldItem.Offset,HoldItem.Size);
            C64:=Origin.Relocations[I64].Relocation-(VirtualItem.VA+HoldItem.Offset);
            TheReloc:=pepLibrary.Relocations[I64];
            TheReloc.Relocation:=vaStolenPCode.VA+UFM.Position-HoldItem.Size-imageVA+C64;
            pepLibrary.Relocations[I64]:=TheReloc;
           end;
         end;

        If K=StolenHolder.Count-1 {last} Then
         begin
           UFM.wrJmp(vaStolenPCode.VA+UFM.Position,
                     VirtualItem.VA+imageVA+HoldItem.Offset+HoldItem.Size+
                     SizeOf(EndVM));

         end
        Else
         begin
          vaStolenChain:=Pointer(StolenHolder[K+1].UserData);
          If Origin.IsX64=False Then
           UFM.wrJmp(vaStolenPCode.VA+UFM.Position, vaStolenChain.VA)
          Else
           UFM.wrJmp(vaStolenPCode.VA+UFM.Position-imageVA, vaStolenChain.VA-imageVA);
         end;
        CopyMemory(vaStolenPCode.Buffer, UFM.Memory, UFM.Size);
        If UFM.Size>vaStolenPCode.Size Then
         Raise Exception.Create('Invalid [vm] operand size ('+IntToStr(UFM.Size)+') !');
        UFM.Free;
       end;
      Section.Position:=VirtualItem.VA-Section.VA;
      vaStolenChain:=Pointer(StolenHolder[0].UserData);
      Section.Position:=Section.Position-SizeOf(BeginVM);
      Section.WriteByte($E9);
      Section.WriteInt(vaStolenChain.VA-(VirtualItem.VA-SizeOf(EndVM){+1}+imageVA)-5);
      StolenHolder.Free;
     Except
      On E:Exception Do Log(' - ['+Language.ui(129)+'] '+E.Message);
     End;
    end;
  end;
 Lss.UserData:= Origin.SectionIndex(Lss);
 Origin.Sections.Delete(Lss.UserData);
 vxCopy(Lss.Memory, vaVirtualDLL.Buffer, Lss.Size);
 Lss.Free;
 SectionSet.Free;

 Log(' - '+Language.ui(133)+' ...'); 


 If Origin.ResourceSection<>NIL Then
  begin
   Origin.ResourceSection.Size:=0;
   Origin.ResourceSection.Flags:=Origin.ResourceSection.Flags+[lsfPacked, lsfZero];
  end;

 Statica.AllocSection(Origin.Sections.Count, Lines, MaxWord);
 For I:=0 To Origin.Sections.Count-1 Do
  Begin
   Section:=Origin.Sections[I];
   If lsfMarker in Section.Flags Then Break;
   Section.UserData:=-1;

   Statica.VarC64[Lines[I], 1]:=Section.VA;
   Statica.VarC64[Lines[I], 2]:=Section.VSize;

   J:=Section.Size;
   If Section.VSize<J Then J:=Section.VSize;

   If (Section.Header.Characteristics and IMAGE_SCN_MEM_WRITE)
       =IMAGE_SCN_MEM_WRITE Then
    begin
     Statica.VarC64[Lines[I], 3]:=0;
    end
   else
    begin
     Statica.VarC64[Lines[I], 3]:=ameCrC(Section.Memory, J);
    end;

   If J>0 Then Statica.WriteBinary(Lines[I], 0, Section.Memory, J);
   Section.Flags:=Section.Flags+[lsfPacked, lsfZero];
   Log(' - 0x'+IntToHex(Section.VA, 8)+' "'+Trim(Section.Name)+'"');
  End;
 Statica.WriteArray(14, 0, Lines);
 SetLength(Lines, 0);
 For I:=0 To Origin.Sections.Count-1 Do
  Begin
   Section:=Origin.Sections[I];
   Section.Name:='';
  End;



 If (True) Then
  Begin
   I:=Origin.DataEntry(IMAGE_DIRECTORY_ENTRY_TLS).VirtualAddress;
   Section:=Origin.VAInSection(I);

   If (Section <> NIL) and (I<>0) Then
    Begin
     Section.Position:=I-Section.VA;

     ZeroMemory(@TlsOriginData32,SizeOf(TlsOriginData32));
     ZeroMemory(@TlsOriginData64,SizeOf(TlsOriginData64));
     If Section.Position+SizeOf(TlsOriginData32)<=Section.Size Then
        Section.Read(TlsOriginData32, SizeOf(TlsOriginData32))
     Else
     Section.Read(TlsOriginData32, Section.Size-Section.Position);
     I64:=TlsOriginData32.AddressOfCallbacks;


     If I64<>0 Then
      begin
       Section:=Origin.VAInSection(I64-imageVA);
       If Section<>NIL Then
        begin
         Section.Position:=I64-imageVA-Section.VA;
         I64:=0;
         While True Do
          begin
           If Origin.IsX64=False then
            begin
             If Section.Position+4<=Section.Size Then
              C64:=Section.ReadCardinal Else Break;
            end
           Else
            begin
             If Section.Position+8<=Section.Size Then
              C64:=Section.ReadInt64 Else Break;
            end;
           If C64=0 Then Break;
           Statica.VarC64[46,I64]:=C64-Origin.ModuleBase;
           Inc(I64);
          end;
        end;
      end;
     End;
  End;

 If (Origin.IsLibrary=True) and (Origin.Relocations.Count>0) Then
   begin
    Statica.WriteBinary(8, 0, @Origin.Relocations.ToArray[0], Origin.Relocations.Count*SizeOf(TpxWindowsPERelocation));
   end;

 Stream:=TMemoryStream.Create;
  Statica.StreamCompression:=not Option.DisableCompression;
  Statica.SaveToStream(Stream);

 Statica.Free;
 LoaderInfoTable.rssz:= pepLibrary.Relocations.Count;
 LoaderInfoTable.libmb:=pepLibrary.ModuleBase;
 LoaderInfoTable.libdb:=Int64(VirtualDLLva-imageVA);
 vaEngineRelocs:=Tree.Add(@pepLibrary.Relocations.ToArray[0],
                          pepLibrary.Relocations.Count*SizeOf(TpxWindowsPERelocation));
 LoaderInfoTable.rels:=vaEngineRelocs.VA-imageVA;
 vaStaticIni:=Tree.Add(Stream.Memory, Stream.Size);
 LoaderInfoTable.dst:= vaStaticIni.VA-imageVA;
 LoaderInfoTable.dsz:= vaStaticIni.Size;
 Stream.Free;
 vapepLoader:=pepLibrary.ExportByName('pepLoader');
 pepLibrary.Free;

 Tree.Align16;
 varCRYPTO_STOP:=Tree.AddInt64(MaxInt);


 If (True) Then
  Begin
   I64:=Origin.DataEntry(IMAGE_DIRECTORY_ENTRY_TLS).VirtualAddress;
   Section:=Origin.VAInSection(I64);

   If (Section <> NIL) and (I64<>0) Then
    Begin
     Log(' - '+Language.ui(136));
     Section.Flags:=Section.Flags+[lsfPacked, lsfZero];
     Section.Position:=I64-Section.VA;

     If Section.Position+SizeOf(TlsOriginData32)<=Section.Size Then
        begin
         Section.Read(TlsOriginData32, SizeOf(TlsOriginData32));
         Section.Position:=I64-Section.VA;
         Section.WriteZero(SizeOf(TlsOriginData32));
        end
     Else
     begin
         ZeroMemory(@TlsOriginData32,SizeOf(TlsOriginData32));
         Section.Read(TlsOriginData32, Section.Size-Section.Position);
         Section.Position:=I64-Section.VA;
         Section.WriteZero(Section.Size-Section.Position);
     end;
     ZeroMemory(@TlsSectionData32,SizeOf(TlsSectionData32));
     TlsSectionData32.SizeOfZeroFill:=TlsOriginData32.SizeOfZeroFill;
     TlsSectionData32.Characteristics:=TlsOriginData32.Characteristics;
     I64:=TlsOriginData32.EndAddressOfRawData - TlsOriginData32.StartAddressOfRawData;
       If I64>0 Then
        begin
         Section:=Origin.VAInSection(TlsOriginData32.StartAddressOfRawData-imageVA);
         If Section<>NIL Then
          begin
           Section.Position:=TlsOriginData32.StartAddressOfRawData-imageVA-Section.VA;
           Buf:=AllocMem(I64);
           If Section.Position+I64<=Section.Size Then
            begin
             Section.Read(Buf^,I64);
             Section.Position:=Section.Position-I64;
             Section.WriteZero(I64);
            end
           Else
            begin
             J64:=Section.Size-Section.Position;
             ZeroMemory(Buf,I64);
             Section.Read(Buf^,J64);
             Section.Position:=Section.Position-J64;
             Section.WriteZero(J64);
            end;
           Tree.Align16;
           varTLSData:=Tree.Add(Buf,I64);
           TlsSectionData32.StartAddressOfRawData:=varTLSData.VA;
           TlsSectionData32.EndAddressOfRawData:=TlsSectionData32.StartAddressOfRawData+I64;
           FreeMem(Buf);
          end;
        end;
       I64:=TlsOriginData32.AddressOfCallbacks;
       If I64<>0 Then
        begin
         Section:=Origin.VAInSection(I64-imageVA);
         If Section<>NIL Then
          begin
           Section.Position:=I64-imageVA-Section.VA;
           While True Do
            begin
             If Section.Position+4<=Section.Size Then
              C64:=Section.ReadCardinal Else  Break;
             If C64=0 Then Break;
             Section.Position:=Section.Position-4;
             Section.WriteZero(4);
            end;
          end;
        end;
       Tree.Align16;
       TlsSectionData32.AddressOfCallbacks:=Tree.AddInt64(0).VA; // they oader


       I64:=TlsOriginData32.AddressOfIndex;
       If I64<>0 Then
        begin
         Tree.Align16;
         varTLSData:=Tree.AddInt64(0);
         Tree.AddInt64(0);
         Tree.AddInt64(0);
         Tree.AddInt64(0);
         Tree.AddInt64(0);
         TlsSectionData32.AddressOfIndex:=varTLSData.VA;
        end;
       Tree.Align16;
       varTlsCopy:=Tree.Add(NIL,0);
       Tree.UpdateBuffer(varTlsCopy,@TlsSectionData32,SizeOf(TlsSectionData32));


      Tree.Align16;
      Tree.AddInt64(Random(MaxInt)+1); // the end
        With Origin.NT Do
         begin
          OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_TLS].VirtualAddress:=varTlsCopy.VA-imageVA;
          OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_TLS].Size:=varTlsCopy.Size;
         end;

     End
    Else
      begin
         With Origin.NT Do
          begin
           OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_TLS].VirtualAddress:=0;
           OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_TLS].Size:=0;
          end;
      end;
  End
 Else
  Begin
     With Origin.NT Do
      begin
       OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_TLS].VirtualAddress:=0;
       OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_TLS].Size:=0;
      end;
  End;








 If Origin.IsLibrary = True Then
  begin
   varTempLEP:=Tree.Add(nil, 0);
   UFM:=TUniversalAsmLanguage.Create(Fasm);
   UFM.AsmMode:=AsmMode;
   With UFM Do
    Begin
      WriteData([$EB, $08]); // jmp $+8
      WriteInt64(0);
      wrJmp(varTempLEP.VA+UFM.Position, Origin.FirstSection.VA+imageVA);
      wrNop;

    End;
   Tree.UpdateBuffer(varTempLEP, UFM.Memory, UFM.Size);
   UFM.Free;
  end Else varTempLEP:=NIL;

 Code.Position:=0;
 Code.Size:=0;
 Tree.Align8;
 Tree.SaveToStream(Code);
 Origin.AlignSection(Code);

 VirtualTable.Free;



 If Option.IncreaseFileSize=True Then
  Begin
   Lss:=Origin.NewSection;
   Lss.Header.Characteristics:=IMAGE_SCN_MEM_READ;
   Lss.Name:='.cdata';
   Lss.WriteRandom(RandomRange(128,164)*1024);
   Origin.AlignSection(Lss);
  End;


 Lss:=Origin.NewSection;
 Lss.Header.Characteristics:= $C0000040; // r & w
 Lss.Name:='.idata';

 ImportName:='kernel32.dll';
 If (Origin.Import.Count=0) or (Origin.FindImportLibrary(ImportName)=NIL) Then
  begin
   iLibrary:=TpxWindowsImportLibrary.Create;
   iLibrary.Name:=ImportName;
   iLibrary.Tag:=0;
   iLibrary.Data:=0;
   iLibrary.Clear;
   Origin.Import.Add(iLibrary);
  end;

 vaKernelLibraryName:=0;
 SetLength(xRndArray, Origin.Import.Count);
 For I:=0 To Origin.Import.Count-1 Do xRndArray[I]:=Origin.Import[I];
 For I:=0 To Origin.Import.Count-1 Do
  Begin
   iLibrary:=vxArrayRandomExclude(xRndArray);
   If SameStrings(iLibrary.Name, InvisibleLibrarys) Then Continue;
   UFM:=TUniversalAsmLanguage.Create;
   UFM.AsmMode:=AsmMode;
   With UFM Do
    begin
     ImportName:=iLibrary.Name;
     ImportName:=RandomFrom([ImportName, WideUpperCase(ImportName)]);
     WriteBuffer(AnsiString(ImportName)[1], Length(ImportName));
     WriteByte(0);
    end;
   iLibrary.Tag:=Lss.VirtualOfs; // set name VA
   If WideSameText('kernel32.dll', iLibrary.Name)=True Then
    vaKernelLibraryName:=Lss.VirtualOfs;
   Lss.Write(UFM.Memory^, UFM.Size);
   UFM.Free;
  End;
 vxFreeArray(xRndArray);


 SetLength(xRndArray, Origin.Import.Count);
 For I:=0 To Origin.Import.Count-1 Do xRndArray[I]:=Origin.Import[I];

 For I:=0 To Origin.Import.Count-1 Do
  Begin
   iLibrary:=vxArrayRandomExclude(xRndArray);
   iLibrary.Data:=0;
   If SameStrings(iLibrary.Name, InvisibleLibrarys) Then Continue;
   SetLength(xRndArray2, iLibrary.List.Count);
   For J:=0 To iLibrary.List.Count-1 Do xRndArray2[J]:=iLibrary.List[J];


   BlackList:=TStringList.Create;
   For J:=0 To iLibrary.List.Count-1 Do
    Begin
     iFunction:=vxArrayRandomExclude(xRndArray2);
     If iFunction.ByOrdinal=False Then
      begin
       If BlackList.IndexOf(iFunction.Name)=-1 Then BlackList.Add(iFunction.Name);
      end
     Else
      begin
       ImportName:='###import@@@ord$$$'+IntToStr(iFunction.Ordinal);
       If BlackList.IndexOf(ImportName)=-1 Then BlackList.Add(ImportName);
      end;
     If J>(iLibrary.List.Count div 10) Then Break;
    End;

   If (iLibrary.Tag=vaKernelLibraryName) Then
    begin
     If BlackList.IndexOf('LoadLibraryA')=-1 Then BlackList.Add('LoadLibraryA');
     If BlackList.IndexOf('GetProcAddress')=-1 Then BlackList.Add('GetProcAddress');
     If BlackList.IndexOf('ExitProcess')=-1 Then BlackList.Add('ExitProcess');
    end;

   Lss.Align(8);
   If BlackList.Count=0 Then
    begin
     iLibrary.Data:= Lss.VirtualOfs;
     Lss.WriteInt64(0);
     Continue;
    end;


   UFM:=TUniversalAsmLanguage.Create;
   UFM.AsmMode:=AsmMode;
   With UFM Do
    begin
     For J:=0 To BlackList.Count-1 Do
      begin
       BlackList.Objects[J]:=Pointer(Lss.VirtualOfs+Position);
       WriteWord(0);
       ImportName:= BlackList[J];
       ImportOrd:='###import@@@ord$$$';
       If SameText(LeftStr(ImportName,Length(ImportOrd)), ImportOrd) Then
        begin
        end
       Else
        begin
         WriteBuffer(AnsiString(ImportName)[1], Length(ImportName));
         WriteByte(0);
        end;
      end;
     WriteInt64(0); // last item
     iLibrary.Data:= Lss.VirtualOfs+Position;
     For J:=0 To BlackList.Count-1 Do
      begin
       If (iLibrary.Tag=vaKernelLibraryName)  Then
        begin
         If SameText('LoadLibraryA', BlackList[J]) Then
          LoaderInfoTable.llw:=Lss.VirtualOfs+Position;
         If SameText('GetProcAddress', BlackList[J]) Then
          LoaderInfoTable.gpa:=Lss.VirtualOfs+Position;
         If SameText('ExitProcess', BlackList[J]) Then
          vaAVScanner:=Lss.VirtualOfs+Position;
        end;
       ImportName:= BlackList[J];
       ImportOrd:='###import@@@ord$$$';
       If SameText(LeftStr(ImportName,Length(ImportOrd)), ImportOrd) Then
        begin
         Delete(ImportName,1, Length(ImportOrd));
         ImportName:=Trim(ImportName);
         If Origin.IsX64=False Then WriteInt(StrToInt64(ImportName) or $80000000)
          Else WriteInt64(StrToInt64(ImportName) or $8000000000000000);
        end
       Else
        begin
         If Origin.IsX64=False Then WriteInt(uInt64(BlackList.Objects[J]))
          Else WriteInt64(uInt64(BlackList.Objects[J]));
        end;
      end;
     WriteInt64(0); // last item
    end;
   Lss.Write(UFM.Memory^, UFM.Size);
   UFM.Free;
   BlackList.Free;
  End;
 vxFreeArray(xRndArray);
 vxFreeArray(xRndArray2);


 SetLength(xRndArray, Origin.Import.Count);
 For I:=0 To Origin.Import.Count-1 Do xRndArray[I]:=Origin.Import[I];
 Stream:=TMemoryStream.Create;
 For I:=0 To Origin.Import.Count-1 Do
  Begin
   iLibrary:=vxArrayRandomExclude(xRndArray); //Origin.Import[I];
   If SameStrings(iLibrary.Name, InvisibleLibrarys) Then Continue;
   ZeroMemory(@ImportItem,SizeOf(ImportItem));
   ImportItem.Name:=iLibrary.Tag;
   ImportItem.FirstThunk:=iLibrary.Data;
   ImportItem.Characteristics:=0;
   ImportItem.TimeDateStamp:=RandomRange(MaxInt div 2, MaxInt);
   Stream.WriteBuffer(ImportItem,SizeOf(ImportItem));
  End;


 vxZero(@ImportItem,SizeOf(ImportItem));
 ImportItem.Name:=0;
 ImportItem.FirstThunk:=0;
 ImportItem.Characteristics:=0;
 Stream.WriteBuffer(ImportItem,SizeOf(ImportItem));
 I:=RandomRange(MaxInt div 2, MaxInt);
 Stream.WriteBuffer(I, 4); // yep, to correct writes of zero's
 vxFreeArray(xRndArray);

 Origin.NT.OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_IMPORT].VirtualAddress:=Lss.VirtualOfs;
 Origin.NT.OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_IMPORT].Size:=Stream.Size;


 Lss.Write(Stream.Memory^, Stream.Size);
 Stream.Free;
 Origin.AlignSection(Lss);

 If (Length(Origin.ExportList)>0) Then
  begin
   Lss:=Origin.NewSection;
   Lss.Header.Characteristics:= $40000040; // read only
   Lss.Name:='.edata';
   Lss.WriteRandom(RandomRange(16,32));
   Origin.ExportEntry.Name:=Lss.VirtualOfs;
   Lss.WriteAnsiString(Origin.ExportName);
   Lss.WriteByte(0);

   Origin.ExportEntry.AddressOfFunctions:=Lss.VirtualOfs;
   Stream:=TMemoryStream.Create;
   For I:=Low(Origin.ExportList) To High(Origin.ExportList) Do
    begin
     Stream.Position:= (Origin.ExportList[I].Ord-Origin.ExportEntry.Base)*4;
     C32:=Origin.ExportList[I].VA;
     Stream.WriteBuffer(C32, 4);
    end;
   Lss.WriteBuffer(Stream.Memory^, Stream.Size);
   Stream.Free;


   Origin.ExportEntry.AddressOfNameOrdinals:=Lss.VirtualOfs;
   For I:=Low(Origin.ExportList) To High(Origin.ExportList) Do
    begin
     Lss.WriteWord(Origin.ExportList[I].Ord-Origin.ExportEntry.Base);
    end;


   Stream:=TMemoryStream.Create;
   For I:=Low(Origin.ExportList) To High(Origin.ExportList) Do
    begin
     J:=Lss.VirtualOfs;
     Lss.WriteAnsiString(Origin.ExportList[I].Name);
     Lss.WriteByte(0);
     Stream.WriteBuffer(J, 4);
    end;
   Origin.ExportEntry.AddressOfNames:=Lss.VirtualOfs;
   Lss.WriteBuffer(Stream.Memory^, Stream.Size);
   Stream.Free;

   Origin.NT.OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_EXPORT].VirtualAddress:=Lss.VirtualOfs;
   Origin.NT.OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_EXPORT].Size:=Lss.Size;

   Lss.WriteBuffer(Origin.ExportEntry, SizeOf(Origin.ExportEntry));
   Lss.WriteRandom(16);

   Origin.AlignSection(Lss);
  end;

   With Origin.NT Do
    Begin
     OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_DEBUG].VirtualAddress:=0;
     OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_DEBUG].Size:=0;

     OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_COM_DESCRIPTOR].VirtualAddress:=0;
     OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_COM_DESCRIPTOR].Size:=0;

     OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_COPYRIGHT].VirtualAddress:=0;
     OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_COPYRIGHT].Size:=0;

     OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_IAT].VirtualAddress:=0;
     OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_IAT].Size:=0;

     OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_BOUND_IMPORT].VirtualAddress:=0;
     OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_BOUND_IMPORT].Size:=0;

     OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_DELAY_IMPORT].VirtualAddress:=0;
     OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_DELAY_IMPORT].Size:=0;

     OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_LOAD_CONFIG].VirtualAddress:=0;
     OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_LOAD_CONFIG].Size:=0;

     OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_SECURITY].VirtualAddress:=0;
     OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_SECURITY].Size:=0;
    End;


 If Origin.Sections.Count<>0 Then
  For I:=0 To Origin.Sections.Count-1 Do
   begin
    Section:=Origin.Sections[I];
    If (lsfZero in Section.Flags)=False Then Continue;
    Section.Zero;
    Section.Size:=0;
   end;


 Origin.FirstSection.Position:=0;
 Origin.FirstSection.Header.Characteristics:= $60000020; // RE
 UFM:=TUniversalAsmLanguage.Create(Fasm);
 UFM.AsmMode:=AsmMode;

   With UFM Do
   Begin
    WriteData([$EB, $08]); // jmp $+8
    WriteInt64(0);
   End;

   With UFM Do
   Begin

     wrNop(umStatic);
     wrPush(Random(MaxInt), umStatic);
     uni('push dword [fs:0]'); wrNop(umStatic);
     wrPush('eax', umStatic); wrNop(umStatic);
     wrPush('ebx', umStatic); wrNop(umStatic);
     wrPush('ecx', umStatic); wrNop(umStatic);
     wrPush('edx', umStatic); wrNop(umStatic);
     wrPush('esi', umStatic); wrNop(umStatic);
     wrPush('edi', umStatic); wrNop(umStatic);
     wrPush('ebp', umStatic);







     ufReg1:=wrReg;
     ufReg2:=wrReg([ufReg1]);
     ufReg3:=wrReg([ufReg1, ufReg2]);
     ufReg4:=wrReg([ufReg1, ufReg2, ufReg3]);
     ufReg5:=wrReg([ufReg1, ufReg2, ufReg3, ufReg4]);
     Buffering:=True;

     wrNop;
     uni('mov %s, %d',[ufReg1, Code.VA+imageVA]); // where  (M)
     wrNop;
     uni('mov %s, %d',[ufReg5, varCRYPTO_STOP.VA]); // size
     wrNop;


     wrNop;
     uni('mov %s, dword [%s]',[ufReg2, ufReg1]); // C
     wrNop;
     uni('add %s, %d',[ufReg1, 4]); // next bytes
     wrNop;
     uni('label_while:');
      wrNop;
      uni('mov %s, dword [%s]',[ufReg3, ufReg1]);  // B:=PInteger(uInt64(M)+I)^;
      wrPush(ufReg3, umStatic);                    // A:=B;
      uni('cld');
      wrNop;
      uni('clc');
      wrNop;
      uni('sub %s, %s',[ufReg3, ufReg2]);          // B:=B-C;
      wrNop;
      uni('xor %s, %d',[ufReg3, CorXorConst]);          // B:=B xor CorXorConst;
      wrNop;
      uni('xor %s, %s',[ufReg3, ufReg2]);          // B:=B xor C;
      wrNop;
      uni('mov dword [%s], %s',[ufReg1, ufReg3]);  // PInteger(uInt64(M)+I)^:=B;
      wrPop(ufReg2, umStatic);                     // C:=A;
      uni('add %s, %d',[ufReg1, 4]);               // next bytes   Inc(I, 4);
      wrNop;
      uni('cmp %s, %s',[ufReg1, ufReg5]);
      uni('jl label_while');    // If I>=Sz Then Break;

     Buffering:=False;




     ufReg1:=wrReg;
     ufReg2:=wrReg([ufReg1]);
     ufReg3:=wrReg([ufReg1, ufReg2]);


     uni('mov %s, %d', [ufReg1, imageVA]);


     uni('mov %s, esp', [ufReg3]);
     wrNop;
     uni('mov %s, %s', [ufReg2, ufReg1]);
     wrNop;
     uni('add %s, %d', [ufReg2, VirtualDLLva+vapepLoader-imageVA]);
     wrNop;

     wrNop;
     uni('push %s',[ufReg3]);
     wrNop;
     uni('push %s',[ufReg1]);

     uni('call %s', [ufReg2]);
   End;

  With UFM Do
   begin
     {$IFNDEF DBG} wrPolyBuf(RandomRange(1024*2, 3*1024)); {$ENDIF}
     Origin.NT.FileHeader.PointerToSymbolTable:=Origin.FirstSection.VA+UFM.Position;
     WriteBuffer(LoaderInfoTable, SizeOf(LoaderInfoTable));
     {$IFNDEF DBG} wrPolyBuf(RandomRange(1024*2, 4*1024)); {$ENDIF}
     WriteByte(ProgramSubVer);
     WriteByte(ProgramVer);
     WriteInt64(Random(MaxInt));
     WriteInt64(Random(MaxInt));
     WriteInt64(Random(MaxInt));
     WriteInt64(0);
     WriteInt64(0);
     WriteRandom(1);
     WriteInt64(Random(MaxInt));
     WriteInt64(Random(MaxInt));
   end;

  Origin.FirstSection.Write(UFM.Memory^, UFM.Size);
  UFM.Free;

   Origin.NT.OptionalHeader.AddressOfEntryPoint:=Origin.FirstSection.VA;
   If Origin.IsLibrary = True Then
    begin
     Origin.NT.OptionalHeader.AddressOfEntryPoint:=varTempLEP.VA-imageVA;
    end;

   MyvxMatriXCrypt(Code.Memory, varCRYPTO_STOP.VA-(Code.VA+imageVA), CorXorConst);

   With Origin.NT do
    begin
     OptionalHeader.SizeOfCode:=Origin.FirstSection.VSize;
     OptionalHeader.SizeOfInitializedData:=Origin.FirstSection.VSize+Code.VSize;
     OptionalHeader.SizeOfUninitializedData:=Code.VSize;
     OptionalHeader.BaseOfCode:=Origin.FirstSection.VA;
     OptionalHeader.BaseOfData:=Origin.FirstSection.VA;
    end;

 If Origin.ResourceSection<>NIL Then
  Begin
   Section:=Origin.NewSection;
   Section.Name:='.rsrc';
   Section.Header.Characteristics:=$40000040; // standard
   Section.Position:=0;


   Log(' - '+Language.ui(138));
   Resources:=TpxExeLoader.Create;

    Stream:=TvxMemoryStream.Create(GStore.VarBuf(0, 3), GStore.VarSize(0, 3));
    Resources.LoadFromStream(Stream);
    Stream.Free;


    While Resources.Sections.Count<>1 do
     begin
      Resources.Sections.Delete(0);
     end;

    Resources.ResourceSection.Header.VirtualAddress:=Section.VA;
    Resources.ResourceSection.VSize:=vxAlignOffset(Section.VSize,Resources.SecAligment);
    With Resources.NT Do
    begin
        OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_RESOURCE].VirtualAddress:=Section.VA;
        OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_RESOURCE].Size:=
         vxAlignOffset(Section.VSize, Resources.SecAligment);
    end;


    Resources.SaveToFile(Option.FileName);
    Resources.Free;
    Sleep(1);

    WriteResourceSnapShort(Option.FileName,ResourceSnap,[]); // copy all
    Sleep(1);

   Resources:=TpxExeLoader.Create;
   Resources.LoadFromFile(Option.FileName);
   Resources.CopyResourcesData(Section);
   Resources.Free;

   If Section.Size<>0 Then
    begin
     Section.VSize:=vxAlignOffset(Section.Size, Origin.SecAligment);
     With Origin.NT Do
     begin
         OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_RESOURCE].VirtualAddress:=Section.VA;
         OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_RESOURCE].Size:=Section.VSize;
     end;
    end
   Else
    begin
     Origin.Sections.Delete(Origin.SectionIndex(Section));
     With Origin.NT Do
     begin
         OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_RESOURCE].VirtualAddress:=0;
         OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_RESOURCE].Size:=0;
     end;
    end;
  End;
 WriteResourceSnapShort('',ResourceSnap,[]); // free
 ResourceSnap.Free;
 Log(' - '+Language.ui(139));
 For I:=0 To Origin.Sections.Count-1 Do
  Begin
   Section:=Origin.Sections[I];
   Section.Name:='.';
   For K:=1 To 10 Do Section.Name:=Section.Name + Chr(RandomRange(Ord('a'), Ord('z')));
  End;
 Origin.OptimizeSections;
 Tree.Free;
 Origin.SaveToFile(Option.FileName);
 Origin.Free;
 If Option.SameSize Then
  begin
   If MakeFileSameSize(Option.FileName) = False Then Log(' - '+Language.ui(140))
    Else Log(' - '+Language.ui(141));
  end;

 Log('');
 Log(Language.ui(142));

 Result:=0;
Except
 On E:Exception Do
  Begin
   Log(Language.ui(143)+' ['+E.Message+'] !');
   Result:=1;
  End;
End;
 SetLength(Lines,0);
 SetLength(Tables,0);
End;




















Initialization

 UserHooks:=TStringList.Create;
 ResHooks:=TStringList.Create;
 ppiHooks:=TStringList.Create;
 InvisibleLibrarys:=TStringList.Create;


 With InvisibleLibrarys do
  begin
   Add('advapi32.dll');
   Add('mpr.dll');
   Add('wininet.dll');
   Add('wsock32.dll');
   Add('rehlpic-x32.pll');
   Add('rehlpic-x64.pll');
   Add('ole32.dll');
   Add('oleaut32.dll');
   Add('shell32.dll');
  end;



 With ResHooks Do
  begin
   Add('LoadResource');
   Add('FreeResource');
   Add('SizeofResource');
   Add('FindResourceExA');
   Add('FindResourceExW');
   Add('FindResourceA');
   Add('FindResourceW');
  end;

 With UserHooks Do
  begin
   Add('LoadStringA');
   Add('LoadStringW');
  end;


 With ppiHooks do
  begin
   Add('ppiProtectionStatus');
   Add('ppiGetTrialDaysCount');
   Add('ppiGetTrialExecutionCount');
   Add('ppiGetLicenseId');
   Add('ppiGetKeyPath');
   Add('ppiGetKeyValue');
   Add('ppiGetUserNameValue');
   Add('ppiGetUserOption');
   Add('ppiGetKeyExpirationDate');
   Add('ppiDeleteKey');
   Add('ppiSaveKey');
   Add('ppiGetHaveKey');
  end;












end.

Unit RuntimeProtection;





Interface
Uses Winapi.Windows, PlatformConsts;







Function pepRuntimeThreadProtection(const P:TConstDWord):TConstDWord;stdcall;
Function pepSpyDriverThreadProtection(const P:TConstDWord):TConstDWord;stdcall;
Function pepRuntimeCrCProtection(const P:TConstDWord):TConstDWord;stdcall;



Procedure AddToCrcTable(const VA: TConstQWord; const Size: TConstInt64; const Crc: TConstQWord);
Procedure ReCalcCrcTable;






Implementation
uses ssLameCrypt;


Type
 TKnownDebuggersType = record
  crc   : TConstQWord;
  len   : TConstQWord;
  ByCls : Boolean;
 End;


Const
 KnownDbds  : array [1..17] of  TKnownDebuggersType=
           (
             (crc:6827168681436852162; len:6; ByCls:false),    // DeDe 3
             (crc:7799684945511250674; len:7; ByCls:false),    // OllyDbg
             (crc:6260435431390799433; len:10; ByCls:false),   // Import REC
             (crc:12790687676596618908; len:8; ByCls:false),   // PE Tools
             (crc:14781095442640762642; len:7; ByCls:true),    // OllyDBG
             (crc:14319101887281926612; len:7; ByCls:true),    // OLLYDBG
             (crc:16233303750820479094; len:13; ByCls:true),   // TDeDeMainForm
             (crc:9919134511724762069; len:12; ByCls:false),   // File Monitor
             (crc:396914475313686104; len:16; ByCls:false),    // Registry Monitor
             (crc:18299339682900398666; len:13; ByCls:false),  // Rock Debugger
             (crc:2535467121862807719; len:7; ByCls:false),    // OllyPad
             (crc:15153239747895329705; len:7; ByCls:true),    // DeFixed
             (crc:10100970027339287682; len:8; ByCls:false),   // CHimpREC
             (crc:9460476412861455737; len:9; ByCls:false),    // oepfinder
             (crc:5198322150590979175; len:22; ByCls:false),   // Universal Import Fixer
             (crc:18219361789508283191; len:8; ByCls:true),    // ollydbg2
             (crc:18219361789508283191; len:8; ByCls:false)    // ollydbg2
           );


const
 KnownDrivers : array[1..9] of TConstWString =
                ('\\.\NTICE', '\\.\OLLYBONE', '\\.\FRDTSC',
                 '\\.\FRDTSC0', '\\.\EXTREMEHIDE', '\\.\SICE',
                 '\\.\SIWVID', '\\.\ICEEXT', '\\.\SYSERBOOT');

 KnownSpys : array[1..1] of TConstWString =
                ('WpeSpy.dll');




Type
 TCrcTableItem = record
  VA   : TConstQWord;
  Size : TConstInt64;
  CrC  : TConstQWord;
 end;



Var
 CBufs  : Pointer;
 TBufs  : Pointer;
 CrcTable : Array of TCrcTableItem;



{===============================PROCEDURE==================================}

Function pepRuntimeCrCProtection(const P:TConstDWord):TConstDWord;stdcall;
var
 I   : Integer;
 C64 : TConstQWord;
Begin
 While True Do
  Begin
   For I:=Low(CrcTable) to High(CrcTable) do
    begin
     C64:=ameCrC(Pointer(CrcTable[I].VA), CrcTable[I].Size);
     If CrcTable[I].CrC<>C64 Then pepHaltDbgMsg(5);
    end;
   Sleep(6000);
  End;
 pepHaltDbgMsg();
End;

{===============================PROCEDURE==================================}

Procedure ReCalcCrcTable;
var
 I : Integer;
begin
 For I:=Low(CrcTable) to High(CrcTable) do
  CrcTable[I].CrC:=ameCrC(Pointer(CrcTable[I].VA), CrcTable[I].Size);
end;

{===============================PROCEDURE==================================}

Procedure AddToCrcTable(const VA: TConstQWord; const Size: TConstInt64; const Crc: TConstQWord);
begin
 SetLength(CrcTable, Length(CrcTable)+1);
 CrcTable[High(CrcTable)].VA:=VA;
 CrcTable[High(CrcTable)].Size:=Size;
 CrcTable[High(CrcTable)].Crc:=Crc;
end;

{===============================PROCEDURE==================================}

Function EnumWndCallBack(H:HWND; P:LPARAM):LongBool;stdcall;
Var
 I : Integer;
 ClassCount, TextCount : TConstQWord;
Begin
 Result:=True;
 ClassCount:=GetClassNameW(H, CBufs, $1000);
 TextCount:=GetWindowTextW(H, TBufs, $1000);
 For I:=Low(KnownDbds) To High(KnownDbds) Do
  Begin
   If KnownDbds[I].ByCls = True Then
    Begin
     If ClassCount>0 Then
      If ameCrC(CBufs, KnownDbds[I].len *2)=KnownDbds[I].CRC Then Result:=False;
    End
   Else
    Begin
     If TextCount>0 Then
      If ameCrC(TBufs, KnownDbds[I].len *2)=KnownDbds[I].CRC Then Result:=False;
    End;
  End;

End;

{===============================PROCEDURE==================================}

Function pepRuntimeThreadProtection(const P:TConstDWord):TConstDWord;stdcall;
Begin
 CBufs:=VirtualAlloc( nil, $6000, MEM_COMMIT, PAGE_READWRITE);
 TBufs:=VirtualAlloc( nil, $6000, MEM_COMMIT, PAGE_READWRITE);
 While True Do
  Begin
   If EnumWindows(@EnumWndCallBack, LPARAM(P))=True Then
    begin
     Sleep(5000);
     Continue;
    end;
   pepHaltDbgMsg;
  End;
 pepHaltDbgMsg();
End;

{===============================PROCEDURE==================================}

Function pepSpyDriverThreadProtection(const P:TConstDWord):TConstDWord;stdcall;
var
 I : Integer;
 B : BOOL;
 K : HMODULE;
 api_IsDebuggerPresent:function(): BOOL; stdcall;
 api_CheckRemoteDebuggerPresent:function(hProcess: THandle;var pbDebuggerPResent: BOOL): BOOL; stdcall;
begin
 K:=GetModuleHandleW(PConstWChar('kernel32.dll'));
 @api_IsDebuggerPresent:=GetProcAddress(K, PConstAChar('IsDebuggerPresent'));
 @api_CheckRemoteDebuggerPresent:=GetProcAddress(K, PConstAChar('CheckRemoteDebuggerPresent'));
 While True Do
  begin
   // [ drivers ]
   For I:=Low(KnownDrivers) to High(KnownDrivers) do
    begin
     If CreateFileW(PWideChar(KnownDrivers[I]), GENERIC_READ, 0, NIL,
                    OPEN_EXISTING,FILE_ATTRIBUTE_NORMAL,0)<>INVALID_HANDLE_VALUE
      Then pepHaltDbgMsg;
    end;
   For I:=Low(KnownSpys) to High(KnownSpys) do
    begin
     If GetModuleHandleW(PWideChar(KnownSpys[I]))<>0
      Then pepHaltDbgMsg;
    end;
   If Assigned(@api_IsDebuggerPresent) Then
     If api_IsDebuggerPresent()<>False Then pepHaltDbgMsg;

   If Assigned(@api_CheckRemoteDebuggerPresent) Then
    begin
     If api_CheckRemoteDebuggerPresent(GetCurrentProcess, B)=False Then
      pepHaltDbgMsg;
     If B=True Then pepHaltDbgMsg;
    end;

   Sleep(5000);
  End;
 pepHaltDbgMsg();
end;



End.





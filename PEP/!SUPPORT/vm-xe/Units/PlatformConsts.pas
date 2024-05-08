Unit PlatformConsts;





Interface
Uses Winapi.Windows, ssStore, ssLameCrypt;



Type
 TPlatformCardinal = Cardinal;
 PPlatformCardinal = ^TPlatformCardinal;
 TPlatformInt = Integer;
 PPlatformInt = ^TPlatformInt;
 TConstQWord = uInt64;
 PConstQWord = ^TConstQWord;
 TConstDWord = {$IFDEF FPC}uInt{32}{$ELSE}DWord{$ENDIF};
 PConstDWord = ^TConstDWord;
 PuInt64 = ^uInt64;
 TConstInt64 = Int64;
 PConstInt64 = ^TConstInt64;
 TConstWString = {$IFDEF FPC}WideString{$ELSE}String{$ENDIF};
 TConstWChar = WideChar;
 PConstWChar = PWideChar;
 TConstAChar = AnsiChar;
 PConstAChar = PAnsiChar;








Type
 PLoaderInfoTable = ^TLoaderInfoTable;

 TLoaderInfoTable = packed record
  ib    : UInt64; 
  sea   : UInt64; 
  lib   : UInt64; 
  dst   : UInt64; 
  dsz   : UInt64; 
  rels  : UInt64; 
  rssz  : UInt64; 
  libmb : UInt64; 
  libdb : Int64;  
  iat   : UInt64; 
  gpa   : UInt64; 
  llw   : UInt64; 
  xwin  : Int64;  
  isdll : Boolean;
  isnet : Boolean;
 End;




var
 OriginIB      : TConstQWord;
 ModuleRET     : TPlatformCardinal;
 Jumper        : TPlatformCardinal;   
 Statica       : TMemoryStore;
 Critical : TRTLCriticalSection;
 SelfMZ : PImageDosHeader;
 SelfNT : PImageNtHeaders32;
 GLIT: TLoaderInfoTable;  










 Function IsUserAdmin: Boolean;
 Function IntToStr(const Value: int64): string;
 Function IntToHex(Value: UInt64; Digits: Integer): TConstWString;
 Function hex2i(const xid: TConstWString; buf: pointer):Boolean;
 Procedure pepHaltDbgMsg(const MsgNum:Int64=1);



 function IsLeapYear(Year: Word): Boolean;
 function Now: TDateTime;
 function UnixToDateTime(const USec: TConstQWord): TDateTime;
 function DateTimeToUnix(const ConvDate: TDateTime): TConstQWord;
 function DaysBetween(const ANow, AThen: TDateTime): Integer;
 function IncDay(const AValue: TDateTime; const ANumberOfDays: Integer): TDateTime;
 function Trim(const S: unicodestring): unicodestring;
 function ExtractFilePath(const FileName: string): TConstWString;
 Function FileExists (Const FileName : TConstWString) : Boolean;
 function IncludeTrailingPathDelimiter(Const Path : TConstWString) : TConstWString;

 function ReplaceChar(const S:TConstWString;const W: Array of WideChar; const ToW:TConstWString=''):WideString;
 procedure DecodeDate(Date: TDateTime; out Year, Month, Day: word);



 function pepWideUpperCase(const S:String):string;
 function StrPas(const Str: PAnsiChar): AnsiString;




Implementation



type
  TTimeStamp = record
    Time: Integer;      
    Date: Integer;      
  end;

const
 AllowDirectorySeparators : set of char = ['\','/'];
 DirectorySeparator = '\';
 AllowDriveSeparators : set of char = [':'];





{===============================PROCEDURE==================================}

function pepWideUpperCase(const S:String):string;
begin
 Result:=Copy(S,1, MaxInt);
 If Length(Result)>0 Then
  CharUpperBuffW(PWideChar(Result), Length(Result));
end;

{===============================PROCEDURE==================================}

function StrPas(const Str: PAnsiChar): AnsiString;
begin
 Result := Str;
end;

{===============================PROCEDURE==================================}

Function vxVarDump(M:Pointer; Sz:uInt64; const FileName:TConstWString):Boolean;
Var
 Handle : THandle;
 Dw : DWord;
begin
 Result:=False;
 Handle:=CreateFileW(PWideChar(FileName), GENERIC_WRITE,
                     0, nil, CREATE_ALWAYS, FILE_ATTRIBUTE_NORMAL, 0);
 If Handle<>INVALID_HANDLE_VALUE Then
  begin
   If WriteFile(Handle, M^, Sz, Dw, nil) Then
    begin
     If Dw=Sz Then Result:=True;
    end;
   CloseHandle(Handle);
  end;
end;

{===============================PROCEDURE==================================}

procedure DecodeDate(Date: TDateTime; out Year, Month, Day: word);
const
   DateDelta = 693594;       
var
  ly,ld,lm,j : cardinal;
begin
  if Date <= -datedelta then  
    begin
    Year := 0;
    Month := 0;
    Day := 0;
    end
  else
    begin
    j := pred((Trunc(System.Int(Date)) + 693900) SHL 2);
    ly:= j DIV 146097;
    j:= j - 146097 * cardinal(ly);
    ld := j SHR 2;
    j:=(ld SHL 2 + 3) DIV 1461;
    ld:= (cardinal(ld) SHL 2 + 7 - 1461*j) SHR 2;
    lm:=(5 * ld-3) DIV 153;
    ld:= (5 * ld +2 - 153*lm) DIV 5;
    ly:= 100 * cardinal(ly) + j;
    if lm < 10 then
     inc(lm,3)
    else
      begin
        dec(lm,9);
        inc(ly);
      end;
    year:=ly;
    month:=lm;
    day:=ld;
    end;
end;

{===============================PROCEDURE==================================}

function ReplaceChar(const S:TConstWString;const W: Array of WideChar; const ToW:TConstWString=''):WideString;
Var
 I,X : Integer;
 F : Boolean;
begin
 If S='' Then Exit(S);
 Result:='';
 For X:=1 To Length(S) Do
  begin
   F:=False;
   For I:=Low(W) To High(W) Do
    begin
     If W[I]=S[X] Then
      begin
       F:=True;
       Break;
      end;
    end;
   If F=True Then
    begin
     If ToW<>'' Then Result:=Result+ToW;
     Continue;
    end;
   Result:=Result+S[X];
  end;
end;

{===============================PROCEDURE==================================}

function ComposeDateTime(Date,Time : TDateTime) : TDateTime;
begin
  if Date < 0 then Result := trunc(Date) - Abs(frac(Time))
  else Result := trunc(Date) + Abs(frac(Time));
end;

{===============================PROCEDURE==================================}

function TimeStampToDateTime(const TimeStamp: TTimeStamp): TDateTime;
const
  HoursPerDay   = 24;
  MinsPerHour   = 60;
  SecsPerMin    = 60;
  MSecsPerSec   = 1000;
  MinsPerDay    = HoursPerDay * MinsPerHour;
  SecsPerDay    = MinsPerDay * SecsPerMin;
  SecsPerHour   = SecsPerMin * MinsPerHour;
  MSecsPerDay   = SecsPerDay * MSecsPerSec;
  DateDelta = 693594;
begin
  Result := ComposeDateTime(TimeStamp.Date - DateDelta,TimeStamp.Time / MSecsPerDay)
end;

{===============================PROCEDURE==================================}

function TryEncodeTime(Hour, Min, Sec, MSec: Word; out Time: TDateTime): Boolean;
const
  HoursPerDay   = 24;
  MinsPerHour   = 60;
  SecsPerMin    = 60;
  MSecsPerSec   = 1000;
  MinsPerDay    = HoursPerDay * MinsPerHour;
  SecsPerDay    = MinsPerDay * SecsPerMin;
  SecsPerHour   = SecsPerMin * MinsPerHour;
  MSecsPerDay   = SecsPerDay * MSecsPerSec;
  DateDelta = 693594;

var
  TS: TTimeStamp;
begin
  Result := False;
  if (Hour < HoursPerDay) and (Min < MinsPerHour) and (Sec < SecsPerMin) and (MSec < MSecsPerSec) then
  begin
    TS.Time :=  (Hour * (MinsPerHour * SecsPerMin * MSecsPerSec))
              + (Min * SecsPerMin * MSecsPerSec)
              + (Sec * MSecsPerSec)
              +  MSec;
    TS.Date := DateDelta; 
    Time := TimeStampToDateTime(TS);
    Result := True;
  end;
end;

{===============================PROCEDURE==================================}

function IncludeTrailingPathDelimiter(Const Path : TConstWString) : TConstWString;
Var
 l : Integer;
begin
  Result:=Path;
  l:=Length(Result);
  If (L=0) or not(Result[l] in AllowDirectorySeparators) then
    Result:=Result+DirectorySeparator;
end;

{===============================PROCEDURE==================================}

Function FileExists (Const FileName : TConstWString) : Boolean;
var
  Attr:Dword;
begin
 Attr:=GetFileAttributesW(PWideChar(FileName));
 if Attr <> $ffffffff then Result:= (Attr and FILE_ATTRIBUTE_DIRECTORY) = 0
  else Result:=False;
end;

{===============================PROCEDURE==================================}

function ExtractFilePath(const FileName: string): TConstWString;
var
 i : Integer;
 EndSep : Set of Char;
begin
 i := Length(FileName);
 EndSep:=AllowDirectorySeparators+AllowDriveSeparators;
 while (i > 0) and not (FileName[i] in EndSep) do Dec(i);
 If I>0 then Result := Copy(FileName, 1, i)
  else Result:='';
end;

{===============================PROCEDURE==================================}

function Trim(const S: unicodestring): unicodestring;
var
 Ofs, Len: Integer;
begin
 len := Length(S);
 while (Len>0) and (S[Len]<=' ') do dec(Len);
 Ofs := 1;
 while (Ofs<=Len) and (S[Ofs]<=' ') do Inc(Ofs);
 result := Copy(S, Ofs, 1 + Len - Ofs);
end;

{===============================PROCEDURE==================================}

function IncDay(const AValue: TDateTime; const ANumberOfDays: Integer): TDateTime;inline;
begin
  Result := AValue + ANumberOfDays;
end;

{===============================PROCEDURE==================================}

function SpanOfNowAndThen(const ANow, AThen: TDateTime): TDateTime;inline;
begin
 if ANow < AThen then Result := AThen - ANow
  else Result := ANow - AThen;
end;

{===============================PROCEDURE==================================}

function DaySpan(const ANow, AThen: TDateTime): Double;inline;
begin
  Result := SpanOfNowAndThen(ANow, AThen);
end;

{===============================PROCEDURE==================================}

function DaysBetween(const ANow, AThen: TDateTime): Integer;inline;
begin
  Result := Trunc(DaySpan(ANow, AThen));
end;

{===============================PROCEDURE==================================}

function DateTimeToUnix(const ConvDate: TDateTime): TConstQWord;
const
  UnixStartDate: TDateTime = 25569.0;
begin
  Result := Round((ConvDate - UnixStartDate) * 86400);
end;

{===============================PROCEDURE==================================}

function UnixToDateTime(const USec: TConstQWord): TDateTime;
const
  UnixStartDate: TDateTime = 25569.0;
begin
  Result := (Usec / 86400) + UnixStartDate;
end;

{===============================PROCEDURE==================================}

function IsLeapYear(Year: Word): Boolean;
begin
  Result := (Year mod 4 = 0) and ((Year mod 100 <> 0) or (Year mod 400 = 0));
end;

{===============================PROCEDURE==================================}

Function TryEncodeDate(Year,Month,Day : TConstQWord; Out Date : TDateTime) : Boolean;
type
  PDayTable = ^TDayTable;
  TDayTable = array[1..12] of Word;

const
  MonthDays: array [Boolean] of TDayTable =
    ((31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31),
     (31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31));
  DateDelta = 693594;
var
  I: Integer;
  DayTable: PDayTable;
begin
  Result := False;
  DayTable := @MonthDays[IsLeapYear(Year)];
  if (Year >= 1) and (Year <= 9999) and (Month >= 1) and (Month <= 12) and
    (Day >= 1) and (Day <= DayTable^[Month]) then
  begin
    for I := 1 to Month - 1 do Inc(Day, DayTable^[I]);
    I := Year - 1;
    Date := I * 365 + I div 4 - I div 100 + I div 400 + Day - DateDelta;
    Result := True;
  end;
end;

{===============================PROCEDURE==================================}

function Now: TDateTime;
var
 SystemTime: TSystemTime;
 D1, D2 : TDateTime;
begin
 GetLocalTime(SystemTime);
 with SystemTime do
  begin
   TryEncodeDate(wYear, wMonth, wDay, D1);
   TryEncodeTime(wHour, wMinute, wSecond, wMilliseconds, D2);
  end;
 Result:=D1+D2;
end;

{===============================PROCEDURE==================================}

function IntToStr(const Value: int64): string;
begin
 System.Str(Value, result);
end;

{===============================PROCEDURE==================================}

Function hex2i(const xid: TConstWString; buf: pointer):Boolean;
var
 B : PByte;
 V,E,I : Integer;
 S : String;
begin
 Result:=True;
 B:=buf;
 I:=1;
 While True do
  begin
   S:=Copy(xid,I,2);
   If S='' Then Break;
   System.Val('x'+S, V, E);
   If E<>0 Then Break;
   B^:=V;
   Inc(B);
   Inc(I,2);
  end;
end;

{===============================PROCEDURE==================================}

function IntToHex(Value: UInt64; Digits: Integer): TConstWString;
const
  TwoHexLookup : packed array[0..255] of array[1..2] of WideChar =
  ('00','01','02','03','04','05','06','07','08','09','0A','0B','0C','0D','0E','0F',
   '10','11','12','13','14','15','16','17','18','19','1A','1B','1C','1D','1E','1F',
   '20','21','22','23','24','25','26','27','28','29','2A','2B','2C','2D','2E','2F',
   '30','31','32','33','34','35','36','37','38','39','3A','3B','3C','3D','3E','3F',
   '40','41','42','43','44','45','46','47','48','49','4A','4B','4C','4D','4E','4F',
   '50','51','52','53','54','55','56','57','58','59','5A','5B','5C','5D','5E','5F',
   '60','61','62','63','64','65','66','67','68','69','6A','6B','6C','6D','6E','6F',
   '70','71','72','73','74','75','76','77','78','79','7A','7B','7C','7D','7E','7F',
   '80','81','82','83','84','85','86','87','88','89','8A','8B','8C','8D','8E','8F',
   '90','91','92','93','94','95','96','97','98','99','9A','9B','9C','9D','9E','9F',
   'A0','A1','A2','A3','A4','A5','A6','A7','A8','A9','AA','AB','AC','AD','AE','AF',
   'B0','B1','B2','B3','B4','B5','B6','B7','B8','B9','BA','BB','BC','BD','BE','BF',
   'C0','C1','C2','C3','C4','C5','C6','C7','C8','C9','CA','CB','CC','CD','CE','CF',
   'D0','D1','D2','D3','D4','D5','D6','D7','D8','D9','DA','DB','DC','DD','DE','DF',
   'E0','E1','E2','E3','E4','E5','E6','E7','E8','E9','EA','EB','EC','ED','EE','EF',
   'F0','F1','F2','F3','F4','F5','F6','F7','F8','F9','FA','FB','FC','FD','FE','FF');

var
  I32    : Integer;
  I, J   : UInt64;
  P      : PWideChar;
  NewLen : Integer;
begin
  NewLen := 1;
  I := Value shr 4;
  while I > 0 do
  begin
    Inc(NewLen);
    I := I shr 4;
  end;
  if Digits > NewLen then
  begin
    SetLength(Result, Digits);
    for I32 := 1 to Digits - NewLen do
      Result[I32] := '0';
    P := @Result[Digits - NewLen+1];
  end
  else
  begin
    SetLength(Result, NewLen);
    P := PWideChar(Result);
  end;
  I := Value;
  while NewLen > 2 do
  begin
    J := I and $FF;
    I := I shr 8;
    Dec(NewLen, 2);
    PDWord(P + NewLen)^ := DWord(TwoHexLookup[J]);
  end;
  if NewLen = 2 then
    PDWord(P)^ := DWord(TwoHexLookup[I])
  else
    PWideChar(P)^ := (PWideChar(@TwoHexLookup[I])+1)^;
end;

{===============================PROCEDURE==================================}

Function pepBeginHaltWaitLong(ParamX:Cardinal):Integer;stdcall;
Begin
 Sleep(7000);
 ExitProcess(ParamX);
 Halt;
End;

{===============================PROCEDURE==================================}

Procedure uidbg(const Msg:TConstWString; const Caption:TConstWString='');
Begin
 MessageBoxW(0,PWideChar(Msg),PWideChar(Caption),
             MB_OK or MB_ICONINFORMATION or MB_TASKMODAL);
End;

{===============================PROCEDURE==================================}

Procedure pepHaltDbgMsg(const MsgNum:Int64=1);
Var
 M : TConstWString;
 T : TConstDWord;
Begin
 T:=CreateThread(NIL, 0, @pepBeginHaltWaitLong, Pointer(Random(MaxInt)), 0, T);
 EnterCriticalSection(Critical); 
 M:=Statica.VarW[2, MsgNum];
 If M<>'' Then
  begin
   If Statica.VarW[2,0]<>'' Then M:=M+sLineBreak+sLineBreak+Statica.VarW[2,0];
   uidbg(M, Statica.VarW[0,0] );
  end;
 ExitProcess(Random(MaxInt));
 TerminateProcess(GetCurrentProcess, Random(MaxInt));
End;

{===============================PROCEDURE==================================}

Function IsUserAdmin: Boolean;
Var
 Handle : THandle;
 IsUserAdmin : Function: LongBool; stdcall;
begin
 Result := True;
 Handle:=LoadLibraryW(PWideChar('setupapi.dll'));
 @IsUserAdmin:=GetProcAddress(Handle, PAnsiChar('IsUserAdmin'));
 If Assigned(IsUserAdmin) Then Result:=IsUserAdmin();
end;

{===============================PROCEDURE==================================}



End.


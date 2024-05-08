unit Licensing;




{$DEFINE PM}      
{-$DEFINE CUSTOMs}



interface
Uses Winapi.Windows, PlatformConsts;



Procedure ResetTrialCommand;
Procedure InitializeLicensing;
Procedure LoadTrialParams;
Procedure SaveTrialParams;
Procedure VerifyTrialParams;
Procedure LoadKey;
Procedure SaveKey(const AName, AKey: TConstWString);
Procedure VerifyKey;
Procedure TrialVersionVerifyKey;
Procedure DeleteKey;
Function ppiGetLicenseIDFmt:TConstWString;
Function ppiGetTrialDaysCount:Int64;
Function ppiGetTrialExecutionCount:Int64;
Function ppiGetHaveKey:Int64;
Function ppiGetKeyPath:TConstWString;
Function ppiGetKeyValue:TConstWString;
Function ppiGetNameValue:TConstWString;
Procedure ppiDeleteKey;
Function ppiUserOptions:Int64;
Function ppiKeyExpiration:TConstWString;
Procedure InitializeHWID;
Procedure InitializeTrialVersionHWID;
Function pepBeginExecLimitation(ParamX:Cardinal):Integer;stdcall;






implementation
Uses ssLameCrypt {$IFDEF CUSTOMs}Customization{$ENDIF};



var
 TrialParams : record
  ClockMan    : TConstQWord;
  TrialECount : Int64;
  TrialDCount : TConstQWord;
 End;


var
 LocalKey : record
  Name : TConstWString;
  Key  : TConstWString;
  Path : TConstWString;
  Raw  : TameRSABytes;
 end;



var
 rcEncryption : TameRSABytes;  
 catLicensing : Int64;
 valFmtHWID   : Int64;
 valKey       : Int64;
 TrialExecutionCount : Int64;
 TrialDaysCount : Int64;
 UserOptions : Byte;
 KeyExpirationDate : TConstQWord;






{===============================PROCEDURE==================================}

Function pepBeginExecLimitation(ParamX:Cardinal):Integer;stdcall;
Begin
 Sleep(Statica.VarC64[0,6]);
 pepHaltDbgMsg(6);
 ExitProcess(ParamX);
 Halt;
End;

{===============================PROCEDURE==================================}

Function ppiKeyExpiration:TConstWString;
var
 Year, Month, Day: word;
begin
 
 DecodeDate(UnixToDateTime(KeyExpirationDate), Year, Month, Day);
 If Day<10 Then Result:='0'+IntToStr(Day)
  Else Result:=IntToStr(Day);
 Result:=Result+'.';
 If Month<10 Then Result:=Result+'0'+IntToStr(Month)
  Else Result:=Result+IntToStr(Month);
 Result:=Result+'.';
 Result:=Result+IntToStr(Year);
 
end;

{===============================PROCEDURE==================================}

Function ppiUserOptions:Int64;
begin
 
 Result:=UserOptions;
 
end;

{===============================PROCEDURE==================================}

Procedure VerifyKey;
begin
 TrialVersionVerifyKey;
end;

{===============================PROCEDURE==================================}

Procedure TrialVersionVerifyKey;
begin
 Statica.DeleteValue(catLicensing, valKey);
 LocalKey.Key:='';
 LocalKey.Name:='';
 If Length(LocalKey.Raw)=0 Then Exit;

 Statica.VarI64[catLicensing, valKey]:=Random(MaxInt); 
end;

{===============================PROCEDURE==================================}

Function KeyPathDelegate:TConstWString;
begin
 Result:=Statica.VarW[0,27];
 If Result='' Then Result:=Statica.VarW[0,0];
end;

{===============================PROCEDURE==================================}

Procedure SaveKey(const AName, AKey: TConstWString);
Label rexit;
var
 Name, Path : TConstWString;
 Handle : THandle;
 RegKeyHandle : HKEY;
 Dw : TConstDWord;
 Ok : Boolean;
 C64 : TConstQWord;
begin
 LocalKey.Key:=AKey;
 LocalKey.Name:=AName;
 LocalKey.Path:='';
 SetLength(LocalKey.Raw, 0);
 Name:=LocalKey.Name+'/#&&#/'+LocalKey.Key+#00+#00;
 rc4memtokey(PByte(PWideChar(Name)), Length(Name)*2, LocalKey.Raw);

 Ok:=False;
 Name:=Statica.VarW[0,11]; 
 Path:=ExtractFilePath(ParamStr(0));
 Handle:=CreateFileW(PWideChar(Path+Name), GENERIC_WRITE,
                     0, nil, CREATE_ALWAYS, FILE_ATTRIBUTE_NORMAL, 0);
 If Handle<>INVALID_HANDLE_VALUE Then
  begin
   If WriteFile(Handle, LocalKey.Raw[0], Length(LocalKey.Raw), Dw, nil) Then
    begin
     If Dw=Length(LocalKey.Raw) Then
      begin
       Ok:=True;
       LocalKey.Path:=Path+Name;
      end;
    end;
   CloseHandle(Handle);
  end;
 If Ok Then Goto rexit;
 Path:='Software\'+KeyPathDelegate+'\';
 C64:=RegCreateKeyExW(HKEY_CURRENT_USER, PWideChar(Path), 0, '',
                      REG_OPTION_NON_VOLATILE, KEY_ALL_ACCESS, nil, RegKeyHandle, @Dw);
 If (RegKeyHandle<>0) and (C64=ERROR_SUCCESS) Then
  Begin
   Dw:=Length(LocalKey.Raw);
   C64:=RegSetValueExW(RegKeyHandle, PWideChar(Name),0, REG_BINARY, @LocalKey.Raw[0], Dw);
   If C64=ERROR_SUCCESS Then
    begin
     Ok:=True;
     LocalKey.Path:=Path+Name;
    end;
   RegCloseKey(RegKeyHandle);
  End;
 If Ok Then Goto rexit;
 SetLength(Path, 4096);
 Dw:=GetEnvironmentVariableW(PWideChar('APPDATA'), PWideChar(Path), 2000);
 SetLength(Path, Dw);
 If Path<>'' Then Path:=IncludeTrailingPathDelimiter(Path);
 Path:=Path+KeyPathDelegate+'\';
 Handle:=CreateFileW(PWideChar(Path+Name), GENERIC_WRITE,
                     0, nil, CREATE_ALWAYS, FILE_ATTRIBUTE_NORMAL, 0);
 If Handle<>INVALID_HANDLE_VALUE Then
  begin
   If WriteFile(Handle, LocalKey.Raw[0], Length(LocalKey.Raw), Dw, nil) Then
    begin
     If Dw=Length(LocalKey.Raw) Then
      begin
       Ok:=True;
       LocalKey.Path:=Path+Name;
      end;
    end;
   CloseHandle(Handle);
  end;
 If Ok Then Goto rexit;

 pepHaltDbgMsg(3); 

rexit:
  Ok:=True;
end;

{===============================PROCEDURE==================================}

Procedure DeleteKey;
label rexit;
begin
 If LocalKey.Path='' Then Goto rexit;
 If Copy(LocalKey.Path, 1, 5)='HKCU\' Then
  begin
   SaveKey('','');
  end
 Else
  begin
   If FileExists(LocalKey.Path)=True Then
    DeleteFileW(PWideChar(LocalKey.Path));
  end;
 LocalKey.Key:='';
 LocalKey.Name:='';
 LocalKey.Path:='';
 rexit:
  SetLength(LocalKey.Raw, 0);
end;

{===============================PROCEDURE==================================}

Procedure ppiDeleteKey;
begin
 
 DeleteKey;
 
end;

{===============================PROCEDURE==================================}

Procedure LoadKey;
label rexit;
var
 Name, Path : TConstWString;
 Handle : THandle;
 RegKeyHandle : HKEY;
 Dw : TConstDWord;
begin
 LocalKey.Key:='';
 LocalKey.Name:='';
 LocalKey.Path:='';
 SetLength(LocalKey.Raw, 0);
 Name:=Statica.VarW[0,11]; 

 Path:=ExtractFilePath(ParamStr(0));
 If FileExists(Path+Name)=True Then
  begin
   Handle:=CreateFileW(PWideChar(Path+Name),GENERIC_READ,
                       0, nil, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, 0);
   If Handle<>INVALID_HANDLE_VALUE Then
    begin
     SetLength(LocalKey.Raw, $3000);
     If ReadFile(Handle, LocalKey.Raw[0], $1000, Dw, nil) Then
      begin
       SetLength(LocalKey.Raw, Dw);
       LocalKey.Path:=Path+Name;
      end else SetLength(LocalKey.Raw, 0);
     CloseHandle(Handle);
     If Length(LocalKey.Raw)>0 Then Goto rexit;
    end;
  end;

 Path:='Software\'+KeyPathDelegate+'\';
 RegOpenKeyExW(HKEY_CURRENT_USER, PWideChar(Path),0,KEY_READ, RegKeyHandle);
 If RegKeyHandle<>0 Then
  Begin
   SetLength(LocalKey.Raw, $3000);
   RegQueryValueExW(RegKeyHandle, PWideChar(Name), nil, nil, PByte(@LocalKey.Raw[0]), @Dw);
   If (Dw>0) Then SetLength(LocalKey.Raw, Dw) else SetLength(LocalKey.Raw, 0);
   RegCloseKey(RegKeyHandle);
   If Length(LocalKey.Raw)>0 Then
    begin
     LocalKey.Path:='HKCU\'+Path+Name;
     Goto rexit;
    end;
  End;

 SetLength(Path, 4096);
 Dw:=GetEnvironmentVariableW(PWideChar('APPDATA'), PWideChar(Path), 2000);
 SetLength(Path, Dw);
 If Path<>'' Then Path:=IncludeTrailingPathDelimiter(Path);
 Path:=Path+KeyPathDelegate+'\';
 If FileExists(Path+Name)=True Then
  begin
   Handle:=CreateFileW(PWideChar(Path+Name),GENERIC_READ,
                       0, nil, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, 0);
   If Handle<>INVALID_HANDLE_VALUE Then
    begin
     SetLength(LocalKey.Raw, $3000);
     If ReadFile(Handle, LocalKey.Raw[0], $1000, Dw, nil) Then
      begin
       SetLength(LocalKey.Raw, Dw);
       LocalKey.Path:=Path+Name;
      end else SetLength(LocalKey.Raw, 0);
     CloseHandle(Handle);
     If Length(LocalKey.Raw)>0 Then Goto rexit;
    end;
  end;
rexit:
 dw:=0; 
end;

{===============================PROCEDURE==================================}

Function ppiGetHaveKey:Int64;
begin

If Statica.ValueExists(catLicensing, valKey)=False Then Result:=-1
 Else Result:=1;

end;

{===============================PROCEDURE==================================}

Function ppiGetTrialExecutionCount:Int64;
begin
 
 Result:=TrialExecutionCount;
 
end;

{===============================PROCEDURE==================================}

Function ppiGetTrialDaysCount:Int64;
begin
 
 Result:=TrialDaysCount;
 
end;

{===============================PROCEDURE==================================}

Function ppiGetLicenseIDFmt:TConstWString;
begin
 
 Result:=Statica.VarW[catLicensing, valFmtHWID];
 
end;

{===============================PROCEDURE==================================}

Function ppiGetKeyPath:TConstWString;
begin

Result:=LocalKey.Path;

end;

{===============================PROCEDURE==================================}

Function ppiGetKeyValue:TConstWString;
begin

Result:=LocalKey.Key;

end;

{===============================PROCEDURE==================================}

Function ppiGetNameValue:TConstWString;
begin

Result:=LocalKey.Name;

end;

{===============================PROCEDURE==================================}

Procedure LoadTrialParams;
Label rexit;
var
 RegKeyHandle : HKEY;
 C64 : TConstQWord;
begin
 
 FillChar(TrialParams, SizeOf(TrialParams), 0);
 TrialParams.ClockMan:= DateTimeToUnix(Now);
 TrialParams.TrialDCount:= DateTimeToUnix(Now);
 RegOpenKeyExW(HKEY_CLASSES_ROOT, PWideChar(Statica.VarW[1,0]),0,KEY_READ, RegKeyHandle);
 

 If RegKeyHandle = 0 Then Goto rexit;

 
 C64:=SizeOf(TrialParams);
 RegQueryValueExW(RegKeyHandle, nil, nil, nil, PByte(@TrialParams), @C64);
 If C64<>SizeOf(TrialParams) Then pepHaltDbgMsg;
 RegCloseKey(RegKeyHandle);
 rc4decrypt(@TrialParams, SizeOf(TrialParams), rcEncryption);
 

rexit:
 C64:=0;
end;

{===============================PROCEDURE==================================}

Procedure SaveTrialParams;
Label rexit;
var
 RegKeyHandle : HKEY;
 C64, D64 : TConstQWord;
begin
 
 D64:=0;
 C64:=RegCreateKeyExW(HKEY_CLASSES_ROOT, PWideChar(Statica.VarW[1,0]), 0, '',
                    REG_OPTION_NON_VOLATILE, KEY_ALL_ACCESS, nil, RegKeyHandle, @D64);
 
 If RegKeyHandle = 0 Then Goto rexit;
 If C64 <> ERROR_SUCCESS Then Goto rexit;

 
 rc4crypt(@TrialParams, SizeOf(TrialParams), rcEncryption);
 RegSetValueExW(RegKeyHandle, nil,0, REG_BINARY, @TrialParams, SizeOf(TrialParams));
 RegCloseKey(RegKeyHandle);
 

 rexit:
  C64:=0;
end;

{===============================PROCEDURE==================================}

Procedure VerifyTrialParams;
var
 Handle : THandle;
 RegKeyHandle : HKEY;
 C64, T64, D64 : TConstQWord;
 DT : TDateTime;
begin
 
 T64:=Statica.VarC64[0,9]; 
 If TrialParams.ClockMan<T64 Then pepHaltDbgMsg(8);
 T64:=DateTimeToUnix(Now);
 If TrialParams.ClockMan>T64 Then pepHaltDbgMsg(8);
 TrialParams.ClockMan:=T64;
 
T64:=Statica.VarC64[0,10];      
If T64<>0 Then
 begin
  

  Handle:=CreateFileW(PWideChar(ParamStr(0)+':'+Statica.VarW[1,1]),GENERIC_READ,
                      0, nil, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, 0);
  If Handle<>INVALID_HANDLE_VALUE Then pepHaltDbgMsg(2);

  RegOpenKeyExW(HKEY_CLASSES_ROOT, PWideChar(Statica.VarW[1,1]),0,KEY_READ, RegKeyHandle);
  If RegKeyHandle <> 0 Then pepHaltDbgMsg(2);
  

  C64:=Statica.VarC64[0,9];     
  D64:=DateTimeToUnix(Now);     
  If (T64<D64) or (T64<C64) Then 
   begin
    
    Handle:=CreateFileW(PWideChar(ParamStr(0)+':'+Statica.VarW[1,1]),GENERIC_WRITE,
                        0,nil,CREATE_ALWAYS, FILE_ATTRIBUTE_NORMAL, 0);
    If Handle<>INVALID_HANDLE_VALUE Then CloseHandle(Handle);

    RegCreateKeyExW(HKEY_CLASSES_ROOT, PWideChar(Statica.VarW[1,1]), 0, '',
                    REG_OPTION_NON_VOLATILE, KEY_ALL_ACCESS, nil, RegKeyHandle, @C64);
    pepHaltDbgMsg(2);
    
   end;
 end;



 TrialExecutionCount:=0;
 If (Statica.VarB[0,15]=True) and (ppiGetHaveKey<>1) Then
  begin
   
   TrialExecutionCount:=Statica.VarI64[0,16];
   If TrialParams.TrialECount<0 Then pepHaltDbgMsg(9);
   If TrialParams.TrialECount>=TrialExecutionCount Then pepHaltDbgMsg(9); // msg exec expired!
   TrialParams.TrialECount:=TrialParams.TrialECount+1;
   TrialExecutionCount:=TrialExecutionCount - TrialParams.TrialECount;
   
  End;

 TrialDaysCount:=0;
 If (Statica.VarB[0,13]=True) and (ppiGetHaveKey<>1) Then
  begin
   
   DT:=UnixToDateTime(TrialParams.TrialDCount); 
   DT:=IncDay(DT,Statica.VarI64[0,14]);
   C64:=DateTimeToUnix(DT);                     
   T64:=DateTimeToUnix(Now);
   If T64>C64 Then pepHaltDbgMsg(10); 
   TrialDaysCount:=DaysBetween(Now, DT);
   
  End;
end;

{===============================PROCEDURE==================================}

Procedure InitializeLicensing;
begin
 
 LocalKey.Key:='';
 LocalKey.Name:='';
 LocalKey.Path:='';
 SetLength(LocalKey.Raw, 0);
 catLicensing:=Statica.AllocSection();
 valFmtHWID:=Statica.AllocValue(catLicensing);
 Statica.VarI64[catLicensing, valFmtHWID]:=Random(MaxInt); 
 rc4memtokey(Statica.VarBuf(0, 18), Statica.VarSize(0, 18), rcEncryption);
 
end;

{===============================PROCEDURE==================================}

Procedure ResetTrialCommand;
begin
 
 FillChar(TrialParams, SizeOf(TrialParams), 0);
 TrialParams.ClockMan:= DateTimeToUnix(Now);
 TrialParams.TrialDCount:= DateTimeToUnix(Now);
 SaveTrialParams; 
 
end;

{===============================PROCEDURE==================================}

Procedure InitializeHWID;
begin
 InitializeTrialVersionHWID;
end;

{===============================PROCEDURE==================================}

Procedure InitializeTrialVersionHWID;
begin
 
 Statica[catLicensing, valFmtHWID]:=Statica.VarW[0, 21]+'-11111111-11111111-2222222222222222';
 
end;

{===============================PROCEDURE==================================}






end.


unit EngineAPI;


{$DEFINE PM}     


interface
uses PlatformConsts;



Procedure RegisterAppCallHandler;


Function HooKppiProtectionStatus(const hApp:TConstQWord=0):TConstQWord;stdcall;
Function HooKppiGetTrialDaysCount(const hApp:TConstQWord=0):TConstQWord;stdcall;
Function HooKppiGetTrialExecutionCount(const hApp:TConstQWord=0):TConstQWord;stdcall;
Function HooKppiGetLicenseId(const hApp:TConstQWord=0):PWideChar;stdcall;
Function HooKppiGetKeyPath(const hApp:TConstQWord=0):PWideChar;stdcall;
Function HooKppiGetKeyValue(const hApp:TConstQWord=0):PWideChar;stdcall;
Function HooKppiGetUserNameValue(const hApp:TConstQWord=0):PWideChar;stdcall;
Function HooKppiGetUserOption(const hApp:TConstQWord=0; hNumber:TConstQWord=0):TConstQWord;stdcall;
Function HooKppiGetKeyExpirationDate(const hApp:TConstQWord=0):PWideChar;stdcall;
Function HooKppiDeleteKey(const hApp:TConstQWord=0):TConstQWord;stdcall;
Function HooKppiSaveKey(const hApp:TConstQWord; const AName:PWideChar; const AKeyValue:PWideChar):TConstQWord;stdcall;
Function HooKppiGetHaveKey(const hApp:TConstQWord=0):TConstQWord;stdcall;







implementation
Uses Winapi.Windows, Licensing;


// HERE FULL PORT OF API's for integration (direct import link)

Function HooKppiProtectionStatus(const hApp:TConstQWord=0):TConstQWord;stdcall;
begin
 
 Result:=1;
 
end;

Function HooKppiGetTrialDaysCount(const hApp:TConstQWord=0):TConstQWord;stdcall;
begin
 
 Result:=ppiGetTrialDaysCount();
 
end;

Function HooKppiGetTrialExecutionCount(const hApp:TConstQWord=0):TConstQWord;stdcall;
begin
 
 Result:=ppiGetTrialExecutionCount();
 
end;

Function HooKppiGetLicenseId(const hApp:TConstQWord=0):PWideChar;stdcall;
begin
 
 Result:=PWideChar(ppiGetLicenseIDFmt());
 
end;

Function HooKppiGetKeyPath(const hApp:TConstQWord=0):PWideChar;stdcall;
begin
 
 Result:=PWideChar(ppiGetKeyPath());
 
end;

Function HooKppiGetKeyValue(const hApp:TConstQWord=0):PWideChar;stdcall;
begin
 
 Result:=PWideChar(ppiGetKeyValue());
 
end;

Function HooKppiGetUserNameValue(const hApp:TConstQWord=0):PWideChar;stdcall;
begin
 
 Result:=PWideChar(ppiGetNameValue());
 
end;

Function GetBit(const B, Num:Byte):Boolean;
begin
 Result:=((B shr Num) and 1) = 1;
end;

Function HooKppiGetUserOption(const hApp:TConstQWord=0; hNumber:TConstQWord=0):TConstQWord;stdcall;
begin
 
 Result:=TConstQWord(GetBit(ppiUserOptions(), hNumber));
 
end;

Function HooKppiGetKeyExpirationDate(const hApp:TConstQWord=0):PWideChar;stdcall;
begin
 
 Result:=PWideChar(ppiKeyExpiration());
 
end;

Function HooKppiDeleteKey(const hApp:TConstQWord=0):TConstQWord;stdcall;
begin
 
 ppiDeleteKey();
 Result:=1;
 
end;

Function HooKppiSaveKey(const hApp:TConstQWord; const AName:PWideChar; const AKeyValue:PWideChar):TConstQWord;stdcall;
begin
 
 SaveKey(AName, AKeyValue);
 Result:=1;
 
end;

Function HooKppiGetHaveKey(const hApp:TConstQWord=0):TConstQWord;stdcall;
begin
 
 Result:=ppiGetHaveKey();
 
end;








{===============================PROCEDURE==================================}

Function AppCall(const hApi, hLParam, hRParam:TConstQWord):TConstQWord;stdcall;
begin
 //-->
 case hApi of
  0:
    begin
     Result:=1;
     Exit;
    end;
  1:
    begin
     Result:=ppiGetHaveKey;
     Exit;
    end;
  2:
    begin
     Result:=ppiGetTrialDaysCount;
     Exit;
    end;
  3:
    begin
     Result:=ppiGetTrialExecutionCount;
     Exit;
    end;
  4:
    begin
     Result:=ppiUserOptions;
     Exit;
    end;
  5:
    begin
     Result:=TConstQWord(PWideChar(ppiGetLicenseIDFmt));
     Exit;
    end;
  6:
    begin
     Result:=TConstQWord(PWideChar(ppiGetKeyPath));
     Exit;
    end;
  7:
    begin
     Result:=TConstQWord(PWideChar(ppiGetKeyValue));
     Exit;
    end;
  8:
    begin
     Result:=TConstQWord(PWideChar(ppiGetNameValue));
     Exit;
    end;
  9:
    begin
     Result:=TConstQWord(PWideChar(ppiKeyExpiration));
     Exit;
    end;
  10:
    begin
     ppiDeleteKey;
     Result:=1;
     Exit;
    end;
  11:
    begin
     SaveKey(PWideChar(hLParam), PWideChar(hRParam));
     Result:=1;
     Exit;
    end;
  Else Result:=0;
 end;
 //-->
end;

{===============================PROCEDURE==================================}

Procedure RegisterAppCallHandler;
begin

end;

{===============================PROCEDURE==================================}





end.


unit ssLameCrypt;




Interface




Type
 TameRSAHandle = record
  hContainer : UInt64;
  hProvider : THandle;
  hKey : THandle;
  hHash : THandle;
 end;
 TameRSABytes = Array of Byte;
 TameRSAKey  = TameRSABytes;
 TameRSAMD5  = TameRSABytes;  
 TameRSASign = TameRSABytes;  
 TameCRC     = UInt64;




Function ameCrC(Source:PByte; Length:Int64):TameCRC;
Function ameStringCrC(const S:{$IFDEF FPC}WideString{$ELSE}String{$ENDIF}):TameCRC;inline;
Function ameAnsiStringCrC(const S:AnsiString):TameCRC;inline;
Function ameIntCrC(const I:Int64):TameCRC;inline;
Function ameAEncode(const Buf:Pointer;var Sz:Int64):Pointer; inline;
Function ameADecode(const Buf:Pointer;var PackedSize:Int64):Pointer; inline;

Function  rsaNewHandle(const HashCheck:Boolean=False):TameRSAHandle;
Procedure rsaFreeHandle(var H:TameRSAHandle);
Procedure rsaGenerateKeys(var H:TameRSAHandle);
Procedure rsaExportPublicKey(const H:TameRSAHandle; var K:TameRSAKey);
Procedure rsaExportPrivateKey(const H:TameRSAHandle; var K:TameRSAKey);
Procedure rsaImportKey(var H:TameRSAHandle; const K:TameRSAKey);
Procedure rsaBlockIn(const M: Pointer;const ASize:Int64;var OutBuf:Pointer; var OutSize:Int64; const AHandle:TameRSAHandle);
Procedure rsaOut(const M : Pointer;const ASize:Int64; const AHandle:TameRSAHandle);
Procedure rsaFreeKey(var K:TameRSAKey);
Procedure rsaSignData(const M : Pointer;const ASize:Int64; const APrivateKey:TameRSAKey; var Sign:TameRSASign);
Function  rsaVerifySign(const M : Pointer;const ASize:Int64; const APublicKey:TameRSAKey; const Sign:TameRSASign):Boolean;

Procedure rsaMD5(const M:Pointer;const ASize:Int64; var RMD: TameRSAMD5);
Function rsaMD5U(const M:Pointer;const ASize:Int64):string;


Procedure rc4crypt(M:PByte; Sz:Int64; const C:TameRSABytes);inline;
Procedure rc4decrypt(M:PByte; Sz:Int64; const C:TameRSABytes);inline;
Procedure rc4key(var C:TameRSABytes; KLen:Int64=4096);inline;
Procedure rc4freekey(var C:TameRSABytes);inline;
Procedure rc4mergekeys(var C:TameRSABytes; const K1:TameRSABytes; const K2:TameRSABytes);inline;
Procedure rc4addkeys(var C:TameRSABytes; const K1:TameRSABytes; const K2:TameRSABytes);inline;
Procedure rc4xorkeys(var C:TameRSABytes; const K1:TameRSABytes; const K2:TameRSABytes);inline;
Procedure rc4memtokey(M:PByte; const Sz:Int64; var C:TameRSABytes);//inline;









implementation
Uses  Winapi.Windows, {$IFNDEF FPC}ssZLib{$ELSE}fpczlib{$ENDIF};



Type
 HCRYPTPROV = THandle;
 HCRYPTHASH = THandle;
 HCRYPTKEY = THandle;
 ALG_ID = Cardinal;

const
 advapiname = 'advapi32.dll';


function CryptAcquireContextW(var phProv: HCRYPTPROV; pszContainer: LPCWSTR;
  pszProvider: LPCWSTR; dwProvType: Cardinal; dwFlags: Cardinal): BOOL; stdcall;
  external advapiname name 'CryptAcquireContextW';
function CryptReleaseContext(hProv: HCRYPTPROV; dwFlags: ULONG_PTR): BOOL; stdcall;
 external advapiname name 'CryptReleaseContext';
function CryptGenKey(hProv: HCRYPTPROV; Algid: ALG_ID; dwFlags: Cardinal;
  var phKey: HCRYPTKEY): BOOL; stdcall;
 external advapiname name 'CryptGenKey';
function CryptExportKey(hKey, hExpKey: HCRYPTKEY; dwBlobType, dwFlags: Cardinal;
  pbData: LPBYTE; var pdwDataLen: Cardinal): BOOL; stdcall;
 external advapiname name 'CryptExportKey';
function CryptImportKey(hProv: HCRYPTPROV; pbData: LPBYTE; dwDataLen: Cardinal;
  hPubKey: HCRYPTKEY; dwFlags: Cardinal; var phKey: HCRYPTKEY): BOOL; stdcall;
 external advapiname name 'CryptImportKey';
function CryptEncrypt(hKey: HCRYPTKEY; hHash: HCRYPTHASH; Final: BOOL;
  dwFlags: Cardinal; pbData: LPBYTE; var pdwDataLen: Cardinal; dwBufLen: Cardinal): BOOL; stdcall;
 external advapiname name 'CryptEncrypt';
function CryptDecrypt(hKey: HCRYPTKEY; hHash: HCRYPTHASH; Final: BOOL;
  dwFlags: Cardinal; pbData: LPBYTE; var pdwDataLen: Cardinal): BOOL; stdcall;
 external advapiname name 'CryptDecrypt';
function CryptGetProvParam(hProv: HCRYPTPROV; dwParam: Cardinal; pbData: LPBYTE;
  var pdwDataLen: Cardinal; dwFlags: Cardinal): BOOL; stdcall;
 external advapiname name 'CryptGetProvParam';
function CryptGetKeyParam(hKey: HCRYPTKEY; dwParam: Cardinal; pbData: LPBYTE;
  var pdwDataLen: Cardinal; dwFlags: Cardinal): BOOL; stdcall;
 external advapiname name 'CryptGetKeyParam';
function CryptGenRandom(hProv: HCRYPTPROV; dwLen: Cardinal; pbBuffer: LPBYTE): BOOL; stdcall;
 external advapiname name 'CryptGenRandom';
function CryptSetKeyParam(hKey: HCRYPTKEY; dwParam: Cardinal; pbData: LPBYTE;
  dwFlags: Cardinal): BOOL; stdcall;
 external advapiname name 'CryptSetKeyParam';
function CryptCreateHash(hProv: HCRYPTPROV; Algid: ALG_ID; hKey: HCRYPTKEY;
  dwFlags: Cardinal; var phHash: HCRYPTHASH): BOOL; stdcall;
 external advapiname name 'CryptCreateHash';
function CryptHashData(hHash: HCRYPTHASH; pbData: LPBYTE; dwDataLen, dwFlags: Cardinal): BOOL; stdcall;
 external advapiname name 'CryptHashData';
function CryptGetHashParam(hHash: HCRYPTHASH; dwParam: Cardinal; pbData: LPBYTE;
  var pdwDataLen: Cardinal; dwFlags: Cardinal): BOOL; stdcall;
 external advapiname name 'CryptGetHashParam';
function CryptDestroyHash(hHash: HCRYPTHASH): BOOL; stdcall;
 external advapiname name 'CryptDestroyHash';
function CryptDestroyKey(hKey: HCRYPTKEY): BOOL; stdcall;
 external advapiname name 'CryptDestroyKey';
function CryptSignHashW(hHash:HCRYPTHASH; dwKeySpec: DWORD;
                       sDescription :LPCWSTR; dwFlags: DWORD; pbSignature:PBYTE;
                       pdwSigLen: PDWORD):BOOL; stdcall;
 external advapiname name 'CryptSignHashW';
function CryptVerifySignatureW(hHash : HCRYPTHASH; const pbSignature : PBYTE;
                               dwSigLen: DWORD; hPubKey:HCRYPTKEY;
                               sDescription:LPCWSTR; dwFlags : DWORD) :BOOL; stdcall;
 external advapiname name 'CryptVerifySignatureW';







const
 PROV_RSA_FULL      = 1;
 CRYPT_VERIFYCONTEXT  = DWORD($F0000000);
 CRYPT_NEWKEYSET      = $00000008;
 CRYPT_DELETEKEYSET   = $00000010;
 AT_KEYEXCHANGE = 1;
 CRYPT_EXPORTABLE     = $00000001;
 SIMPLEBLOB           = $1;
 PRIVATEKEYBLOB       = $7;
 PUBLICKEYBLOB        = $6;
 ALG_CLASS_DATA_ENCRYPT = 3 shl 13;
 ALG_TYPE_STREAM        = 4 shl 9;
 ALG_CLASS_HASH         = 4 shl 13;
 HP_HASHVAL       = $0002; // Hash value
 ALG_SID_MD5        = 3;
 ALG_SID_RC4  = 1;
 ALG_TYPE_ANY           = 0;
 CALG_RC4                  = ALG_CLASS_DATA_ENCRYPT or ALG_TYPE_STREAM or ALG_SID_RC4;
 CALG_MD5                  = ALG_CLASS_HASH or ALG_TYPE_ANY or ALG_SID_MD5;
 RSA1024BIT_KEY       = $08000000;
 KP_BLOCKLEN           = 8;  // Block size of the cipher



var
  crc64_table_empty : boolean = TRUE;
  crc64_table : array of TameCRC;






{===============================PROCEDURE==================================}

Procedure rc4memtokey(M:PByte; const Sz:Int64; var C:TameRSABytes);
var
 I, H : Integer;
begin
 H:=High(C)+1;
 SetLength(C, Length(C)+Sz);
 For I:=0 to Sz-1 do
  begin
   C[H+I]:=M^;
   Inc(M);
  end;
end;

{===============================PROCEDURE==================================}

function IntToStr(Value: Int64): string;
begin
 System.Str(Value, Result);
end;

{===============================PROCEDURE==================================}

Procedure rc4mergekeys(var C:TameRSABytes; const K1:TameRSABytes; const K2:TameRSABytes);
Var
 I, G :Integer;
begin
 SetLength(C, Length(K1)+Length(K2));
 G:=Low(C);
 For I:=Low(K1) to High(K1) do
  begin
    C[G]:=K1[I];
    Inc(G);
  end;
 For I:=Low(K2) to High(K2) do
  begin
    C[G]:=K2[I];
    Inc(G);
  end;
end;

{===============================PROCEDURE==================================}

Procedure rc4addkeys(var C:TameRSABytes; const K1:TameRSABytes; const K2:TameRSABytes);
Var
 I : Integer;
begin
 SetLength(C, Length(K1));
 For I:=Low(K1) to High(K1) do C[I]:=K1[I]+K2[I];
end;

{===============================PROCEDURE==================================}

Procedure rc4xorkeys(var C:TameRSABytes; const K1:TameRSABytes; const K2:TameRSABytes);inline;
Var
 I : Integer;
begin
 SetLength(C, Length(K1));
 For I:=Low(K1) to High(K1) do C[I]:=Byte(K1[I] xor K2[I]);
end;

{===============================PROCEDURE==================================}

Procedure rc4freekey(var C:TameRSABytes);
begin
 SetLength(C, 0);
end;

{===============================PROCEDURE==================================}

Procedure rc4key(var C:TameRSABytes; KLen:Int64=4096);
Var
 I : Integer;
begin
 SetLength(C, KLen);
 For I:=Low(C) To High(C) do C[I]:=Random(255);
end;

{===============================PROCEDURE==================================}

Procedure rc4decrypt(M:PByte; Sz:Int64; const C:TameRSABytes);
var
 K, T : Int64;
 B, P : Byte;
begin
 If (Length(C)=0) or (Sz=0) Then Exit;
 K:=Low(C);
 T:=High(C);
 B:=C[K] xor C[T];
 while Sz>0 do
  begin
   P:=M^;
   M^:=M^ xor B;
   M^:=M^ - C[T];
   M^:=M^ xor C[K];
   B:=P;
   If K=High(C) Then K:=Low(C);
   If T=Low(C) Then T:=High(C);
   Inc(M); Dec(Sz); Inc(K); Dec(T);
  end;
end;

{===============================PROCEDURE==================================}

Procedure rc4crypt(M:PByte; Sz:Int64; const C:TameRSABytes);
var
 K, T : Int64;
 B : Byte;
begin
 If (Length(C)=0) or (Sz=0) Then Exit;
 K:=Low(C);
 T:=High(C);
 B:=C[K] xor C[T];
 while Sz>0 do
  begin
   M^:=M^ xor C[K];
   M^:=M^ + C[T];
   M^:=M^ xor B;
   B:=M^;
   If K=High(C) Then K:=Low(C);
   If T=Low(C) Then T:=High(C);
   Inc(M); Dec(Sz); Inc(K); Dec(T);
  end;
end;

{===============================PROCEDURE==================================}

Procedure rsaFreeKey(var K:TameRSAKey);inline;
begin
 SetLength(K, 0);
end;

{===============================PROCEDURE==================================}

Function rsaMD5U(const M:Pointer;const ASize:Int64):string;
Var
 D : TameRSAMD5;
 I : Integer;
begin
 Result:='';
 SetLength(D, 0);
 rsaMD5(M, ASize, D);
 For I:=Low(D) To High(D) do Result:=Result+Chr(D[I]);
 SetLength(D, 0);
end;

{===============================PROCEDURE==================================}

Procedure rsaMD5(const M:Pointer;const ASize:Int64; var RMD: TameRSAMD5);
Var
 R: TameRSAHandle;
 DL : Cardinal;
begin
 R:=rsaNewHandle(True);
 CryptCreateHash(R.hProvider, CALG_MD5,0,0, R.hHash);
 CryptHashData(R.hHash, M, ASize, 0);
 DL:=16;
 SetLength(RMD, DL);
 CryptGetHashParam(R.hHash, HP_HASHVAL, PByte(@RMD[0]), DL,0);
 CryptDestroyHash(R.hHash);
 rsaFreeHandle(R);
end;

{===============================PROCEDURE==================================}

Procedure rsaSignData(const M : Pointer;const ASize:Int64; const APrivateKey:TameRSAKey; var Sign:TameRSASign);
Var
 R  : TameRSAHandle;
 DL : Cardinal;
begin
 SetLength(Sign, 0);
 R:=rsaNewHandle(True);
 CryptCreateHash(R.hProvider, CALG_MD5,0,0, R.hHash);
 rsaImportKey(R, APrivateKey);
 CryptHashData(R.hHash, M, ASize, 0);
 If CryptSignHashW(R.hHash, AT_KEYEXCHANGE, nil, 0, nil, @DL) then
  begin
   SetLength(Sign, DL);
   CryptSignHashW(R.hHash, AT_KEYEXCHANGE, nil, 0, @Sign[0], @DL);
  end;
 CryptDestroyHash(R.hHash);
 rsaFreeHandle(R);
end;

{===============================PROCEDURE==================================}

Function  rsaVerifySign(const M : Pointer;const ASize:Int64;
                        const APublicKey:TameRSAKey; const Sign:TameRSASign):Boolean;
Var
 R  : TameRSAHandle;
 DL : Cardinal;
begin
 R:=rsaNewHandle(True);
 CryptCreateHash(R.hProvider, CALG_MD5,0,0, R.hHash);
 rsaImportKey(R, APublicKey);
 CryptHashData(R.hHash, M, ASize, 0);
 DL:=Length(Sign);
 If CryptVerifySignatureW(R.hHash, @Sign[0], DL, R.hKey, nil, 0)=True then
  Result:=True Else Result:=False;
 CryptDestroyHash(R.hHash);
 rsaFreeHandle(R);
end;

{===============================PROCEDURE==================================}

Procedure rsaBlockIn(const M: Pointer;const ASize:Int64;var OutBuf:Pointer; var OutSize:Int64; const AHandle:TameRSAHandle);
Var
 BLen, ZLen : Cardinal;
 B : PByte;
 Flag : Boolean;
 DSize : Int64;
begin
 OutBuf:=nil;
 OutSize:=0;
 If ASize=0 Then Exit;
 // get data block length
 ZLen:=0;
 BLen:=4;
 CryptGetKeyParam(AHandle.hKey, KP_BLOCKLEN, @ZLen, BLen, 0);
 If ZLen=0 then Exit;
 // get buf size
 ZLen:=ZLen div 8;
 OutSize:= ((ASize+ZLen-1) div ZLen)*ZLen;
 OutBuf:=AllocMem(OutSize);
 Move(M^, OutBuf^, ASize);
 // crypt
 ZLen:=117;     //  max 117 for 1024 rsa
 DSize:=ASize;
 B:=OutBuf;
 Flag:=False;
 while True do
  begin
   Dec(DSize, ZLen);
   If DSize<=0 Then Flag:=True;
   Blen:=ZLen;
   if not CryptEncrypt(AHandle.hKey, 0, Flag, 0, B, BLen, OutSize) then
    {MessageBox(0,PChar(IntToStr(GetLastError)),nil,mb_ok)};
   Inc(B, ZLen);
   If Flag Then Break;
  end;
 end;

{===============================PROCEDURE==================================}

Procedure rsaOut(const M : Pointer;const ASize:Int64; const AHandle:TameRSAHandle);
//Var
 //BLen : Cardinal;
begin
 raise TObject(nil);
 //BLen:=ASize;
 //CryptDecrypt(AHandle.hKey{hAlgKey}, 0, True, 0, M, BLen);
end;

{===============================PROCEDURE==================================}

Procedure rsaImportKey(var H:TameRSAHandle; const K:TameRSAKey);
begin
 CryptImportKey(H.hProvider, @K[0], Length(K), 0, 0, H.hKey);
end;

{===============================PROCEDURE==================================}

Procedure rsaExportPublicKey(const H:TameRSAHandle; var K:TameRSAKey);
Var
 DataLen : Cardinal;
begin
 DataLen:=0;
 CryptExportKey(H.hKey, 0, PUBLICKEYBLOB, 0, nil, DataLen);
 SetLength(K, DataLen);
 CryptExportKey(H.hKey, 0, PUBLICKEYBLOB, 0, @K[0], DataLen);
end;

{===============================PROCEDURE==================================}

Procedure rsaExportPrivateKey(const H:TameRSAHandle; var K:TameRSAKey);
Var
 DataLen : Cardinal;
begin
 DataLen:=0;
 CryptExportKey(H.hKey, 0, PRIVATEKEYBLOB, 0, nil, DataLen);
 SetLength(K, DataLen);
 CryptExportKey(H.hKey, 0, PRIVATEKEYBLOB, 0, @K[0], DataLen);
end;

{===============================PROCEDURE==================================}

Procedure rsaGenerateKeys(var H:TameRSAHandle);
begin
 CryptGenKey(H.hProvider, AT_KEYEXCHANGE, CRYPT_EXPORTABLE or RSA1024BIT_KEY, H.hKey);
end;

{===============================PROCEDURE==================================}

Function rsaNewHandle(const HashCheck:Boolean=False):TameRSAHandle;
begin
 Randomize;
 FillChar(Result, SizeOf(Result),0);
 Result.hContainer:=Abs(Random(MaxInt));
 CryptAcquireContextW(Result.hProvider, PWideChar(IntToStr(Result.hContainer)),
                      nil, PROV_RSA_FULL, CRYPT_DELETEKEYSET);
 If HashCheck=False Then
  CryptAcquireContextW(Result.hProvider, PWideChar(IntToStr(Result.hContainer)),
                       nil, PROV_RSA_FULL, CRYPT_NEWKEYSET)
 Else
  begin
   CryptAcquireContextW(Result.hProvider, nil, nil, PROV_RSA_FULL, CRYPT_VERIFYCONTEXT);
  end;
end;

{===============================PROCEDURE==================================}

Procedure rsaFreeHandle(var H:TameRSAHandle);
begin
 If H.hHash<>0 Then CryptDestroyHash(H.hHash);
 If H.hKey<>0 Then CryptDestroyKey(H.hKey);
 CryptReleaseContext(H.hProvider,0);
 H.hProvider:=0;
 CryptAcquireContextW(H.hProvider, PWideChar(IntToStr(H.hContainer)), nil,
                      PROV_RSA_FULL, CRYPT_DELETEKEYSET);
 H.hContainer:=0;
 H.hProvider:=0;
 H.hKey:=0;
 H.hHash:=0;
end;

{===============================PROCEDURE==================================}

Function ameAEncode(const Buf:Pointer;Var Sz:Int64):Pointer;
Var
 SzOut : Integer;
Begin
 {$IFNDEF FPC}
 ZCompress(Buf, Sz, Result, SzOut, zcMax);
 Sz:=SzOut;
 {$ELSE}
 Result:=nil;
 Sz:=0;
 {$ENDIF}
End;

{===============================PROCEDURE==================================}

Function ameADecode(const Buf:Pointer;Var PackedSize:Int64):Pointer;
Var
 OutSz : Integer;
Begin
 ZDecompress(Buf, PackedSize, Result, OutSz);
 PackedSize:=OutSz;
End;

{===============================PROCEDURE==================================}

procedure make_crc64_table;
const
  POLY64REV  = UInt64($95AC9329AC4BC9B5);
var
  i,j: Integer;
  part: UInt64;
begin
 SetLength(crc64_table, 256 {Byte});
  for i := 0 to 255 do
  begin
    part := i;
    for j := 0 to 7 do
    begin
      if part and $1 <> 0 then
        part := (part shr 1) xor POLY64REV
      else
        part := part shr 1;
    end;
    crc64_table[i] := part;
  end;
  crc64_table_empty := FALSE;
end;

{===============================PROCEDURE==================================}

Function ameCrC(Source:PByte;Length:Int64):TameCRC;
begin
 Result:=0;
 if (Source = nil) then Exit;;

 if crc64_table_empty then make_crc64_table;

 while (Length >= 8) do
 begin
  Result := crc64_table[(Result xor Source^) and $ff] xor (Result shr 8);
  inc(Source);
  Result := crc64_table[(Result xor Source^) and $ff] xor (Result shr 8);
  inc(Source);
  Result := crc64_table[(Result xor Source^) and $ff] xor (Result shr 8);
  inc(Source);
  Result := crc64_table[(Result xor Source^) and $ff] xor (Result shr 8);
  inc(Source);
  Result := crc64_table[(Result xor Source^) and $ff] xor (Result shr 8);
  inc(Source);
  Result := crc64_table[(Result xor Source^) and $ff] xor (Result shr 8);
  inc(Source);
  Result := crc64_table[(Result xor Source^) and $ff] xor (Result shr 8);
  inc(Source);
  Result := crc64_table[(Result xor Source^) and $ff] xor (Result shr 8);
  inc(Source);
  dec(Length, 8);
 end;

 while (Length > 0) do
 begin
  Result := crc64_table[(Result xor Source^) and $ff] xor (Result shr 8);
  inc(Source);
  dec(Length);
 end;
end;

{===============================PROCEDURE==================================}

Function ameStringCrC(const S:{$IFDEF FPC}WideString{$ELSE}String{$ENDIF}):TameCRC;
Var
 L:Int64;
Begin
 Result:=0;
 L:=Length(S);
 If L=0 Then Exit;
 Result:=ameCrC(@S[1],L*{$IFDEF FPC}2{$ELSE}SizeOf(Char){$ENDIF}); // fixed new !
End;

{===============================PROCEDURE==================================}

Function ameAnsiStringCrC(const S:AnsiString):TameCRC;
Var
 L:Int64;
Begin
 Result:=0;
 L:=Length(S);
 If L=0 Then Exit;
 Result:=ameCrC(@S[1],L);
End;

{===============================PROCEDURE==================================}

Function ameIntCrC(const I:Int64):TameCRC;inline;
begin
 Result:=ameCrC(@I, SizeOf(I));
end;





end.

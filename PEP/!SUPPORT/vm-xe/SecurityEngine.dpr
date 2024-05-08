Library SecurityEngine;

{$EXTENSION .EXE}
{$WEAKLINKRTTI ON}
{$RTTI EXPLICIT METHODS([]) PROPERTIES([]) FIELDS([])}
{$IMAGEBASE $1000000}
{$DYNAMICBASE ON}
{$DEFINE LicensingAPI}
{$DEFINE Unsafe35VirtualMachine}


uses
 Winapi.Windows, ssLameCrypt, ssStore, PlatformConsts, PreLoader
 {$ifdef LicensingAPI},EngineAPI, RegistrationDialog, Licensing{$endif}
 {$ifdef Unsafe35VirtualMachine},ssLamePCode{$endif};

{===============================PROCEDURE==================================}

Procedure ExitToEntryPoint(const asmMRET : TPlatformCardinal);assembler;stdcall;
label enter_ep;
asm
   db $EB, $03
   db $99, $08, $99

    mov esp, asmMRET
    pop ebp
    pop edi
    pop esi
    pop edx
    pop ecx
    pop ebx
    pop eax
    db $64, $8F, $05, 0,0,0,0

    cmp dword [esp], 0
    jne enter_ep
     pop eax
     mov eax, 1

    enter_ep:
     ret
   db $EB, $03
   db $98, $08, $98
end;

{===============================PROCEDURE==================================}

Function DLL_UnloadEntry(H:HMODULE; dwReason: DWord; lpvReserved:Pointer):Integer;stdcall;
Var
 C64: TConstQWord;
 CorTLS : Function(H:HMODULE; dwReason: DWord; lpvReserved:Pointer):Integer stdcall;
begin
 Result:=1;
 C64:=Statica.VarC64[0,19]+OriginIB;
 CorTLS:=Pointer(C64);
 If C64<>OriginIB Then Result:=CorTLS(H, dwReason, lpvReserved);
End;

{===============================PROCEDURE==================================}







Exports
 pepLoader
 {$ifdef LicensingAPI}
  ,
   HooKppiProtectionStatus, HooKppiGetTrialDaysCount,HooKppiGetTrialExecutionCount,
   HooKppiGetLicenseId, HooKppiGetKeyPath, HooKppiGetKeyValue,
   HooKppiGetUserNameValue, HooKppiGetUserOption, HooKppiGetKeyExpirationDate,
   HooKppiDeleteKey, HooKppiSaveKey, HooKppiGetHaveKey
 {$endif}



 {$ifdef Unsafe35VirtualMachine}
 ,vmRunPCode
 {$endif}
 ;









{-$DEFINE StaticDebug}


Var
 I, J : Integer;
 C64, V64, Z64 : TConstQWord;
 I64 : Int64;
 C32 : TConstDWord;
 Lines, Tables   : TMemoryStoreIntArray;
 P : Pointer;
 Name, Key : TConstWString;
 CorTLS : Function(H:HMODULE; dwReason: DWord; lpvReserved:Pointer):Boolean;  stdcall;
Begin
 Randomize;
 {$IFDEF StaticDebug}OriginIB:=GetModuleHandle(nil);{$ENDIF}
 SelfMZ:=Pointer(OriginIB);
 SelfNT:=Pointer(OriginIB+SelfMZ._lfanew);
 InitializeCriticalSection(Critical);


 Statica:=TMemoryStore.Create;
 {$IFNDEF StaticDebug}
  Statica.LoadFromMemory(Pointer(GLIT.dst+OriginIB), GLIT.dsz);
 {$ELSE}
  I64:=465581; P:=GetMem(I64);
  C64:=CreateFileW(PWideChar('A:\Static.dmp'), GENERIC_READ, 0, nil, 3, 128, 0);
  ReadFile(C64, P^,I64, C32, nil); CloseHandle(C64);
  Statica.LoadFromMemory(P, I64);
  Statica.VarB[0,17]:=False; // disable anti debug
 {$ENDIF}




 // [ IsLoginAsAdmin ]
 If Statica.VarB[0, 4]=True Then
  Begin
   If IsUserAdmin=False Then pepHaltDbgMsg(4);
  End;


 // [ only one exec copy ]
 If Statica.VarB[0,7] = True Then
  begin
   C64 := CreateMutexW(nil, True, PWideChar(Statica.VarW[0,0] {app name + ver}));
   if (C64 = 0) or (GetLastError() = ERROR_ALREADY_EXISTS) then pepHaltDbgMsg(7);
  End;



 // [ init trial library ]
 {$IFDEF LicensingAPI}
  InitializeLicensing;
  If ameStringCrC(pepWideUpperCase(ParamStr(1)))=Statica.VarC64[0,26] Then
   ResetTrialCommand; //  -> /ResetTrial cmd-line
  LoadTrialParams;
  InitializeTrialVersionHWID;
  LoadKey;
  If ParamStr(1)='/DeleteLKey' Then ppiDeleteKey;
   TrialVersionVerifyKey;

  // exit if no key?
  If (ppiGetHaveKey<>1) and (Statica.VarB[0,12]=True) Then
   begin
    If ShowNagScreen(Name, Key)<>1 Then pepHaltDbgMsg(-1);
    SaveKey(Name, Key);
    LoadKey;
    TrialVersionVerifyKey;
    If (ppiGetHaveKey<>1) Then pepHaltDbgMsg(-1);
   end;

  // show nag screen?
  If (ppiGetHaveKey<>1) Then
   begin
    If Statica.VarB[0,22]=True Then
     If ShowNagScreen(Name, Key)=1 Then
      begin
       SaveKey(Name, Key);
       LoadKey;
       {$IFNDEF TrialVersion} VerifyKey; {$ELSE} TrialVersionVerifyKey; {$ENDIF}
      end;
   end;

  If (ppiGetHaveKey<>1) Then VerifyTrialParams;
  SaveTrialParams;
 {$ENDIF}








// [Unpack section]    X64+
Lines:=Statica.ReadArray(14, 0);
For I:=Low(Lines) To High(Lines) Do
 begin
  V64:= Statica.VarC64[Lines[I], 1]; // va
  If V64<=0 Then Continue;
  C64:= Statica.VarC64[Lines[I], 2]; // vsize zero it any way :(
  If C64<=0 Then Continue;
  VirtualProtect(Pointer(V64+OriginIB), C64, PAGE_EXECUTE_READWRITE, @I64);
  FillChar(Pointer(V64+OriginIB)^, C64, 0);
  I64:=Statica.VarSize(Lines[I], 0);
  Move(Statica.VarBuf(Lines[I],0)^, Pointer(V64+OriginIB)^, I64);
 end;






// [Reloc table]    X64 +
C64:=Statica.VarSize(8, 0);
If C64>0 Then
 begin
  P:=Statica.VarBuf(8, 0);
  C64:=C64 div 16;
  I64:=OriginIB-GLIT.ib;
  For I:=0 To C64-1 Do
   begin
    If PConstQWord(P)^=4 Then
     begin
      P:=Pointer(TConstQWord(P)+8);
      V64:=OriginIB+PConstQWord(P)^;
      PConstDWord(V64)^:=PConstDWord(V64)^+I64;
     end;

    If PConstQWord(P)^=8 Then
     begin
      P:=Pointer(TConstQWord(P)+8);
      V64:=OriginIB+PConstQWord(P)^;
      PConstQWord(V64)^:=PConstQWord(V64)^+I64;
     end;
    P:=Pointer(TConstQWord(P)+8);
   End;
 End;







If Statica.VarC64[6,1]<>0 Then
 begin
  VirtualProtect(@SelfNT.OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_COM_DESCRIPTOR], 16, PAGE_EXECUTE_READWRITE, @I64);
  SelfNT.OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_COM_DESCRIPTOR].VirtualAddress:=Statica.VarC64[6,1];
 end;

If Statica.VarC64[6,2]<>0 Then
 begin
  VirtualProtect(@SelfNT.OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_COM_DESCRIPTOR], 16, PAGE_EXECUTE_READWRITE, @I64);
  SelfNT.OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_COM_DESCRIPTOR].Size:=Statica.VarC64[6,2];
 end;



Lines:=Statica.ReadArray(9,0); // list of librarys sections
For I:=Low(Lines) To High(Lines) Do
 begin
  Name:=Statica.VarW[Lines[I], 0]; // library name
  If Name='' Then Break;

  Z64:=GetModuleHandleW(PWideChar(Name));
  If Z64=0 Then Z64:=LoadLibraryW(PWideChar(Name));


  // [Process import table, hook functions]
  Tables:=Statica.ReadArray(Lines[I],1);
  For J:=Low(Tables) to High(Tables) Do
   begin
    If Statica.VarI64[Tables[J],1] = 0 Then
      begin

       // import by name
       Name:=Statica.VarW[Tables[J],2];
       P:=GetProcAddress(Z64,PAnsiChar(AnsiString(Name)));

      end
    Else
      begin

       // import by ord
       I64:=Statica.VarI64[Tables[J],2];
       P:=GetProcAddress(Z64,PAnsiChar(I64));

      end;


    // [ is engine hooked function? ]
    C64:=Statica.VarC64[Tables[J], 3];
    If C64>0 then P:=Pointer(C64+OriginIB);

    C64:=Statica.VarC64[Tables[J],20];
    If C64>0 Then PPointer(C64+OriginIB)^:=P;

    C64:=Statica.VarC64[Tables[J],19];        // bound IAT
    If C64>0 Then PPointer(C64+OriginIB)^:=P;
   end;
 end;



 {$IFDEF LicensingAPI}
 RegisterAppCallHandler;
 {$ENDIF}


 // TLS call-backs processing!
 For I:=0 To MaxInt Do
  begin
   C64:=Statica.VarC64[46, I];
   If C64=0 Then Break;
   CorTLS:=Pointer(C64+OriginIB);
   CorTLS(OriginIB, DLL_PROCESS_ATTACH, nil);
  End;



 // [ execution limitation ]
 {$IFDEF LicensingAPI}
 If (not GLIT.isdll) and (not GLIT.isnet) Then
  begin
   // [ limit enabled? ]
   If (Statica.VarB[0,5]=True) and (ppiGetHaveKey<>1) Then
    begin
     CreateThread(nil, 0, @pepBeginExecLimitation, nil, 0, C32);
    end;
  end;
 {$ENDIF}






 // oep jmp !
 Jumper:=Statica.VarC64[0,19]+OriginIB;

 If GLIT.isdll = True Then
  begin
   C64:=SelfNT.OptionalHeader.AddressOfEntryPoint+OriginIB;
   PByte(C64)^:=$E9;
   PConstDWord(C64)^:=TConstQWord(@DLL_UnloadEntry)-(C64-1)-5;
   If Jumper=OriginIB Then Jumper:=0;
  end;




 // set out ep
 PPlatformCardinal(ModuleRET + 8*SizeOf(TPlatformCardinal))^:=Jumper;
 ExitToEntryPoint(ModuleRET);

end.














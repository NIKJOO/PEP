unit PreLoader;


{$DEFINE PM}      




interface
Uses PlatformConsts;






Procedure pepLoader(const uib:TPlatformCardinal;const uret:TPlatformCardinal); stdcall;









implementation
Uses Winapi.Windows;





{============================PROCEDURE==================================}


Procedure pepLoader(const uib:TPlatformCardinal;const uret:TPlatformCardinal); stdcall;
Var
 C64, D64 : TConstQWord;
 R64, I64 : TConstInt64;
 M64 : Pointer;
 LIT : PLoaderInfoTable;
 import_table : PImageImportDescriptor;
 import_fun   : {$ifdef win32}PConstDWord{$else}PConstQWord{$endif};
 import_iat   : {$ifdef win32}PConstDWord{$else}PConstQWord{$endif};
 LLW : Function(lpLibFileName: Pointer): HMODULE; stdcall;
 GPA : Function(hModule: HMODULE; lpProcName: Pointer): FARPROC; stdcall;
 SelfEA : Function(H:HMODULE; dwReason: DWord; lpvReserved:Pointer):Boolean; stdcall;
begin
 
 LIT:=Pointer(PImageNtHeaders(TConstQWord(PImageDosHeader(uib)._lfanew)+uib)^.FileHeader.PointerToSymbolTable+uib);
 R64:=LIT.rssz;
 If R64>0 Then
  begin
   D64:=uib-LIT.libmb;
   D64:=D64+LIT.libdb;
   M64:= Pointer(LIT.rels+uib);

   I64:=0;
   While True do
    begin
     If I64>R64-1 Then Break;
     If PConstQWord(M64)^=4 Then
      begin
       Inc(PConstQWord(M64));
       C64:=uib+PConstQWord(M64)^;
       PConstDWord(C64)^:=PConstDWord(C64)^+D64;
      end
     Else
     If PConstQWord(M64)^=8 Then
      begin
       Inc(PConstQWord(M64));
       C64:=uib+PConstQWord(M64)^;
       PConstQWord(C64)^:=PConstQWord(C64)^+D64;
      end;
     Inc(PConstQWord(M64)); 
     Inc(I64);
    end;
  End;

 LLW:=Pointer(PPlatformCardinal(LIT.llw+uib)^);
 GPA:=Pointer(PPlatformCardinal(LIT.gpa+uib)^);

 R64:=IMAGE_ORDINAL_FLAG32;
 If LIT.xwin=64 Then R64:= IMAGE_ORDINAL_FLAG64;
 import_table:=Pointer(LIT.iat+uib);
 While import_table.Name <> 0 Do
  Begin
   C64:=LLW(Pointer(import_table.Name+LIT.lib+uib));
   import_iat:=Pointer(LIT.lib+uib+import_table.FirstThunk);

   import_fun:=Pointer(import_table.OriginalFirstThunk+LIT.lib+uib);
   If import_table.TimeDateStamp<>$FFFFFFFF Then
    import_fun:=Pointer(import_table.FirstThunk+LIT.lib+uib);

   While import_fun^ <> 0 Do
    Begin
     If (import_fun^ and R64)<>0 Then D64:= (import_fun^ and $FFFF)
      Else D64:=import_fun^+LIT.lib+uib+2;

     M64:=GPA(C64, Pointer(D64));
     PPointer(import_fun)^:=M64;
     import_iat^:=TConstQWord(M64);
     Inc(import_iat);
     Inc(import_fun);
    End;

   Inc(import_table);
  End;
 OriginIB:=uib;
 ModuleRET:=uret;
 GLIT:=LIT^;

 SelfEA:=Pointer(LIT.sea+uib);
 SelfEA(LIT.lib+uib, DLL_PROCESS_ATTACH, nil);
 
end;








end.


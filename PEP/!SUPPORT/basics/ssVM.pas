unit ssVM;



interface
Uses Windows, Classes;








Type
 TUniMetaMethod   = (umStatic, umDynamic);
 TUniRollState    = (ursBack, ursRestore);
 TUniAsmMode      = (uaX32, uaX64);


Type
 TUniversalAsmLanguage = Class(TMemoryStream)
 Protected
  FALine  : Pointer;
  FError  : String;
  FBuffer : Pointer;
  FBufferSz : Integer;
  FRollPos : Int64;
  FAsmInBuffer : Boolean;
  FAsmBuf : String;
  FAsmMode : TUniAsmMode;
  Function ALine(const inS:String):Integer;
  Procedure SetBuffering(V:Boolean);
 Public
  Procedure   Clear;
  Procedure   WriteRandom(Sz:Integer);
  Procedure   WriteData(const Block:Array of Byte);
  Procedure   WriteByte(B:Byte);
  Procedure   WriteWord(W:Word);
  Procedure   WriteInt(I:Integer);
  Procedure   WriteInt64(I64:Int64);
  Constructor Create(ACompiler:Pointer=nil);
  Destructor  Destroy;override;
  Function uni(const A: String):Integer;overload;
  Function uni(const A: String; const Args:Array Of Const):Integer;overload;
  Function uni(const A: Array Of String; const Args:Array Of Const):Integer;overload;
  Function uni(const A: Array Of String):Integer;overload;
  Property Compiler:Pointer Read FALine Write FALine;
  Function wrPolyBuf(inSize:Integer):Integer;   
  Function  wrReg(const in_Excepts:Array of String):String;overload;
  Function  wrReg:String;overload;             
  Procedure wrJmp(vaFrom, vaTo:Integer);       
  Procedure wrCall(vaFrom, vaTo:Integer);      
  Procedure wrPush(const inReg:String; inMethod:TUniMetaMethod=umDynamic);overload;
  Procedure wrPush(inValue:Int64; inMethod:TUniMetaMethod=umDynamic);overload;
  Procedure wrNop(inMethod:TUniMetaMethod=umDynamic);
  Procedure wrPop(const inReg:String; inMethod:TUniMetaMethod=umDynamic);
  Procedure wrDebug;       
  Procedure Roll(AMove:Int64; State:TUniRollState);overload;
  Function Roll(FindFrom:Int64; FindWhat, ChangeTo:Integer):Boolean; overload;
  Property  Buffering:Boolean Read FAsmInBuffer Write SetBuffering;
  Property  AsmMode:TUniAsmMode Read FAsmMode Write FAsmMode default uaX32;
 End;







 Function uaInstructionBuffer(uAL: TUniversalAsmLanguage; Sz:Integer):Integer;







implementation
Uses SysUtils, Math, ssMemory, StrUtils;





{===============================PROCEDURE==================================}

Function uaInstructionBuffer(uAL: TUniversalAsmLanguage; Sz:Integer):Integer;
Label  again1, again2;

Var
 r1, r2, v1, c : String;
 K, T, G :Integer;
 con_na, con_r, con_r2_basic, con_rv_basic : String;
 list_na, list_r, list_r2, list_rv : TStringList;
begin
 Randomize;
 Result:=0;

 con_na :=    
  'nop'+sLineBreak+'cbw'+sLineBreak+'cdq'+sLineBreak+'clc'+sLineBreak+'cmc'+sLineBreak+
  'cwd'+sLineBreak+'cwde'+sLineBreak+'lahf'+sLineBreak+
  'stc';


 con_r :=
  'neg %s'+sLineBreak+'not %s'+sLineBreak+'mul %s'+sLineBreak+
  'imul %s'+sLineBreak+'inc %s'+sLineBreak+'dec %s'+sLineBreak+
  'bswap %s';

 con_r2_basic :=
   'test %s, %s'+sLineBreak+'cmp %s, %s'+sLineBreak+
   'mov %s, %s'+sLineBreak+'and %s, %s'+sLineBreak+'add %s, %s'+sLineBreak+
   'sub %s, %s'+sLineBreak+'xor %s, %s'+sLineBreak+'or %s, %s'+sLineBreak+
   'xchg %s, %s'+sLineBreak+'adc %s, %s'+sLineBreak+'sbb %s, %s'+sLineBreak+
   'bsf %s, %s'+sLineBreak+'bsr %s, %s';


 con_rv_basic:=
   'cmp %s, %s'+sLineBreak+'test %s, %s' +sLineBreak+
   'mov %s, %s'+sLineBreak+'and %s, %s'+sLineBreak+'add %s, %s'+sLineBreak+
   'sub %s, %s'+sLineBreak+'or %s, %s'+sLineBreak+'xor %s, %s';



 list_na:=TStringList.Create;
 list_na.Text:=con_na;

 list_r:=TStringList.Create;
 list_r.Text:=con_r;

 list_r2:=TStringList.Create;
 list_r2.Text:=con_r2_basic;

 list_rv:=TStringList.Create;
 list_rv.Text:=con_rv_basic;


 T:=-1;
 While Result<Sz Do
  begin
   again1:
    r1:=uAL.wrReg();
    r2:=uAL.wrReg(r1);
    If uAL.AsmMode=uaX32 Then v1:='0x'+IntToHex(RandomRange(0, MaxWord div 4), 8)
     Else v1:='0x'+IntToHex(RandomRange(MaxWord, MaxInt), 16);
  again2:
   K:=RandomRange(1,20);
   If K=T Then Goto again2;
   T:=K;
   Case K Of
    1:       
      begin
       G:=RandomRange(0, list_na.Count-1);
       c:=list_na[G];
       list_na.Delete(G);
       If list_na.Count=0 Then list_na.Text:=con_na; 
       Result:=Result+uAL.uni(c);
      end;
    2..3:       
      begin
       G:=RandomRange(0, list_r.Count-1);
       c:=list_r[G];
       list_r.Delete(G);
       If list_r.Count=0 Then list_r.Text:=con_r; 
       Result:=Result+uAL.uni(c, [r1]);
      end;
    4..8:     
      begin
       G:=RandomRange(0, list_r2.Count-1);
       c:=list_r2[G];
       list_r2.Delete(G);
       If list_r2.Count=0 Then list_r2.Text:=con_r2_basic; 
       Result:=Result+uAL.uni(c, [r1, r2]);
      end;
    9..11:    
      begin
       G:=RandomRange(1,6);
       Case G Of
        1:
           begin
            c:='clc'+sLineBreak+'jc %s';
            Result:=Result+uAL.uni(c, [v1]);
           end;
        2:
           begin
            c:='stc'+sLineBreak+'jnc %s';
            Result:=Result+uAL.uni(c, [v1]);
           end;
        3:
           begin
            c:=RandomFrom(['jmp', 'jnz', 'jz', 'je', 'jne', 'jg',
                           'jl', 'jge', 'jle', 'jc', 'jnc'])+
                         ' short $+2';
            Result:=Result+uAL.uni(c);
           end;
        4:
           begin
            If uAL.AsmMode=uaX32 Then c:=RandomFrom(['xor ecx, ecx', 'mov ecx, 0'])+sLineBreak
             Else c:=RandomFrom(['xor rcx, rcx', 'mov rcx, 0'])+sLineBreak;
            c:=c+
               RandomFrom(['rep movsb', 'rep movsw', 'rep movsd',
                           'rep cmpsb', 'rep cmpsw', 'rep cmpsd',
                           'rep scasb', 'rep scasw', 'rep scasd']);
            Result:=Result+uAL.uni(c);
           end;
        5:
           begin
            If uAL.AsmMode=uaX32 Then
             c:=RandomFrom(['push '+r1, 'pushfd', 'push dword '+v1])+sLineBreak+
                RandomFrom(['add esp, 4', 'pop '+r2])
            Else
             c:=RandomFrom(['push '+r1, 'push qword '+v1,'pushfq'])+sLineBreak+
                RandomFrom(['add rsp, 8', 'pop '+r2]);
            Result:=Result+uAL.uni(c);
           end;
        6:
           begin
            v1:='0x'+IntToHex(Random(MaxByte-10)+1, 2);
            c:=RandomFrom(['shl', 'shr','sal', 'sar'])+' %s, %s';
            Result:=Result+uAL.uni(c, [r1, v1]);
           end;
       End;
      end;
    12..20:     
      begin
       G:=RandomRange(0, list_rv.Count-1);
       c:=list_rv[G];
       list_rv.Delete(G);
       If list_rv.Count=0 Then list_rv.Text:=con_rv_basic; 
       Result:=Result+uAL.uni(c, [r1, v1]);
      end;
   End;
  end;

 list_na.Free;
 list_r.Free;
 list_r2.Free;
 list_rv.Free;
end;

{===============================PROCEDURE==================================}

Function TUniversalAsmLanguage.wrReg(const in_Excepts:Array of String):String;
Var
 R : String;
 I : Integer;
 L : TStringList;
begin
 Randomize;
 If FAsmMode = uaX32 Then
  R:='eax'+sLineBreak+'ebx'+sLineBreak+'ecx'+sLineBreak+'edx'+sLineBreak+'esi'+sLineBreak+'edi'
 Else
  R:='rax'+sLineBreak+'rbx'+sLineBreak+'rcx'+sLineBreak+'rdx'+sLineBreak+'rsi'+sLineBreak+'rdi'
     +sLineBreak+'r8'+sLineBreak+'r9'+sLineBreak+'r10'+sLineBreak+'r11'+sLineBreak+'r12'+sLineBreak+'r13'
     +sLineBreak+'r14'+sLineBreak+'r15';

 If SizeOf(in_Excepts)>0 Then
  For I:=Low(in_Excepts) To High(in_Excepts) Do
   R:=ReplaceText(R, in_Excepts[I], '');
 L:=TStringList.Create;
  L.Text:=Trim(R);
  While True Do
   begin
    Result:=Trim(L[RandomRange(0,L.Count-1)]);
    If Result<>'' Then Break;
   end;
 L.Free;
end;

{===============================PROCEDURE==================================}

Function  TUniversalAsmLanguage.wrReg:String;
begin
 Result:=wrReg([]);
end;

{===============================PROCEDURE==================================}

Procedure TUniversalAsmLanguage.wrPush(const inReg:String; inMethod:TUniMetaMethod=umDynamic);
Label sta_tic,sta_tic64;
Var
 R2, V : String;
begin
 If FAsmMode = uaX32 Then
  begin
   R2:=wrReg(inReg);
   V:='0x'+IntToHex(Random(MAxInt), 8);
   If inReg='esp' Then
    begin
     uni('push esp');
     Exit;
    end;

   If  inMethod = umStatic Then Goto sta_tic;
   Case RandomRange(1,6) Of
    1: uni(['mov %s, %s', 'push %s'],[R2, inReg, R2]);
    2: uni(['push %s', 'mov [esp], %s'],[R2, inReg]);
    3: uni(['push %s'],[inReg]);
    4: uni(['pushfd', 'mov [esp], %s'],[inReg]);
    5: uni(['sub esp, 4', 'mov [esp], %s'],[inReg]);
    6: uni(['add esp, -4', 'mov [esp], %s'],[inReg]);
   End;
   Exit;

  sta_tic:
   Case RandomRange(1,3) Of
    1: uni(['push %s'],[inReg]);
    2: uni(['pushfd', 'mov [esp], %s'],[inReg]);
    3: uni(['push %s', 'mov [esp], %s'],[R2, inReg]);
   End;
   Exit;
  end
 else
  begin
   uni('push %s', [inReg]);
  end;
end;

{===============================PROCEDURE==================================}

Procedure TUniversalAsmLanguage.wrDebug;
begin
 uni('db 0xCC');
end;

{===============================PROCEDURE==================================}

Procedure TUniversalAsmLanguage.Roll(AMove:Int64; State:TUniRollState);
begin
 If State=ursBack Then
  begin
   FRollPos:=Position;
   Position:=AMove;
  end
 Else
  begin
   Position:=FRollPos;
  end;
end;

{===============================PROCEDURE==================================}

Procedure TUniversalAsmLanguage.SetBuffering(V:Boolean);
begin
 If V=FAsmInBuffer Then Exit;
 If (FAsmInBuffer=True) and (V=False) Then
  begin
   FAsmInBuffer:=V; // disable
   uni(FAsmBuf);
   FAsmBuf:='';
  end;
 If V=True Then FAsmBuf:='';
 FAsmInBuffer:=V;
end;

{===============================PROCEDURE==================================}

Function TUniversalAsmLanguage.Roll(FindFrom:Int64; FindWhat, ChangeTo:Integer):Boolean;
Var
 Value   : Integer;
 SavePos : Int64;
Begin
 Result:=False;
 SavePos:=Position;
 Position:=FindFrom;
 While True Do
  Begin
   If Position+4>Size Then Break;
   ReadBuffer(Value,4);
   If Value<>FindWhat Then
    Begin
     Position:=Position-3;
     Continue;
    End;
   // yep, we find !
   Position:=Position-4;
   WriteInt(ChangeTo);
   Result:=True;
   Break;
  End;
 // restore
 Position:=SavePos;
End;

{===============================PROCEDURE==================================}

Procedure TUniversalAsmLanguage.wrPop(const inReg:String; inMethod:TUniMetaMethod=umDynamic);
Label sta_tic;
Var
 R2, V : String;
begin
 If FAsmMode = uaX32 Then
  begin
   R2:=wrReg(inReg);
   V:='0x'+IntToHex(Random(MAxInt), 8);
   If  inMethod = umStatic Then Goto sta_tic;

   Case RandomRange(1,10) Of
    1: uni(['pop %s'], [inReg]);
    2: uni(['mov %s, dword [esp]', 'add esp, 4'], [inReg]);
    3: uni(['xchg %s, dword [esp]', 'add esp, 4'], [inReg]);
    4: uni(['mov %s, dword [esp]', 'sub esp, -4'], [inReg]);
    5: uni(['xchg %s, dword [esp]', 'sub esp, -4'], [inReg]);
    6: uni(['pop %s', 'mov %s, %s'], [R2, inReg, R2]);
    7: uni(['mov %s, dword [esp]', 'pop %s'], [inReg, R2]);
    8: uni(['xchg %s, dword [esp]', 'pop %s'], [inReg, R2]);
    9: uni(['pop %s', 'xchg %s, %s'], [R2, inReg, R2]);
    10: uni(['mov %s, %s', 'xchg %s, dwrod [esp]', 'pop %s'], [inReg, V, inReg, R2]);
   End;
   Exit;

  sta_tic:
   Case RandomRange(1,5) Of
    1: uni(['pop %s'], [inReg]);
    2: uni(['mov %s, dword [esp]', 'add esp, 4'], [inReg]);
    3: uni(['xchg %s, dword [esp]', 'add esp, 4'], [inReg]);
    4: uni(['mov %s, dword [esp]', 'sub esp, -4'], [inReg]);
    5: uni(['xchg %s, dword [esp]', 'sub esp, -4'], [inReg]);
   End;
   Exit;
  end
 Else
  begin
    uni(['pop %s'], [inReg]);
  end;
end;

{===============================PROCEDURE==================================}

Procedure TUniversalAsmLanguage.wrNop(inMethod:TUniMetaMethod=umDynamic);
Var
 R1, R2, V : String;
 M, L : Integer;
begin
 If FAsmMode = uaX32 Then
  begin
   R1:=wrReg;
   R2:=wrReg([R1]);
   V:='0x'+IntToHex(Random(MAxInt), 8);
   If inMethod = umStatic Then M:=15 Else M:=31;
   L:=RandomRange(0,4);
   Case RandomRange(1,M) Of
    1:  uni('nop');
    2:  uni('fnop');
    3:  uni(['push %s', 'pop %s'], [R1, R1]);
    4:  uni('jno short $+2');
    5:  uni('jz short $+2');
    6:  uni('jg short $+2');
    7: uni('jc short $+2');
    8: uni('jge short $+2');
    9: uni('jnc short $+2');
    10: uni('jnz short $+2');
    11: uni('je short $+2');
    12:
        begin
         uni('jmp short $+%d', [2+L]);
         WriteRandom(L);
        end;
    13: uni('jle short $+2');
    14: uni('jl short $+2');
    15: uni('jo short $+2');


    // they change flags
    16:  uni(['xchg %s, %s', 'xchg %s, %s'], [R1, R2, R2, R1]);
    17:  uni(['bswap %s', 'bswap %s'], [R1, R1]);
    18:  uni(['mov %s, %s'], [R1, R1]);
    19: uni(['not %s', 'not %s'], [R1, R1]);
    20: uni(['or %s, %s'], [R1, R1]);
    21: uni(['xor %s, %s', 'xor %s, %s'], [R1, V, R1, V]);
    22: uni(['neg %s', 'neg %s'], [R1, R1]);
    23: uni(['pushfd', 'add esp, 4']);
    24: uni(['call $+5', 'add esp, 4']);
    25: uni(['test %s, %s'], [R1, R1]);
    26: uni(['test %s, %s'], [R1, R2]);
    27: uni(['test %s, %s'], [R1, V]);
    28: uni(['and %s, 0xFFFFFFFF'], [R1]);
    29: uni(['cmp %s, %s'], [R1, R1]);
    30: uni(['cmp %s, %s'], [R1, R2]);
    31: uni(['cmp %s, %s'], [R1, V]);
   End;
   Exit;
  end
 else
  begin
   uni('nop');
  end;
end;

{===============================PROCEDURE==================================}

Procedure TUniversalAsmLanguage.wrPush(inValue:Int64; inMethod:TUniMetaMethod=umDynamic);
Label sta_tic,sta_tic64;
Var
 R2, V : String;
 I : Integer;
begin
 If FAsmMode = uaX32 Then
  begin
   R2:=wrReg;
   V:='0x'+IntToHex(Random(MAxInt), 8);
   If  inMethod = umStatic Then Goto sta_tic;
   I:=Random(MaxInt);

   Case RandomRange(1,6) Of
    1: uni(['push dword %d'],[inValue]);
    2: uni(['pushfd', 'mov dword [esp], %d'],[inValue]);
    3: uni(['push %s', 'mov dword [esp], %d'],[R2, inValue]);
    4: uni(['mov %s, %d', 'xor %s, %d', 'push %s'],[R2, inValue xor I, R2, I, R2]);
    5: uni(['mov %s, %d', 'push %s'],[R2, inValue, R2]);
    6: uni(['call $+5', 'mov dword [esp], %d'],[inValue]);
   End;
   Exit;

  sta_tic:
   Case RandomRange(1,3) Of
    1: uni(['push dword %d'],[inValue]);
    2: uni(['pushfd', 'mov dword [esp], %d'],[inValue]);
    3: uni(['push %s', 'mov dword [esp], %d'],[R2, inValue]);
    // 4: uni(['push dword %s', 'mov dword [esp], dword %d'],[V, inValue]);
   End;
   Exit;
  end
 Else
  begin
   uni(['push qword %d'],[inValue]);
  end;
end;

{===============================PROCEDURE==================================}

Procedure TUniversalAsmLanguage.wrJmp(vaFrom, vaTo:Integer);
begin                         
   WriteByte($E9);
   WriteInt(vaTo-vaFrom-5);
end;

{===============================PROCEDURE==================================}

Procedure TUniversalAsmLanguage.wrCall(vaFrom, vaTo:Integer);
begin                       
   WriteByte($E8);
   WriteInt(vaTo-vaFrom-5);
end;

{===============================PROCEDURE==================================}

Function TUniversalAsmLanguage.wrPolyBuf(inSize:Integer):Integer;
begin
 Result:=uaInstructionBuffer(Self, inSize);  // x64 +
end;

{===============================PROCEDURE==================================}

Function TUniversalAsmLanguage.ALine(const inS:String):Integer;
const
 use32 = 'use32';
 use64 = 'use64';
Var
 in_a : AnsiString;
 i1, i2, i3, i4 : Integer;            
 S : String;
begin
 Result:=0;
 If FALine=nil Then Exit;
 S:=Trim(inS);
 If S='' Then Exit;
 If FAsmInBuffer=True Then
  begin
   FAsmBuf:=FAsmBuf+sLineBreak+S+sLineBreak;
   FAsmBuf:=ReplaceText(FAsmBuf, sLineBreak+sLineBreak, sLineBreak);
   Exit;
  end;

 If FAsmMode=uaX32 Then in_a:=use32;
 in_a:=in_a+sLineBreak+S+#0+#0+#0;
 i2:=Length(in_a);
 i1:=Integer(PAnsiChar(in_a));
 i3:=Integer(FBuffer);
 i4:=Integer(FALine);
 Try
   Asm
     pushad

     push i3
     push i2
     push i1
     call i4
     mov i1, eax
     mov i2, ecx
     mov i3, edx

     popad
   End;
 Except
  On E:Exception Do
   begin
     i3:=2011;
     in_a:=' ['+S+'] '+E.Message;
     i2:=Integer(PAnsiChar(in_a));
   end;
 End;

 If i1<>0 Then
  begin
   Result:=i1;
   WriteBuffer(FBuffer^, Result);
   Exit;
  end;
 Raise Exception.Create(S+sLineBreak+IntToStr(i3)+' '+StrPas(PAnsiChar(i2)));
end;

{===============================PROCEDURE==================================}

Function TUniversalAsmLanguage.uni(const A: String):Integer;
begin
 Result:=uni(A, []);
end;

{===============================PROCEDURE==================================}

Function TUniversalAsmLanguage.uni(const A: String; const Args:Array Of Const):Integer;
begin
 If SizeOf(Args)=0 Then Result:=ALine(A)
  Else Result:=ALine(Format(A, Args));
end;

{===============================PROCEDURE==================================}

Function TUniversalAsmLanguage.uni(const A: Array Of String; const Args:Array Of Const):Integer;
Var
 S : String;
 I : Integer;
begin
 S:='';
 If SizeOf(A)>0 Then
  For I:=Low(A) To High(A) Do S:=S+A[I]+sLineBreak;
 Result:=uni(S, Args);
end;

{===============================PROCEDURE==================================}

Function TUniversalAsmLanguage.uni(const A: Array Of String):Integer;
begin
 Result:=uni(A, []);
end;

{===============================PROCEDURE==================================}

Constructor TUniversalAsmLanguage.Create(ACompiler:Pointer=nil);
begin
 Inherited Create;
 FBufferSz:=64*1024;
 FBuffer:=vxAllocMem(FBufferSz); // 16 kb
 FALine:=ACompiler;
 FAsmBuf:='';
 FAsmInBuffer:=False;
 Clear;
end;

{===============================PROCEDURE==================================}

Destructor TUniversalAsmLanguage.Destroy;
begin
 Clear;
 vxFreeMem(FBuffer);
 Inherited Destroy;
end;

{===============================PROCEDURE==================================}

Procedure TUniversalAsmLanguage.Clear;
begin
 Size:=0;
 FRollPos:=0;
 Position:=0;
 FAsmBuf:='';
 FAsmInBuffer:=False;
end;

{===============================PROCEDURE==================================}

Procedure TUniversalAsmLanguage.WriteByte(B:Byte);
Begin
 If FAsmInBuffer=True Then uni('db %d', [B])
  Else WriteBuffer(B,SizeOf(B));
End;

{===============================PROCEDURE==================================}

Procedure TUniversalAsmLanguage.WriteRandom(Sz:Integer);
begin
 While Sz<>0 Do
  begin
   WriteByte(Random(MaxByte));
   Sz:=Sz-1;
  end;
end;

{===============================PROCEDURE==================================}

Procedure TUniversalAsmLanguage.WriteData(const Block:Array of Byte);
Var
 I:Integer;
Begin
 If FAsmInBuffer=False Then
  begin
   WriteBuffer(Block,SizeOf(Block));
   Exit;
  end;
 For I:=Low(Block) To High(Block) Do WriteByte(Block[I]);
End;

{===============================PROCEDURE==================================}

Procedure TUniversalAsmLanguage.WriteWord(W:Word);
Begin
 If FAsmInBuffer=True Then uni('dw %d', [W])
  Else WriteBuffer(W,SizeOf(W));
End;

{===============================PROCEDURE==================================}

Procedure TUniversalAsmLanguage.WriteInt(I:Integer);
Begin
 If FAsmInBuffer=True Then uni('dd %d', [I])
  Else WriteBuffer(I,SizeOf(I));
End;

{===============================PROCEDURE==================================}

Procedure TUniversalAsmLanguage.WriteInt64(I64:Int64);
Begin
 WriteBuffer(I64,SizeOf(I64));
End;

{===============================PROCEDURE==================================}










end.

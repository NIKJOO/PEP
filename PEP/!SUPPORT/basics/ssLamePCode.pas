unit ssLamePCode;



interface







Type
 TvmOperationType = (votCommand, votUndefined, votSetVMA);
 TvmRegister      = (vrEAX,vrECX,vrEDX,vrEBX,vrESP,vrEBP,vrESI,vrEDI, vrFlags, vrEIP);
 TvmOperations    =
  (
    voNop,          voBegin,           voEnd,          voStoArg,
    voStoLoc,       voLdRef,          voLdLoc,         voStoCon,
    voLdCon,        voStoRef,          voPop,          voStoFlags,
    voLdFlags,      voCallArg,         voCall,        voStoLocArg,
    voStoLocRef,    voLdRefLoc,      voLdRefArg,      voStoRefLoc,
    voStoLocRefLoc, voStoLocRefLocI, voStoRefLocLoc, voStoRefLocILoc,
    voCpuId,        voDiv,             voMul,         voDebugBreak,
    voAddLocArg,    voAddLocLoc,     voAddLocRef,     voAddRefLoc,
    voXorLocArg,    voXorLocLoc,     voSubLocArg,     voSubLocLoc
  );



Type
 PvmCmd = ^ TvmCmd;
 TvmCmd = Packed Record
  Data    : Array [1..16] of Byte;
  Variant : TvmOperationType;
  Cmd     : TvmOperations;
  L       : TvmRegister;
  LP      : Integer;
  R       : TvmRegister;
  RP      : Integer;
  UP      : Integer;
 End;




Procedure vmRunPCode(vmPCodeStream : PvmCmd);stdcall;



implementation





Type
 PvmCPUContext = ^TvmCPUContext;
 TvmCPUContext = Packed Array[TvmRegister] Of Integer;

Const
  TvmSwitch  : Array[0..7] of TvmRegister = (vrEAX,vrEBX,vrEDX,vrECX,vrESI,vrEDI,vrEBP,vrFlags);


Type
 PvmControl = ^TvmControl;
 TvmControl = Packed Record
  Switch   : TvmCPUContext;
  Cmd      : TvmCmd;
  Context  : TvmCPUContext;
  VMA      : Integer;
  Stream   : Pointer;
 End;


{===============================PROCEDURE==================================}

Procedure runPCODE(TreeAbsolute, RegAbsolute : Cardinal);stdcall;
Label Init, Fin, Iterate, Done;
  Procedure rcSetContext(Context,Switch: PvmCPUContext;How:Byte=0);inline;
  Var
   I : TvmRegister;
  begin
   For I:=Low(TvmRegister) To High(TvmRegister) Do
    If How=1 Then Switch[I]:=Context[I] Else
     If I<>vrEBP Then Context[I]:=Switch[I];
  end;

Const
 eStackSz           = 64*1024;
Var
 VirtualStack : Array [1..eStackSz] of Byte;
 Control      : PvmControl;
 Local,Value  : Integer;
Begin
 Goto Init;
Iterate:
 While True Do
  begin
   Case Control.Cmd.Variant Of
    votSetVMA:
     begin
      Control.VMA:=Control.Cmd.UP;
     end;
    votUndefined:
     begin
      
      Control.Cmd.Variant:=votCommand;
      Control.Cmd.Cmd:=voCallArg;
      Control.Cmd.RP:=Control.Cmd.LP+1; 
      If Control.VMA = 0 Then Control.Cmd.LP:=Control.Context[vrEsp]-Control.Cmd.RP
       Else Control.Cmd.LP:=Control.VMA;

      Control.Cmd.Data[Control.Cmd.RP]:=$C3;
      Control.Cmd.UP:=Integer(@Control.Cmd.Data);
      Continue;
      
     end;
    votCommand:
     begin
      
      Local:=Ord(Control.Cmd.Cmd) xor 0;
      

      Case Local Of
       Integer(voEnd): Break;
       Integer(voStoArg):  
        begin
         
         Control.Context[vrEsp]:=Control.Context[vrEsp]-4;
         PInteger(Control.Context[vrEsp])^:=Control.Cmd.LP;
         
        end;
       Integer(voStoLoc):   
        begin
         
         Control.Cmd.LP:=Control.Context[Control.Cmd.L];
         Control.Cmd.Cmd:=voStoArg;
         Continue;
         
        end;
       Integer(voStoRef):  
        begin
         
         Control.Context[vrEsp]:=Control.Context[vrEsp]-Control.Cmd.RP;
         Value:=Control.Cmd.RP div 4;
         Local:=0;
         While Value<>0 Do
          begin
           PInteger(Control.Context[vrEsp]+Local)^:=PInteger(Control.Cmd.LP+Local)^;
           Local:=Local+4;
           Value:=Value-1;
          end;
         Value:=Control.Cmd.RP mod 4;
         Local:=0;
         While Value<>0 Do
          begin
           PByte(Control.Context[vrEsp]+Local)^:=PByte(Control.Cmd.LP+Local)^;
           Local:=Local+1;
           Value:=Value-1
          end;
         
        end;
       Integer(voStoCon):   
        begin
         
         Control.Cmd.Cmd:=voStoRef;
         Control.Cmd.LP:=Integer(@Control.Context);
         Control.Cmd.RP:=SizeOf(Control.Context);
         Continue;
         
        end;
       Integer(voStoRefLoc):   
        begin
         
         PInteger(Control.Cmd.LP)^:=Control.Context[Control.Cmd.R];
         
        end;
       Integer(voStoLocRefLocI): 
        begin
         
         Control.Context[Control.Cmd.L]:=PInteger(Control.Context[Control.Cmd.R]+Control.Cmd.RP)^;
         
        end;
       Integer(voStoLocRefLoc):  
        begin
         
         Control.Cmd.Cmd:=voStoLocRefLocI;
         Control.Cmd.RP:=0;
         Continue;
         
        end;
       Integer(voStoRefLocILoc): 
        begin
         
         PInteger(Control.Context[Control.Cmd.L]+Control.Cmd.LP)^:=Control.Context[Control.Cmd.R];
         
        end;
       Integer(voStoRefLocLoc):  
        begin
         
         Control.Cmd.Cmd:=voStoRefLocILoc;
         Control.Cmd.LP:=0;
         Continue;
         
        end;
       Integer(voLdRef):         
        begin
         
         Value:=Control.Cmd.RP div 4;
         Local:=0;
         While Value<>0 Do
          begin
           PInteger(Control.Cmd.LP+Local)^:=PInteger(Control.Context[vrEsp]+Local)^;
           Local:=Local+4;
           Value:=Value-1;
          end;
         Value:=Control.Cmd.RP mod 4;
         Local:=0;
         While Value<>0 Do
          begin
           PByte(Control.Cmd.LP+Local)^:=PByte(Control.Context[vrEsp]+Local)^;
           Local:=Local+1;
           Value:=Value-1
          end;
         Control.Context[vrEsp]:=Control.Context[vrEsp]+Control.Cmd.RP;
         
        end;
       Integer(voLdCon):   
        begin
         
         Control.Cmd.Cmd:=voLdRef;
         Control.Cmd.LP:=Integer(@Control.Context);
         Control.Cmd.RP:=SizeOf(Control.Context);
         Continue;
         
        end;
       Integer(voLdLoc):   
        begin
         
         Control.Context[Control.Cmd.L]:=PInteger(Control.Context[vrEsp])^;
         Control.Cmd.Cmd:=voPop;
         Continue;
         
        end;
       Integer(voPop):        
        begin
         
         Control.Context[vrEsp]:=Control.Context[vrEsp]+4;
         
        end;
       Integer(voStoFlags):   
        begin
         
         Control.Cmd.Cmd:=voStoLoc;
         Control.Cmd.L:=vrFlags;
         Continue;
         
        end;
       Integer(voLdFlags):   
        begin
         
         Control.Cmd.Cmd:=voLdLoc;
         Control.Cmd.L:=vrFlags;
         Continue;
         
        end;
       Integer(voCallArg):   
        begin
         
         If Control.Cmd.UP<>0 Then
          begin
           Local:=0;
           If Control.VMA = 0 Then
            Control.Context[vrEsp]:=Control.Context[vrEsp]-Control.Cmd.RP;
            
           While Local<Control.Cmd.RP Do
            begin
             If Control.VMA = 0 Then PByte(Control.Context[vrEsp]+Local)^:=PByte(Control.Cmd.UP+Local)^
              Else PByte(Control.VMA+Local)^:=PByte(Control.Cmd.UP+Local)^;

             Inc(Local);
            end;
          end;
         rcSetContext(@Control.Context,@Control.Switch,1);
         
         Asm
          pushfd
          pushad
          sub esp,8*4
          mov local, esp
         End;
         For Value:=0 To High(TvmSwitch) Do
          PInteger(Local+Value*4)^:=Control.Switch[TvmSwitch[Value]];

         Local:=Control.Context[vrEsp];
         Value:=Control.Cmd.LP;
         Asm
          jmp @@begin_context

          @@restore_context:
           push local 

           pushfd
           push ebp
           push edi
           push esi
           push ecx
           push edx
           push ebx
           push eax
           jmp @@save_context

          @@begin_context:
           pop eax
           pop ebx
           pop edx
           pop ecx
           pop esi
           pop edi
           add esp,4
           popfd
           jmp @@begin_call


          @@begin_call:
           push value
           push ebp
           mov ebp, Local
           xchg esp, ebp
           db $E8, 0, 0, 0, 0        
           add [esp],7               
           jmp DWORD PTR [ebp+4]    
           xchg ebp, esp
           xchg ebp, [esp]
           pop Local       
           pop Value  
           jmp  @@restore_context

          @@save_context:
           mov local,esp
           add esp,8*4+4
           popad
           popfd
           sub esp,8*4+4+32+4
         End;

         For Value:=0 To High(TvmSwitch) Do
          Control.Switch[TvmSwitch[Value]]:=PInteger(Local+Value*4)^;

         Asm
          add esp,8*4
          pop local
          add esp,32+4
         End;



         
         rcSetContext(@Control.Context,@Control.Switch,0);
         Control.Context[vrEsp]:=Local;        
         If Control.Cmd.UP<>0 Then
          begin
           If Control.VMA = 0 Then
            Control.Context[vrEsp]:=Control.Context[vrEsp]+Control.Cmd.RP
           Else
            begin
             Local:=0;
             While Local<Control.Cmd.RP Do
              begin
               PByte(Control.VMA+Local)^:=0;
               Inc(Local);
              end;
            end;
          end;
         
        end;
       Integer(voCall):  
        begin
         
         Control.Cmd.Cmd:=voCallArg;
         Control.Cmd.LP:=Control.Context[Control.Cmd.L];
         Continue;
         
        end;
       Integer(voStoLocArg): 
        begin
         
         Control.Context[Control.Cmd.L]:=Control.Cmd.LP;
         
        end;
       Integer(voStoLocRef): 
        begin
         
         Control.Cmd.Cmd:=voStoLocArg;
         Control.Cmd.LP:=PInteger(Control.Cmd.LP)^;
         Continue;
         
        end;
       Integer(voLdRefArg):   
        begin
         

         PInteger(Control.Cmd.LP)^:=Control.Cmd.RP;

         
        end;
       Integer(voLdRefLoc):  
        begin
         
         Control.Cmd.Cmd:=voLdRefArg;
         Control.Cmd.RP:=Control.Context[Control.Cmd.R];
         Continue;
         
        end;
       Integer(voCpuId): 
        begin
         
         Control.Cmd.Variant:=votUndefined;
         Control.Cmd.LP:=2;
         Control.Cmd.Data[1]:=$0F;
         Control.Cmd.Data[2]:=$A2;
         Continue;
         
        end;
       Integer(voDebugBreak):  
        begin
         
         Control.Cmd.Variant:=votUndefined;
         Control.Cmd.LP:=1;
         Control.Cmd.Data[1]:=$CC;
         Continue;
         
        end;
       Integer(voSubLocArg):
        begin
         
         Control.Context[Control.Cmd.L]:=Control.Context[Control.Cmd.L]-Control.Cmd.LP;
         
        end;
       Integer(voSubLocLoc):  
        begin
         
         Control.Cmd.Cmd:=voSubLocArg;
         Control.Cmd.LP:=Control.Context[Control.Cmd.R];
         Continue;
         
        end;
       Integer(voAddLocArg): 
        begin
         
         Control.Context[Control.Cmd.L]:=Control.Context[Control.Cmd.L]+Control.Cmd.LP;
         
        end;
       Integer(voAddLocLoc): 
        begin
         
         Control.Cmd.Cmd:=voAddLocArg;
         Control.Cmd.LP:=Control.Context[Control.Cmd.R];
         Continue;
         
        end;
       Integer(voAddLocRef): 
        begin
         
         Control.Cmd.Cmd:=voAddLocArg;
         Control.Cmd.LP:=PInteger(Control.Cmd.LP)^;
         Continue;
         
        end;
       Integer(voAddRefLoc): 
        begin
         
         {$IFDEF Win32}
         PInteger(Control.Cmd.LP)^:=PInteger(Control.Cmd.LP)^+Control.Context[Control.Cmd.L];
         {$ENDIF}
         
        end;
       Integer(voXorLocArg): 
        begin
         
         Control.Context[Control.Cmd.L]:=Control.Context[Control.Cmd.L] xor Control.Cmd.LP;
         
        end;
       Integer(voXorLocLoc): 
        begin
         
         Control.Cmd.Cmd:=voXorLocArg;
         Control.Cmd.LP:=Control.Context[Control.Cmd.R];
         Continue;
         
        end;
       Integer(voDiv):       
        begin
         
         Control.Context[vrEAX]:=Control.Context[vrEAX] div Control.Context[Control.Cmd.L];
         
        end;
       Integer(voMul):     
        begin
         
         Control.Context[vrEAX]:=Control.Context[vrEAX] * Control.Context[Control.Cmd.L];
         
        end;
      End;
      
      Control.Context[vrEIP]:=Control.Context[vrEip]+1;
      
     end;
   End;
   
   Control.Stream:=Pointer(Cardinal(Control.Stream)+SizeOf(TvmCmd));
   Control.Cmd:=PvmCmd(Control.Stream)^;
   
  end;
 Goto Fin;

 Fin:
  
  Control.Context[vrEBP]:=Control.Context[vrEBP] - 4;
  rcSetContext(@Control.Context,@Control.Switch,1);
  For Local:=0 To High(TvmSwitch) Do
   PInteger(RegAbsolute+Local*4)^:=Control.Switch[TvmSwitch[Local]];
  
  Goto Done;

 Init:
   
   Control:=@VirtualStack;
   For Local:=0 To High(TvmSwitch) Do
    Control.Switch[TvmSwitch[Local]]:=PInteger(RegAbsolute+Local*4)^;
   Control.Stream:=Pointer(TreeAbsolute);
   Control.VMA:=0;
   Control.Cmd:=PvmCmd(Control.Stream)^;
   rcSetContext(@Control.Context,@Control.Switch,0);
   Control.Context[vrEIP]:=0;
   Control.Context[vrEsp]:=Cardinal(Control)+eStackSz-SizeOf(Control^);
   Control.Context[vrEBP]:=Control.Switch[vrEBP] + 4; 
   

  Goto Iterate;

 Done:

end;

{===============================PROCEDURE==================================}

Procedure vmRunPCode(vmPCodeStream : PvmCmd);stdcall;assembler;
asm

    db $EB, $03          
    db $99, $08, $99
   @@begin_push:
     pushfd
     push ebp
     push edi
     push esi
     push ecx
     push edx
     push ebx
     push eax
     jmp @@begin_call

   @@begin_pop:
     pop eax
     pop ebx
     pop edx
     pop ecx
     pop esi
     pop edi
     pop ebp
     popfd
     jmp @@begin_exit

   @@begin_call:
    push esp
    push vmPCodeStream
    call runPCODE
    jmp @@begin_pop

   @@begin_exit:

   db $EB, $03         
   db $98, $08, $98
End;






Begin
End.

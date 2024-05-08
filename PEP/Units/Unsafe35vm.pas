unit Unsafe35vm;

interface
Uses ssLamePCode, HandleUnit;



const
 markBeginVMX32 : Array[1..5] of Byte = ($EB, $03, $99, $09, $99);
 markEndVMX32   : Array[1..5] of Byte = ($EB, $03, $98, $09, $98);



Function Code2PCode(H:PHolderItem):PvmCmd;





implementation
Uses System.SysUtils, Winapi.Windows, ssMemory;



Function Code2PCode(H:PHolderItem):PvmCmd;
Label X, E;
Const
 Veg32 : Array [0..7] of TvmRegister = (vrEAX,vrECX,vrEDX,vrEBX,vrESP,vrEBP,vrESI,vrEDI);
begin
 New(Result);
 vxRandom(Result,SizeOf(TvmCmd));
 Case H.Size Of
  1:
     begin
       Case H.Data[1] Of
         $90:
          begin
           Result.Variant:=votCommand;
           Result.Cmd:=voNop;
           Goto X;
          end;
         $CC:
          begin
           Result.Variant:=votCommand;
           Result.Cmd:=voDebugBreak;
           Goto X;
          end;
       End;
     end;
  2:
     begin
       If (H.Data[1]=$0F) and (H.Data[2]=$A2) Then
        begin
           Result.Variant:=votCommand;
           Result.Cmd:=voCpuId;
           Goto X;
        end;
       Case H.Data[1] Of
        $31, $33:
             begin
               Result.Variant:=votUndefined;
               Result.LP:=2;
               CopyMemory(@Result.Data[1], @H.Data[1], Result.LP);
               Goto X;
             end;
        $39:
             begin
               Result.Variant:=votUndefined;
               Result.LP:=2;
               CopyMemory(@Result.Data[1], @H.Data[1], Result.LP);
               Goto X;
             end;
        $49:
             begin
               Result.Variant:=votUndefined;
               Result.LP:=2;
               CopyMemory(@Result.Data[1], @H.Data[1], Result.LP);
               Goto X;
             end;
        $21:
             begin
               Result.Variant:=votUndefined;
               Result.LP:=2;
               CopyMemory(@Result.Data[1], @H.Data[1], Result.LP);
               Goto X;
             end;
        $89:
             begin
               Result.Variant:=votUndefined;
               Result.LP:=2;
               CopyMemory(@Result.Data[1], @H.Data[1], Result.LP);
               Goto X;
             end;
        $35:
             begin
               Result.Variant:=votUndefined;
               Result.LP:=2;
               CopyMemory(@Result.Data[1], @H.Data[1], Result.LP);
               Goto X;
             end;
        $8B:
             begin
              Case H.Data[2] Of
               0..$07:
                       begin
                         Result.Variant:=votCommand;
                         Result.Cmd:=voStoLocRefLoc;
                         Result.L:=vrEAX;
                         Result.R:=Veg32[H.Data[2]];
                         Goto X;
                       end;
               $08..38:
                       begin
                         Result.Variant:=votUndefined;
                         Result.LP:=2;     // call as undefined !
                         CopyMemory(@Result.Data[1], @H.Data[1], Result.LP);
                         Goto X;
                       end;
              End;
             end;
       End;
     end;
  5:
     begin
      Case H.Data[1] Of
       $35:
        begin
           Result.Variant:=votCommand;
           Result.Cmd:=voXorLocArg;
           Result.L:=vrEAX;
           Result.LP:=PInteger(@H.Data[2])^;
           Goto X;
        end;
       $B8..$B8+Ord(vrEDI):
        begin
           Result.Variant:=votCommand;
           Result.Cmd:=voStoLocArg;
           Result.L:=Veg32[H.Data[1]-$B8];
           If Result.L in [vrESP, vrEBP] Then Goto E;
           Result.LP:=PInteger(@H.Data[2])^;
           Goto X;
        end;
       $A1:
        begin
           Result.Variant:=votCommand;
           Result.Cmd:=voStoLocRef;
           Result.L:=vrEAX;
           Result.LP:=PInteger(@H.Data[2])^;
           Goto X;
        end;
       $A3:
        begin
           Result.Variant:=votCommand;
           Result.Cmd:=voStoRefLoc;
           Result.R:=vrEAX;
           Result.LP:=PInteger(@H.Data[2])^;
           Goto X;
        end;
      End;
     end;
  6:
     begin
       If (H.Data[1]=$8B) and (H.Data[2] in [$0D..$0D+Ord(vrEDI)]) Then
        begin
           Result.Variant:=votCommand;
           Result.Cmd:=voStoLocRef;
           Result.L:=Veg32[(H.Data[2]-$05) shr 3];
           Result.LP:=PInteger(@H.Data[3])^;
           Goto X;
        end;
       If (H.Data[1]=$81) and (H.Data[2] in [$F0..$F0+Ord(vrEDI)]) Then
        begin
           Result.Variant:=votCommand;
           Result.Cmd:=voXorLocArg;
           Result.L:=Veg32[H.Data[2]-$F0];
           Result.LP:=PInteger(@H.Data[3])^;
           Goto X;
        end;
       If (H.Data[1]=$81) and (H.Data[2] in [$F8..$F8+Ord(vrEDI)]) Then
        begin
           Result.Variant:=votUndefined;
           Result.LP:=6;
           CopyMemory(@Result.Data[1], @H.Data[1], Result.LP);
           Goto X;
        end;
       If (H.Data[1]=$81) and (H.Data[2] in [$E8..$E8+Ord(vrEDI)]) Then
        begin
           Result.Variant:=votCommand;
           Result.Cmd:=voSubLocArg;
           Result.L:=Veg32[H.Data[2]-$E8];
           Result.LP:=PInteger(@H.Data[3])^;
           Goto X;
        end;
       If (H.Data[1]=$81) and (H.Data[2] in [$C0..$C0+Ord(vrEDI)]) Then
        begin
           Result.Variant:=votCommand;
           Result.Cmd:=voAddLocArg;
           Result.L:=Veg32[H.Data[2]-$C0];
           Result.LP:=PInteger(@H.Data[3])^;
           Goto X;
        end;
     end;
 End;

E:
 Dispose(Result);
 Result:=NIL;

X:

end;



end.

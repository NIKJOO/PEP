unit HandleUnit;

interface
Uses Windows, Classes, ssResources, ssVM, ssStore, ssLameUI;



Const
 TAGGANTS_REQUIRED_LENGTH = $2000;



Const
 black_delim = '--delim--';
 BeginVM : Array[1..5] of Byte = ($EB, $03, $99, $08, $99);
 EndVM   : Array[1..5] of Byte = ($EB, $03, $98, $08, $98);

Type
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



Type
 TPlatformCardinal = Cardinal;
 PPlatformCardinal = ^TPlatformCardinal;
 TPlatformInt = Integer;
 PPlatformInt = ^TPlatformInt;
 TConstQWord = uInt64;
 PConstQWord = ^TConstQWord;
 TConstDWord = uInt32;
 PConstDWord = ^TConstDWord;
 PConstInt32 = ^Int32;


Type
 TCodeTreeItem = class
 private
  Data : Array of Byte;
 public
  VA : TConstQWord;
  procedure SetData(const M:Pointer;const Sz:TPlatformInt);
  function Size:TPlatformInt;
  function Buffer:Pointer;
  constructor Create;
  destructor Free;
 End;



Type
 TCodeTree = Class
 Protected
  FList : TList;
  FVA   : TConstQWord;
 Public
  Procedure SaveToStream(const Stream:TStream);
  Function  Last : TCodeTreeItem;
  Function  First : TCodeTreeItem;
  Function  Add(const Buffer:Pointer;const Size:TPlatformInt):TCodeTreeItem;overload;
  Procedure UpdateBuffer(const Item:TCodeTreeItem;const Buf:Pointer;const Sz:Integer);
  Function  AddInt64(const Value:Int64):TCodeTreeItem;
  Procedure Clear;
  Function  Count:TPlatformInt;
  Function  Size:TPlatformInt;
  Procedure Align8;
  Procedure Align16;
  Constructor Create(const VA:TConstQWord=0);
  Destructor  Free;
 End;



 Type
  TVirtualTableItem = Record
   VA      : TConstQWord;
   Sz      : Int64;
   SysFlag : Int64;
   AllowVM : Boolean;
  End;

Type
 PHolderItem = ^ THolderItem;
 THolderItem = Record
  Relative   : Boolean;
  RelativeType : Integer;
  Size       : Integer;
  Offset     : Integer;
  FarAddress : Integer;
  ShortAddress : Integer;
  Data       : Array [1..99] of Byte;
  // user fields
  UserData   : Pointer;
  // info
  UpRelative : Boolean;
  DownRelative : Boolean;
 End;



Type
 TProcedureHolder = Class
 Protected
  FList : TList;
  FMaxHold : Integer;
  Function GetItem(const Index:Integer):PHolderItem;
 Public
  Procedure Clear;
  Function  ItemByOfs(AOfs:Integer):PHolderItem;
  //
  Function Count:Integer;
  Function Size:Integer;
  Function Hold(S:Pointer; StartVA:TConstQWord; Sz:Integer=-1; mCount:Integer=-1):Integer;
  Function Add(const H:THolderItem):Integer;
  Function NextAfter(Index:Integer):PHolderItem;
  Function LastItem:PHolderItem;
  //
  Constructor Create;
  Destructor Free;
  //
  Property Items[const Index:Integer]:PHolderItem Read GetItem;Default;
  Property MaxHoldSize:Integer read FMaxHold write FMaxHold;
 End;


Var
 Language : TuiLanguage;
 Fasm     : Pointer;
 Dasm     : Pointer;








Function  WriteResourceSnapShort(const EndFile:String; Snap:TList; wTypes:Array of Integer):Integer;
Function  CreateResourceSnapShort(const SourceFile:String; Snap:TList):Integer;
Function  MakeFileSameSize(const EndFile:String):Boolean;
Procedure DeleteEQLStrings(List:TStringList; Sort:Boolean=True);
Function  SameStrings(const S:String;AToSame:TStrings):Boolean;
Function nl2br(const S:String):String;
Function br2nl(const S:String):String;
Function nlCount(const S:String):Integer;



Type
 TvxArray = Array of Pointer;



Function  vxNewArray(const Args:Array Of Pointer):TvxArray;
Procedure vxFreeArray(var A:TvxArray);
Function  vxArrayRandomExclude(var A:TvxArray):Pointer;



Function RandomChar:Char;
Function SizeOfCode(const Code: Pointer; const AsmMode:Int64=32): Integer;
Function IsRelativeCmd(const Code: Pointer): Boolean;
Function IsRelativeCmdEx(const Code: Pointer): Integer;
Procedure MyvxMatriXCrypt(const M:Pointer; Sz:Int64; Cnz:TConstQWord);
Procedure MyvxMatriXCrypt64(const M:Pointer; Sz:Int64; Cnz:TConstQWord);
Function FindData(const M:TMemoryStream; const D:Pointer; const Sz:Int64):Int64;
function DateTimeToUnix(ConvDate: TDateTime): TConstQWord;




implementation
Uses StrUtils, SysUtils, Math, ssMemory, ssLameCrypt;






{===============================PROCEDURE==================================}

function DateTimeToUnix(ConvDate: TDateTime): TConstQWord;
const
  UnixStartDate: TDateTime = 25569.0;
begin
  Result := Round((ConvDate - UnixStartDate) * 86400);
end;

{===============================PROCEDURE==================================}

Function FindData(const M:TMemoryStream; const D:Pointer; const Sz:Int64):Int64;
Var
 P, E : PByte;
Begin
 Result:=-1;
 If Sz=0 Then Exit;
 P:=Pointer(TConstQWord(M.Memory)+M.Position);
 E:=Pointer(TConstQWord(M.Memory)+M.Size);

 case Sz of
  1:
     While True Do
      Begin
       If (P>=E) Then Break;
       If PByte(D)^=P^ Then
        Begin
         Result:=TConstQWord(P)-TConstQWord(M.Memory);
         Exit;
        End;
       Inc(P);
      End;
  2:
     While True Do
      Begin
       If (P>=E) Then Break;
       If PWord(D)^=PWord(P)^ Then
        Begin
         Result:=TConstQWord(P)-TConstQWord(M.Memory);
         Exit;
        End;
       Inc(P);
      End;
  4:
     While True Do
      Begin
       If (P>=E) Then Break;
       If PConstInt32(D)^=PConstInt32(P)^ Then
        Begin
         Result:=TConstQWord(P)-TConstQWord(M.Memory);
         Exit;
        End;
       Inc(P);
      End;
   Else
     While True Do
      Begin
       If (P>=E) Then Break;
       If CompareMem(D,P,Sz)=True Then
        Begin
         Result:=TConstQWord(P)-TConstQWord(M.Memory);
         Exit;
        End;
       Inc(P);
      End;
 end;
End;

{===============================PROCEDURE==================================}

Procedure MyvxMatriXCrypt(const M:Pointer; Sz:Int64; Cnz:TConstQWord);
Var
 I, B, C : Integer;
begin
 C:=PConstInt32(M)^;
 I:=4;
 While True Do
  begin
   If I>=Sz Then Break;
   B:=PConstInt32(uInt64(M)+I)^;
   B:=B xor C;
   B:=B xor Cnz;
   B:=B+C;
   PConstInt32(uInt64(M)+I)^:=B;
   C:=B;
   Inc(I, 4);
   If I>=Sz Then Break;
  end;
end;

{===============================PROCEDURE==================================}

Procedure MyvxMatriXCrypt64(const M:Pointer; Sz:Int64; Cnz:TConstQWord);
Var
 I, B, C : Int64;
begin
 C:=PInt64(M)^;
 I:=8;
 While True Do
  begin
   If I>=Sz Then Break;
   B:=PInt64(TConstQWord(M)+I)^;
   B:=B xor C;
   B:=B xor Cnz;
   B:=B+C;
   PInt64(TConstQWord(M)+I)^:=B;
   C:=B;
   Inc(I, 8);
   If I>=Sz Then Break;
  end;
end;


{===============================PROCEDURE==================================}

Function SizeOfCode(const Code: Pointer; const AsmMode:Int64=32): Integer;
Var
 bi:Procedure;
begin
 Result:=0;
 @bi:=Dasm;
 If AsmMode=32 then
  begin
   asm
    pushad
     push 0
     push Code
     call bi
     mov result, eax
    popad
   end;
   If Result<0 Then Result:=0;
   Exit;
  end;
 If AsmMode=64 then
  begin
   asm
    pushad
     push 64
     push Code
     call bi
     mov result, eax
    popad
   end;
   If Result<0 Then Result:=0;
   Exit;
  end;
end;

{===============================PROCEDURE==================================}

Function IsRelativeCmdEx(const Code: Pointer): Integer;
Var
 L : Integer;
begin
 L:=SizeOfCode(Code);
 Case L Of
  2:
     begin
      If (PByte(Code)^ in [$70..$7F]) or (PByte(Code)^ in [$E0..$EB]) Then
       begin
        If PByte(TConstQWord(Code)+1)^<=127 Then
         Result:=2 {down} else Result:=3 {up};
        Exit;
       end;
      If (PByte(Code)^ = $FF) and (PByte(TConstQWord(Code)+1)^ in [$D0..$D7]) Then
       begin
        Result:=0;
        Exit;
       end;
      If (PByte(Code)^ = $FF) and (PByte(TConstQWord(Code)+1)^ in [$E0..$E7]) Then
       begin
        Result:=1;
        Exit;
       end;
     end;

  5:
     begin
      If (PByte(Code)^ = $E8) then
       begin
        Result:=0;
        Exit;
       end;
      If (PByte(Code)^ = $E9) then
       begin
        Result:=1;
        Exit;
       end;
     end;


  6:
     begin
      If (PByte(Code)^ = $0F) and (PByte(TConstQWord(Code)+1)^ in [$80..$8F]) Then
       begin
        If PConstInt32(TConstQWord(Code)+2)^>=0 then Result:=2 Else Result:=3;
        Exit;
       end;
      If (PByte(Code)^ = $FF) and (PByte(TConstQWord(Code)+1)^ = $15) Then
       begin
        Result:=0;
        Exit;
       end;
      If (PByte(Code)^ = $FF) and (PByte(TConstQWord(Code)+1)^ = $25) Then
       begin
        Result:=1;
        Exit;
       end;
     end;
 End;

 Result:=-1;
end;

{===============================PROCEDURE==================================}

Function IsRelativeCmd(const Code: Pointer): Boolean;
begin
 If IsRelativeCmdEx(Code) = -1 Then Result:=False Else Result:=True;
end;

{============================PROCEDURE==================================}

Function RandomChar:Char;
Const
 A : String = 'qwertyuiopasdfghjklzxcvbnm';
begin
 Result:=A[RandomRange(1, Length(A))];
 If RandomRange(0,1) = 1 Then Result:=UpCase(Result);
end;

{============================PROCEDURE==================================}

Function vxArrayRandomExclude(var A:TvxArray):Pointer;
Var
 R : TvxArray;
 N, I, J : Integer;
begin
 Result:=nil;
 If Length(A)=0 Then Exit;
 N:=RandomRange(Low(A), High(A));
 Result:=A[N];
 SetLength(R, Length(A)-1);
 J:=Low(R);
 For I:=Low(A) To High(A) Do
  begin
   if I<>N Then
    begin
     R[J]:=A[I];
     Inc(J);
    end;
  end;
 SetLength(A, 0);
 A:=R;
end;


{============================PROCEDURE==================================}

Procedure vxFreeArray(var A:TvxArray);
begin
 SetLength(A, 0);
end;

{============================PROCEDURE==================================}

Function vxNewArray(const Args:Array Of Pointer):TvxArray;
Var
 I : Integer;
begin
 SetLength(Result, Length(Args));
 For I:=Low(Args) To High(Args) Do Result[I]:= Args[I];
end;

{===============================PROCEDURE==================================}

Function SumByteArray(const B: Array of Byte;const  MaxItem:Int64=MaxInt): Int64;
Var
 I,M : Integer;
begin
 Result:=0;
 M:=Min(MaxItem,High(B));
 For I:=Low(B) To M Do Result:=Result+B[I];
end;

{===============================PROCEDURE==================================}

Function TProcedureHolder.GetItem(const Index:Integer):PHolderItem;
begin
 If (Index<0) or (Index>FList.Count-1) or (FList.Count=0) Then Exit(nil);
 Result:=FList[Index];
end;

{===============================PROCEDURE==================================}

Function TProcedureHolder.NextAfter(Index:Integer):PHolderItem;
begin
 Result:=GetItem(Index+1);
end;

{===============================PROCEDURE==================================}

Function TProcedureHolder.LastItem:PHolderItem;
begin
 Result:=GetItem(FList.Count-1);
end;


{===============================PROCEDURE==================================}

Function TProcedureHolder.Size:Integer;
Var
 I : Integer;
 H : PHolderItem;
begin
 Result:=0;
 If FList.Count=0 Then Exit;
 For I:=0 To FList.Count-1 Do
  begin
   H:=FList[I];
   Result:=Result+H.Size;
  end;
end;

{===============================PROCEDURE==================================}

Function TProcedureHolder.Count:Integer;
begin
 Result:=FList.Count;
end;

{===============================PROCEDURE==================================}

Function TProcedureHolder.ItemByOfs(AOfs:Integer):PHolderItem;
Var
 I : Integer;
 H : PHolderItem;
begin
 Result:=NIL;
 If FList.Count=0 Then Exit;
 For I:=0 To FList.Count-1 Do
  begin
   H:=FList[I];
   If H.Offset=AOfs Then
    begin
      Result:=H;
      Exit;
    end;
  end;
end;

{===============================PROCEDURE==================================}

Function TProcedureHolder.Hold(S:Pointer; StartVA:TConstQWord; Sz:Integer=-1; mCount:Integer=-1):Integer;
Var
 P : Pointer;
 O,J : Integer;
 H : THolderItem;
begin
 Clear;
 O:=0;
 J:=0;
 While True Do
  begin
   vxZero(@H,SizeOf(H));
   P:=Pointer(Integer(S)+O);
   H.Size:=SizeOfCode(P);
   If H.Size=0 Then
    begin
     If PInteger(P)^=$FFFFFFF Then H.Size:=4 Else H.Size:=1; { unknown size }
    end;
   vxCopy(P, @H.Data, H.Size);
   H.RelativeType:=IsRelativeCmdEx(P);
   If H.RelativeType=-1 Then H.Relative:=False Else H.Relative:=True;

   case H.RelativeType of
     0 :
         begin
          If H.Size=5 Then
           H.FarAddress:=PInteger(@H.Data[2])^+(StartVA+O)+5;
          If H.Size=6 then H.FarAddress:=PInteger(@H.Data[3])^;
         end;
     1 :
         begin
          If H.Size=5 Then
           H.FarAddress:=PInteger(@H.Data[2])^+(StartVA+O)+5;
          If H.Size=6 then H.FarAddress:=PInteger(@H.Data[3])^;
         end;
     2 :
         begin
          If H.Size = 2 then
           begin
            J:= Max(H.Data[2]+O+3,J);
            H.FarAddress:=StartVA+O+2+H.Data[2];
            H.ShortAddress:=O+2+H.Data[2];
            H.DownRelative:=True;
           end;
          If H.Size = 6 then
           begin
            H.ShortAddress:=O+6+PInteger(@H.Data[3])^;
            H.FarAddress:=StartVA+O+6+PInteger(@H.Data[3])^;  // <-  4????
            H.DownRelative:=True;
            J:= Max(H.FarAddress+1,J);
           end;
         end;
     3 :
         begin
          If H.Size = 2 then
           begin
            H.UpRelative:=True;
            H.ShortAddress:=O+(H.Data[2]-254);
            H.FarAddress:=(StartVA+O)+(H.Data[2]-254);
           end;
          If H.Size = 6 then
           begin
            H.ShortAddress:=O+6+PInteger(@H.Data[3])^;
            H.FarAddress:=StartVA+O+6+PInteger(@H.Data[3])^;  // <-  4????
            H.UpRelative:=True;
            J:= Max(H.FarAddress+1,J);
           end;
         end;
   end;


   H.Offset:=O;
   Add(H);
   Inc(O,H.Size);

   If FMaxHold<>-1 then
    If O>=FMaxHold Then Break;

   If mCount=-1 Then
    begin
     If Sz<>-1 Then
      begin
       If O>=Sz Then Break;
      end
     Else
      begin
       If ((H.Size=1) and (H.Data[1]=$C3)) or ((H.Size=2) and (H.Data[1]=$C2)) Then
        begin
         If O>J Then Break;
        end;

       If SumByteArray(H.Data,10)=0 Then Break;
      end;
    end
   Else
    begin
      If mCount=FList.Count Then Break;
    end;
  end;
 Result:=O;
end;

{===============================PROCEDURE==================================}

Function TProcedureHolder.Add(const H:THolderItem):Integer;
Var
 P : PHolderItem;
begin
 New(P);
 P^:=H;
 Result:=FList.Add(P)
end;

{===============================PROCEDURE==================================}

Procedure TProcedureHolder.Clear;
Var
 I : Integer;
 P : PHolderItem;
begin
 If FList.Count=0 Then Exit;
 For I:=0 To FList.Count-1 Do
  begin
   P:=FList[I];
   Dispose(P);
  end;
 FList.Clear;
end;

{===============================PROCEDURE==================================}

Constructor TProcedureHolder.Create;
begin
 FList:=TList.Create;
 FMaxHold:=-1;
end;

{===============================PROCEDURE==================================}

Destructor TProcedureHolder.Free;
begin
 Clear;
 FList.Free;
end;

{===============================PROCEDURE==================================}

Function nl2br(const S:String):String;
begin
 Result:=ReplaceText(S, sLineBreak, '[#n]');
end;

{===============================PROCEDURE==================================}

Function br2nl(const S:String):String;
begin
 Result:=ReplaceText(S,'[#n]', sLineBreak);
end;

{============================PROCEDURE==================================}

Function nlCount(const S:String):Integer;
var
 P : Integer;
begin
 Result:=0;
 P:=1;
 while True do
  begin
   P:=PosEx(sLineBreak, S, P);
   If P=0 Then Exit;
   Inc(P);
   Inc(Result);
  end;
end;

{============================PROCEDURE==================================}

Function SameStrings(const S:String;AToSame:TStrings):Boolean;
Var
 I:Integer;
 US:String;
 AA:String;
Begin
 Result:=True;
 US:=Trim(S);
 For I:=0 To AToSame.Count-1 Do
  Begin
   AA:=AToSame[I];
   AA:=Trim(AA);
   If SameText(AA,US)=True Then Exit;
  End;
 Result:=False;
End;

{===============================PROCEDURE==================================}

Procedure DeleteEQLStrings(List:TStringList; Sort:Boolean=True);
Var
 I,J : Integer;
 S : String;
Begin
 If Sort=True Then List.Sort;
 I:=0;
 While I<=List.Count-1 Do
  Begin
   S:=Trim(List[I]);
   If S='' Then
    Begin
     List.Delete(I);
     Continue;
    End;
   J:=I+1;
   While (J<=List.Count-1) and (SameText(Trim(List[J]),S)=True) Do List.Delete(J);
   Inc(I);
  End;
End;

{===============================PROCEDURE==================================}

Function MakeFileSameSize(const EndFile:String):Boolean;
Var
 SameSizeFile : TFileStream;
 Size, Fix : Integer;
begin
 SameSizeFile:=TFileStream.Create(EndFile+'.bak',fmOpenRead);
 Size:=SameSizeFile.Size;
 SameSizeFile.Free;
 SameSizeFile:=TFileStream.Create(EndFile,fmOpenReadWrite);
 Fix:=SameSizeFile.Size;
 If Fix>Size Then Result:=False
  Else
   begin
    SameSizeFile.Size:=Size;
    Result:=True;
   end;
 SameSizeFile.Free;
end;

{===============================PROCEDURE==================================}

Function WriteResourceSnapShort(const EndFile:String; Snap:TList; wTypes:Array of Integer):Integer;
Var
 RC  : TrxResourceCompiler;
 I,J,H : Integer;
 R   : TrxResourceClass;
begin
 Result:=0;
 If Snap.Count=0 Then Exit;
 Result:=-1;
 Try
  RC:=TrxResourceCompiler.Create;
  For I:=0 To Snap.Count-1 Do
   Begin
    R:=Snap[I];
    If SizeOf(wTypes)=0 Then
     begin
      RC.Add(R);
      Continue;
     end;
    H:=0;
    For J:=Low(wTypes) To High(wTypes) Do
     begin
      If Integer(R.wType)=wTypes[J] Then
       begin
        Inc(H);
        Break;
       end;
     end;
    If H=0 Then RC.Add(R);
   End;
  Result:=RC.Count;
  If EndFile<>'' Then RC.Update(EndFile);
  RC.Free;
  For I:=0 To Snap.Count-1 Do
   Begin
    R:=Snap[I];
    R.Free;
   End;
  Snap.Clear;
 Except
  Exit;
 End;
end;

{===============================PROCEDURE==================================}

Function CreateResourceSnapShort(const SourceFile:String; Snap:TList):Integer;
Label Fin;
Var
 Map : TrxResourceMap;
 I : Integer;
 R  : TrxResourceClass;
begin
 Result:=-1;
 Snap.Clear;
 Try
  Map:=TrxResourceMap.Create(SourceFile);
  If Map.List.Count=0 Then Goto Fin;

  I:=0;
  While True Do
   begin
    If I = Map.List.Count Then Break;
    R:=Map.List[I];
    If (R.wType=RT_RCDATA) and (SameText('PACKAGEINFO',R.Named)=True) Then
     begin
      Inc(I);
      Continue;
     end;
    Snap.Add(R);
    Map.UnQueryResource(R);
   end;
  Fin:
   Result:=Snap.Count;
   Map.Free;
 Except
  Exit;
 End;
end;

{===============================PROCEDURE==================================}

Procedure TCodeTree.SaveToStream(const Stream:TStream);
Var
 I   : Integer;
 PTI : TCodeTreeItem;
Begin
 If FList.Count=0 Then Exit;
 For I:=0 To FList.Count-1 Do
  Begin
   PTI:=FList[I];
   If (PTI.Size>0) and (PTI.Buffer<>NIL) Then
    Begin
     Stream.WriteBuffer(PTI.Buffer^,PTI.Size);
    End
   Else
    Raise Exception.Create(
      ClassName+': '+' 0x'+IntToHex(Integer(PTI.Buffer),8)+IntToStr(PTI.Size));
  End;
End;

{===============================PROCEDURE==================================}

Function TCodeTree.AddInt64(const Value:Int64):TCodeTreeItem;
Begin
 Result:=Add(@Value,  SizeOf(Value));
End;

{===============================PROCEDURE==================================}

Function TCodeTree.Last  : TCodeTreeItem;
Begin
 Result:=NIL;
 If FList.Count=0 Then Exit;
 Result:=FList[FList.Count-1];
End;

{===============================PROCEDURE==================================}

Function TCodeTree.First : TCodeTreeItem;
Begin
 Result:=NIL;
 If FList.Count=0 Then Exit;
 Result:=FList[0];
End;

{===============================PROCEDURE==================================}

Function TCodeTree.Add(const Buffer:Pointer;const Size:TPlatformInt):TCodeTreeItem;
Begin
 Result:=TCodeTreeItem.Create;
 If Size<>0 Then Result.SetData(Buffer, Size);
 Result.VA:=FVA;
 If Last<>NIL Then Result.VA:=Last.VA+Last.Size;
 FList.Add(Result);
End;

{===============================PROCEDURE==================================}

Procedure TCodeTree.UpdateBuffer(const Item:TCodeTreeItem;const Buf:Pointer;const Sz:Integer);
Begin
 If Item = NIL Then Exit;

 If (Last<>Item) and (Item.Size<>Sz) Then
  Raise Exception.Create('Invalid type size !');

 Item.SetData(Buf, Sz);
End;

{===============================PROCEDURE==================================}

Function TCodeTree.Count:TPlatformInt;
Begin
 Result:=FList.Count;
End;

{===============================PROCEDURE==================================}

Function TCodeTree.Size:TPlatformInt;
Var
 I   : Integer;
 PTI : TCodeTreeItem;
Begin
 Result:=0;
 If FList.Count=0 Then Exit;
 For I:=0 To FList.Count-1 Do
  Begin
   PTI:=FList[I];
   Result:=Result+PTI.Size;
  End;
End;

{===============================PROCEDURE==================================}

Procedure TCodeTree.Clear;
Var
 PTI : TCodeTreeItem;
 I   : Integer;
Begin
 If FList.Count=0 Then  Exit;
 For I:=0 To FList.Count-1 Do
  Begin
   PTI:=FList[I];
   PTI.Free;
  End;
 FList.Clear;
End;

{===============================PROCEDURE==================================}

Procedure TCodeTree.Align16;
var
 B : Byte;
begin
 while (Self.Size mod 16 <> 0) do
  begin
   B:=Random(MaxByte);
   If B<>0 Then Self.Add(@B, 1);
  end;
end;

{===============================PROCEDURE==================================}

Procedure TCodeTree.Align8;
var
 B : Byte;
begin
 while (Self.Size mod 8 <> 0) do
  begin
   B:=Random(MaxByte);
   If B<>0 Then Self.Add(@B, 1);
  end;
end;

{===============================PROCEDURE==================================}

Constructor TCodeTree.Create(const VA:TConstQWord=0);
Begin
 FList:=TList.Create;
 FVA:=VA;
End;

{===============================PROCEDURE==================================}

Destructor TCodeTree.Free;
Begin
 Clear;
 FList.Free;
End;

{===============================PROCEDURE==================================}

function TCodeTreeItem.Size:TPlatformInt;
begin
 Result:=Length(Data);
end;

{===============================PROCEDURE==================================}

function TCodeTreeItem.Buffer:Pointer;
begin
 If Length(Data)=0 Then Result:=nil Else
  Result:=@Data[0];
end;

{===============================PROCEDURE==================================}

constructor TCodeTreeItem.Create;
begin
 SetLength(Data,0);
end;

{===============================PROCEDURE==================================}

destructor TCodeTreeItem.Free;
begin
 SetLength(Data,0);
end;

{===============================PROCEDURE==================================}

procedure TCodeTreeItem.SetData(const M:Pointer; const Sz:TPlatformInt);
begin
 SetLength(Data,Sz);
 Move(M^, Data[0], Sz);
end;





end.

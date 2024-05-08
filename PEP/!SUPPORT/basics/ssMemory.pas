unit ssMemory;



{$IFDEF FPC}
 {$mode delphi}{$H+}
{$ENDIF}



interface
Uses Windows, Classes;



Type
 TvxMemoryStream=Class(TMemoryStream)
 Public
  Procedure SetMemory(AMemory:Pointer; ASize:Integer);
  Procedure SetSize(NewSize: Longint);Override;
  Constructor Create(AMemory:Pointer; ASize:Integer);
  Destructor Destroy;Override;
 End;


Type
 TvxByteArray = array of Byte;


Function  vxAllocMem(Size:Integer):Pointer;
Procedure vxFreeMem(var Buf:Pointer);
Procedure vxZero(M:Pointer;Sz:Integer);
Procedure vxRandom(M:Pointer;Sz:Integer);
Function  vxPtr(Basis:Pointer; Ofs:Integer):Pointer;
Procedure vxCopy(F, T :Pointer; Count:Integer);
Function vxAlignOffset(O,A:UInt64):UInt64;

Function vxSetBit(B, Num:Byte; Value:Boolean):Byte;
Function vxGetBit(B, Num:Byte):Boolean;

Function vxVarDump(M:Pointer; Sz:uInt64; const FileName:String):Boolean;
Function vxVarTextDump(const S:String; const FileName:String):Boolean;
Function  vxVarToStr(M:Pointer; Sz:Integer):String;
Procedure vxStrToVar(M:Pointer; Sz:Integer; const V:string);overload;
Procedure vxStrToVar(const V:string; var BArray:TvxByteArray);overload;

function vxHexToInt64(const S: String): Int64;
Function vxHexToInt(const S:String):Integer;
function vxReplaceChar(const S:String;const W: Array of Char; const ToW:String=''):String;






implementation
Uses SysUtils;


{============================PROCEDURE==================================}

Function vxAlignOffset(O,A:UInt64):UInt64;
Begin
 Result:= ((O+A-1) div A)*A;
 If Result=0 Then Result:=A;
End;

{============================PROCEDURE==================================}

function vxReplaceChar(const S:String;const W: Array of Char; const ToW:String=''):String;
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

{============================PROCEDURE==================================}

function vxHexToInt64(const S: String): Int64;inline;
begin
 Result:=StrToInt64('$'+S);
end;

{============================PROCEDURE==================================}

Function vxHexToInt(const S:String):Integer;inline;
begin
 Result:=StrToInt('$'+S);
End;

{===============================PROCEDURE==================================}

Function  vxVarToStr(M:Pointer; Sz:Integer):String;
Var
 I:Integer;
begin
 Result:='';
 For I:=0 To Sz-1 Do Result:=Result+IntToHex(PByte(Integer(M)+I)^, 2);
end;

{===============================PROCEDURE==================================}

Procedure vxStrToVar(M:Pointer; Sz:Integer; const V:string);
Var
 I:Integer;
 B:String;
begin
 For I:=0 To Sz-1 Do
  begin
   B:=Copy(V, I*2+1, 2);
   If B='' Then Break;
   PByte(Integer(M)+I)^:=vxHexToInt(B);
  end;
end;

{===============================PROCEDURE==================================}

Procedure vxStrToVar(const V:string; var BArray:TvxByteArray);
Var
 L, I : Integer;
 B : String;
begin
 L:=Length(V) div 2;
 SetLength(BArray, L);
 L:=Low(BArray);
 I:=0;
 While True do
  begin
   B:=Copy(V, I*2+1, 2);
   If B='' Then Break;
   BArray[L]:=vxHexToInt(B);
   Inc(L);
   Inc(I);
  end;
end;

{===============================PROCEDURE==================================}

Function vxVarDump(M:Pointer; Sz:uInt64; const FileName:String):Boolean;
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

Function vxVarTextDump(const S:String; const FileName:String):Boolean;
Var
 T : TextFile;
begin
 AssignFile(T, FileName);
 Rewrite(T);
 Writeln(T, S);
 CloseFile(T);
 Result:=True;
end;

{===============================PROCEDURE==================================}

Procedure vxCopy(F, T :Pointer; Count:Integer);inline;
begin
 If Count>0 Then Move(F^, T^, Count);
end;

{===============================PROCEDURE==================================}

Function vxSetBit(B, Num:Byte; Value:Boolean):Byte;inline;
begin
  if Value then Result := B or (1 shl Num)
   else Result := B and (not (1 shl Num));
end;

{===============================PROCEDURE==================================}

Function vxGetBit(B, Num:Byte):Boolean;inline;
begin
 Result:=((B shr Num) and 1) = 1;
end;

{===============================PROCEDURE==================================}

Function  vxPtr(Basis:Pointer; Ofs:Integer):Pointer;inline;
begin
 Result:=Pointer(Cardinal(Basis)+Ofs);
end;

{===============================PROCEDURE==================================}

Procedure vxRandom(M:Pointer;Sz:Integer);
Var
 I:Integer;
begin
 If M=NIL Then Exit;
 Randomize;
 For I:=0 To Sz-1 Do PByte(Cardinal(M)+I)^:=Random(MaxByte);
end;

{===============================PROCEDURE==================================}

Constructor TvxMemoryStream.Create(aMemory:Pointer;aSize:Integer);
Begin
 Inherited Create;
 SetPointer(aMemory,aSize);
End;

{===============================PROCEDURE==================================}

Destructor TvxMemoryStream.Destroy;
Begin
 SetPointer(NIl,0);
 Inherited Destroy;
End;

{===============================PROCEDURE==================================}

Procedure TvxMemoryStream.SetSize(NewSize: Longint);
Begin
 Raise Exception.Create('');
End;

{===============================PROCEDURE==================================}

Procedure TvxMemoryStream.SetMemory(aMemory:Pointer;aSize:Integer);
Begin
 SetPointer(aMemory,aSize);
End;

{===============================PROCEDURE==================================}

Function vxAllocMem(Size:Integer):Pointer;inline;
Begin
 Result:=VirtualAlloc(NIL,Size,MEM_COMMIT,PAGE_EXECUTE_READWRITE);
End;

{===============================PROCEDURE==================================}

Procedure vxFreeMem(var Buf:Pointer);inline;
Begin
 VirtualFree(Buf, 0, MEM_RELEASE);
 Buf:=NIL;
End;

{===============================PROCEDURE==================================}

Procedure vxZero(M:Pointer;Sz:Integer);inline;
Begin
 FillChar(M^,Sz,0);
End;




end.

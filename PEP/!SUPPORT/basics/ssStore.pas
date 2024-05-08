unit ssStore;


{$IFDEF FPC}
 {$mode delphi}
{$ENDIF}

{--$DEFINE FPC}  


interface
Uses Windows, {$IFNDEF FPC} Classes,{$ENDIF} ssLameCrypt;




Type
 TMemoryStoreIntArray     = Array of Int64;
 TMemoryStoreByteArray    = Array of Byte;
 TMemoryStoreSectionNames = TMemoryStoreIntArray;
 TMemoryStoreValueNames   = TMemoryStoreIntArray;




Type
 TMemoryStoreItem = class
 private
  FMemory : TMemoryStoreByteArray;
  FName : Int64;
  FSection : Int64;
  FFlags : Byte;
 public
  function AsPointer:Pointer;
  function Size:Int64;
  procedure Store(const Buffer: Pointer; const BufferSize: Int64);
  procedure Clear;
  constructor Create;
  destructor Free;
  //
  property Memory : TMemoryStoreByteArray read FMemory;
  property Name : Int64 read FName write FName;
  property Section : Int64 read FSection write FSection;
  property Flags : Byte read FFlags write FFlags;
 end;





Type
 TMemoryStoreNamesList = class
 private
  FNames : TMemoryStoreIntArray;
  function GetItem(const AIndex:Int64):Int64;
 public
  procedure Clear;
  constructor Create;
  destructor Free;
  function Count:Int64;
  procedure Add(const AValue:Int64);
  function Exist(const AValue:Int64):Boolean;
  function AsLow:Int64;
  function AsHigh:Int64;
  Property Value[const AIndex:Int64]:Int64 Read GetItem;default;
 end;





Type
 TMemoryStoreMapArray = class
 private
  FMap : Array of TMemoryStoreItem;
  function GetItem(const AIndex:Int64):TMemoryStoreItem;
 public
  procedure Clear;
  constructor Create;
  destructor Free;
  function Count:Int64;
  procedure Delete(AIndex:Int64);
  procedure Add(const AItem:TMemoryStoreItem);
  function SectionExist(const ASection:Int64):Boolean;
  function SectionValueByName(const ASection, AName:Int64):TMemoryStoreItem;
  function SectionValueIndexByName(const ASection, AName:Int64):Int64;
  Procedure DeleteSectionValues(const SectionName:Int64);
  Function  SectionCount:Int64;
  Function  SectionNames(const ANames:TMemoryStoreNamesList):Int64;
  Function  ValueNames(const SectionName:Int64; const ANames:TMemoryStoreNamesList):Int64;
  function AsLow:Int64;
  function AsHigh:Int64;
  Property Value[const AIndex:Int64]:TMemoryStoreItem Read GetItem;default;
 end;








Type
 TMemoryStore = class
 Protected
  FArray    : TMemoryStoreMapArray;
  FCompression : Boolean;
  FPersonalKey : TameRSABytes;

  Function gc64Variable(const SectionName, KeyName:Int64):UInt64;
  Function gi64Variable(const SectionName, KeyName:Int64):Int64;
  Function giVariable(const SectionName, KeyName:Int64):Integer;
  Function gcVariable(const SectionName, KeyName:Int64):Cardinal;
  Function gaVariable(const SectionName, KeyName:Int64):AnsiString;
  Function gwVariable(const SectionName, KeyName:Int64):WideString;
  Function gbVariable(const SectionName, KeyName:Int64):Boolean;
  Function gdVariable(const SectionName, KeyName:Int64):TDateTime;
  Function gfVariable(const SectionName, KeyName:Int64):Double;

  Procedure saVariable(const SectionName, KeyName:Int64;const Value:AnsiString);
  Procedure swVariable(const SectionName, KeyName:Int64;const Value:WideString);
  Procedure siVariable(const SectionName, KeyName:Int64;const Value:Integer);
  Procedure scVariable(const SectionName, KeyName:Int64;const Value:Cardinal);
  Procedure sbVariable(const SectionName, KeyName:Int64;const Value:Boolean);
  Procedure sdVariable(const SectionName, KeyName:Int64;const Value:TDateTime);
  Procedure sfVariable(const SectionName, KeyName:Int64;const Value:Double);
  Procedure si64Variable(const SectionName, KeyName:Int64;const Value:Int64);
  Procedure sc64Variable(const SectionName, KeyName:Int64;const Value:UInt64);

  Function FindValue(const SectionName, Name:Int64):TMemoryStoreItem;
  Function WriteValue(SectionName, Name:Int64; V:Pointer; Sz:Int64; ForLoad:Boolean=False; inFlags:Byte=0):TMemoryStoreItem;
  Function ReadValue(SectionName, Name:Int64; var V:Pointer; var Sz:Int64):Boolean;

  Function GetBit(const B, Num:Byte):Boolean;
  Function SetBit(const B, Num:Byte; const Value:Boolean):Byte;
 Public
  Constructor Create;
  Destructor Free;
  Procedure Clear;
  Function  Count:Int64;
  {$IFNDEF FPC}
  Procedure LoadFromFile(const AFileName:String);
  Procedure LoadFromStream(const AStream : TStream);
  Procedure LoadFromResource(const AResourceName: string; const ResType: PChar=RT_RCDATA);overload;
  Procedure LoadFromResource(const AResourceName: PChar; const ResType: PChar=RT_RCDATA);overload;
  Procedure SaveToSymbolicFile(const AFileName:String);
  Procedure SaveToFile(const AFileName:String);
  Procedure SaveToStream(const AStream : TStream);
  {$ENDIF}
  Procedure LoadFromMemory(AMem : Pointer; Size:Int64);
  Procedure DeleteValue(const SectionName, KeyName:Int64);
  Function  ValueExists(const SectionName, KeyName:Int64):Boolean;
  Function  SectionExists(const SectionName:Int64):Boolean;
  Function  SectionCount:Int64;
  Function  SectionNames(const ANames:TMemoryStoreNamesList):Int64;
  Procedure DeleteSection(const SectionName:Int64);
  Procedure AllocSection(scCount:Integer;var scNames:TMemoryStoreIntArray; RangeFrom:Int64=-1);overload;
  Function  AllocSection(const Enums:Boolean=False):Int64;overload;
  Function  ValueNames(const SectionName:Int64; const ANames:TMemoryStoreNamesList):Int64;
  Function  AllocValue(const SectionName:Int64; const Enums:Boolean=False):Int64;
  Procedure WriteArray(const SectionName, KeyName:Int64;const Value:TMemoryStoreIntArray);overload;
  Function  ReadArray(const SectionName, KeyName:Int64):TMemoryStoreIntArray;overload;
  Procedure WriteArray(const SectionName, KeyName:Int64;const Value:TMemoryStoreByteArray);overload;
  Procedure ReadArray(const SectionName, KeyName:Int64; var R:TMemoryStoreByteArray);overload;

  {$IFNDEF FPC}
  Procedure WriteBinaryFile(const SectionName, KeyName:Int64; const BFileName:String);
  Procedure WriteStream(const SectionName, KeyName:Int64; const AStream:TStream);
  {$ENDIF}
  Procedure WriteBinary(const SectionName, KeyName:Int64; const Value:Pointer; const Size:Int64);
  Function ReadBinary(const SectionName, KeyName:Int64; const Value:Pointer; const Size:Int64):Boolean;
  Function  VarSize(const SectionName, KeyName:Int64):Int64;
  Function  VarBuf(const SectionName, KeyName:Int64):Pointer;

  Property VarA[const SectionName, KeyName:Int64]:AnsiString Read gaVariable Write saVariable;
  Property VarW[const SectionName, KeyName:Int64]:WideString Read gwVariable Write swVariable; default;
  Property VarI[const SectionName, KeyName:Int64]:Integer Read giVariable Write siVariable;
  Property VarC[const SectionName, KeyName:Int64]:Cardinal Read gcVariable Write scVariable;
  Property VarB[const SectionName, KeyName:Int64]:Boolean Read gbVariable Write sbVariable;
  Property VarD[const SectionName, KeyName:Int64]:TDateTime Read gdVariable Write sdVariable;
  Property VarF[const SectionName, KeyName:Int64]:Double Read gfVariable Write sfVariable;
  Property VarI64[const SectionName, KeyName:Int64]:Int64 Read gi64Variable Write si64Variable;
  Property VarC64[const SectionName, KeyName:Int64]:UInt64 Read gc64Variable Write sc64Variable;

  Property StreamCompression:Boolean read FCompression write FCompression;
 End;






implementation
{$IFNDEF FPC}Uses SysUtils, Math;{$ENDIF}


{===============================PROCEDURE==================================}

procedure TMemoryStoreNamesList.Add(const AValue:Int64);
begin
 SetLength(FNames, Count+1);
 FNames[High(FNames)]:=AValue;
end;

{===============================PROCEDURE==================================}

function TMemoryStoreNamesList.Exist(const AValue:Int64):Boolean;
var
 I :Integer;
begin
 For I:=Low(FNames) to High(FNames) do
  If FNames[I]=AValue Then Exit(True);
 Result:=False;
end;

{===============================PROCEDURE==================================}

function TMemoryStoreNamesList.AsLow:Int64;
begin
 Result:=Low(FNames);
end;

{===============================PROCEDURE==================================}

function TMemoryStoreNamesList.AsHigh:Int64;
begin
 Result:=High(FNames);
end;

{===============================PROCEDURE==================================}

function TMemoryStoreNamesList.GetItem(const AIndex:Int64):Int64;
begin
 Result:=FNames[AIndex];
end;

{===============================PROCEDURE==================================}

procedure TMemoryStoreNamesList.Clear;
begin
 SetLength(FNames, 0);
end;

{===============================PROCEDURE==================================}

constructor TMemoryStoreNamesList.Create;
begin
 Clear;
end;

{===============================PROCEDURE==================================}

destructor TMemoryStoreNamesList.Free;
begin
 Clear;
end;

{===============================PROCEDURE==================================}

function TMemoryStoreNamesList.Count:Int64;
begin
 Result:=Length(FNames);
end;

{===============================PROCEDURE==================================}

function TMemoryStoreMapArray.SectionValueByName(const ASection, AName:Int64):TMemoryStoreItem;
var
 AIndex : Int64;
begin
 AIndex:=SectionValueIndexByName(ASection, AName);
 If AIndex=-1 Then Result:=nil Else Result:=FMap[AIndex];
end;

{===============================PROCEDURE==================================}

function TMemoryStoreMapArray.SectionValueIndexByName(const ASection, AName:Int64):Int64;
var
 I : Integer;
begin
 For I:=Low(FMap) to High(FMap) do
  If (FMap[I].Section = ASection) and (FMap[I].Name = AName) Then Exit(I);
 Result:=-1;
end;

{===============================PROCEDURE==================================}

Procedure TMemoryStoreMapArray.DeleteSectionValues(const SectionName:Int64);
label again;
var
 I : Integer;
begin
 again:
  For I:=Low(FMap) to High(FMap) do
   If (FMap[I].Section = SectionName) Then
    begin
     Delete(I);
     Goto again;
    end;
end;

{===============================PROCEDURE==================================}

Function TMemoryStoreMapArray.SectionCount:Int64;
var
 ANames : TMemoryStoreNamesList;
begin
 ANames:=TMemoryStoreNamesList.Create;
 Result:=SectionNames(ANames);
 ANames.Free;
end;

{===============================PROCEDURE==================================}

Function TMemoryStoreMapArray.SectionNames(const ANames:TMemoryStoreNamesList):Int64;
var
 I : Integer;
begin
 For I:=Low(FMap) to High(FMap) do
  begin
   If ANames.Exist(FMap[I].Section)=True Then Continue;
   ANames.Add(FMap[I].Section);
  end;
 Result:=ANames.Count;
end;

{===============================PROCEDURE==================================}

Function TMemoryStoreMapArray.ValueNames(const SectionName:Int64; const ANames:TMemoryStoreNamesList):Int64;
var
 I : Integer;
begin
 For I:=Low(FMap) to High(FMap) do
  begin
   If FMap[I].Section<>SectionName Then Continue;
   If ANames.Exist(FMap[I].Name)=True Then Continue;
   ANames.Add(FMap[I].Name);
  end;
 Result:=ANames.Count;
end;

{===============================PROCEDURE==================================}

function TMemoryStoreMapArray.AsLow:Int64;
begin
 Result:=Low(FMap);
end;

{===============================PROCEDURE==================================}

function TMemoryStoreMapArray.AsHigh:Int64;
begin
 Result:=High(FMap);
end;

{===============================PROCEDURE==================================}

function TMemoryStoreMapArray.GetItem(const AIndex:Int64):TMemoryStoreItem;
begin
 Result:=FMap[AIndex];
end;

{===============================PROCEDURE==================================}

function TMemoryStoreMapArray.SectionExist(const ASection:Int64):Boolean;
var
 I : Integer;
begin
 For I:=Low(FMap) to High(FMap) do
  If (FMap[I].Section = ASection) Then Exit(True);
 Result:=False;
end;

{===============================PROCEDURE==================================}

function TMemoryStoreMapArray.Count:Int64;
begin
 Result:=Length(FMap);
end;

{===============================PROCEDURE==================================}

procedure TMemoryStoreMapArray.Add(const AItem:TMemoryStoreItem);
begin
 SetLength(FMap, Length(FMap)+1);
 FMap[High(FMap)]:=AItem;
end;

{===============================PROCEDURE==================================}

procedure TMemoryStoreMapArray.Delete(AIndex:Int64);
var
 AItem : TMemoryStoreItem;
begin
 If (AIndex>High(FMap)) or (AIndex<Low(FMap)) Then Exit;
 If Count=1 Then
  begin
   Clear;
   Exit;
  end;
 If AIndex=High(FMap) then
  begin
   SetLength(FMap, Length(FMap)-1);
   Exit;
  end;
 AItem:=FMap[AIndex];
 FMap[AIndex]:=FMap[High(FMap)];
 SetLength(FMap, Length(FMap)-1);
 If Assigned(AItem) Then AItem.Free;
end;

{===============================PROCEDURE==================================}

procedure TMemoryStoreMapArray.Clear;
var
 I : Integer;
begin
 For I:=Low(FMap) to High(FMap) do
  If Assigned(FMap[I]) Then FMap[I].Free;
 SetLength(FMap, 0);
end;

{===============================PROCEDURE==================================}

constructor TMemoryStoreMapArray.Create;
begin
 Clear;
end;

{===============================PROCEDURE==================================}

destructor TMemoryStoreMapArray.Free;
begin
 Clear;
end;

{===============================PROCEDURE==================================}

function TMemoryStoreItem.Size:Int64;
begin
 Result:=Length(FMemory);
end;

{===============================PROCEDURE==================================}

function TMemoryStoreItem.AsPointer:Pointer;
begin
 If Size=0 Then Result:=nil Else Result:=@FMemory[0];
end;

{===============================PROCEDURE==================================}

procedure TMemoryStoreItem.Store(const Buffer: Pointer; const BufferSize: Int64);
begin
 SetLength(FMemory, BufferSize);
 Move(Buffer^, FMemory[0], BufferSize);
end;

{===============================PROCEDURE==================================}

procedure TMemoryStoreItem.Clear;
begin
 SetLength(FMemory, 0);
 FName:=-1;
 FSection:=-1;
 FFlags:=0;
end;

{===============================PROCEDURE==================================}

constructor TMemoryStoreItem.Create;
begin
 Clear;
end;

{===============================PROCEDURE==================================}

destructor TMemoryStoreItem.Free;
begin
 Clear;
end;

{===============================PROCEDURE==================================}

Function TMemoryStore.WriteValue(SectionName, Name:Int64; V:Pointer; Sz:Int64; ForLoad:Boolean=False; inFlags:Byte=0):TMemoryStoreItem;
begin
 Result:=FindValue(SectionName, Name);
 If not Assigned(Result) then
  begin
   Result:=TMemoryStoreItem.Create;
   Result.Section:=SectionName;
   Result.Name:=Name;
   FArray.Add(Result);
  end;
 Result.Store(V, Sz);
 Result.Flags:=0;
 Result.Flags:=SetBit(Result.Flags,0,False);    // reset flags,  packed & crypted
 Result.Flags:=SetBit(Result.Flags,1,False);
 If ForLoad Then Result.Flags:=inFlags;
end;

{===============================PROCEDURE==================================}

Function TMemoryStore.FindValue(const SectionName, Name:Int64):TMemoryStoreItem;
begin
 Result:=FArray.SectionValueByName(SectionName, Name);
end;

{===============================PROCEDURE==================================}

Function TMemoryStore.ReadValue(SectionName, Name:Int64; var V:Pointer; var Sz:Int64):Boolean;
Var
 AItem : TMemoryStoreItem;
 TempMem : Pointer;
begin
 Result:=False;
 AItem:=FindValue(SectionName, Name);
 If Assigned(AItem)=False Then Exit;
 Result:=True;
 If GetBit(AItem.Flags, 1)=True Then
  begin
   AItem.Flags:=SetBit(AItem.Flags, 1, False);
   rc4decrypt(AItem.AsPointer, AItem.Size, FPersonalKey);
  end;

 If GetBit(AItem.Flags, 0)=True Then
  begin
   AItem.Flags:=SetBit(AItem.Flags, 0, False);
   Sz:=AItem.Size;
   TempMem:=ameADecode(AItem.AsPointer, Sz);
   AItem.Store(TempMem, Sz);
   FreeMem(TempMem);
  end;

 V:=AItem.AsPointer;
 Sz:=AItem.Size;
end;

{===============================PROCEDURE==================================}

Function TMemoryStore.SetBit(const B, Num:Byte; const Value:Boolean):Byte;
begin
  if Value then Result := B or (1 shl Num)
   else Result := B and (not (1 shl Num));
end;

{===============================PROCEDURE==================================}

Function TMemoryStore.GetBit(const B, Num:Byte):Boolean;
begin
 Result:=((B shr Num) and 1) = 1;
end;

{===============================PROCEDURE==================================}

{$IFNDEF FPC}
Procedure TMemoryStore.LoadFromFile(const AFileName:String);
Var
 Stream: TStream;
Begin
 Clear;
 If FileExists(AFileName)=False Then Exit;
 Stream := TFileStream.Create(AFileName,fmOpenRead);
 Try
   LoadFromStream(Stream);
 Finally
   If (Assigned(Stream)) Then Stream.Free;
 End;
End;
{$ENDIF}

{===============================PROCEDURE==================================}

{$IFNDEF FPC}
Procedure TMemoryStore.LoadFromResource(const AResourceName: string; const ResType: PChar=RT_RCDATA);
Var
 Stream: TResourceStream;
Begin
 Clear;
 Stream := TResourceStream.Create(HInstance, AResourceName, ResType);
 Try
   LoadFromStream(Stream);
 Finally
  If (Assigned(Stream)) Then Stream.Free;
 End;
end;

{===============================PROCEDURE==================================}

Procedure TMemoryStore.LoadFromResource(const AResourceName: PChar; const ResType: PChar=RT_RCDATA);
Var
 Stream: TResourceStream;
Begin
 Clear;
 Stream := TResourceStream.CreateFromID(HInstance, Int64(AResourceName), ResType);
 Try
   LoadFromStream(Stream);
 Finally
  If (Assigned(Stream)) Then Stream.Free;
 End;
end;

{$ENDIF}

{===============================PROCEDURE==================================}

{$IFNDEF FPC}
Procedure TMemoryStore.SaveToFile(const AFileName:String);
Var
 Stream: TStream;
Begin
 Stream := TFileStream.Create(AFileName,fmCreate);
 Try
   SaveToStream(Stream);
 Finally
   Stream.Free;
 End;
End;
{$ENDIF}

{===============================PROCEDURE==================================}

Function TMemoryStore.Count:Int64;
begin
 Result:=FArray.Count;
end;

{===============================PROCEDURE==================================}

Function TMemoryStore.VarSize(const SectionName, KeyName:Int64):Int64;
Var
 Buf : Pointer;
begin
 If ReadValue(SectionName, KeyName, Buf, Result)=False Then Result:=0;
end;

{===============================PROCEDURE==================================}

Function TMemoryStore.VarBuf(const SectionName, KeyName:Int64):Pointer;
Var
 Sz : Int64;
begin
 If ReadValue(SectionName, KeyName, Result, Sz)=False Then Result:=nil;
end;

{===============================PROCEDURE==================================}
{$IFNDEF FPC}
Procedure TMemoryStore.WriteBinaryFile(const SectionName, KeyName:Int64; const BFileName:String);
Var
 M : TMemoryStream;
begin
 If FileExists(BFileName)=False Then Exit;
 M:=TMemoryStream.Create;
 M.LoadFromFile(BFileName);
 WriteBinary(SectionName, KeyName, M.Memory, M.Size);
 M.Free;
end;

{===============================PROCEDURE==================================}

Procedure TMemoryStore.WriteStream(const SectionName, KeyName:Int64; const AStream:TStream);
Var
 M : TMemoryStream;
begin
 M:=TMemoryStream.Create;
 M.CopyFrom(AStream, AStream.Size-AStream.Position);
 WriteBinary(SectionName, KeyName, M.Memory, M.Size);
 M.Free;
end;

{$ENDIF}
{===============================PROCEDURE==================================}

Procedure TMemoryStore.WriteBinary(const SectionName, KeyName:Int64; const Value:Pointer; const Size:Int64);
begin
 WriteValue(SectionName, KeyName, Value, Size);
end;

{===============================PROCEDURE==================================}

Function TMemoryStore.ReadBinary(const SectionName, KeyName:Int64; const Value:Pointer; const Size:Int64):Boolean;
var
 V : Pointer;
 Sz : Int64;
begin
 Result:=ReadValue(SectionName, KeyName, V, Sz);
 If not Result Then Exit;
 If Sz>Size Then Sz:=Size;
 Move(V^, Value^, Sz);
end;

{===============================PROCEDURE==================================}

Function TMemoryStore.ValueExists(const SectionName, KeyName:Int64):Boolean;
begin
 If FindValue(SectionName, KeyName)=nil Then Result:=False Else Result:=True;
end;

{===============================PROCEDURE==================================}

Procedure TMemoryStore.DeleteValue(const SectionName, KeyName:Int64);
Var
 AIndex : Int64;
begin
 AIndex:=FArray.SectionValueIndexByName(SectionName, KeyName);
 If AIndex<>-1 Then FArray.Delete(AIndex);
end;

{===============================PROCEDURE==================================}

Function TMemoryStore.giVariable(const SectionName, KeyName:Int64):Integer;
Var
 Sz : Int64;
 Buf : Pointer;
begin
 Result:=0;
 If ReadValue(SectionName, KeyName, Buf, Sz)=False Then Exit;
 If Sz<SizeOf(Result) Then Exit;
 Result:=PInteger(Buf)^;
end;

{===============================PROCEDURE==================================}

Function TMemoryStore.gcVariable(const SectionName, KeyName:Int64):Cardinal;
Var
 Sz : Int64;
 Buf : Pointer;
begin
 Result:=0;
 If ReadValue(SectionName, KeyName, Buf, Sz)=False Then Exit;
 If Sz<SizeOf(Result) Then Exit;
 Result:=PCardinal(Buf)^;
end;

{===============================PROCEDURE==================================}

Function TMemoryStore.gc64Variable(const SectionName, KeyName:Int64):UInt64;
Var
 Sz : Int64;
 Buf : Pointer;
begin
 Result:=0;
 If ReadValue(SectionName, KeyName, Buf, Sz)=False Then Exit;
 If Sz<SizeOf(Result) Then Exit;
 Result:={$IFDEF FPC}PUInt64{$ELSE}PUInt64{$ENDIF}(Buf)^;
end;

{===============================PROCEDURE==================================}

Function TMemoryStore.gi64Variable(const SectionName, KeyName:Int64):Int64;
Var
 Sz : Int64;
 Buf : Pointer;
begin
 Result:=0;
 If ReadValue(SectionName, KeyName, Buf, Sz)=False Then Exit;
 If Sz<SizeOf(Result) Then Exit;
 Result:=PInt64(Buf)^;
end;

{===============================PROCEDURE==================================}

Function TMemoryStore.gaVariable(const SectionName, KeyName:Int64):AnsiString;
Var
 Sz : Int64;
 Buf : Pointer;
begin
 Result:='';
 If ReadValue(SectionName, KeyName, Buf, Sz)=False Then Exit;
 If Sz=0 Then Exit;
 SetLength(Result, Sz);
 Move(Buf^, PAnsiChar(Result)^, Sz);
end;

{===============================PROCEDURE==================================}

Function TMemoryStore.gwVariable(const SectionName, KeyName:Int64):WideString;
Var
 Sz : Int64;
 Buf : Pointer;
begin
 Result:='';
 If ReadValue(SectionName, KeyName, Buf, Sz)=False Then Exit;
 If Sz=0 Then Exit;
 SetLength(Result, Sz div 2);
 Move(Buf^, PWideChar(Result)^, Sz);
end;

{===============================PROCEDURE==================================}

Function TMemoryStore.gbVariable(const SectionName, KeyName:Int64):Boolean;
Var
 Sz : Int64;
 Buf : Pointer;
begin
 Result:=False;
 If ReadValue(SectionName, KeyName, Buf, Sz)=False Then Exit;
 If Sz<SizeOf(Result) Then Exit;
 {$IFDEF FPC}
 If PBoolean(Buf)^=False Then Result:=False Else Result:=True;
 {$ELSE}
  Result:=PBoolean(Buf)^;
 {$ENDIF}
end;

{===============================PROCEDURE==================================}

Function TMemoryStore.gdVariable(const SectionName, KeyName:Int64):TDateTime;
Var
 Sz : Int64;
 Buf : Pointer;
begin
 Result:=0;
 If ReadValue(SectionName, KeyName, Buf, Sz)=False Then Exit;
 If Sz<SizeOf(Result) Then Exit;
 Result:=PDateTime(Buf)^;
end;

{===============================PROCEDURE==================================}

Function TMemoryStore.gfVariable(const SectionName, KeyName:Int64):Double;
Var
 Sz : Int64;
 Buf : Pointer;
begin
 Result:=0;
 If ReadValue(SectionName, KeyName, Buf, Sz)=False Then Exit;
 If Sz<SizeOf(Result) Then Exit;
 Result:=PDouble(Buf)^;
end;

{===============================PROCEDURE==================================}

Procedure TMemoryStore.saVariable(const SectionName, KeyName:Int64;const Value:AnsiString);
begin
 WriteValue(SectionName, KeyName, PAnsiChar(Value), Length(Value));
end;

{===============================PROCEDURE==================================}

Procedure TMemoryStore.WriteArray(const SectionName, KeyName:Int64;const Value:TMemoryStoreIntArray);
begin
 WriteValue(SectionName, KeyName, Value, Length(Value)*SizeOf(Int64));
end;

{===============================PROCEDURE==================================}

Function TMemoryStore.ReadArray(const SectionName, KeyName:Int64):TMemoryStoreIntArray;
Var
 Sz : Int64;
 Buf : Pointer;
begin
 SetLength(Result,0);
 If ReadValue(SectionName, KeyName, Buf, Sz)=False Then Exit;
 SetLength(Result, Sz div SizeOf(Int64));
 Move(Buf^, Result[0], Sz);
end;

{===============================PROCEDURE==================================}

Procedure TMemoryStore.WriteArray(const SectionName, KeyName:Int64;const Value:TMemoryStoreByteArray);
begin
 WriteValue(SectionName, KeyName, Value, Length(Value)*SizeOf(Byte));
end;

{===============================PROCEDURE==================================}

Procedure TMemoryStore.ReadArray(const SectionName, KeyName:Int64; var R:TMemoryStoreByteArray);
Var
 Sz : Int64;
 Buf : Pointer;
begin
 SetLength(R,0);
 If ReadValue(SectionName, KeyName, Buf, Sz)=False Then Exit;
 SetLength(R, Sz div SizeOf(Byte));
 Move(Buf^, R[0], Sz);
end;

{===============================PROCEDURE==================================}

Procedure TMemoryStore.swVariable(const SectionName, KeyName:Int64;const Value:WideString);
begin
 WriteValue(SectionName, KeyName, PWideChar(Value), Length(Value)*2);
end;

{===============================PROCEDURE==================================}

Procedure TMemoryStore.siVariable(const SectionName, KeyName:Int64;const Value:Integer);
begin
 WriteValue(SectionName, KeyName, @Value, SizeOf(Value));
end;

{===============================PROCEDURE==================================}

Procedure TMemoryStore.scVariable(const SectionName, KeyName:Int64;const Value:Cardinal);
begin
 WriteValue(SectionName, KeyName, @Value, SizeOf(Value));
end;

{===============================PROCEDURE==================================}

Procedure TMemoryStore.si64Variable(const SectionName, KeyName:Int64;const Value:Int64);
begin
 WriteValue(SectionName, KeyName, @Value, SizeOf(Value));
end;

{===============================PROCEDURE==================================}

Procedure TMemoryStore.sc64Variable(const SectionName, KeyName:Int64;const Value:UInt64);
begin
 WriteValue(SectionName, KeyName, @Value, SizeOf(Value));
end;

{===============================PROCEDURE==================================}

Procedure TMemoryStore.sbVariable(const SectionName, KeyName:Int64;const Value:Boolean);
begin
 WriteValue(SectionName, KeyName, @Value, SizeOf(Value));
end;

{===============================PROCEDURE==================================}

Procedure TMemoryStore.sdVariable(const SectionName, KeyName:Int64;const Value:TDateTime);
begin
 WriteValue(SectionName, KeyName, @Value, SizeOf(Value));
end;

{===============================PROCEDURE==================================}

Procedure TMemoryStore.sfVariable(const SectionName, KeyName:Int64;const Value:Double);
begin
 WriteValue(SectionName, KeyName, @Value, SizeOf(Value));
end;

{===============================PROCEDURE==================================}
{$IFNDEF FPC}
Procedure TMemoryStore.SaveToSymbolicFile(const AFileName:String);
Var
 I, K : Integer;
 L : Int64;
 AT : TextFile;
 Names, Values : TMemoryStoreNamesList;
 T,Z   : String;
 P : Pointer;
begin
 T:='';
 Names:=TMemoryStoreNamesList.Create;
 Values:=TMemoryStoreNamesList.Create;
 SectionNames(Names);

 For K:=Names.AsLow To Names.AsHigh Do
  begin
   T:=T+'['+IntToStr(Int64(Names[K]))+']'+sLineBreak;
   Values.Clear;
   ValueNames(Names[K], Values);
   For I:=Values.AsLow To Values.AsHigh Do
    begin
     ReadValue(Names[K], Values[I], P, L);
     T:=T+' '+IntToStr(Values[I]);
     Case L of
      1: T:=T+' : byte  = '+IntToStr(PByte(P)^)+sLineBreak;
      2: T:=T+' : word  = '+IntToStr(PWord(P)^)+sLineBreak;
      4: T:=T+' : int32 = '+IntToStr(PInteger(P)^)+sLineBreak;
      8: T:=T+' : int64 = '+IntToStr(PInt64(P)^)+sLineBreak;
      else
       begin
        T:=T+' : ptr  = { '+IntToStr(L)+' }'+sLineBreak;
        SetLength(Z, 4096);
        BinToHex(P, PChar(Z), Min(L,256));
        SetLength(Z, Min(L,256));
        T:=T+' ['+sLineBreak+'  '+Z+sLineBreak+' ]'+sLineBreak;
       End;
     End;
    end;
   T:=T+sLineBreak+sLineBreak;
  end;


 Values.Free;
 Names.Free;
 AssignFile(AT, AFileName);
  Rewrite(AT);
  Writeln(AT, T);
 CloseFile(AT);
end;
{$ENDIF}
{===============================PROCEDURE==================================}
{$IFNDEF FPC}
Procedure TMemoryStore.SaveToStream(const AStream : TStream);
  procedure wi64(W:Int64);
  begin
   rc4crypt(@W, SizeOf(W), FPersonalKey);
   AStream.WriteBuffer(W, SizeOf(W));
  end;

Var
 I : Integer;
 AItem : TMemoryStoreItem;
 L, N : Int64;
 C, T : Pointer;
 B : Byte;
begin
 For I:=FArray.AsLow To FArray.AsHigh Do
  begin
   AItem:=FArray[I];
   ReadValue(AItem.Section, AItem.Name, C, L);
  end;
 Randomize;
 rc4key(FPersonalKey, 4096);

Try
 AStream.WriteBuffer(FPersonalKey[0], Length(FPersonalKey));  // generate new key

 For I:=FArray.AsLow To FArray.AsHigh Do
  begin
   AItem:=FArray[I];

   wi64(AItem.Name);
   wi64(AItem.Section);

   B:=AItem.Flags;
   L:=AItem.Size;
   N:=L; 
   If StreamCompression Then C:=ameAEncode(AItem.AsPointer, N);
   If (N<L) and (StreamCompression=True) Then
    begin
     wi64(N);  
     B:=SetBit(B,0, True);   
     B:=SetBit(B,1, True);   

     rc4crypt(@B, 1, FPersonalKey);
     AStream.WriteBuffer(B, 1);

     rc4crypt(C, N, FPersonalKey);
     AStream.WriteBuffer(C^, N);
    end
   Else
    begin
     wi64(L);  
     B:=SetBit(B,0, False);  
     B:=SetBit(B,1, True);  
     rc4crypt(@B, 1, FPersonalKey);

     AStream.WriteBuffer(B, 1);
     T:=AllocMem(L);
     Move(AItem.AsPointer^, T^, L);

     rc4crypt(T, L, FPersonalKey);
     AStream.WriteBuffer(T^, L);
     FreeMem(T);
    end;
   If StreamCompression Then FreeMem(C);
  end;
finally

end
end;
{$ENDIF}
{===============================PROCEDURE==================================}
{$IFNDEF FPC}
Procedure TMemoryStore.LoadFromStream(const AStream : TStream);
 Function ri64:Int64;
 begin
  AStream.ReadBuffer(Result, SizeOf(Result));
  rc4decrypt(@Result, SizeOf(Result), FPersonalKey);
 end;

Var
 L, N, Section : Int64;
 C : Pointer;
 B : Byte;
begin
 Clear;
 rc4key(FPersonalKey, 4096);
 AStream.ReadBuffer(FPersonalKey[0], Length(FPersonalKey));

Try
 While True Do
  begin
   If AStream.Position+SizeOf(Int64)>=AStream.Size Then Break;
   N:=ri64;  // Name
   Section:=ri64; // Section
   L:=ri64;  // Size
   AStream.ReadBuffer(B, 1); // FLAGS
   rc4decrypt(@B, 1, FPersonalKey);
   If L=0 Then Continue;
   If (AStream.Position+L)>AStream.Size Then Break;
   C:=AllocMem(L);
   AStream.ReadBuffer(C^, L);
   WriteValue(Section, N, C, L, True, B);
   FreeMem(C);
  end;
finally
 // nothing
End;
end;
{$ENDIF}
{===============================PROCEDURE==================================}

Procedure TMemoryStore.LoadFromMemory(AMem : Pointer; Size:Int64);
  Function rm64(O:Pointer; Distance:Int64):Pointer;
  begin
   while Distance>0 do begin Inc(PByte(O)); Dec(Distance); end;
   Result:=O;
  end;
  procedure rbuf64(M:Pointer; Sz:Int64);
  begin
   Move(AMem^, M^, Sz);
   AMem:=rm64(AMem, Sz);
   Dec(Size, Sz);
  end;
 Function ri64:Int64;
 begin
  rbuf64(@Result, SizeOf(Result));
  rc4decrypt(@Result, SizeOf(Result), FPersonalKey);
 end;

Var
 L, N, Section : Int64;
 B : Byte;
begin
 Clear;
 If (AMem=nil) or (Size=0) Then Exit;
 rc4key(FPersonalKey, 4096);
 rbuf64(@FPersonalKey[0], Length(FPersonalKey));


try
 While True Do
  begin
   If Size<=0 Then Break;

   N:=ri64;        // Name
   Section:=ri64;  // Section
   L:=ri64;        // Size
   B:=PByte(AMem)^;// Flags
   Inc(PByte(AMem));
   Dec(Size);
   rc4decrypt(@B, 1, FPersonalKey);

   If L=0 Then Continue;
   WriteValue(Section, N, AMem, L, True, B);
   AMem:=rm64(AMem, L);
   Dec(Size, L);
  end;
finally
 //
End;
end;

{===============================PROCEDURE==================================}

Procedure TMemoryStore.DeleteSection(const SectionName:Int64);
begin
 FArray.DeleteSectionValues(SectionName);
end;

{===============================PROCEDURE==================================}

Function TMemoryStore.SectionExists(const SectionName:Int64):Boolean;
begin
 Result:=FArray.SectionExist(SectionName);
end;

{===============================PROCEDURE==================================}

Function TMemoryStore.AllocSection(const Enums:Boolean=False):Int64;
Var
 iNames : TMemoryStoreNamesList;
 X : Int64;
begin
 Randomize;
 Result:=-1; 
 iNames:=TMemoryStoreNamesList.Create;
 SectionNames(iNames);
 X:=iNames.Count;
 While True Do
  begin
   If Enums=False Then
    Result:={$IFDEF FPC}Random(MaxInt){$ELSE}RandomRange(0,MaxInt){$ENDIF}
   Else
    begin
     Inc(X);
     Result:=X;
    end;
   If Result=-1 Then Continue;
   If iNames.Exist(Result)=False Then Break;
  end;
 iNames.Free;
end;

{===============================PROCEDURE==================================}

Function TMemoryStore.AllocValue(const SectionName:Int64; const Enums:Boolean=False):Int64;
Var
 iNames : TMemoryStoreNamesList;
 X : Int64;
begin
 Randomize;
 Result:=-1; 
 iNames:=TMemoryStoreNamesList.Create;
 ValueNames(SectionName, iNames);
 X:=iNames.Count;
 While True Do
  begin
   If Enums=False Then
    Result:={$IFDEF FPC}Random(MaxInt){$ELSE}RandomRange(1,MaxInt){$ENDIF}
   Else
    begin
     Inc(X);
     Result:=X;
    end;
   If (Result=-1) or (Result=0) Then Continue;
   If iNames.Exist(Result)=False Then Break;
  end;
 iNames.Free;
end;

{===============================PROCEDURE==================================}

Procedure TMemoryStore.AllocSection(scCount:Integer; var scNames:TMemoryStoreIntArray; RangeFrom:Int64=-1);
Var
 iNames : TMemoryStoreNamesList;
 I : Integer;
 R : Int64;
begin
 Randomize;
 SetLength(scNames, scCount);
 If scCount=0 Then Exit;
 iNames:=TMemoryStoreNamesList.Create;
 SectionNames(iNames);
 I:=0;
 While True Do
  begin
   If RangeFrom=-1 then
    begin
     R:={$IFDEF FPC}Random(MaxInt div 2){$ELSE}RandomRange(1,MaxInt div 2){$ENDIF};
    end
   Else
    begin
     R:={$IFDEF FPC}Random(MaxInt div 2){$ELSE}RandomRange(RangeFrom,MaxInt div 2){$ENDIF};
    end;
   If (R=-1) or (R=0) Then Continue;
   If iNames.Exist(R)=False Then
    begin
     iNames.Add(R);
     scNames[I]:=R;
     Inc(I);
    end;
   If I>=scCount Then Break;
  end;
 iNames.Free;
end;

{===============================PROCEDURE==================================}

Function TMemoryStore.SectionCount:Int64;
begin
 Result:=FArray.SectionCount;
end;

{===============================PROCEDURE==================================}

Function TMemoryStore.SectionNames(const ANames:TMemoryStoreNamesList):Int64;
begin
 Result:=FArray.SectionNames(ANames);
end;

{===============================PROCEDURE==================================}

Function TMemoryStore.ValueNames(const SectionName:Int64; const ANames:TMemoryStoreNamesList):Int64;
begin
 Result:=FArray.ValueNames(SectionName, ANames);
end;

{===============================PROCEDURE==================================}

Procedure TMemoryStore.Clear;
begin
 StreamCompression:=True;
 rc4freekey(FPersonalKey);
 FArray.Clear;
end;

{===============================PROCEDURE==================================}

Constructor TMemoryStore.Create;
begin
 FArray:=TMemoryStoreMapArray.Create;
 StreamCompression:=True;
 Clear;
end;

{===============================PROCEDURE==================================}

Destructor TMemoryStore.Free;
begin
 Clear;
 FArray.Free;
end;

{===============================PROCEDURE==================================}



end.

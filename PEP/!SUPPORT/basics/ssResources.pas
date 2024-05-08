unit ssResources;




interface
Uses Windows, Classes, SysUtils;


{$IFDEF FPC}
 {$mode delphi}{$H+}
{$ENDIF}



Const
 Win32RStatusClear   = 0 ;
 Win32RStatusUpdated = 1 ;
 Win32RStatusDelete  = 2 ;

 

Type
 TrxResourceClass = Class
 public
  wType   : PChar;
  Typed   : String;
  wName   : PChar;
  Named   : String;
  Size    : Integer;
  Buffer  : Pointer;
  Status  : Integer;
  DefLang : Integer;
  UserField : Integer;
  uid     : Cardinal;
 End;


 


Type
 TrxResourceMap = Class
 Protected
  FFileName : String;
  FList     : TList;
 Public
  Function  FindResource(R:TrxResourceClass):TrxResourceClass;
  Procedure EnumAvailableLang(AList:TList; const wTypes:Array of Integer);Overload;
  Procedure EnumAvailableLang(AList:TList);Overload;
  Procedure EnumByType(wType:PChar; AList:TList; wLanguage:Integer=-1);Overload;
  Procedure EnumByType(wType:PChar; AList:TList; const wLanguage:Array of Integer);Overload;
  Procedure UnQueryResource(rInfo:TrxResourceClass);
  Procedure Sort(const wTypes:Array of Integer);
  Procedure Clear;
  Constructor Create(const AFileName:String);overload;
  Constructor Create(const AHandle:THandle);overload;
  Destructor  Free;
  Property List:TList Read FList;
  Property FileName:String Read FFileName;
 End;






 
Type
 TrxResourceItemClass = Class
 Protected
  FInfo : TrxResourceClass;
  Procedure CreateHandle;virtual;
  Procedure FreeHandle;virtual;
 Public
  Procedure   NewStatus(aStatus:Integer);
  Procedure   AlignStream(AStream:TStream;AValue:Integer;AWrite:Boolean=False);
  Function    ReadWChar(aStream:TStream):String;
  Procedure   WriteWChar(AStream:TStream;AValue:String);
  Procedure   SaveToStream(aStream:TStream);
  Procedure   SaveToFile(aFileName:String);
  Procedure   Update(aNewBuf:Pointer;aNewSize:Integer);
  Function    Size:Integer;
  Function    Data:Pointer;
  Function    Name:String;
  Function    ParentType:String;
  Procedure   Change;virtual;
  //
  Constructor Create(aInfo:TrxResourceClass);
  Destructor  Free;
  // main
  Property ResourceData: TrxResourceClass Read FInfo;
 End;



 
 

Type
 TrxResourceString=Class(TrxResourceItemClass)
 Protected
  FIndex : TList;
  Procedure CreateHandle;Override;
  Procedure FreeHandle;Override;
 Public
  List      : Array of String;
  Function  IndexPresent(Ind:Integer):Integer;
  Function  StringByIndex(Ind:Integer):String;
  Procedure Script(L:TStrings);
  Procedure Change;Override;
  Function  Count:Integer;
  Property  IndexList:TList Read FIndex;
 End;






Const
 Win32MenuTag_ITEM   = 0;
 Win32MenuTag_BEGIN  = 1;
 Win32MenuTag_END    = 2;




 
Type
 TrxResourceMenuItem = Class
 public
  Tag         : Integer;
  Typed       : Integer;
  State       : Integer;
  Id          : Integer;
  ResInfo     : Integer;
  Caption     : String;
  ShortCut    : String;
  HasShortCut : Boolean;
  ShortChar   : Char;
  HelpId      : Integer;
  Flags       : Integer;
  UserData    : Pointer;  // user field
  hInstance   : Pointer;  // user field
  ruid        : Cardinal;
  inum        : Integer;
 End;
 


 

Type
 TrxResourceMenu = Class(TrxResourceItemClass)
 Protected
  FIsEx    : Boolean;
  FVersion : Integer;
  FOfs     : Integer;
  FHelpID  : Integer;
  FList    : TList;
  Procedure CreateHandle;Override;
  Procedure FreeHandle;Override;
  Procedure ExtractShortCut(PMenu:TrxResourceMenuItem);
  Function  ShortCut(PMenu:TrxResourceMenuItem):String;
  Function  fmtRUID(AMenuItem:TrxResourceMenuItem):Cardinal;
 Public
  Function  FindItem(AMenuItem:TrxResourceMenuItem): TrxResourceMenuItem;
  Function  IndexPresent(Ind:Integer):Integer;
  Function  StringByIndex(Ind:Integer):String;
  Procedure Script(L:TStrings);
  Procedure Change;Override;
  Property  List:TList Read FList;
  Property  IsExtended:Boolean Read FIsEx;
 End;





Type
 TrxResourceDialogItem = Class
 public
  X         : DWORD;
  Y         : DWORD;
  W         : DWORD;
  H         : DWORD;
  Id        : Integer;
  Style     : DWORD;
  exStyle   : DWORD;
  HelpId    : Integer;
  Caption   : String;
  CaptionId : Integer;
  Control   : String;
  ControlId : Integer;
  UserData  : Pointer;
  hInstance : Pointer;  // user field
  ruid      : Cardinal;
 End;



 
Type
 TrxResourceDialog = Class(TrxResourceItemClass)
 Protected
  FIsEx     : Boolean;
  FX        : DWORD;
  FY        : DWORD;
  FCX       : DWORD;
  FCY       : DWORD;
  FVersion  : Integer;
  FHelpID   : Integer;
  FStyle    : DWORD;
  FexStyle  : DWORD;
  FSign     : Integer;
  FMenu     : String;
  FMenuId   : Integer;
  FHasMenu  : Boolean;
  FClass    : String;
  FCaption  : String;
  FFontName : String;
  FFontSize : Integer;
  FFontW    : Integer;
  FFontB    : Integer;
  FList     : TList;
  Procedure CreateHandle;Override;
  Procedure FreeHandle;Override;
  Function  fmtRUID(ADlgItem:TrxResourceDialogItem):Cardinal;
 Public
  Function  FindItem(ADlgItem:TrxResourceDialogItem): TrxResourceDialogItem;
  Function  FindItemByUserData(uData:Pointer):TrxResourceDialogItem;
  Function  IndexPresentEx(xItem:TrxResourceDialogItem;xIndex:Integer):Integer;
  Function  IndexPresent(Ind:Integer):Integer;
  Function  StringByIndex(Ind:Integer):String;
  Procedure Script(L:TStrings);
  Procedure Change;Override;
  Property X:DWORD Read FX Write FX;
  Property Y:DWORD Read FY Write FY;
  Property CX:DWORD Read FCX Write FCX;
  Property CY:DWORD Read FCY Write FCY;
  Property Caption:String Read FCaption Write FCaption;
  Property FontName:String Read FFontName Write FFontName;
  Property Menu:String Read  FMenu Write FMenu ;
  Property Classed:String Read FClass Write FClass;
  Property FontSize:Integer Read FFontSize Write FFontSize;
  Property FontW:Integer Read FFontW Write FFontW;
  Property FontB:Integer Read FFontB Write FFontB;
  Property HelpId:Integer Read FHelpId Write FHelpId;
  Property Style:DWORD Read FStyle Write FStyle;
  Property exStyle:DWORD Read FexStyle Write FexStyle;
  Property List:TList Read FList;
  Property IsExtended:Boolean Read FIsEx;
 End;





Type
 TrxFormPropertyKind = (pkNone, pkBoolean, pkStrings, pkHex,
                        pkString, pkItems, pkInt, pkEnum);
 

Type
 TrxFormPropertyItem = Class
 public
  Name  : String;
  Value : Variant;
  Kind  : TrxFormPropertyKind;
 End;




Type
 TrxFormPropertyList=Class
 Protected
  FList:TList;
 Public
  Function    Find(const inName:String):TrxFormPropertyItem;
  Procedure   Add(const inName:String; Value:Variant; Kind:TrxFormPropertyKind=pkNone);
  Procedure   Clear;
  Function    Count:Integer;
  Constructor Create;
  Destructor  Free;
  Property    List:TList Read FList;
 End;


 

Type
 TrxResourceFormItem = Class
 public
  Header     : String; 
  FullHeader : String;
  Parent     : TrxResourceFormItem;
  ObjectClassName  : String;
  ObjectName : String;
  List       : TrxFormPropertyList;
  Level      : Integer; 
  UserData   : Pointer;
  hInstance  : Pointer;  
  ruid       : Cardinal;
 End;




Type
 TrxResourceForm = Class(TrxResourceItemClass)
 Protected
  FList       : TList;
  Procedure CreateHandle;Override;
  Procedure FreeHandle;Override;
  Function  fmtRUID(AFrmItem:TrxResourceFormItem):Cardinal;
 Public
  Function  FindItem(AFrmItem:TrxResourceFormItem): TrxResourceFormItem;
  Function  UpdateProperty(FormItem:TrxResourceFormItem; PropertyName:String; Value:Variant):TrxFormPropertyItem;
  Function  ConvertToString(const S:String):String;
  Function  ConvertFromString(const S:String):String;
  Function  FindItemByUserData(uData:Pointer):TrxResourceFormItem;
  Function  NamePresent(const AName:String):Integer;
  Function  ItemByName(const AName:String):TrxResourceFormItem;
  Procedure Script(L:TStrings);
  Procedure Change;Override;
  Property  List:TList Read FList;
 End;



  
Type
 TrxResourceCompiler=Class
 Protected
  FList:TList;
 Public
  Procedure   SaveToStream(Stream:TStream);
  Procedure   LoadFromStream(Stream:TStream);
  Procedure   SaveToFile(const FileName:String);
  Procedure   LoadFromFile(const FileName:String);

  Function    Count:Integer;
  Procedure   Clear;
  Procedure   Add(rInfo:TrxResourceClass);Overload;
  Procedure   Add(rType:PChar;rName:String;Buf:Pointer;BufSize:Integer;rLang:Integer=0);Overload;
  Procedure   Change(rInfo:TrxResourceClass);
  Procedure   Delete(rInfo:TrxResourceClass;DefLang:Integer=-1);
  Procedure   Update(const AFileName:String);
  Constructor Create;
  Destructor  Free;
  Property    List:TList Read FList;
 End;


Type
 TStackList = Class(TList)
 Public
  Procedure   Push(aValue:Pointer);
  Function    Pop:Pointer;Overload;
  Function    HidePop:Pointer;
  Procedure   Pop(Var aValue:Pointer);Overload;
 End;




// Other
Type
  TIconHeader = packed record
    idReserved: Word; 
    idType: Word;    
    idCount: Word;    
  end;

  TIconDirEntry = packed record
    bWidth: Byte;        
    bHeight: Byte;        
    bColorCount: Byte;    
    bReserved: Byte;      
    wPlanes: Word;       
    wBitCount: Word;      
    dwBytesInRes: Longint; 
    dwImageOffset: Longint;
  end;





Const
 RT_MANIFEST = MakeIntResource(24);



Function  fmtDlgCtrlToStr(V:Integer):String;
Function  fmtwTypeToStr(wType:PChar):String;
Function  fmtResourceUID(R:TrxResourceClass):Cardinal;

Function  fmtLanguageID(Primary,Sub:Word):Word;
Function  fmtPrimaryLanguageID(LangID:Word):Word;

Function  fmtLangToStr(LangID:Word):String;
Function  fmtPrimaryLangToStr(PrimaryLang:Word):String;







implementation
Uses StrUtils, ssMemory, ssLameCrypt;



type
  TBaseParser = class
  private
    FText: string;
    FCurrent, FAnchor: Integer;
    FToken: string;
  protected
    procedure Error(const S: string); overload;
    procedure Error(const fmt: string; const A: array of const); overload;
    procedure DropAnchor;
    procedure NextToken;
    procedure NextChar;
    procedure SkipWhitespace;
    Function SkipToEol:String;
    Function SkipTo(ch: Char):String;
    Function SkipToString(const S: string):String;
    function EndOfText: Boolean;
    function IsTokenChar: Boolean;
    function IsWhiteSpace: Boolean;
    function CurrentChar: Char;
    function LastWord: string;
    function ParseEncodedChar: Char;
    function ParseQuotedString: string;
    function ParseStringValue: string;
  public
    procedure Parse; virtual; abstract;
    constructor Create(const S: string); virtual;
    property Token: string read FToken;
  end;



  TDFMParser = class(TBaseParser)
  protected
    procedure ParseComponent(AParent:TrxResourceFormItem);
    procedure ParseProperty(AParent:TrxResourceFormItem);
    function TokenIsObject: Boolean;
    function IsEndToken: Boolean;
  public
    Owner : TrxResourceForm;
    GLevel : Integer;
    procedure Parse; override;
  end;



{===============================PROCEDURE==================================}

constructor TBaseParser.Create(const S: string);
begin
  FText := S;
  FCurrent := 1;
end;

{===============================PROCEDURE==================================}

function TBaseParser.CurrentChar: Char;
begin
  Result := FText[FCurrent];
end;

{===============================PROCEDURE==================================}

procedure TBaseParser.DropAnchor;
begin
  FAnchor := FCurrent;
end;

{===============================PROCEDURE==================================}

function TBaseParser.EndOfText: Boolean;
begin
  result := FCurrent >= Length(FText);
end;

{===============================PROCEDURE==================================}

procedure TBaseParser.Error(const S: string);
begin
  raise EPArserError.Create(S);
end;

{===============================PROCEDURE==================================}

procedure TBaseParser.Error(const fmt: string; const A: array of const);
begin
  Error(Format(fmt, A));
end;

{===============================PROCEDURE==================================}

function TBaseParser.IsTokenChar: Boolean;
begin
 {$IFDEF FPC}
 {$ELSE}
  Result := (CharInSet(Currentchar, ['a'..'z', 'A'..'Z', '0'..'9', '_'])) or
            (CurrentChar = '.');
 {$ENDIF}
end;

{===============================PROCEDURE==================================}

function TBaseParser.IsWhiteSpace: Boolean;
begin
 {$IFDEF FPC}
 {$ELSE}
  Result := CharInSet(Currentchar, [#1..#32]);
 {$ENDIF}
end;

{===============================PROCEDURE==================================}

function TBaseParser.LastWord: string;
begin
  Assert(FAnchor <= FCurrent);
  result := Copy(FText, FAnchor, FCurrent - FAnchor);
end;

{===============================PROCEDURE==================================}

procedure TBaseParser.NextChar;
begin
  Inc(FCurrent);
  if EndOfText then Error('Unexpected end of text');
end;

{===============================PROCEDURE==================================}

procedure TBaseParser.NextToken;
begin
  SkipWhitespace;
  DropAnchor;
  while not EndOfText and IsTokenChar do Inc(FCurrent);
  FToken := LastWord;
end;

{===============================PROCEDURE==================================}

Function TBaseParser.SkipTo(ch: Char):String;
begin
 Result:='';
 while not EndOfText and (CurrentChar <> ch) do
  begin
   NextChar;
   If CurrentChar <> ch Then Result:=Result + CurrentChar;
  end;
 Inc(FCurrent);
end;

{===============================PROCEDURE==================================}

Function TBaseParser.SkipToString(const S: string):String;
Var
 P : Integer;
begin
 Result:='';
 P := PosEx(S, FText, FCurrent+1);
 If P>0 then
  begin
   Result:=Copy(FText, FCurrent+1, P-(FCurrent+1));
   FCurrent := P  + 1 + Length(S);
  end
 else Error('Expected string "%s" not found', [S]);
end;

{===============================PROCEDURE==================================}

Function TBaseParser.SkipToEol:String;
begin
 Result:='';
 while not EndOfText and (FText[FCurrent] <> #10) do
  begin
   If (CurrentChar<>#10) and (CurrentChar<>#13) Then
    Result:=Result+CurrentChar;
   Inc(FCurrent);
  end;
end;

{===============================PROCEDURE==================================}

procedure TBaseParser.SkipWhitespace;
begin
  while not EndOfText and IsWhiteSpace do
    Inc(FCurrent);
end;

{===============================PROCEDURE==================================}

function TBaseParser.ParseQuotedString: string;
begin
  Assert(CurrentChar = '''');
  Result := '';
  repeat
    NextChar; {skip leading quote}
    DropAnchor;
    while CurrentChar <> '''' do
      NextChar;
    Result := Result + LastWord;
    NextChar;
    if CurrentChar = '''' then
      Result := Result + ''''; {literal quote}
  until
    CurrentChar <> '''';
  SkipWhitespace;
end;

{===============================PROCEDURE==================================}

function TBaseParser.ParseEncodedChar: Char;
var
  n: Integer;
begin
  Assert(CurrentChar = '#');
  NextChar;
  DropAnchor;
  if CurrentChar = '$' then
  begin
    NextChar;
    {$IFDEF FPC}
    {$ELSE}
     while CharInSeT(CurrentChar, ['A'..'F', 'a'..'f', '0'..'9']) do
       NextChar;
    {$ENDIF}
  end
  else
   begin
    {$IFDEF FPC}
    {$ELSE}
      while CharInSeT(CurrentChar, ['0'..'9', '-', '+']) do NextChar;
    {$ENDIF}
   End;

  n := StrToInt(LastWord);
  //if n > High(Byte) then
  //  Error('Encountered UNICODE character in string, cannot handle that.');
  //Result := Char(n);
  Result := Chr(n);
  SkipWhitespace;
end;

{===============================PROCEDURE==================================}

function TBaseParser.ParseStringValue: string;
begin
  Result := '';
  SkipWhitespace;
  while True do
    case CurrentChar of
      '''':
        Result := Result + ParseQuotedString;
      '#':
        Result := Result + ParseEncodedChar;
      '+':
        begin
          NextChar;
          SkipWhitespace;
        end;
    else
      Break;
    end;
end;

{===============================PROCEDURE==================================}

function TDFMParser.IsEndToken: Boolean;
begin
 Result := SameText(Token, 'end');
end;

{===============================PROCEDURE==================================}

procedure TDFMParser.Parse;
begin
 GLevel:=0;
  while not EndOfText do
  begin
    ParseComponent(nil);
    SkipWhitespace;
  end;
end;

{===============================PROCEDURE==================================}

procedure TDFMParser.ParseComponent(AParent:TrxResourceFormItem);
Var
 PForm     : TrxResourceFormItem;
begin
 if FToken = '' then NextToken;
 if not TokenIsObject then
   Error('Expected: inherited, inline or object, but found : %s, position: %d',
         [Token, FCurrent]);

 PForm:=TrxResourceFormItem.Create;
 PForm.FullHeader:=LastWord+' ';

 NextToken;
 PForm.ObjectName:= Token;
 PForm.FullHeader:=PForm.FullHeader+PForm.ObjectName;

 SkipWhitespace;
 If CurrentChar=':' Then
  begin
   NextChar;
   NextToken;
   PForm.ObjectClassName:=Token;
   PForm.FullHeader:=PForm.FullHeader+' : '+PForm.ObjectClassName;
  end
 Else Dec(FCurrent);

 SkipToEol;
 PForm.Parent:=AParent;
 PForm.Level:=GLevel;
 PForm.List:=TrxFormPropertyList.Create;

 PForm.ruid:=Owner.fmtRUID(PForm);
 Owner.List.Add(PForm);
 repeat
  NextToken;
  if TokenIsObject then
   begin
    Inc(GLevel);
    ParseComponent(PForm);
   end
  Else
   begin
    if not IsEndToken Then ParseProperty(PForm)
     Else Dec(GLevel);
   end;
  SkipWhitespace;
 until IsEndToken or EndOfText;
 if IsEndToken then FToken := '';
end;

{===============================PROCEDURE==================================}

Procedure TDFMParser.ParseProperty(AParent:TrxResourceFormItem);
Var
 PropName  : String;
 PropValue : String;
 PropKind  : TrxFormPropertyKind;
 PT        : Integer;
 Marker    : String;
begin
 PropName := Token;
 SkipWhitespace;
 if CurrentChar <> '=' then
  begin
   Marker:=Copy(FText, FCurrent-20, 20);
   Error('Expected: =, found %s (position %d - marker %s)',
                                   [CurrentChar, FCurrent, Marker]);
  end;

 NextChar;
 SkipWhitespace;
 case CurrentChar of
   '{':
        begin
         PropKind:=pkHex;
         PropValue:= SkipToString('}'#13);
        end;

   '(':
        begin
         PropKind:=pkStrings;
         PropValue:= SkipToString(')'#13);
        end;

   '<':
        begin
         PropKind:=pkItems;
         PT:=FCurrent;
         NextChar;
         NextToken;
         Marker:=LastWord;
         FCurrent:=PT;
         If SameText(Marker, 'item') Then PropValue:= SkipToString('end>'#13)+'end'
          Else PropValue:= SkipToString('>'#13);
        end;

   '[':
        begin
         PropKind:=pkEnum;
         PropValue:= SkipTo(']');
        end;

   '''', '#':
        begin
         PropKind:=pkString;
         PropValue:=ParseStringValue;
        end;
  else
   begin
    PropKind:=pkNone;
    PropValue:=SkipToEol;
   end;

 end;

 If PropKind=pkNone Then
  begin
   If TryStrToInt(PropValue,PT)=True Then PropKind:=pkInt Else
   If SameText(PropValue, 'True') or SameText(PropValue, 'False') Then
    PropKind:=pkBoolean;
  end;
 AParent.List.Add(PropName, PropValue, PropKind);
end;

{===============================PROCEDURE==================================}

function TDFMParser.TokenIsObject: Boolean;
begin
  Result := (SameText(Token, 'inherited')) or (SameText(Token, 'object'))
            or (SameText(Token, 'inline'));
end;

{===============================PROCEDURE==================================}

Procedure TStackList.Push(aValue:Pointer);
Begin
 Self.Add(aValue);
End;

{===============================PROCEDURE==================================}

Function TStackList.Pop:Pointer;
Begin
 Result:=NIL;
 If Self.Count=0 Then Exit;
 Result:=Self[Self.Count-1];
 Self.Delete(Self.Count-1);
End;

{===============================PROCEDURE==================================}

Function TStackList.HidePop:Pointer;
Begin
 Result:=NIL;
 If Self.Count=0 Then Exit;
 Result:=Self[Self.Count-1];
End;

{===============================PROCEDURE==================================}

Procedure TStackList.Pop(Var aValue:Pointer);
Begin
 aValue:=Pop;
End;

{===============================PROCEDURE==================================}

Function fmtwTypeToStr(wType:PChar):String;
Begin
 Result:='RT_UNKNOWN';
 Case Integer(wType) Of
  Integer(RT_CURSOR):       Result:='RT_CURSOR';
  Integer(RT_BITMAP):       Result:='RT_BITMAP';
  Integer(RT_ICON):         Result:='RT_ICON';
  Integer(RT_MENU):         Result:='RT_MENU';
  Integer(RT_DIALOG):       Result:='RT_DIALOG';
  Integer(RT_STRING):       Result:='RT_STRING';
  Integer(RT_FONTDIR):      Result:='RT_FONTDIR';
  Integer(RT_FONT):         Result:='RT_FONT';
  Integer(RT_ACCELERATOR):  Result:='RT_ACCELERATOR';
  Integer(RT_RCDATA):       Result:='RT_RCDATA';
  Integer(RT_MESSAGETABLE): Result:='RT_MESSAGETABLE';
  Integer(RT_GROUP_CURSOR): Result:='RT_GROUP_CURSOR';
  Integer(RT_GROUP_ICON):   Result:='RT_GROUP_ICON';
  Integer(RT_VERSION):      Result:='RT_VERSION';
  Integer(RT_DLGINCLUDE):   Result:='RT_DLGINCLUDE';
  Integer(RT_PLUGPLAY):     Result:='RT_PLUGPLAY';
  Integer(RT_VXD):          Result:='RT_VXD';
  Integer(RT_ANICURSOR):    Result:='RT_ANICURSOR';
  Integer(RT_ANIICON):      Result:='RT_ANIICON';
  Integer(RT_MANIFEST):     Result:='RT_MANIFEST';
 End;
End;

{===============================PROCEDURE==================================}
  
Function fmtPrimaryLangToStr(PrimaryLang:Word):String;
Begin
 Case PrimaryLang Of
  LANG_NEUTRAL    : Result:='Neutral';
  LANG_AFRIKAANS  : Result:='Afrikaans';
  LANG_ALBANIAN   : Result:='Albanian';
  LANG_ARABIC     : Result:='Arabic';
  LANG_BASQUE     : Result:='Basque';
  LANG_BELARUSIAN : Result:='Belarusian';
  LANG_BULGARIAN  : Result:='Bulgarian';
  LANG_CATALAN    : Result:='Catalan';
  LANG_CHINESE    : Result:='Chinese';
  LANG_CROATIAN   : Result:='Croatian';
  LANG_CZECH      : Result:='Czech';
  LANG_DANISH     : Result:='Danish';
  LANG_DUTCH      : Result:='Dutch';
  LANG_ENGLISH    : Result:='English';
  LANG_ESTONIAN   : Result:='Estonian';
  LANG_FAEROESE   : Result:='Faeroese';
  LANG_FARSI      : Result:='Farsi';
  LANG_FINNISH    : Result:='Finnish';
  LANG_FRENCH     : Result:='French';
  LANG_GERMAN     : Result:='German';
  LANG_GREEK      : Result:='Greek';
  LANG_HEBREW     : Result:='Hebrew';
  LANG_HUNGARIAN  : Result:='Hungarian';
  LANG_ICELANDIC  : Result:='Icelandic';
  LANG_INDONESIAN : Result:='Indonesian';
  LANG_ITALIAN    : Result:='Italian';
  LANG_JAPANESE   : Result:='Japanese';
  LANG_KOREAN     : Result:='Korean';
  LANG_LATVIAN    : Result:='Latvian';
  LANG_LITHUANIAN : Result:='Lithunian';
  LANG_NORWEGIAN  : Result:='Norwegian';
  LANG_POLISH     : Result:='Polish';
  LANG_PORTUGUESE : Result:='Portuguese';
  LANG_ROMANIAN   : Result:='Romanian';
  LANG_RUSSIAN    : Result:='Russian';
  LANG_SLOVAK     : Result:='Slovak';
  LANG_SLOVENIAN  : Result:='Slovenian';
  LANG_SPANISH    : Result:='Spanish';
  LANG_SWEDISH    : Result:='Swedish';
  LANG_THAI       : Result:='Thai';
  LANG_TURKISH    : Result:='Turkish';
  LANG_UKRAINIAN  : Result:='Ukrainian';
  LANG_VIETNAMESE : Result:='Vietnamese';
  Else Result:='';
 End;
End;

{===============================PROCEDURE==================================}

Function fmtLangToStr(LangID:Word):String;
Var
 PrimaryLng:Word;
Begin
 PrimaryLng:=fmtPrimaryLanguageID(LangID);
 Result:=fmtPrimaryLangToStr(PrimaryLng);
End;

{===============================PROCEDURE==================================}

Function fmtPrimaryLanguageID(LangID:Word):Word;
Begin
 Result:=LangID And $3ff;
End;

{===============================PROCEDURE==================================}

Function fmtLanguageID(Primary,Sub:Word):Word;
Begin
 Result:=(Sub shl 10) or Primary;
End;

{===============================PROCEDURE==================================}

Procedure TrxResourceMap.EnumByType(wType:PChar; AList:TList; wLanguage:Integer=-1);
Var
 I : Integer;
 R : TrxResourceClass;
Begin
 AList.Clear;
 If FList.Count=0 Then Exit;
 For I:=0 To FList.Count-1 Do
  Begin
   R:=TrxResourceClass(FList[I]);
   If R.wType<>wType Then Continue;
   If wLanguage<>-1 Then
    If R.DefLang<>wLanguage Then Continue;
   AList.Add(R);
  End;
End;

{===============================PROCEDURE==================================}

Procedure TrxResourceMap.EnumByType(wType:PChar; AList:TList; const wLanguage:Array of Integer);
Var
 I,J : Integer;
 R   : TrxResourceClass;
begin
 AList.Clear;
 If FList.Count=0 Then Exit;
 For I:=0 To FList.Count-1 Do
  Begin
   R:=TrxResourceClass(FList[I]);
   If R.wType<>wType Then Continue;
   For J:=Low(wLanguage) To High(wLanguage) Do
    If R.DefLang = wLanguage [J] Then
     Begin
      AList.Add(R);
      Break;
     End;
  End;
end;

{===============================PROCEDURE==================================}

Procedure TrxResourceMap.EnumAvailableLang(AList:TList);
Var
 I : Integer;
 R : TrxResourceClass;
Begin
 AList.Clear;
 If FList.Count=0 Then Exit;
 For I:=0 To FList.Count-1 Do
  Begin
   R:=TrxResourceClass(FList[I]);
   If AList.IndexOf(Pointer(R.DefLang))<>-1 Then Continue;
   AList.Add(Pointer(R.DefLang));
  End;
End;

{===============================PROCEDURE==================================}

Procedure TrxResourceMap.EnumAvailableLang(AList:TList; const wTypes:Array of Integer);
Var
 I,J : Integer;
 R   : TrxResourceClass;
 F   : Boolean;
Begin
 AList.Clear;
 If FList.Count=0 Then Exit;
 For I:=0 To FList.Count-1 Do
  Begin
   R:=TrxResourceClass(FList[I]);
   F:=False;
   For J:=Low(wTypes) To High(wTypes) Do
    If Integer(R.wType)=wTypes[J] Then
     Begin
      F:=True;
      Break;
     End;
   If F=False Then Continue;
   If AList.IndexOf(Pointer(R.DefLang))<>-1 Then Continue;
   AList.Add(Pointer(R.DefLang));
  End;
End;

{===============================PROCEDURE==================================}

Function  fmtResourceUID(R:TrxResourceClass):Cardinal;
Var
 uid : String;
begin
 uid:=IntToStr(R.DefLang)+R.Typed+R.Named;
 Result:=ameStringCrC(uid);
end;

{===============================PROCEDURE==================================}

Function EnumResLangProcF(hModule:THandle;lpType,lpName:LPCTSTR;ID:Word;lParam:Integer):LongBool;stdcall;
Var
 R        : TrxResourceClass;
 Handle,A : Integer;
 Buffer   : Pointer;
Begin
 Result:=True;

 R:=TrxResourceClass.Create;
 R.DefLang:=ID;

 Handle:=FindResourceEx(hModule,lpType,lpName,ID);
 R.Size:=SizeofResource(hModule,Handle);

 If R.Size<>0 Then
  Begin
   A:=LoadResource(hModule,Handle);
   Buffer:=LockResource(A);
   // change to virtual mem
   R.Buffer:=vxAllocMem(R.Size);
   CopyMemory(R.Buffer,Buffer,R.Size);
   UnlockResource(A);
  End;
 R.Status:=Win32RStatusClear;

 If Integer(lpType)<MaxWord Then
  begin
   R.Typed:=IntToStr(Integer(lpType));
   R.wType:=lpType;
  end
 Else
  begin
   R.Typed:=lpType;
   R.wType:=PChar(R.Typed);
  end;

 If Integer(lpName)<MaxWord Then
  begin
   R.Named:=IntToStr(Integer(lpName));
   R.wName:=lpName;
  end
 Else
  begin
   R.Named:=lpName;
   R.wName:=PChar(R.Named);
  end;
 R.uid:=fmtResourceUID(R);
 TList(lParam).Add(R);
End;

{===============================PROCEDURE==================================}

Function EnumResourceNameProcF(hModule:THandle;lpType,lpName:LPCTSTR;lParam:Integer):LongBool;stdcall;
Begin
 Result:=True;
 EnumResourceLanguages(hModule,lpType,lpName,@EnumResLangProcF,lParam);
End;

{===============================PROCEDURE==================================}

Function EnumResourceTypeProcF(hModule:HMODULE;lpszType:LPTSTR;lParam:Integer):BOOL;stdcall;
Begin
 Result:=True;
 EnumResourceNames(hModule,lpszType,@EnumResourceNameProcF,lParam);
End;

{===============================PROCEDURE==================================}

Constructor TrxResourceMap.Create(const AFileName:String);
Var
 FHandle: THandle;
Begin
 FFileName:=AFileName;
 FList:=TList.Create;

 FHandle:=LoadLibraryEx(PChar(FFileName),0,LOAD_LIBRARY_AS_DATAFILE);
 If FHandle=0 Then RaiseLastOSError;

 EnumResourceTypes(FHandle,@EnumResourceTypeProcF,Integer(FList));
 FreeLibrary(FHandle);
End;

{===============================PROCEDURE==================================}

Constructor TrxResourceMap.Create(const AHandle:THandle);
Var
 L : Integer;
Begin
 If AHandle=0 Then RaiseLastOSError;

 SetLength(FFileName, 4096);
 L:=GetModuleFileName(AHandle, PChar(FFileName), 4096);
 SetLength(FFileName, L);

 FList:=TList.Create;
 EnumResourceTypes(AHandle,@EnumResourceTypeProcF,Integer(FList));
end;

{===============================PROCEDURE==================================}

Procedure TrxResourceMap.Clear;
Var
 I : Integer;
 R : TrxResourceClass;
Begin
 FFileName:='';
 If FList.Count<>0 Then
  For I:=0 To FList.Count-1 Do
   Begin
    R:=TrxResourceClass(FList[I]);
    If (R.Size<>0) and (R.Buffer<>NIL) Then
    vxFreeMem(R.Buffer);
    R.Free;
   End;
 FList.Clear;
End;

{===============================PROCEDURE==================================}

Function TrxResourceMap.FindResource(R:TrxResourceClass):TrxResourceClass;
Var
 I : Integer;
 u : Cardinal;
begin
 If FList.Count=0 Then Exit(NiL);
 u:=fmtResourceUID(R);
 For I:=0 To FList.Count-1 Do
  begin
   Result:=TrxResourceClass(FList[I]);
   If Result.uid=u Then Exit;
  end;
 Result:=NIL;
end;

{===============================PROCEDURE==================================}

Procedure TrxResourceMap.Sort(const wTypes:Array of Integer);
Var
 T, J, I, S, E : Integer;
 M       : Array of TList;
 O       : TList;
 R       : TrxResourceClass;
begin
 If SizeOf(wTypes)=0 Then Exit;
 If List.Count=0 Then Exit;
 SetLength(M,SizeOf(wTypes));
 S:=Low(wTypes);
 E:=High(wTypes);
 For I:=S To E Do M[I]:=TList.Create;
 O:=TList.Create;

 // sort
 For J:=0 To List.Count-1 Do
  begin
   R:=TrxResourceClass(List[J]);
   T:=-1;
   For I:=S To E Do
    If Integer(R.wType)=wTypes[I] Then
     Begin
      T:=I;
      Break;
     End;
   If T=-1 Then O.Add(R) Else M[T].Add(R);
  end;

 List.Clear;

 For I:=S To E Do
  begin
   For J:=0 To M[I].Count-1 Do List.Add(M[I][J]);
  end;
 For I:=0 To O.Count-1 Do List.Add(O[I]);

 O.Free; 
 For I:=S To E Do M[I].Free;
 SetLength(M,0);
end;

{===============================PROCEDURE==================================}

Procedure TrxResourceMap.UnQueryResource(rInfo:TrxResourceClass);
Var
 I : Integer;
begin
 I:=FList.IndexOf(rInfo);
 If I=-1 Then Exit;
 FList.Delete(I);
end;

{===============================PROCEDURE==================================}

Destructor TrxResourceMap.Free;
Begin
 Clear;
 FList.Free;
End;

{===============================PROCEDURE==================================}

Function fmtDlgCtrlToStr(V:Integer):String;
Begin
 Result:=IntToStr(V);
 Case V of
  $80: Result:='Button';
  $81: Result:='Edit';
  $82: Result:='Static';
  $83: Result:='ListBox';
  $84: Result:='ScrollBar';
  $85: Result:='ComboBox';
 End;
End;

{===============================PROCEDURE==================================}

Function TrxResourceCompiler.Count:Integer;
Begin
 Result:=FList.Count;
End;

{===============================PROCEDURE==================================}

Procedure TrxResourceCompiler.SaveToStream(Stream:TStream);
Var
 W     :Word;
 B     :Byte;
 I,L   :Integer;
 rInfo :TrxResourceClass;
Begin
 I:=FList.Count;
 Stream.WriteBuffer(I,4);
 If I=0 Then Exit;
 For I:=0 To FList.Count-1 Do
  Begin
   rInfo:=TrxResourceClass(FList[I]);
   // Control byte "by wType or by TypeName"
   B:=0;
   If (Integer(rInfo.wType)>MaxWord) And (Length(rInfo.Typed)<>0) Then B:=1;
   Stream.WriteBuffer(B,1);
   
   // Write a type
   If B=0 Then
    Begin
     W:=Integer(rInfo.wType);
     Stream.WriteBuffer(W,2);
    End
   Else
    Begin
     W:=Length(rInfo.Typed);
     Stream.WriteBuffer(W,2);
     Stream.WriteBuffer(rInfo.Typed[1],W);
    End;

   // Write a name
   B:=0;
   If (Integer(rInfo.wName)>MaxWord) And (Length(rInfo.Named)<>0) Then B:=1;
   Stream.WriteBuffer(B,1);
   // Write a type
   If B=0 Then
    Begin
     W:=Integer(rInfo.wName);
     Stream.WriteBuffer(W,2);
    End
   Else
    Begin
     W:=Length(rInfo.Named);
     Stream.WriteBuffer(W,2);
     Stream.WriteBuffer(rInfo.Named[1],W);
    End;

   W:=rInfo.DefLang;
   Stream.WriteBuffer(W,2);
    
   L:=rInfo.Size;
   Stream.WriteBuffer(L,4);

   Stream.WriteBuffer(rInfo.Buffer^,L);
  End;
End;

{===============================PROCEDURE==================================}

Procedure TrxResourceCompiler.LoadFromStream(Stream:TStream);
Var
 W     :Word;
 B     :Byte;
 iCount,I,L   :Integer;
 rInfo :TrxResourceClass;
Begin
 Stream.ReadBuffer(iCount,4);
 If iCount=0 Then Exit;

 For I:=0 To iCount-1 Do
  Begin
   rInfo:=TrxResourceClass.Create;

   Stream.ReadBuffer(B,1);
   If B=0 Then
    Begin
     Stream.ReadBuffer(W,2);
     rInfo.wType:=PChar(W);
    End
   Else
    Begin
     Stream.ReadBuffer(W,2);
     SetLength(rInfo.Typed,W);
     Stream.ReadBuffer(rInfo.Typed[1],W);
     rInfo.wType:=PChar(rInfo.Typed);
    End;

   Stream.ReadBuffer(B,1);

   If B=0 Then
    Begin
     Stream.ReadBuffer(W,2);
     rInfo.wName:=PChar(W);
    End
   Else
    Begin
     Stream.ReadBuffer(W,2);
     SetLength(rInfo.Named,W);
     Stream.ReadBuffer(rInfo.Named[1],W);
     rInfo.wName:=PChar(rInfo.Named);
    End;

   Stream.ReadBuffer(W,2);
   rInfo.DefLang:=W;

   Stream.ReadBuffer(L,4);
   rInfo.Size:=L;

   If L<>0 Then
    Begin
     rInfo.Buffer:=vxAllocMem(L);
     Stream.ReadBuffer(rInfo.Buffer^,L);
    End;
   FList.Add(rInfo); 
  End;
End;

{===============================PROCEDURE==================================}

Procedure TrxResourceCompiler.SaveToFile(const FileName:String);
Var
 Stream: TStream;
Begin
 Stream := TFileStream.Create(FileName,fmCreate);
 Try
   SaveToStream(Stream);
 Finally
   Stream.Free;
 End;
End;

{===============================PROCEDURE==================================}

Procedure TrxResourceCompiler.LoadFromFile(const FileName:String);
Var
 Stream: TStream;
Begin
 Stream := TFileStream.Create(FileName,fmOpenRead);
 Try
   LoadFromStream(Stream);
 Finally
   Stream.Free;
 End;
End;

{===============================PROCEDURE==================================}

Procedure TrxResourceCompiler.Clear;
Var
 I :Integer;
 R :TrxResourceClass;
Begin
 If FList.Count=0 Then Exit;
 For I:=0 To FList.Count-1 Do
  Begin
   R:=TrxResourceClass(FList[I]);
   If R.Size<>0 Then vxFreeMem(R.Buffer);
   R.Free;
  End;
 FList.Clear; 
End;

{===============================PROCEDURE==================================}

Procedure TrxResourceCompiler.Add(rInfo:TrxResourceClass);
Var
 R:TrxResourceClass;
Begin
 R:=TrxResourceClass.Create;
 R.Typed:=rInfo.Typed;
 If Integer(rInfo.wType)<MaxWord Then  R.wType:=rInfo.wType
  Else R.wType:=PChar(R.Typed);
 R.Named:=rInfo.Named;
 If Integer(rInfo.wName)<MaxWord Then R.wName:=rInfo.wName
  Else R.wName:=PChar(R.Named);
 R.Size:=rInfo.Size;
 R.DefLang:=rInfo.DefLang;
 R.Status:=rInfo.Status;
 If rInfo.Size<>0 Then
  Begin
   R.Buffer:=vxAllocMem(R.Size);
   CopyMemory(R.Buffer,rInfo.Buffer,rInfo.Size);
  End;
 FList.Add(R);
End;

{===============================PROCEDURE==================================}

Procedure TrxResourceCompiler.Add(rType:PChar;rName:String;Buf:Pointer;BufSize:Integer;rLang:Integer=0);
Var
 R:TrxResourceClass;
Begin
 R:=TrxResourceClass.Create;
 R.wType:=rType;
 R.Named:=rName;
 R.wName:=PChar(R.Named);
 R.Size:=BufSize;
 R.DefLang:=rLang;
 R.Buffer:=Buf;
 Add(R);
End;

{===============================PROCEDURE==================================}

Procedure TrxResourceCompiler.Change(rInfo:TrxResourceClass);
Begin
 Add(rInfo);
End;

{===============================PROCEDURE==================================}

Procedure TrxResourceCompiler.Delete(rInfo:TrxResourceClass;DefLang:Integer=-1);
Var
 R:TrxResourceClass;
Begin
 R:=TrxResourceClass.Create;
 R.wType:=rInfo.wType;
 R.wName:=rInfo.wName;
 R.Size:=0;
 R.Buffer:=NIL;
 If DefLang<>-1 Then R.DefLang:=DefLang;
 FList.Add(R);  
End;

{===============================PROCEDURE==================================}

Procedure TrxResourceCompiler.Update(const AFileName:String);
Var
 H:Integer;
 I:Integer;
 P:TrxResourceClass;
Begin
 If FList.Count=0 Then Exit;
 SetFileAttributes(PChar(AFileName), FILE_ATTRIBUTE_NORMAL);
 H:=BeginUpdateResource(PChar(aFileName),False);
 If H=0 Then RaiseLastOSError;
 For I:=0 To FList.Count-1 Do
  Begin
   P:=TrxResourceClass(FList[I]);
   UpdateResource(H,PChar(P.wType),PChar(P.wName),P.DefLang,P.Buffer,P.Size);
  End;
 If EndUpdateResource(H,False)=False Then RaiseLastOSError;

 H:=BeginUpdateResource(PChar(aFileName),False);
 If H=0 Then RaiseLastOSError;
 If EndUpdateResource(H,False)=False Then RaiseLastOSError;
End;

{===============================PROCEDURE==================================}

Constructor TrxResourceCompiler.Create;
Begin
 FList:=TList.Create;
End;

{===============================PROCEDURE==================================}

Destructor TrxResourceCompiler.Free;
Begin
 Clear;
 FList.Free;
End;

{===============================PROCEDURE==================================}

Function TrxFormPropertyList.Count:Integer;
Begin
 Result:=FList.Count;
End;

{===============================PROCEDURE==================================}

Procedure TrxFormPropertyList.Add(const inName:String; Value:Variant; Kind:TrxFormPropertyKind=pkNone);
Var
 P:TrxFormPropertyItem;
Begin
 P:=TrxFormPropertyItem.Create;
 P.Name:=inName;
 P.Value:=Value;
 P.Kind:=Kind;
 FList.Add(P);
End;

{===============================PROCEDURE==================================}

Function TrxFormPropertyList.Find(const inName:String):TrxFormPropertyItem;
Var
 I:Integer;
Begin
 Result:=NIL;
 If FList.Count=0 Then Exit;
 For I:=0 To FList.Count-1 Do
  Begin
   Result:=TrxFormPropertyItem(FList[I]);
   If SameText(Result.Name, inName)=True Then Exit;
  End;
 Result:=NIL;
End;

{===============================PROCEDURE==================================}

Constructor TrxFormPropertyList.Create;
Begin
 FList:=TList.Create;
End;

{===============================PROCEDURE==================================}

Procedure TrxFormPropertyList.Clear;
Var
 I:Integer;
 P:TrxFormPropertyItem;
Begin
 If FList.Count<>0 Then
  For I:=0 To FList.Count-1 Do
   Begin
    P:=TrxFormPropertyItem(FList[I]);
    P.Value:=0;
    P.Free;
   End;
End;

{===============================PROCEDURE==================================}

Destructor TrxFormPropertyList.Free;
Begin
 Clear;
 FList.Free;  
End;

{===============================PROCEDURE==================================}

Procedure TrxResourceForm.CreateHandle;
Var
 OutPut    : TStringStream;
 Buf       : TvxMemoryStream;
 Reader    : TDFMParser;
Begin
 FList:=TList.Create;
 Buf:=TvxMemoryStream.Create(FInfo.Buffer,FInfo.Size);
 OutPut:=TStringStream.Create('');
 ObjectBinaryToText(Buf,OutPut);
 Buf.Free;
 OutPut.Position:=0;

 Reader:=TDFMParser.Create(OutPut.DataString);
  Reader.Owner:=Self;
  Reader.Parse;
 Reader.Free;

 OutPut.Free;
End;

{===============================PROCEDURE==================================}

Function TrxResourceForm.fmtRUID(AFrmItem:TrxResourceFormItem):Cardinal;
begin
 Result:=ameStringCrC(AFrmItem.ObjectClassName+AFrmItem.ObjectName);
end;

{===============================PROCEDURE==================================}

Function TrxResourceForm.FindItem(AFrmItem:TrxResourceFormItem): TrxResourceFormItem;
Var
 I : Integer;
 uid : Cardinal;
begin
 If FList.Count=0 Then Exit(NIL);
 uid:=Self.fmtRUID(AFrmItem);
 For I:=0 To FList.Count-1 Do
  begin
   Result:=TrxResourceFormItem(FList[I]);
   If Result.ruid=uid Then Exit;
  end;
 Result:=NIL;
end;

{===============================PROCEDURE==================================}

Procedure TrxResourceForm.FreeHandle;
Var
 I      :Integer;
 PForm  :TrxResourceFormItem;
Begin
 If FList.Count<>0 Then
  For I:=0 To FList.Count-1 Do
   Begin
    PForm:=TrxResourceFormItem(FList[I]);
    PForm.List.Free;
    PForm.Free;
   End;
 FList.Free;
End;

{===============================PROCEDURE==================================}

Function TrxResourceForm.NamePresent(const AName:String):Integer;
Var
 I:Integer;
 F:TrxResourceFormItem;
Begin
 Result:=-1;
 If FList.Count=0 Then Exit;
 For I:=0 To FList.Count-1 Do
  Begin
   F:=TrxResourceFormItem(FList[I]);
   If SameText(F.ObjectName,AName) Then
    Begin
     Result:=I;
     Exit;
    End;
  End;
End;

{===============================PROCEDURE==================================}

Function TrxResourceForm.FindItemByUserData(uData:Pointer):TrxResourceFormItem;
Var
 I:Integer;
Begin
 Result:=NIL;
 If FList.Count=0 Then Exit;
 For I:=0 To FList.Count-1 Do
  Begin
   Result:=TrxResourceFormItem(FList[I]);
   If Result.UserData=uData Then Exit;
  End;
 Result:=NIL;
End;

{===============================PROCEDURE==================================}

Function TrxResourceForm.UpdateProperty(FormItem:TrxResourceFormItem; PropertyName:String; Value:Variant):TrxFormPropertyItem;
Begin
 Result:=NIL;
 If FormItem=NIL Then Exit;
 Result:=FormItem.List.Find(PropertyName);
 If Result=NIL Then Exit;
 Result.Value:=Value;
End;

{===============================PROCEDURE==================================}

Function TrxResourceForm.ConvertToString(const S:String):String;
Var
 O: TStringStream;
 P: TParser;
Begin
 Result:='';
 If (S='') or (S='''') Then Exit;
 O:=TStringStream.Create(S);
 P:=TParser.Create(O);
 {$IFDEF FPC}
 {$ELSE}
 If CharInSet(P.Token, [Classes.toString, toWString])  Then
  Begin
   Result := P.TokenWideString;
   while P.NextToken = '+' do
    begin
     P.NextToken;
     if not (CharInSet(P.Token, [Classes.toString, toWString])) then
     P.CheckToken(Classes.toString);
     Result := Result + P.TokenWideString;
   end;
  End;
 {$ENDIF}
 P.Free;
 O.Free;
End;

{===============================PROCEDURE==================================}

Function TrxResourceForm.ConvertFromString(const S:String):String;
Var
 I: Integer;
 P: TWriter;
 O: TStringStream;
 M: TMemoryStream;
 L: TStringList;
Begin
 If (S='') Then Exit('''''');
 Result:='';
 {$IFDEF FPC}
 {$ELSE}
 M:=TMemoryStream.Create;
  P:=TWriter.Create(M,4096);
   P.WriteSignature;
   P.WriteStr('TForm');
   P.WriteStr('SDNF');
   P.WriteStr('Caption');
   P.WriteWideString(S);
   P.WriteListEnd;
   P.WriteListEnd;
  P.Free;
 M.Position:=0;
 O:=TStringStream.Create('');
 ObjectBinaryToText(M,O);
 M.Free;
 O.Position:=0;
 L:=TStringList.Create;
 L.Text:=O.DataString;
 O.Free;

 If L.Count<>0 Then
  For I:=1 To L.Count-2 Do
   Result:=Result+L[I];
 L.Free;

 While True Do
  Begin
   If Length(Result)=0 Then Break;
   If SameText(LeftStr(Result,3),' = ') Then
    Begin
     Delete(Result,1,3);
     Break;
    End;
   Delete(Result,1,1);
  End;
 {$ENDIF}
End;

{===============================PROCEDURE==================================}

Function TrxResourceForm.ItemByName(const AName:String):TrxResourceFormItem;
Var
 I:Integer;
Begin
 Result:=NIL;
 I:=NamePresent(AName);
 If I=-1 Then Exit Else Result:=TrxResourceFormItem(FList[I]);
End;

{===============================PROCEDURE==================================}

Procedure TrxResourceForm.Script(L:TStrings);
Var
 I,J    :Integer;
 PForm  :TrxResourceFormItem;
 Prop   :TrxFormPropertyItem;
 Parent :TStackList;
 PNext  :TrxResourceFormItem;
 A      :String;
Begin
 L.Clear;
 If FList.Count=0 Then Exit;
 Parent:=TStackList.Create;

 For I:=0 To FList.Count-1 Do
  Begin
   PForm:=TrxResourceFormItem(FList[I]);
   If I+1<=FList.Count-1 Then PNext:=TrxResourceFormItem(FList[I+1]) Else PNext:=NIL;
   Parent.Push(PForm);
   L.Add(StringOfChar(' ',Parent.Count)+PForm.FullHeader);
   If PForm.List.Count<>0 Then
    For J:=0 To PForm.List.Count-1 Do
     Begin
      Prop:=TrxFormPropertyItem(PForm.List.List[J]);
      A:=Prop.Value;
      Case Prop.Kind Of
       pkHex:    A:='{'+sLineBreak+A+sLineBreak+'}'+sLineBreak;
       pkString: A:=ConvertFromString(A);
       pkEnum:   A:='['+A+']';
       pkStrings: A:='('+A+')';
       pkItems:  A:='<'+A+'>';
      End;
      L.Add(StringOfChar(' ',Parent.Count)+' '+Prop.Name+' = '+A);
     End;

   If FList.Count=1 Then
    Begin

     L.Add(StringOfChar(' ',Parent.Count)+'End');
    End;

   If I=0 Then Continue;
   If PNext=NIL Then
   Begin
    While (Parent.Count<>0)  Do
     Begin
      L.Add(StringOfChar(' ',Parent.Count)+'End');
      Parent.Pop;
     End;
    Break;
   End;

   If PNext.Parent=PForm Then Continue;

   If PNext.Parent=PForm.Parent Then
    Begin
      L.Add(StringOfChar(' ',Parent.Count)+'End');
      Parent.Pop;
      Continue;
    End;

   While PNext.Parent<>TrxResourceFormItem(Parent.HidePop)  Do
    Begin
     L.Add(StringOfChar(' ',Parent.Count)+'End');
     Parent.Pop;
    End;

  End;
 Parent.Free;
End;

{===============================PROCEDURE==================================}

Procedure TrxResourceForm.Change;
Var
 OutPut :TStringStream;
 L      :TStringList;
 Buf    :TMemoryStream;
Begin
 L:=TStringList.Create;
 Script(L);
 OutPut:=TStringStream.Create(L.Text);
 Buf:=TMemoryStream.Create;
 ObjectTextToBinary(OutPut,Buf);
 OutPut.Free;
 L.Free;
 Update(Buf.Memory,Buf.Size);
 Buf.Free;
End;


{===============================PROCEDURE==================================}
  

Type
 DlgItemEX=Packed Record
  HelpID :DWORD;
  exStyle:DWORD;
  Style  :DWORD;
  X      :WORD;
  Y      :WORD;
  CX     :WORD;
  CY     :WORD;
  ID     :WORD;
 End;
 
{===============================PROCEDURE==================================}

Procedure TrxResourceDialog.CreateHandle;
Var
 Buf       :TvxMemoryStream;
 W         :Word;
 ItemCount :Integer;
 I         :Integer;
 PItem     :TrxResourceDialogItem;
 Item      :TDlgItemTemplate;
 ItemX     :DlgItemEX;


 Procedure SkipDialog_NOP(AStream:TStream);
 Var
  WWW:Word;
  Position:Int64;
 Begin
  Position:=AStream.Position;
  AStream.ReadBuffer(WWW,2);
  If WWW<>$9090 Then AStream.Position:=Position;
 End;
Begin
 FList:=TList.Create;
 Buf:=TvxMemoryStream.Create(FInfo.Buffer,FInfo.Size);
 FIsEx:=False;
 Buf.ReadBuffer(W,2);
 If W=$0001 Then
  Begin
   Buf.ReadBuffer(W,2);
   If W=$FFFF Then FIsEX:=True;
  End;
 If FIsEx=True Then
  Begin
   FVersion:=$0001;
   FSign:=$FFFF;
   Buf.ReadBuffer(FHelpID,4);
   Buf.ReadBuffer(FExStyle,4);
   Buf.ReadBuffer(FStyle,4);
  End
 Else
  Begin
   Buf.Position:=0;
   Buf.ReadBuffer(FStyle,4);
   Buf.ReadBuffer(FexStyle,4);
  End;
 Buf.ReadBuffer(W,2);
 ItemCount:=W;
 Buf.ReadBuffer(W,2);
 FX:=W;
 Buf.ReadBuffer(W,2);
 FY:=W;
 Buf.ReadBuffer(W,2);
 FCX:=W;
 Buf.ReadBuffer(W,2);
 FCY:=W;
 Buf.ReadBuffer(W,2);

 FHasMenu:=False;
 FMenuId:=-1;
 
 If W=$FFFF Then
  Begin
   Buf.ReadBuffer(W,2);
   FMenuId:=W;
  End
 Else
  Begin
   FHasMenu:=True;
   Buf.Position:=Buf.Position-2;
   FMenu:=ReadWChar(Buf);
  End;
 FClass:=ReadWChar(Buf);
 FCaption:=ReadWChar(Buf);

 If (FStyle And DS_SETFONT)=DS_SETFONT Then
  Begin
   Buf.ReadBuffer(W,2);
   FFontSize:=W;
   If FIsEx=True Then
    Begin
     Buf.ReadBuffer(W,2);
     FFontW:=W;
     Buf.ReadBuffer(W,2);
     FFontB:=W;
    End;
   FFontName:=ReadWChar(Buf);
  End;

 If ItemCount<>0 Then 
 For I:=1 To ItemCount Do
  Begin
   PItem:=TrxResourceDialogItem.Create;
   AlignStream(Buf, 4);
   If FIsEx=True Then
    Begin
     Buf.ReadBuffer(ItemX,SizeOf(ItemX));
     PItem.X:=ItemX.X;
     PItem.Y:=ItemX.Y;
     PItem.W:=ItemX.CX;
     PItem.H:=ItemX.CY;
     PItem.Id:=ItemX.ID;
     PItem.HelpId:=ItemX.HelpID;
     PItem.Style:=ItemX.Style;
     PItem.exStyle:=ItemX.exStyle;
     AlignStream(Buf,2);
     Buf.ReadBuffer(W,2); 
    End
   Else
    Begin
     Buf.ReadBuffer(Item,SizeOf(Item));
     PItem.X:=Item.X;
     PItem.Y:=Item.Y;
     PItem.W:=Item.CX;
     PItem.H:=Item.CY;
     PItem.Id:=Item.ID;
     PItem.Style:=Item.Style;
     PItem.exStyle:=Item.dwExtendedStyle;
     AlignStream(Buf,2);
     SkipDialog_NOP(Buf);
    End;
   Buf.ReadBuffer(W,2);
   PItem.ControlId:=-1;
   If W=$FFFF Then
     Begin
      Buf.ReadBuffer(W,2);
      PItem.ControlId:=W;
     End
   Else
    Begin
     Buf.Position:=Buf.Position-2;
     PItem.Control:=ReadWChar(Buf);
    End;

   Buf.ReadBuffer(W,2);
   PItem.CaptionId:=-1;
   If W=$FFFF Then
     Begin
      Buf.ReadBuffer(PItem.CaptionId,2);
     End
   Else
    Begin
     Buf.Position:=Buf.Position-2;
     PItem.Caption:=ReadWChar(Buf);
    End;


   Buf.ReadBuffer(W,2);  
   If W<>0 Then
    Raise Exception.Create('Dialog (type:['+FInfo.Typed+
                           '], name:['+FInfo.Named+
                           ']) has extra bytes (count: '+IntToStr(W)+')!');
   PItem.ruid:=fmtRUID(PItem);
   FList.Add(PItem);
  End;
 Buf.Free;
End;

{===============================PROCEDURE==================================}

Function TrxResourceDialog.fmtRUID(ADlgItem:TrxResourceDialogItem):Cardinal;
begin
 Result:=ameStringCrC(IntToStr(ADlgItem.Id)+IntToStr(ADlgItem.HelpId)+
                       IntToStr(ADlgItem.CaptionId)+IntToStr(ADlgItem.ControlId)+
                       ADlgItem.Control);
end;

{===============================PROCEDURE==================================}

Function TrxResourceDialog.FindItem(ADlgItem:TrxResourceDialogItem): TrxResourceDialogItem;
Var
 I : Integer;
 uid : Cardinal;
begin
 If FList.Count=0 Then Exit(NIL);
 uid:=Self.fmtRUID(ADlgItem);
 For I:=0 To FList.Count-1 Do
  begin
   Result:=TrxResourceDialogItem(FList[I]);
   If Result.ruid=uid Then Exit;
  end;
 Result:=NIL;
end;

{===============================PROCEDURE==================================}

Procedure TrxResourceDialog.Change;
Var
 PItem     :TrxResourceDialogItem;
 I         :Integer;
 W         :Word;
 Buf       :TMemoryStream;
 Item      :TDlgItemTemplate;
 ItemX     :DlgItemEX;
Begin
 Buf:=TMemoryStream.Create;
 If FIsEx=True Then
  Begin
   W:=FVersion;
   Buf.WriteBuffer(W,2);
   W:=FSign;
   Buf.WriteBuffer(W,2);
  End;

 If FIsEx=True Then
  Begin
   Buf.WriteBuffer(FHelpID,4);
   Buf.WriteBuffer(FExStyle,4);
   Buf.WriteBuffer(FStyle,4);
  End
 Else
  Begin
   Buf.WriteBuffer(FStyle,4);
   Buf.WriteBuffer(FexStyle,4);
  End;
 W:=FList.Count;
 Buf.WriteBuffer(W,2);
 W:=FX;
 Buf.WriteBuffer(W,2);
 W:=FY;
 Buf.WriteBuffer(W,2);
 W:=FCX;
 Buf.WriteBuffer(W,2);
 W:=FCY;
 Buf.WriteBuffer(W,2);

 If FHasMenu=False Then
  Begin
   W:=$FFFF;
   Buf.WriteBuffer(W,2);
   W:=FMenuId;
   Buf.WriteBuffer(W,2);
  End
 Else WriteWChar(Buf,FMenu);

 WriteWChar(Buf,FClass);
 WriteWChar(Buf,FCaption);

 If (FFontName<>'') And ((FStyle And DS_SETFONT)<>DS_SETFONT) Then
  FStyle:=FStyle OR DS_SETFONT;

 If (FStyle And DS_SETFONT)=DS_SETFONT Then
  Begin
   W:=FFontSize;
   Buf.WriteBuffer(W,2);
   If FIsEx=True Then
    Begin
     W:=FFontW;
     Buf.WriteBuffer(W,2);
     W:=FFontB;
     Buf.WriteBuffer(W,2);
    End;
   WriteWChar(Buf,FFontName);
  End;
 If FList.Count<>0 Then
 For I:=0 To FList.Count-1 Do
  Begin
   PItem:=TrxResourceDialogItem(FList[I]);
   AlignStream(Buf,4,True);  
   If FIsEx=True Then
    Begin
     ItemX.X:=PItem.X;
     ItemX.Y:=PItem.Y;
     ItemX.CX:=PItem.W;
     ItemX.CY:=PItem.H;
     ItemX.ID:=PItem.Id;
     ItemX.HelpID:=PItem.HelpId;
     ItemX.Style:=PItem.Style;
     ItemX.exStyle:=PItem.exStyle;
     Buf.WriteBuffer(ItemX,SizeOf(ItemX));
    End
   Else
    Begin
     Item.X:=PItem.X;
     Item.Y:=PItem.Y;
     Item.CX:=PItem.W;
     Item.CY:=PItem.H;
     Item.ID:=PItem.Id;
     Item.Style:=PItem.Style;
     Item.dwExtendedStyle:=PItem.exStyle;
     Buf.WriteBuffer(Item,SizeOf(Item));
    End;    

   If PItem.ControlId<>-1 Then
    Begin
     If FIsEX Then
      Begin
       W:=$0000;
       Buf.WriteBuffer(W,2); 
      End;
     W:=$FFFF;
     Buf.WriteBuffer(W,2);
     W:=PItem.ControlId;
     Buf.WriteBuffer(W,2);
    End
   Else
    Begin
     If FIsEx=True Then AlignStream(Buf,4,True) Else AlignStream(Buf,2,True);
     WriteWChar(Buf,PItem.Control);
    End;

   If PItem.CaptionId<>-1 Then
    Begin
     W:=$FFFF;
     Buf.WriteBuffer(W,2);
     W:=PItem.CaptionId;
     Buf.WriteBuffer(W,2);
    End
   Else
    Begin
     AlignStream(Buf,2,True);
     WriteWChar(Buf,PItem.Caption);
    End;

   W:=0;
   Buf.WriteBuffer(W,2);  
  End;
 Update(Buf.Memory,Buf.Size);
 Buf.Free;
End;

{===============================PROCEDURE==================================}

Procedure TrxResourceDialog.FreeHandle;
Var
 I : Integer;
Begin
 For I:=0 To FList.Count-1 Do TrxResourceDialogItem(FList[I]).Free;
 FList.Free;
End;

{===============================PROCEDURE==================================}

Function  TrxResourceDialog.IndexPresent(Ind:Integer):Integer;
Var
 I:Integer;
 P:TrxResourceDialogItem;
Begin
 If FList.Count=0 Then Exit(-1);
 For I:=0 To FList.Count-1 Do
  Begin
   P:=TrxResourceDialogItem(FList[I]);
   If P.Id=Ind Then Exit(I);
  End;
 Result:=-1;
End;

{===============================PROCEDURE==================================}

Function TrxResourceDialog.FindItemByUserData(uData:Pointer):TrxResourceDialogItem;
Var
 I:Integer;
Begin
 If FList.Count=0 Then Exit(nil);
 For I:=0 To FList.Count-1 Do
  Begin
   Result:=TrxResourceDialogItem(FList[I]);
   If Result.UserData=uData Then Exit;
  End;
 Result:=NIL; 
End;

{===============================PROCEDURE==================================}

Function  TrxResourceDialog.IndexPresentEx(xItem:TrxResourceDialogItem;xIndex:Integer):Integer;
Var
 I  :  Integer;
 P  :  TrxResourceDialogItem;
Begin
 Result:=-1;
 If FList.Count=0 Then Exit;

 If (xIndex>=0) And (xIndex<=FList.Count-1) Then
  Begin
   P:=TrxResourceDialogItem(FList[xIndex]);
   If (P.Id=xItem.Id) And (P.Style=xItem.Style) And (P.exStyle=xItem.exStyle)
       And (P.HelpId=xItem.HelpId) And (P.ControlId=xItem.ControlId)
       And SameText(P.Control,xItem.Control) And (P.CaptionId=xItem.CaptionId)
        Then
    Begin
     Result:=xIndex;
     Exit;
    End;
  End;

 For I:=0 To FList.Count-1 Do
  Begin
   P:=TrxResourceDialogItem(FList[I]);
   If (P.Id=xItem.Id) And (P.Style=xItem.Style) And (P.exStyle=xItem.exStyle)
       And (P.HelpId=xItem.HelpId) And (P.ControlId=xItem.ControlId)
       And SameText(P.Control,xItem.Control) And (P.CaptionId=xItem.CaptionId)
        Then
    Begin
     Result:=I;
     Exit;
    End;
  End;
End;

{===============================PROCEDURE==================================}

Function  TrxResourceDialog.StringByIndex(Ind:Integer):String;
Var
 I:Integer;
Begin
 Result:='';
 I:=IndexPresent(Ind);
 If I=-1 Then Exit Else Result:=TrxResourceDialogItem(FList[I]).Caption;
End;

{===============================PROCEDURE==================================}

Procedure TrxResourceDialog.Script(L:TStrings);
Var
 PItem:TrxResourceDialogItem;
 I:Integer;
Begin
 L.Clear;
 If FIsEx=True Then
  L.Add(Format('DIALOGEX %s,%d,%d,%d,%d',[FInfo.Named,FX,FY,FCX,FCY]))
 Else
  L.Add(Format('DIALOG %s,%d,%d,%d,%d',[FInfo.Named,FX,FY,FCX,FCY]));
 If FList.Count=0 Then
  Begin
   L.Add('{');
   L.Add('}');
   Exit;
  End;
 L.Add('{');
 For I:=0 To FList.Count-1 Do
  Begin
   PItem:=TrxResourceDialogItem(FList[I]);
   If PItem.ControlId=-1 Then
    L.Add(Format('CONTROL "%s","%s",%d,%d,%d,%d,%d',[PItem.Caption,PItem.Control,
          PItem.Id,PItem.X,PItem.Y,PItem.W,PItem.H]))
   Else
    L.Add(Format('CONTROL "%s",%d,%d,%d,%d,%d,%d',[PItem.Caption,PItem.ControlId,
          PItem.Id,PItem.X,PItem.Y,PItem.W,PItem.H]))
  End;
 L.Add('}');
End;   
  
{===============================PROCEDURE==================================}

Procedure TrxResourceMenu.ExtractShortCut(PMenu:TrxResourceMenuItem);
Var
 I:Integer;
 L:Integer;
 S:String;
Begin
 PMenu.HasShortCut:=False;
 S:=PMenu.Caption;
 L:=Length(S);
 If L=0 Then Exit;
 For I:=L DownTo 1 Do
  If (S[I]=#9) Or (S[I]=#8) Then
   Begin
    PMenu.HasShortCut:=True;
    Break;
   End;
 If PMenu.HasShortCut=False Then Exit;
 PMenu.ShortChar:=S[I];
 PMenu.Caption:=Copy(S,1,I-1);
 PMenu.ShortCut:=Copy(S,I+1,MaxInt);
End;

{===============================PROCEDURE==================================}

Function TrxResourceMenu.ShortCut(PMenu:TrxResourceMenuItem):String;
Begin
 Result:=PMenu.Caption;
 If PMenu.HasShortCut=False Then Exit;
 Result:=Result+PMenu.ShortChar+PMenu.ShortCut;
End;

{===============================PROCEDURE==================================}

Procedure TrxResourceMenu.CreateHandle;
Var
 W       : Word;
 Buf     : TvxMemoryStream;
 PMenu   : TrxResourceMenuItem;
 inCount : Integer;
Begin
 FList:=TList.Create;
 Buf:=TvxMemoryStream.Create(FInfo.Buffer,FInfo.Size);

 Buf.ReadBuffer(W,2);
 If W<>0 Then FIsEX:=True Else FIsEX:=False;
 FVersion:=W;
 Buf.ReadBuffer(W,2);
 FOfs:=W;       
 If FIsEX Then Buf.ReadBuffer(FHelpID,4);
 inCount:=0;

 While Buf.Position<>Buf.Size Do
  Begin
   PMenu:=TrxResourceMenuItem.Create;
   If FIsEx Then
    Begin
     Buf.ReadBuffer(PMenu.Typed,4);  // Читаем dwType
     Buf.ReadBuffer(PMenu.State,4);  // Читаем dwState
     Buf.ReadBuffer(PMenu.Id,4);     // Читаем dwID
     Buf.ReadBuffer(W,2);            // Читаем dwResInfo
     PMenu.ResInfo:=W;
     PMenu.Caption:=ReadWChar(Buf);
     AlignStream(Buf,4,False);
     If (W And $01)<>0 Then
      Begin
       Buf.ReadBuffer(PMenu.HelpId,4); // Читаем dwHelpID
       PMenu.Tag:=Win32MenuTag_BEGIN;
      End
     Else
      Begin
       PMenu.Tag:=Win32MenuTag_ITEM;
       If (W And $80)<>0 Then PMenu.Tag:=Win32MenuTag_END;
      End;
    End
   Else
    Begin
     Buf.ReadBuffer(W,2); 
     PMenu.Flags:=W;
     If (W And MF_POPUP)=MF_POPUP Then
      Begin
       PMenu.Caption:=ReadWChar(Buf);
       PMenu.Tag:=Win32MenuTag_BEGIN;
       PMenu.Id:=0;
      End
     Else
      Begin
       PMenu.Tag:=Win32MenuTag_ITEM;
       Buf.ReadBuffer(W,2); // Читаем идентификатор
       PMenu.Id:=W;
       PMenu.Caption:=ReadWChar(Buf);
       {$IFDEF FPC}
       {$ELSE}
       If (PMenu.Flags And MF_END)=MF_END Then PMenu.Tag:=Win32MenuTag_END;
       {$ENDIF}
      End;
    End;
   ExtractShortCut(PMenu);
   PMenu.inum:=inCount;
   PMenu.ruid:=fmtRUID(PMenu);
   FList.Add(PMenu);
   Inc(inCount);
  End;
 Buf.Free;
End;

{===============================PROCEDURE==================================}

Function TrxResourceMenu.fmtRUID(AMenuItem:TrxResourceMenuItem):Cardinal;
Var
 im : String;
begin
 im:=IntToStr(AMenuItem.inum);
 If FIsEx Then im:='';
 Result:=ameStringCrC(IntToStr(AMenuItem.Id)+IntToStr(AMenuItem.State)+
                       IntToStr(AMenuItem.HelpId)+IntToStr(AMenuItem.ResInfo)+
                       IntToStr(AMenuItem.Flags)+IntToStr(AMenuItem.Tag)+
                       im);
end;

{===============================PROCEDURE==================================}

Procedure TrxResourceMenu.FreeHandle;
Var
 I:Integer;
Begin
 For I:=0 To FList.Count-1 Do TrxResourceMenuItem(FList[I]).Free;
 FList.Free;
End;

{===============================PROCEDURE==================================}

Function TrxResourceMenu.IndexPresent(Ind:Integer):Integer;
Var
 I:Integer;
 M:TrxResourceMenuItem;
Begin
 Result:=-1;
 If FList.Count=0 Then Exit;
 For I:=0 To FList.Count-1 Do
  Begin
   M:=TrxResourceMenuItem(FList[I]);
   If M.Id=Ind Then Exit(I);
  End;
End;

{===============================PROCEDURE==================================}

Function TrxResourceMenu.FindItem(AMenuItem:TrxResourceMenuItem): TrxResourceMenuItem;
Var
 I : Integer;
 uid : Cardinal;
begin
 If FList.Count=0 Then Exit(NIL);
 uid:=Self.fmtRUID(AMenuItem);
 For I:=0 To FList.Count-1 Do
  begin
   Result:=TrxResourceMenuItem(FList[I]);
   If Result.ruid=uid Then Exit;
  end;
 Result:=NIL;
end;

{===============================PROCEDURE==================================}

Function TrxResourceMenu.StringByIndex(Ind:Integer):String;
Var
 I:Integer;
Begin
 Result:='';
 I:=IndexPresent(Ind);
 If I=-1 Then Exit Else Result:=TrxResourceMenuItem(FList[I]).Caption;
End;

{===============================PROCEDURE==================================}

Procedure TrxResourceMenu.Script(L:TStrings);
Var
 I,Level:Integer;
 PMenu:TrxResourceMenuItem;
Begin
 L.Clear;
 If FIsEx=True Then
  L.Add('MENUEX '+FInfo.Named+', $'+IntToHex(FHelpID,8)) Else L.Add('MENU '+FInfo.Named);
 If FList.Count=0 Then
  Begin
   L.Add('{');
   L.Add('}');
   Exit;
  End;
 L.Add('{');
 Level:=1;
 For I:=0 To FList.Count-1 Do
  Begin
   PMenu:=TrxResourceMenuItem(FList[I]);
   If (PMenu.Flags And MF_POPUP)=MF_POPUP Then
    Begin
     L.Add(StringOfChar(' ',Level)+'POPUP "'+ShortCut(PMenu)+'"');
     L.Add(StringOfChar(' ',Level)+'{');
     {$IFDEF FPC}
     {$ELSE}
     If (PMenu.Flags And MF_END)=MF_END Then
      Begin
       Dec(Level);
       L.Add(StringOfChar(' ',Level)+'}');
      End;
     {$ENDIF}
     Inc(Level);
    End
   Else
    Begin
     If FIsEx=True Then
      L.Add(StringOfChar(' ',Level)+'MENUITEM "'+ShortCut(PMenu)+'",'+IntToStr(PMenu.Id))
     Else
      Begin
       If PMenu.Id=0 Then
        L.Add(StringOfChar(' ',Level)+'MENUITEM SEPARATOR')
       Else
        L.Add(StringOfChar(' ',Level)+'MENUITEM "'+ShortCut(PMenu)+'",'+IntToStr(PMenu.Id));
      End;
     {$IFDEF FPC}
     {$ELSE}
     If (PMenu.Flags And MF_END)=MF_END Then
      Begin
       Dec(Level);
       L.Add(StringOfChar(' ',Level)+'}');
      End;
     {$ENDIF}
    End;
  End;
 L.Add('}')
End;

{===============================PROCEDURE==================================}

Procedure TrxResourceMenu.Change;
Var
 W      :Word;
 Buf    :TMemoryStream;
 I      :Integer;
 PMenu  :TrxResourceMenuItem;
Begin
 Buf:=TMemoryStream.Create;


 W:=FVersion;
 Buf.WriteBuffer(W,2);
 W:=FOfs;
 Buf.WriteBuffer(W,2);
 If FIsEx Then Buf.WriteBuffer(FHelpId,4);


 If FList.Count<>0 Then
 For I:=0 To FList.Count-1 Do
  Begin
   PMenu:=TrxResourceMenuItem(FList[I]);
   Case PMenu.Tag Of
    Win32MenuTag_BEGIN:
     Begin
   
      If FIsEX=True Then
       Begin
        Buf.WriteBuffer(PMenu.Typed,4);
        Buf.WriteBuffer(PMenu.State,4);
        Buf.WriteBuffer(PMenu.Id,4);
        W:=PMenu.ResInfo;
        Buf.WriteBuffer(W,2);
        WriteWChar(Buf,ShortCut(PMenu));
        AlignStream(Buf,4,True);
        If (PMenu.ResInfo And $01) <> 0 Then Buf.WriteBuffer(PMenu.HelpId,4);
       End
      Else
       Begin
        W:=PMenu.Flags;
        Buf.WriteBuffer(W,2); 
        WriteWChar(Buf,ShortCut(PMenu));
       End;
     End;
    Win32MenuTag_ITEM, Win32MenuTag_END:
     Begin
      If FIsEX=True Then
       Begin
        Buf.WriteBuffer(PMenu.Typed,4);
        Buf.WriteBuffer(PMenu.State,4);
        Buf.WriteBuffer(PMenu.Id,4);
        W:=PMenu.ResInfo;
        Buf.WriteBuffer(W,2);
        WriteWChar(Buf,ShortCut(PMenu));
        AlignStream(Buf,4,True);
       End
      Else
       Begin
        W:=PMenu.Flags;
        Buf.WriteBuffer(W,2); 
        W:=PMenu.Id;
        Buf.WriteBuffer(W,2); 
        WriteWChar(Buf,ShortCut(PMenu));
       End;
     End;
   End;
  End;
 Update(Buf.Memory,Buf.Size);
 Buf.Free;
End;

{===============================PROCEDURE==================================}

Procedure TrxResourceString.Script(L:TStrings);
Var
 I:Integer;
Begin
 L.Clear;
 For I:=1 To Count Do L.Add(IntToStr(Integer(FIndex[I]))+', '+List[I]);
End;

{===============================PROCEDURE==================================}

Function TrxResourceString.IndexPresent(Ind:Integer):Integer;
Var
 I:Integer;
Begin
 Result:=-1;
 For I:=0 To FIndex.Count-1 Do
  If Integer(FIndex[I])=Ind Then
   Begin
    Result:=I;
    Exit;
   End;
End;

{===============================PROCEDURE==================================}

Function TrxResourceString.StringByIndex(Ind:Integer):String;
Var
 I:Integer;
Begin
 Result:='';
 I:=IndexPresent(Ind);
 If I=-1 Then Exit Else Result:=List[I+1];
End;

{===============================PROCEDURE==================================}

Procedure TrxResourceString.Change;
Var
 W   :Word;
 S   :WideString;
 I   :Integer;
 Buf :TMemoryStream;
Begin
 Buf:=TMemoryStream.Create;
 For I:=1 To Count Do
  Begin
   S:=List[I];
   W:=Length(S);
   Buf.WriteBuffer(W,2);
   Buf.WriteBuffer(S[1],Length(S)*2);
  End;
 W:=0;
 Buf.WriteBuffer(W,2);
 Update(Buf.Memory,Buf.Size);
 Buf.Free;
End;

{===============================PROCEDURE==================================}

Function TrxResourceString.Count:Integer;
begin
 Result:=16;
end;

{===============================PROCEDURE==================================}

Procedure TrxResourceString.CreateHandle;
Var
 S  : String;
 W  : Word;
 I  : Integer;
 X  : TvxMemoryStream;
 ID : Integer;
Begin
 FIndex:=TList.Create;
 SetLength(List,16 + 1);
 X:=TvxMemoryStream.Create(FInfo.Buffer,FInfo.Size);
 For I:=1 To Count Do
  Begin
   X.ReadBuffer(W,2);
   If W<>0 Then
    Begin
     SetLength(S,W);
     X.ReadBuffer(S[1],W*2);
     List[I]:=S;
    End
   Else
    Begin
     S:='';
     List[I]:=S;
    End;
   ID := ((Integer(FInfo.wName) - 1) shl 4) + I-1;
   FIndex.Add(Pointer(ID));
  End;
 X.Free;
End;

{===============================PROCEDURE==================================}

Procedure TrxResourceString.FreeHandle;
Begin
 SetLength(List,0);
 FIndex.Free;
End;

{===============================PROCEDURE==================================}

Procedure TrxResourceItemClass.AlignStream(AStream:TStream;AValue:Integer;AWrite:Boolean=False);
Var
 M:Integer;
 I:Integer;
 B:Pointer;
Begin
 I:=aStream.Position;
 While (I mod AValue)<>0 Do Inc(I);
 If AWrite Then
  Begin
   M:=Abs(I-aStream.Position);
   B:=AllocMem(M);
   ZeroMemory(B, M);
   aStream.WriteBuffer(B^,M);
   FreeMem(B,M);
  End;        
 aStream.Position:=I;
End;

{===============================PROCEDURE==================================}

Function  TrxResourceItemClass.ReadWChar(aStream:TStream):String;
Var
 W : Word;
 P : Int64;
 L : Integer;
Begin
 Result:='';
 P:=AStream.Position;
 L:=0;
 While True Do
  Begin
   aStream.ReadBuffer(W,2);
   If W=0 Then Break;
   Inc(L);
  End;
 If L=0 Then Exit;
 SetLength(Result,L);
 aStream.Position:=P;
 aStream.ReadBuffer(Result[1], L*2);
 aStream.ReadBuffer(W,2);       
End;

{===============================PROCEDURE==================================}

Procedure TrxResourceItemClass.WriteWChar(AStream:TStream; AValue:String);
Var
 W : Word;
Begin
 If Length(AValue)=0 Then
  Begin
   W:=0;
   AStream.WriteBuffer(W,2);
   Exit;
  End;
 AStream.WriteBuffer(AValue[1],Length(AValue)*2);
 W:=0;
 AStream.WriteBuffer(W,2);
End;

{===============================PROCEDURE==================================}

Procedure TrxResourceItemClass.SaveToStream(aStream:TStream);
Begin
 If Size<>0 Then aStream.WriteBuffer(Data^,Size);
End;

{===============================PROCEDURE==================================}

Procedure TrxResourceItemClass.SaveToFile(aFileName:String);
Var
 M : TMemoryStream;
Begin
 M:=TMemoryStream.Create;
 Try
  SaveToStream(M);
  M.SaveToFile(AFileName);
 Finally
  M.Free;
 End;
End;

{===============================PROCEDURE==================================}

Procedure TrxResourceItemClass.Update(aNewBuf:Pointer;aNewSize:Integer);
Begin
 If FInfo.Size<>0 Then vxFreeMem(FInfo.Buffer);
 FInfo.Size:=aNewSize;
 FInfo.Buffer:=vxAllocMem(FInfo.Size);
 CopyMemory(FInfo.Buffer,aNewBuf,FInfo.Size);
End;

{===============================PROCEDURE==================================}

Function TrxResourceItemClass.Size:Integer;
Begin
 Result:=FInfo.Size;
End;

{===============================PROCEDURE==================================}

Function TrxResourceItemClass.Data:Pointer;
Begin
 Result:=FInfo.Buffer;
End;

{===============================PROCEDURE==================================}

Function TrxResourceItemClass.Name:String;
Begin
 Result:=FInfo.Named;
End;

{===============================PROCEDURE==================================}

Function TrxResourceItemClass.ParentType:String;
Begin
 Result:=FInfo.Typed;
End;

{===============================PROCEDURE==================================}

Procedure TrxResourceItemClass.NewStatus(aStatus:Integer);
Begin
 FInfo.Status:=aStatus;
End;

{===============================PROCEDURE==================================}

Procedure TrxResourceItemClass.CreateHandle;
Begin
End;

{===============================PROCEDURE==================================}

Procedure TrxResourceItemClass.FreeHandle;
Begin
End;

{===============================PROCEDURE==================================}

Procedure TrxResourceItemClass.Change;
Begin
End;

{===============================PROCEDURE==================================}

Constructor TrxResourceItemClass.Create(aInfo:TrxResourceClass);
Begin
 FInfo:=aInfo;
 CreateHandle;
End;

{===============================PROCEDURE==================================}

Destructor TrxResourceItemClass.Free;
Begin
 FreeHandle;
End;

{===============================PROCEDURE==================================}



end.

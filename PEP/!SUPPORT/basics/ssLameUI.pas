Unit ssLameUI;





interface
Uses Winapi.Windows, Classes, System.Generics.Collections;





Type
 TuiLanguageFile = Class
 Public
  CodePage : Integer;
  Name     : String;
  FileName : String;
  Path     : String;
  IdName   : String;
  Mui      : TStringList;
 Public
  Constructor Create;
  Destructor Free;
 End;





 TuiLanguage = Class
 Private
  FList    : TList<TuiLanguageFile>;
  FSelect  : TuiLanguageFile;
  FAltLang : TuiLanguageFile;

  Function  FindId(const id:string; const S:TStringList; var R:String):Boolean;
 Public
  Function    ShortPrefix:String;
  Procedure   Select(C:TuiLanguageFile);
  Function    FindLocal:TuiLanguageFile;
  Function    FindByCodePage(CP:Integer):TuiLanguageFile;
  Function    FindByIdName(const Id:String):TuiLanguageFile;
  Function    Count:Integer;
  Function    Names(L:TStringList):Integer;
  Function    AddLanguage(const AFileName:String):TuiLanguageFile;overload;
  Function    AddLanguage(const ASource:TStream):TuiLanguageFile;overload;
  Function    AddLanguage(const AResourceName:String; const ResType: PChar):TuiLanguageFile;overload;
  Function    AddLanguage(const AResourceName:PChar; const ResType: PChar):TuiLanguageFile;overload;
  Procedure   LoadFromDir(const InitDir:String);
  //
  Constructor Create;
  Destructor  Free;
  Procedure   Clear;
  //
  Property Language:TuiLanguageFile Read FSelect;
  Property Native:TuiLanguageFile Read FAltLang Write FAltLang;
  Property List:TList<TuiLanguageFile> Read FList;
  //
  Function ui(const Id:String):String;overload;
  Function ui(Id:Integer):String;overload;
 End;







Procedure uiInfo(const Msg:String; const Caption:String='');overload;
Procedure uiInfo(const Msg:String; const Args:Array of Const; const Caption:String='');overload;
Procedure uiError(const Msg:String; const Caption:String='');overload;
Procedure uiError(const Msg:String; const Args:Array of Const; const Caption:String='');overload;
Function  uiConfirm(const Msg:String; const Caption:String=''):Boolean;



Function  uiSelectOpenFile(const Path,Caption:String; const  Filter:Array of String):String;
Function  uiSelectSaveFile(const Path,Caption:String; const Filter:Array of String; const DefExt:String=''):String;
Procedure uiAbout;

Function uiSelectDir(Handle: THandle; Caption: string; var strFolder: string): Boolean;



implementation
Uses SysUtils, Vcl.Dialogs, ShlObj, StrUtils {$IFDEF CIL},System.IO{$ENDIF};






{===============================PROCEDURE==================================}

function BrowseCallbackProc(hwnd: HWND; uMsg: UINT; lParam: LPARAM; lpData: LPARAM): Integer; stdcall;
begin
  if (uMsg = BFFM_INITIALIZED) then SendMessage(hwnd, BFFM_SETSELECTION, 1, lpData);
  BrowseCallbackProc := 0;
end;

{===============================PROCEDURE==================================}

Function uiSelectDir(Handle: THandle; Caption: string; var strFolder: string): Boolean;
const
  BIF_STATUSTEXT           = $0004;
  BIF_NEWDIALOGSTYLE       = $0040;
  BIF_RETURNONLYFSDIRS     = $0080;
  BIF_SHAREABLE            = $0100;
  BIF_USENEWUI             = BIF_EDITBOX or BIF_NEWDIALOGSTYLE;
var
  BrowseInfo: TBrowseInfo;
  ItemIDList: PItemIDList;
  JtemIDList: PItemIDList;
  Path: PChar;
begin
  Result := False;
  Path := StrAlloc(MAX_PATH);
  SHGetSpecialFolderLocation(Handle, CSIDL_DRIVES, JtemIDList);
  with BrowseInfo do
  begin
    hwndOwner := GetActiveWindow;
    pidlRoot := JtemIDList;
    SHGetSpecialFolderLocation(hwndOwner, CSIDL_DRIVES, JtemIDList);
    pszDisplayName := StrAlloc(MAX_PATH);
    lpszTitle := PChar(Caption);//'Select the folder';
    lpfn := @BrowseCallbackProc;
    lParam := LongInt(PChar(strFolder));
  end;
  ItemIDList := SHBrowseForFolder(BrowseInfo);
  if (ItemIDList <> nil) then
    if SHGetPathFromIDList(ItemIDList, Path) then
    begin
      strFolder := Path;
      Result := True
    end;
end;

{===============================PROCEDURE==================================}

Constructor TuiLanguageFile.Create;
begin
 Mui:=TStringList.Create;
end;

{===============================PROCEDURE==================================}

Destructor TuiLanguageFile.Free;
begin
 Mui.Free;
end;

{===============================PROCEDURE==================================}

Procedure TuiLanguage.Clear;
Var
 L : TuiLanguageFile;
begin
 FSelect:=NIL;
 for L in List do L.Free;
 FList.Clear;
end;

{===============================PROCEDURE==================================}

Function TuiLanguage.AddLanguage(const AFileName:String):TuiLanguageFile;
Var
 L : TuiLanguageFile;
 S : String;
begin
 Result:=nil;
 If FileExists(AFileName)=False Then Exit;
 L:=TuiLanguageFile.Create;
 L.FileName:=Trim(AFileName);
 Try
  L.Mui.LoadFromFile(L.FileName);
 Except
  L.FileName:='';
 End;
 If L.FileName='' Then
  begin
   L.Free;
   Exit;
  end;

 L.Path:=ExtractFilePath(L.FileName);
 L.IdName:=ExtractFileName(L.FileName);
 L.Name:=L.IdName;

 FindId('ui_code_page', L.Mui, S);
 L.CodePage:=StrToIntDef(S,1251);

 FindId('ui_name', L.Mui, S);
 If S<>'' Then L.Name:=S;

 FList.Add(L);
 Result:=L;
end;

{===============================PROCEDURE==================================}

Function TuiLanguage.AddLanguage(const ASource:TStream):TuiLanguageFile;
Var
 L : TuiLanguageFile;
 S : String;
begin
 Result:=nil;
 L:=TuiLanguageFile.Create;
 Try
  L.Mui.LoadFromStream(ASource);
 Except
  L.Free;
  Exit;
 End;

 FindId('ui_code_page', L.Mui, S);
 L.CodePage:=StrToIntDef(S,1251);

 FindId('ui_name', L.Mui, S);
 If S<>'' Then L.Name:=S;

 FList.Add(L);
 Result:=L;
end;

{===============================PROCEDURE==================================}

Function TuiLanguage.AddLanguage(const AResourceName: string; const ResType: PChar):TuiLanguageFile;
var
 R : TResourceStream;
begin
 try
  R:=TResourceStream.Create(HInstance, AResourceName, ResType);
  Result:=AddLanguage(R);
  Result.IdName:=AResourceName;
 finally
  If (Assigned(R)) Then R.Free
 end;
end;

{===============================PROCEDURE==================================}

Function TuiLanguage.AddLanguage(const AResourceName:PChar; const ResType: PChar):TuiLanguageFile;
var
 R : TResourceStream;
begin
 try
  R:=TResourceStream.CreateFromID(HInstance, Int64(AResourceName), ResType);
  Result:=AddLanguage(R);
 finally
  If (Assigned(R)) Then R.Free
 end;
end;

{===============================PROCEDURE==================================}

Function TuiLanguage.ShortPrefix:String;
begin
 Result:='';
 If FSelect=NIl Then Exit;
 Result:=Copy(ExtractFileName(FSelect.FileName),1,2);
end;

{===============================PROCEDURE==================================}

Function TuiLanguage.FindId(const id:string; const S:TStringList; var R:String):Boolean;
Var
 I, P :Integer;
 M, N : String;
begin
 Result:=False;
 R:='';
 For I:=0 To S.Count-1 do
  begin
   M:=S[I];
   P:=Pos('=', M);
   If P<=0 Then Continue;
   N:=Trim(Copy(M, 1, P-1));
   If SameText(N, id)=False Then Continue;
   R:=Trim(Copy(M, P+1, MaxInt));
   R:=ReplaceText(R, '[#n]', sLineBreak);
   Exit(True);
  end;
end;

{===============================PROCEDURE==================================}

Function TuiLanguage.ui(const Id:String):String;
begin
 Result:='';
 If (FSelect=nil) and (FAltLang=nil) Then Exit;

 If FSelect<>nil Then
  If FindId(Id, FSelect.Mui, Result)=True Then Exit;

 If FAltLang<>nil Then
  If FindId(Id, FAltLang.Mui, Result)=True Then Exit;
end;

{===============================PROCEDURE==================================}

Function TuiLanguage.ui(Id:Integer):String;
begin
 Result:=ui(IntToStr(Id));
end;

{===============================PROCEDURE==================================}

Function TuiLanguage.Names(L:TStringList):Integer;
Var
 M : TuiLanguageFile;
begin
 Result:=0;
 L.Clear;
 If FList.Count=0 Then Exit;
 For M in FList do L.Add(M.Name);
 Result:=L.Count;
end;

{===============================PROCEDURE==================================}

Function TuiLanguage.FindByCodePage(CP:Integer):TuiLanguageFile;
begin
 Result:=nil;
 If FList.Count=0 Then Exit;
 For Result in FList do If Result.CodePage=CP Then Exit;
 Result:=nil;
end;

{===============================PROCEDURE==================================}

Function TuiLanguage.FindByIdName(const Id:String):TuiLanguageFile;
begin
 Result:=nil;
 If FList.Count=0 Then Exit;
 For Result in FList do If SameText(Result.IdName, Id) Then Exit;
 Result:=nil;
end;

{===============================PROCEDURE==================================}

Function TuiLanguage.FindLocal:TuiLanguageFile;
begin
 Result:=FindByCodePage(GetACP);
end;

{===============================PROCEDURE==================================}

Procedure TuiLanguage.Select(C:TuiLanguageFile);
begin
 If FList.IndexOf(C)<>-1 Then FSelect:=C Else FSelect:=NIl;
end;

{===============================PROCEDURE==================================}

Function TuiLanguage.Count:Integer;
begin
 Result:=FList.Count;
end;

{===============================PROCEDURE==================================}

Procedure TuiLanguage.LoadFromDir(const InitDir:String);
Label ins_it;
Var
 F : TSearchRec;
 I : Integer;
begin
 Clear;
 I:=FindFirst(InitDir+'*.uil', faAnyFile, F);
 If I=0 Then Goto ins_it;
 While True Do
  Begin
   I:=FindNext(F);
   If I<>0 Then Break;
   ins_it:
    AddLanguage(InitDir+F.Name);
  End;
end;

{===============================PROCEDURE==================================}

Constructor TuiLanguage.Create;
begin
 FSelect:=NIL;
 FList:=TList<TuiLanguageFile>.Create;
end;

{===============================PROCEDURE==================================}

Destructor TuiLanguage.Free;
begin
 Clear;
 FList.Free;
end;

{===============================PROCEDURE==================================}

Procedure uiAbout;
begin
 uiInfo('Your about here!');
end;

{===============================PROCEDURE==================================}
{$WARNINGS OFF}
Function uiSelectSaveFile(const Path,Caption:String; const  Filter:Array of String; const DefExt:String=''):String;
Var
 {$IFNDEF FPC}
 OpenFile   : TFileSaveDialog;
 {$ENDIF}
 OpenFileXP : TSaveDialog;
 I, P : Integer;
 L, R : String;
Begin
 Result:='';
 {$IFNDEF FPC}
 If Win32MajorVersion<6 Then
  begin // 2k, xp
 {$ENDIF}
    OpenFileXP:=TSaveDialog.Create(NIL);
    OpenFileXP.Title:=Caption;
    OpenFileXP.InitialDir:=Path;
    OpenFileXP.Options:=[ofPathMustExist];
    OpenFileXP.DefaultExt:=DefExt;
    OpenFileXP.Filter:='';
    If SizeOf(Filter)<>0 Then
     For I:=Low(Filter) To High(Filter) Do
      begin
       OpenFileXP.Filter:=OpenFileXP.Filter+Filter[I];
       If I<>High(Filter) Then OpenFileXP.Filter:=OpenFileXP.Filter+'|';
      end;
    If OpenFileXP.Execute=True Then Result:=OpenFileXP.Filename;
    OpenFileXP.Free;
 {$IFNDEF FPC}
  end
 Else
  begin // vista and >...
   OpenFile:=TFileSaveDialog.Create(NIL);
   OpenFile.Title:=Caption;
   OpenFile.DefaultFolder:=Path;
   OpenFile.Options:=[fdoPathMustExist, fdoHideMRUPlaces];
   OpenFile.DefaultExtension:=DefExt;
   If SizeOf(Filter)<>0 Then
    For I:=Low(Filter) To High(Filter) Do
     With OpenFile.FileTypes.Add Do
      begin
       P:=Pos('|', Filter[I]);
       If P=0 Then Continue;
       L:=Copy(Filter[I], 1, P-1);
       R:=Copy(Filter[I], P+1, MaxInt);
       DisplayName:=L;
       FileMask:=R;
      end;
   If OpenFile.Execute=True Then Result:=OpenFile.Filename;
   OpenFile.Free;
  end;
 {$ENDIF}
End;

{===============================PROCEDURE==================================}

Function uiSelectOpenFile(const Path,Caption:String; const Filter:Array of String):String;
Var
 {$IFNDEF FPC}
 OpenFile   : TFileOpenDialog;
 {$ENDIF}
 OpenFileXP : TOpenDialog;
 I, P : Integer;
 L, R : String;
Begin
 Result:='';
 {$IFNDEF FPC}
 If Win32MajorVersion<6 Then
  begin    // xp, 2k
 {$ENDIF}
    OpenFileXP:=TOpenDialog.Create(NIL);
    OpenFileXP.Title:=Caption;
    OpenFileXP.InitialDir:=Path;
    OpenFileXP.Options:=[ofPathMustExist, ofFileMustExist];
    OpenFileXP.Filter:='';
    If SizeOf(Filter)<>0 Then
     For I:=Low(Filter) To High(Filter) Do
      begin
       OpenFileXP.Filter:=OpenFileXP.Filter+Filter[I];
       If I<>High(Filter) Then OpenFileXP.Filter:=OpenFileXP.Filter+'|';
      end;
    If OpenFileXP.Execute=True Then Result:=OpenFileXP.Filename;
    OpenFileXP.Free;
 {$IFNDEF FPC}
  end
 Else
  begin  // vista and > ...
    OpenFile:=TFileOpenDialog.Create(NIL);
    OpenFile.Title:=Caption;
    OpenFile.DefaultFolder:=Path;
    OpenFile.Options:=[fdoPathMustExist, fdoFileMustExist, fdoHideMRUPlaces];
    If SizeOf(Filter)<>0 Then
     For I:=Low(Filter) To High(Filter) Do
      With OpenFile.FileTypes.Add Do
       begin
        P:=Pos('|', Filter[I]);
        If P=0 Then Continue;
        L:=Copy(Filter[I], 1, P-1);
        R:=Copy(Filter[I], P+1, MaxInt);
        DisplayName:=L;
        FileMask:=R;
       end;
    If OpenFile.Execute=True Then Result:=OpenFile.Filename;
    OpenFile.Free;
  end;
 {$ENDIF}
End;
{$WARNINGS ON}
{===============================PROCEDURE==================================}

Procedure uiInfo(const Msg:String; const Caption:String='');
Begin
 {$IFDEF CIL}
  MessageBox(0, Msg, Caption, MB_OK or MB_ICONINFORMATION or MB_TASKMODAL);
 {$ELSE}
  MessageBox(0,PChar(Msg),PChar(Caption),MB_OK or MB_ICONINFORMATION or MB_TASKMODAL);
 {$ENDIF}
End;

{===============================PROCEDURE==================================}

Procedure uiInfo(const Msg:String; const Args:Array of Const; const Caption:String='');
Begin
 uiInfo(Format(Msg,Args),Caption);
End;

{===============================PROCEDURE==================================}

Procedure uiError(const Msg:String; const Args:Array of Const; const Caption:String='');
Begin
 uiError(Format(Msg,Args),Caption);
End;

{===============================PROCEDURE==================================}

Function uiConfirm(const Msg:String; const Caption:String=''):Boolean;
Begin
 Result:=False;
 {$IFDEF CIL}
 If MessageBox(0, Msg, Caption,MB_OKCANCEL or MB_ICONQUESTION or MB_TASKMODAL)=IDOK Then
 {$ELSE}
 If MessageBox(0,PChar(Msg),PChar(Caption),MB_OKCANCEL or MB_ICONQUESTION or MB_TASKMODAL)=IDOK Then
 {$ENDIF}
  Result:=True;
End;

{===============================PROCEDURE==================================}

Procedure uiError(const Msg:String; const Caption:String='');
Begin
 {$IFDEF CIL}
 MessageBox(0, Msg, Caption,MB_OK or MB_ICONERROR or MB_TASKMODAL);
 {$ELSE}
 MessageBox(0,PChar(Msg),PChar(Caption),MB_OK or MB_ICONERROR or MB_TASKMODAL);
 {$ENDIF}
End;



end.

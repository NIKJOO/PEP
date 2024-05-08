program PeP;

(*     ===========================================   *)
(*     =====  Copyright by SetiSoft (c) Tech =====   *)
(*     =====       All rights reserved !     =====   *)
(*     =====          2003  -  2013          =====   *)
(*     ===========================================   *)
(*     =====    Internet: www.setisoft.com   =====   *)
(*     =====    E-Mail: setisoft@gmail.com   =====   *)
(*     ===========================================   *)

//     -------------------------------------------   //
//      This source code is a part of PEP project    //
//     -------------------------------------------   //

{-$DEFINE ESTORE}    // <-- on/off external store


{$IFNDEF ESTORE}
 {$R *.dres}
{$ENDIF}

uses
  Forms,
  Classes,
  Windows,
  Registry,
  SysUtils,
  ssStore,
  ssLameUI,
  Vcl.Themes,
  Vcl.Styles,
  MainUnit in 'Units\MainUnit.pas' {frmMain},
  ProtectUnit in 'Units\ProtectUnit.pas',
  HandleUnit in 'Units\HandleUnit.pas',
  UnitCode in 'Units\UnitCode.pas' {frmCode},
  BlackUnit in 'Units\BlackUnit.pas' {frmNewBlack},
  Unsafe35vm in 'Units\Unsafe35vm.pas';

{$R *.res}



{$IFDEF DEBUG} {$O-} {$ENDIF}

{$IFDEF DEBUG}
 {$MESSAGE WARN '-----------!--!----------> Compiler DEBUG MODE is ON'}
{$ENDIF}


Label EndMe;


Var
 GlobalLog  : TStringList;
 CmdParams  : TStringList;
 E          : Boolean;
 P          : Integer;
 EM, FN, LN : String;
 LngP       : TuiLanguageFile;



{===============================PROCEDURE==================================}

Procedure LogToTextFile(const T:String);
begin
 GlobalLog.Add(T);
 Writeln(T);
 Application.ProcessMessages;
end;

{===============================PROCEDURE==================================}

begin
 Path:=ExtractFilePath(ParamStr(0));

 // LANG
 Language:=TuiLanguage.Create;
 {$IFDEF ESTORE}
 Language.AddLanguage(Path+'store\english.uil');
 {$ELSE}
 Language.AddLanguage('english',RT_RCDATA).IdName:='english';
 {$ENDIF}

 Language.Native:=Language.FindByIdName('english');
 Language.Select(Language.Native);

 {$IFDEF ESTORE}
 Language.AddLanguage(Path+'store\russian.uil');
 {$ELSE}
 Language.AddLanguage('russian',RT_RCDATA).IdName:='russian';
 {$ENDIF}

 zeroMemory(@Item, SizeOf(Item));





 // GLOBAL STORE
 GStore:=TMemoryStore.Create;
 {$IFDEF ESTORE}
 GStore.LoadFromFile(Path+'store\store.in');   //
 {$ELSE}
 GStore.LoadFromResource('store', RT_RCDATA);   //
 {$ENDIF}


 // GLOBAL INI
 ConfigFile:=TRegIniFile.Create('Software\'+ApplicationName); // HKEY_CURRENT_USER

 If Language.Language=NIL Then
  begin
   Language.Select(Language.FindByCodePage(1251));
   If Language.Language=NIL Then Language.Select(Language.List[0]);
  end;

 LngP:=Language.FindByIdName(ConfigFile.ReadString('Run', 'Language', ''));
 If LngP<>nil Then Language.Select(LngP);


 CmdParams:=TStringList.Create;
 If ParamCount>0 Then
  For P:=1 To ParamCount Do CmdParams.Add(UpperCase(Trim(ParamStr(P))));










 Application.Initialize;
 P:=CmdParams.IndexOf(UpperCase('-console'));
 If P=-1 Then
  Begin
    Application.Title := ApplicationName;
    Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TfrmCode, frmCode);
  Application.CreateForm(TfrmNewBlack, frmNewBlack);
  // localize
    frmMain.UpdateUI;
    Application.Run;
  End
 Else
  Begin
   CmdParams.Delete(P);
   FN:='';
   LN:='';

   AllocConsole;
   IsConsole:=True;

   Writeln;
   Writeln('Private exe Protector version ',ProgramVer,'.',ProgramSubVer,ProgramSP);
   Writeln('Copyright by SetiSoft (c) Tech, 2003 - 2013 (http://setisoft.com)');
   Writeln;
   Writeln('Usage:');
   Writeln(' "private exe protector.exe" -console -project project_file.pep [-log log_file.log]');
   Writeln;
   Writeln;

   P:=CmdParams.IndexOf(UpperCase('-project'));
   If P<>-1 Then
    begin
     If P+1 <= CmdParams.Count-1 then
      begin
       FN:=ExpandFileName(CmdParams[P+1]);
       CmdParams.Delete(P+1);
      end;
     CmdParams.Delete(P);
    end;


   P:=CmdParams.IndexOf(UpperCase('-log'));
   If P<>-1 Then
    begin
     If P+1 <= CmdParams.Count-1 then
      begin
       LN:=ExpandFileName(CmdParams[P+1]);
       CmdParams.Delete(P+1);
      end;
     CmdParams.Delete(P);
    end;

   If FileExists(FN)=False Then
    begin
     Writeln(Format(Language.ui(106),[FN]));
     Goto EndMe;
    end;

   E:=False;
   FillChar(Item,SizeOf(Item),0);


   Try
    ReadWriteIni(FN,Item,False);
   Except
    On Ex:Exception Do
     begin
      E:=True;
      EM:=Ex.Message;
     end;
   End;
   If E=True Then
    begin
     Writeln(Language.ui(107)+' '+FN+sLineBreak+EM);
     Readln;
     Goto EndMe;
    end;

   // submit log
   GlobalLog:=TStringList.Create;
   P:=ProtectFile(Item,LogToTextFile);
   If LN<>'' Then
    begin
     Try
      GlobalLog.SaveToFile(LN);
     Except
      On E:Exception Do
       Writeln(Language.ui(108)+' '+LN+sLineBreak+'['+E.Message+']');
     End;
    end;
   GlobalLog.Free;


  EndMe:
   Writeln;
   FreeConsole;
   ExitProcess(P);
   Application.Terminate;
   Exit;
 End;


 CmdParams.Free;
 ConfigFile.Free;
 Language.Free;
 GStore.Free;
end.


unit MainUnit;


interface

uses
  Registry, ProtectUnit, Windows, SysUtils, Classes, Controls, Forms,
  Menus, ExtCtrls, CategoryButtons, Messages,
  ComCtrls, StdCtrls, Spin, Buttons, ImgList, ToolWin, Vcl.Grids, Vcl.ValEdit,
  Vcl.Dialogs;

type
  TfrmMain = class(TForm)
    Timer: TTimer;
    immMsg: TImageList;
    mainMnu: TMainMenu;
    mnuMFile: TMenuItem;
    mnuMHelp: TMenuItem;
    mnuNewProject: TMenuItem;
    mnuOpenProject: TMenuItem;
    mnuSaveProject: TMenuItem;
    mnuExit: TMenuItem;
    mnuHelp: TMenuItem;
    N2: TMenuItem;
    mnuAbout: TMenuItem;
    N3: TMenuItem;
    mnuLng: TMenuItem;
    recentPop: TPopupMenu;
    Submenu1: TMenuItem;
    N7: TMenuItem;
    eProjectName: TStatusBar;
    btnHomePage: TMenuItem;
    panelMenu: TCategoryButtons;
    Panel1: TPanel;
    Pages: TPageControl;
    shGeneral: TTabSheet;
    lblInputFile: TLabel;
    lblAppNameVer: TLabel;
    lblHomePage: TLabel;
    lblResult: TLabel;
    lblVersion: TLabel;
    eAppName: TEdit;
    bsSkinPanel1: TPanel;
    btnProtect: TSpeedButton;
    btnRestore: TSpeedButton;
    btnTest: TSpeedButton;
    eResult: TMemo;
    eAppVer: TEdit;
    shMsg: TTabSheet;
    eMsgList: TTreeView;
    shLic: TTabSheet;
    shExcl: TTabSheet;
    pStolenRC: TCheckBox;
    pAntiDebug: TCheckBox;
    oAntiDump: TCheckBox;
    eReqAdminR: TCheckBox;
    shNag: TTabSheet;
    shBlack: TTabSheet;
    btnOrderNow: TMenuItem;
    N1: TMenuItem;
    eBlack: TListView;
    popBlack: TPopupMenu;
    mnuPopBlackAdd: TMenuItem;
    mnuPopBlackDel: TMenuItem;
    N8: TMenuItem;
    bvvccb: TCoolBar;
    mnuPanel: TPanel;
    btnNew: TSpeedButton;
    btnOpen: TSpeedButton;
    btnSave: TSpeedButton;
    immButtons: TImageList;
    immMenu: TImageList;
    immUI: TImageList;
    mnuOptions: TMenuItem;
    mnuKG: TMenuItem;
    btnReadVersion: TSpeedButton;
    btnSelectFN: TSpeedButton;
    pAllowMsg: TCheckBox;
    oSameSize: TCheckBox;
    pnlNag: TPanel;
    lblNagText: TLabel;
    eNAGText: TMemo;
    lblNagHlp: TLabel;
    eNAGHelp: TEdit;
    eNAGOK: TEdit;
    lblNagOk: TLabel;
    lblNagBuy: TLabel;
    eNAGBuy: TEdit;
    oCustomNAG: TCheckBox;
    eUseOneCopy: TCheckBox;
    HwidGrup: TGroupBox;
    eHwidMode1: TRadioButton;
    eHwidMode2: TRadioButton;
    eHwidMode3: TRadioButton;
    eHomePage: TEdit;
    eFileName: TEdit;
    tsKG: TTabSheet;
    tvKgMsg: TTreeView;
    mniSaveprojectas: TMenuItem;
    chkDisableCompression: TCheckBox;
    chkIncreaseSize: TCheckBox;
    lblNagcaption: TLabel;
    eNAGDlgCaption: TEdit;
    lblLidcaption: TLabel;
    eNAGLicCaption: TEdit;
    lblNagUName: TLabel;
    eNagUserName: TEdit;
    eNAGKeyCaption: TEdit;
    lblActivationKey: TLabel;
    lblPurchasePage: TLabel;
    eBuyPage: TEdit;
    dlgColor: TColorDialog;
    nagBackColor: TLabel;
    nagFontColor: TLabel;
    chkTextAlign: TCheckBox;
    lblKeyPath: TLabel;
    edtKeyPath: TEdit;
    chkDelay: TCheckBox;
    lblPPKey: TLabel;
    ePrivateData: TEdit;
    btnGenPrivateD: TSpeedButton;
    btnExportKey: TSpeedButton;
    btnImportKey: TSpeedButton;
    eUseEDate: TCheckBox;
    chkUseExecCount: TCheckBox;
    chkUseDaysLimit: TCheckBox;
    chkUseExecLimit: TCheckBox;
    eExitIfNoKey: TCheckBox;
    eEDate: TDateTimePicker;
    seExecCount: TSpinEdit;
    seDaysCount: TSpinEdit;
    seExecLimit: TSpinEdit;
    blnhnt1: TBalloonHint;
    procedure FormCreate(Sender: TObject);
    procedure TimerTimer(Sender: TObject);
    procedure btnNewClick(Sender: TObject);
    procedure btnOpenClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnAppInfo2Click(Sender: TObject);
    procedure btnOptionsClick(Sender: TObject);
    procedure btnDialogsClick(Sender: TObject);
    procedure btnHomePageClick(Sender: TObject);
    procedure btnProtectClick(Sender: TObject);
    procedure btnRestoreClick(Sender: TObject);
    procedure btnTestClick(Sender: TObject);
    procedure eMsgListDblClick(Sender: TObject);
    procedure btnLicClick(Sender: TObject);
    procedure Exit1Click(Sender: TObject);
    procedure mnuAboutClick(Sender: TObject);
    procedure Help2Click(Sender: TObject);
    procedure mnuNewProjectClick(Sender: TObject);
    procedure mnuOpenProjectClick(Sender: TObject);
    procedure mnuSaveProjectClick(Sender: TObject);
    procedure recentPopPopup(Sender: TObject);
    Procedure recentMenuClick(Sender: TObject);
    procedure SelectLangClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnSellAppClick(Sender: TObject);
    procedure btnOrderNowClick(Sender: TObject);
    procedure btnNewBlackClick(Sender: TObject);
    procedure shBlackShow(Sender: TObject);
    procedure btnDelBlackClick(Sender: TObject);
    procedure eBlackDblClick(Sender: TObject);
    procedure btnReadVersionClick(Sender: TObject);
    procedure tvKgMsgDblClick(Sender: TObject);
    procedure mniSaveprojectasClick(Sender: TObject);
    procedure btnGenPrivateDClick(Sender: TObject);
    procedure btnExportKeyClick(Sender: TObject);
    procedure btnImportKeyClick(Sender: TObject);
    procedure nagBackColorClick(Sender: TObject);
    procedure nagFontColorClick(Sender: TObject);
    procedure eNAGTextChange(Sender: TObject);
    procedure chkDelayClick(Sender: TObject);
    procedure chkTextAlignClick(Sender: TObject);
  private
    { Private declarations }
   Procedure FlipPage(Page:Integer);
   Procedure UpdateBlackList;
  public
   Procedure UpdatePDCRC;
   Procedure UpdateUI;
   procedure AcceptFiles( var msg : TMessage ); message WM_DROPFILES;
    { Public declarations }
  end;




var
  frmMain: TfrmMain;





Const
 ApplicationName      = 'Private exe Protector';





Procedure ReadWriteIni(const FileName:String;Var P:TFileProject;W:Boolean=False);
Procedure GetInfo(frm:TfrmMain);






Var
 Item     : TFileProject;
 ConfigFile : TRegIniFile;





implementation
Uses ShellApi, ssMemory, StrUtils, ssLamePE, HandleUnit, IniFiles,
     UnitCode, ssLameUI, BlackUnit, ssStore, ssLameCrypt;

{$R *.dfm}



{============================PROCEDURE==================================}

procedure TfrmMain.AcceptFiles( var msg : TMessage );
var
  dropFileName : array [0..2000] of Char;
begin
 DragQueryFile( msg.WParam, $FFFFFFFF, dropFileName, 1000 );
 DragQueryFile( msg.WParam, 0, dropFileName, 1000 );
 eFileName.Text:=Trim(dropFileName);
 DragFinish( msg.WParam );
end;

{===============================PROCEDURE==================================}

Procedure ReadWriteIni(const FileName:String;Var P:TFileProject;W:Boolean=False);
Const
 Sec = 'PEP4';
Var
 Ini  : TMemIniFile;
 BArray : TvxByteArray;
Begin
 Ini:=TMemIniFile.Create(FileName);

 If W=False Then
  With Ini Do
   Begin
    P.FileName := ReadString(Sec,'0', '');
    P.AppName  := ReadString(Sec,'1', '');
    P.AppVer   := ReadString(Sec,'2', '');
    P.HomePage := ReadString(Sec,'3', '');
    P.AllowMsg      := ReadBool(Sec,'9', False);
    P.AntiDebug     := ReadBool(Sec,'10', False);
    P.SameSize   := ReadBool(Sec,'19', False);
    P.AntiDump   := ReadBool(Sec,'20', False);
    P.StolenRC   := ReadBool(Sec,'22', False);
    P.RequestAdminR := ReadBool(Sec,'60', False);
    P.MsgDbg    := br2nl(ReadString(Sec,'27', ''));
    P.MsgSKey   := br2nl(ReadString(Sec,'28', ''));
    P.MsgEDate  := br2nl(ReadString(Sec,'29', ''));
    P.MsgNotAdmin  := br2nl(ReadString(Sec,'62', ''));
    P.MsgCrCfail  := br2nl(ReadString(Sec,'63', ''));


    P.ExitIfNoKey  := ReadBool(Sec,'34', False);
    P.PurchasePage := ReadString(Sec,'35', '');
    P.ExpiredDate  := ReadDate(Sec,'38', 0);
    P.nagDialog      := ReadString(Sec,'39', '');
    P.nagLicenseID   := ReadString(Sec,'40', '');
    P.nagActivateKey := ReadString(Sec,'41', '');
    P.nagText := br2nl(ReadString(Sec,'42', ''));
    P.nagHelp := ReadString(Sec,'43', '');
    P.nagOK   := ReadString(Sec,'44', '');
    P.nagBuy  := ReadString(Sec,'45', '');
    P.StdNAG  := ReadBool(Sec,'47', False);
    P.ProjectFile  := ReadString(Sec,'46', '');
    P.BlackList  := br2nl(ReadString(Sec,'48', ''));

    P.UseExecLimit:=ReadBool(Sec,'65', False);
    P.UseOneCopy:=ReadBool(Sec,'67', False);
    P.ExecLimit:=ReadInteger(Sec,'68', 0);
    P.HwidMode:=ReadInteger(Sec,'69', 0);
    P.MsgCopyLimit:=ReadString(Sec,'70', '');
    P.MsgClockMan:=ReadString(Sec,'71', '');

    P.UseDayLimit:=ReadBool(Sec, '82', False);
    P.DayLimit:=ReadInteger(Sec, '83', 0);
    P.UseExecCount:=ReadBool(Sec, '84', False);
    P.ExecCount:=ReadInteger(Sec, '85', 0);

    P.MsgTECount:=ReadString(Sec, '86', '');
    P.MsgTDCount:=ReadString(Sec, '87', '');

    P.kgO1:=ReadString(Sec, '88', '');
    P.kgO2:=ReadString(Sec, '89', '');
    P.kgO3:=ReadString(Sec, '90', '');
    P.kgO4:=ReadString(Sec, '91', '');
    P.kgO5:=ReadString(Sec, '92', '');
    P.kgO6:=ReadString(Sec, '93', '');
    P.kgO7:=ReadString(Sec, '94', '');
    P.kgO8:=ReadString(Sec, '95', '');

    P.DisableCompression:=ReadBool(Sec, '2001', False);
    P.IncreaseFileSize:=ReadBool(Sec, '2002', False);

    P.nagUserName  := ReadString(Sec,'2003','');

    vxStrToVar(ReadString(Sec, '2004', ''), BArray);
    SetLength(P.PrivateKey, 0);
    If Length(BArray)>0 Then
     rc4memtokey(@BArray[0], Length(BArray), P.PrivateKey);

    vxStrToVar(ReadString(Sec, '2005', ''), BArray);
    SetLength(P.PublicKey, 0);
    If Length(BArray)>0 Then
     rc4memtokey(@BArray[0], Length(BArray), P.PublicKey);

    vxStrToVar(ReadString(Sec, '2007', ''), BArray);
    SetLength(P.PrivateRC4, 0);
    If Length(BArray)>0 Then
     rc4memtokey(@BArray[0], Length(BArray), P.PrivateRC4);

    P.nagBackColor := ReadInteger(Sec,'2008', 0);
    P.nagFontColor := ReadInteger(Sec,'2009', 0);
    P.nagTextAlign := ReadInteger(Sec,'2010', 0);
    P.licKeyPath   := ReadString(Sec, '2011', '');
    P.nagDelay     := ReadInteger(Sec,'2012', 0);
    P.MsgExecLimit := ReadString(Sec,'2013', '');
   End
 Else
  With Ini Do
   Begin
    Clear;
    WriteString(Sec,'0', P.FileName);
    WriteString(Sec,'1', P.AppName);
    WriteString(Sec,'2', P.AppVer);
    WriteString(Sec,'3', P.HomePage);
    WriteBool(Sec,'9', P.AllowMsg);
    WriteBool(Sec,'10', P.AntiDebug);
    WriteBool(Sec,'19', P.SameSize);
    WriteBool(Sec,'20', P.AntiDump);
    WriteBool(Sec,'22', P.StolenRC);
    WriteBool(Sec,'60', P.RequestAdminR);
    WriteString(Sec,'27', nl2br(P.MsgDbg));
    WriteString(Sec,'28', nl2br(P.MsgSKey));
    WriteString(Sec,'29', nl2br(P.MsgEDate));
    WriteString(Sec,'62', nl2br(P.MsgNotAdmin));
    WriteString(Sec,'63', nl2br(P.MsgCrCfail));

    WriteBool(Sec,'34', P.ExitIfNoKey);
    WriteString(Sec,'35', P.PurchasePage);
    WriteDate(Sec,'38', P.ExpiredDate);
    WriteString(Sec,'39', P.nagDialog);
    WriteString(Sec,'40', P.nagLicenseID);
    WriteString(Sec,'41', P.nagActivateKey);
    WriteString(Sec,'42', nl2br(P.nagText));
    WriteString(Sec,'43', P.nagHelp);
    WriteString(Sec,'44', P.nagOK);
    WriteString(Sec,'45', P.nagBuy);
    WriteBool(Sec,'47', P.StdNAG);
    WriteString(Sec,'46', P.ProjectFile);
    WriteString(Sec,'48', nl2br(P.BlackList));


    WriteBool(Sec,'65', P.UseExecLimit);
    WriteBool(Sec,'67', P.UseOneCopy);
    WriteInteger(Sec,'68', P.ExecLimit);
    WriteInteger(Sec,'69', P.HwidMode);
    WriteString(Sec,'70', P.MsgCopyLimit);
    WriteString(Sec,'71', P.MsgClockMan);

    WriteBool(Sec, '82', P.UseDayLimit);
    WriteInteger(Sec, '83', P.DayLimit);
    WriteBool(Sec, '84', P.UseExecCount);
    WriteInteger(Sec, '85', P.ExecCount);


    WriteString(Sec, '86', P.MsgTECount);
    WriteString(Sec, '87', P.MsgTDCount);

    WriteString(Sec, '88', P.kgO1);
    WriteString(Sec, '89', P.kgO2);
    WriteString(Sec, '90', P.kgO3);
    WriteString(Sec, '91', P.kgO4);
    WriteString(Sec, '92', P.kgO5);
    WriteString(Sec, '93', P.kgO6);
    WriteString(Sec, '94', P.kgO7);
    WriteString(Sec, '95', P.kgO8);

    WriteBool(Sec, '2001', P.DisableCompression);
    WriteBool(Sec, '2002', P.IncreaseFileSize);

    WriteString(Sec,'2003', P.nagUserName);

    WriteString(Sec, '2004', vxVarToStr(@P.PrivateKey[0], Length(P.PrivateKey)));
    WriteString(Sec, '2005', vxVarToStr(@P.PublicKey[0], Length(P.PublicKey)));
    WriteString(Sec, '2007', vxVarToStr(@P.PrivateRC4[0], Length(P.PrivateRC4)));

    WriteInteger(Sec, '2008', P.nagBackColor);
    WriteInteger(Sec, '2009', P.nagFontColor);
    WriteInteger(Sec, '2010', P.nagTextAlign);
    WriteString(Sec, '2011', P.licKeyPath);
    WriteInteger(Sec, '2012', P.nagDelay);

    WriteString(Sec, '2013', P.MsgExecLimit);
   End;

 If W=True Then Ini.UpdateFile;
 Ini.Free;
End;

{===============================PROCEDURE==================================}

Procedure SetInfo(frm:TfrmMain);
Begin
 With frm Do
  Begin
  eFileName.Text      := Item.FileName;
  eAppName.Text       := Item.AppName;
  eAppVer.Text        := Item.AppVer;
  eHomePage.Text      := Item.HomePage;
  pAllowMsg.Checked    := Item.AllowMsg;
  oSameSize.Checked    := Item.SameSize;
  pStolenRC.Checked    := Item.StolenRC;
  pAntiDebug.Checked   := Item.AntiDebug;
  oAntiDump.Checked    := Item.AntiDump;
  eReqAdminR.Checked   := Item.RequestAdminR;
  eBuyPage.Text       := Item.PurchasePage;
  eExitIfNoKey.Checked:=Item.ExitIfNoKey;
  eEDate.Date:=Item.ExpiredDate;
  If Item.ExpiredDate=0 Then
   begin
    eUseEDate.Checked:=False;
    eEDate.DateTime:=Now;
   end Else eUseEDate.Checked:=True;
  eNAGDlgCaption.Text:=Item.nagDialog;
  eNAGLicCaption.Text:=Item.nagLicenseID;
  eNAGKeyCaption.Text:=Item.nagActivateKey;
  eNAGText.Text:=Item.nagText;
  eNAGHelp.Text:=Item.nagHelp;
  eNAGOK.Text:=Item.nagOK;
  eNAGBuy.Text:=Item.nagBuy;
  oCustomNAG.Checked:=Item.StdNAG;
  eNagUserName.Text:=Item.nagUserName;
  eProjectName.Panels[0].Text:=Item.ProjectFile;


  eUseOneCopy.Checked:=Item.UseOneCopy;
  Case  Item.HwidMode of
   0: eHwidMode1.Checked:=True;
   1: eHwidMode2.Checked:=True;
   2: eHwidMode3.Checked:=True;
  End;

  chkUseDaysLimit.Checked:=Item.UseDayLimit;
  chkUseExecCount.Checked:=Item.UseExecCount;
  seDaysCount.Value:=Item.DayLimit;
  seExecCount.Value:=Item.ExecCount;

  chkDisableCompression.Checked:=Item.DisableCompression;
  chkIncreaseSize.Checked:=Item.IncreaseFileSize;
  UpdatePDCRC;

  nagBackColor.Color:=Item.nagBackColor;
  nagFontColor.Font.Color:=Item.nagFontColor;
  nagFontColor.Color:=nagBackColor.Color;

  If Item.nagTextAlign=1 Then chkTextAlign.Checked:=True
   Else chkTextAlign.Checked:=False;

  edtKeyPath.Text:=Item.licKeyPath;

  chkDelay.OnClick:=nil;
  chkDelay.Checked:=Item.nagDelay>0;
  chkDelay.OnClick:=chkDelayClick;

  chkUseExecLimit.Checked:=Item.UseExecLimit;
  seExecLimit.Value:=Item.ExecLimit;
 End;
End;

{===============================PROCEDURE==================================}

Procedure GetInfo(frm:TfrmMain);
Begin
 With frm Do
  Begin
  Item.FileName      := Trim(eFileName.Text);
  Item.AppName       := Trim(eAppName.Text);
  Item.AppVer        := Trim(eAppVer.Text);
  Item.HomePage      := Trim(eHomePage.Text);

  Item.AllowMsg    := pAllowMsg.Checked;
  Item.SameSize    := oSameSize.Checked;

  Item.StolenRC      := pStolenRC.Checked;
  Item.AntiDebug     := pAntiDebug.Checked;
  Item.AntiDump      := oAntiDump.Checked;
  Item.RequestAdminR := eReqAdminR.Checked;

  Item.PurchasePage       := Trim(eBuyPage.Text);
  Item.ExitIfNoKey:=eExitIfNoKey.Checked;
  Item.ExpiredDate:=0;
  If eUseEDate.Checked=True Then Item.ExpiredDate:=eEDate.Date;

  Item.nagDialog:=Trim(eNAGDlgCaption.Text);
  Item.nagLicenseID:=Trim(eNAGLicCaption.Text);
  Item.nagActivateKey:=Trim(eNAGKeyCaption.Text);
  Item.nagText:=eNAGText.Text;
  Item.nagHelp:=Trim(eNAGHelp.Text);
  Item.nagOK:=Trim(eNAGOK.Text);
  Item.nagBuy:=Trim(eNAGBuy.Text);
  Item.nagUserName:=Trim(eNagUserName.Text);
  Item.StdNAG:=oCustomNAG.Checked;

  Item.UseOneCopy:=eUseOneCopy.Checked;
  If eHwidMode1.Checked Then Item.HwidMode:=0 else
  If eHwidMode2.Checked Then Item.HwidMode:=1 else
  If eHwidMode3.Checked Then Item.HwidMode:=2;

  Item.UseDayLimit:=chkUseDaysLimit.Checked;
  Item.UseExecCount:=chkUseExecCount.Checked;
  Item.DayLimit:=seDaysCount.Value;
  Item.ExecCount:=seExecCount.Value;

  Item.DisableCompression:=chkDisableCompression.Checked;
  Item.IncreaseFileSize:=chkIncreaseSize.Checked;

  Item.nagBackColor:=nagBackColor.Color;
  Item.nagFontColor:=nagFontColor.Font.Color;

  If chkTextAlign.Checked=True Then Item.nagTextAlign:=1
   Else Item.nagTextAlign:=0;

  Item.licKeyPath:=Trim(edtKeyPath.Text);

  Item.UseExecLimit:=chkUseExecLimit.Checked;
  Item.ExecLimit:=seExecLimit.Value;
 End;
End;

{===============================PROCEDURE==================================}

procedure TfrmMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 Timer.Enabled:=False;
 ConfigFile.WriteInteger('Run', 'X', Left);
 ConfigFile.WriteInteger('Run', 'Y', Top);
end;

{===============================PROCEDURE==================================}

Procedure TfrmMain.UpdateUI;
begin
 Application.Title:=ApplicationName;
 Self.Caption:=Application.Title;
 mnuMFile.Caption:=Language.ui(1);
 mnuExit.Caption:=Language.ui(2);
 mnuNewProject.Caption:=Language.ui(3);
 mnuOpenProject.Caption:=Language.ui(4);
 mnuSaveProject.Caption:=Language.ui(5);
 mniSaveprojectas.Caption:=Language.ui(15);

 mnuMHelp.Caption:=Language.ui(6);
 mnuHelp.Caption:=Language.ui(7);
 mnuAbout.Caption:=Language.ui(8);


 btnNew.Hint:=mnuNewProject.Caption;
 btnOpen.Hint:=mnuOpenProject.Caption;
 btnSave.Hint:=mnuSaveProject.Caption;

 panelMenu.Categories[0].Caption:=Language.ui(10);

 With panelMenu.Categories[0] Do
  begin
   Items[0].Caption:=' '+Language.ui(12);
   shGeneral.Caption:=Trim(Items[0].Caption);
   Items[1].Caption:=' '+Language.ui(13);
   shExcl.Caption:=Trim(Items[1].Caption);

   Items[2].Caption:=' '+Language.ui(17);
   Items[3].Caption:=' '+Language.ui(14);
   shLic.Caption:=Trim(Items[2].Caption);
   shBlack.Caption:=Language.ui(162);
  end;

 lblResult.Caption:=Language.ui(197);


 lblInputFile.Caption:=Language.ui(22);
 lblAppNameVer.Caption:=Language.ui(23);
 lblHomePage.Caption:=Language.ui(24);
 lblPurchasePage.Caption:=Language.ui(25);
 oAntiDump.Caption:=Language.ui(31);
 oSameSize.Caption:=Language.ui(32);
 pAllowMsg.Caption:=Language.ui(35);
 pAntiDebug.Caption:=Language.ui(38);
 chkDisableCompression.Caption:=Language.ui(39);
 chkIncreaseSize.Caption:=Language.ui(42);
 pStolenRC.Caption:=Language.ui(41);

 shMsg.Caption:=Language.ui(47);
 eMsgList.Items.Clear;
 With eMsgList.Items.Add(NIL,Language.ui(200)) do
  begin
   ImageIndex:=2;
   Data:=Pointer(0);
  end;

 With eMsgList.Items.Add(NIL,Language.ui(206)) do
  begin
   ImageIndex:=2;
   Data:=Pointer(1);
  end;

 With eMsgList.Items.Add(NIL,Language.ui(201)) do
  begin
   ImageIndex:=2;
   Data:=Pointer(2);
  end;

 With eMsgList.Items.Add(NIL,Language.ui(203)) do
  begin
   ImageIndex:=2;
   Data:=Pointer(3);
  end;

 With eMsgList.Items.Add(NIL,Language.ui(202)) do
  begin
   ImageIndex:=3;
   Data:=Pointer(4);
  end;

 With eMsgList.Items.Add(NIL,Language.ui(207)) do
  begin
   ImageIndex:=3;
   Data:=Pointer(5);
  end;

 With eMsgList.Items.Add(NIL,Language.ui(217)) do
  begin
   ImageIndex:=3;
   Data:=Pointer(6);
  end;


 With eMsgList.Items.Add(NIL,Language.ui(272)) do
  begin
   ImageIndex:=3;
   Data:=Pointer(7);
  end;

 With eMsgList.Items.Add(NIL,Language.ui(273)) do
  begin
   ImageIndex:=3;
   Data:=Pointer(8);
  end;


 With eMsgList.Items.Add(NIL,Language.ui(216)) do
  begin
   ImageIndex:=3;
   Data:=Pointer(9);
  end;


 btnProtect.Caption:=Language.ui(60);
 btnRestore.Caption:=Language.ui(61);
 btnTest.Caption:=Language.ui(62);


 lblPPKey.Caption:=Language.ui(163);
 lblKeyPath.Caption:=Language.ui(79);
 eUseEDate.Caption:=Language.ui(165);
 eExitIfNoKey.Caption:=Language.ui(166);
 lblVersion.Caption:=Language.ui(172);
 chkUseExecLimit.Caption:=Language.ui(215);

 oCustomNAG.Caption:=Language.ui(178);
 lblNagcaption.Caption:=Language.ui(179);
 lblLidcaption.Caption:=Language.ui(180);
 lblActivationKey.Caption:=Language.ui(181);
 lblNagText.Caption:=Language.ui(182);
 lblNagHlp.Caption:=Language.ui(183);
 lblNagOk.Caption:=Language.ui(184);
 lblNagBuy.Caption:=Language.ui(185);



 eBlack.Columns[0].Caption:=ReplaceText(Language.ui(27), ':', '');
 eBlack.Columns[1].Caption:=ReplaceText(Language.ui(48), ':', '');
 eBlack.Columns[2].Caption:=ReplaceText(Language.ui(68), ':', '');

 mnuPopBlackAdd.Caption:=Language.ui(74);
 mnuPopBlackDel.Caption:=Language.ui(76);

 mnuOptions.Caption:=Language.ui(186);
 mnuKG.Caption:=Language.ui(187);
 btnHomePage.Caption:=Language.ui(188);
 btnOrderNow.Caption:=Language.ui(189);
 shNag.Caption:=Language.ui(190);
 eReqAdminR.Caption:=Language.ui(191);
 btnReadVersion.Hint:=Language.ui(194);
 btnSelectFN.Hint:=Language.ui(195);

 HwidGrup.Caption:=Language.ui(209);
 eHwidMode1.Caption:=Language.ui(210);
 eHwidMode2.Caption:=Language.ui(211);
 eHwidMode3.Caption:=Language.ui(212);
 eUseOneCopy.Caption:=Language.ui(214);

 chkUseDaysLimit.Caption:=Language.ui(231);
 chkUseExecCount.Caption:=Language.ui(232);
 chkTextAlign.Caption:=Language.ui(19);
 lblNagUName.Caption:=Language.ui(20);
 chkDelay.Caption:=Language.ui(26);

 tsKG.Caption:='Keygen';
 tvKgMsg.Items.Clear;
 With tvKgMsg.Items.Add(NIL,'User option #1 caption') do
  begin
   ImageIndex:=3;
   Data:=Pointer(0);
  end;
 With tvKgMsg.Items.Add(NIL,'User option #2 caption') do
  begin
   ImageIndex:=3;
   Data:=Pointer(1);
  end;
 With tvKgMsg.Items.Add(NIL,'User option #3 caption') do
  begin
   ImageIndex:=3;
   Data:=Pointer(2);
  end;
 With tvKgMsg.Items.Add(NIL,'User option #4 caption') do
  begin
   ImageIndex:=3;
   Data:=Pointer(3);
  end;
 With tvKgMsg.Items.Add(NIL,'User option #5 caption') do
  begin
   ImageIndex:=3;
   Data:=Pointer(4);
  end;
 With tvKgMsg.Items.Add(NIL,'User option #6 caption') do
  begin
   ImageIndex:=3;
   Data:=Pointer(5);
  end;
 With tvKgMsg.Items.Add(NIL,'User option #7 caption') do
  begin
   ImageIndex:=3;
   Data:=Pointer(6);
  end;
 With tvKgMsg.Items.Add(NIL,'User option #8 caption') do
  begin
   ImageIndex:=3;
   Data:=Pointer(7);
  end;
end;

{===============================PROCEDURE==================================}

procedure TfrmMain.FormCreate(Sender: TObject);
Var
 I : Integer;
 M : TMenuItem;
 Lng : TStringList;
 S : String;
begin
 FillChar(Item,SizeOf(Item),0);

 eProjectName.Panels[1].Text:=''+IntToStr(ProgramVer)+'.'+
                               IntToStr(ProgramSubVer)+ProgramSP;

 Left:=Screen.Width div 2 - Width div 2;
 Top:=Screen.Height div 2 - Height div 2;


 DragAcceptFiles( Handle, True );

 btnNewClick(Sender);


 If ConfigFile.ReadInteger('Run', 'X',0)<>0 Then
  Left:=ConfigFile.ReadInteger('Run', 'X',0);
 If ConfigFile.ReadInteger('Run', 'Y',0)<>0 Then
  Top:=ConfigFile.ReadInteger('Run', 'Y',0);

 If ParamCount=1 Then
  begin
   S:= Trim(ParamStr(1));
   S:=ExpandFileName(S);
  end
 Else S:= ConfigFile.ReadString('Run', 'AutoOpen', '');

 If FileExists(S)=True Then
  begin
   Try
    ReadWriteIni(S,Item,False);
    Item.ProjectFile:=S;
    btnOpenClick(NIL);
   Except
    btnNewClick(Sender);
   End;
  end;


 mnuLng.Clear;
 Lng:=TStringList.Create;
 Language.Names(Lng);
 For I:=0 To Lng.Count-1 Do
  begin
   M:=TMenuItem.Create(mnuLng);
   M.Caption:=Lng[I];
   M.OnClick:=SelectLangClick;
   M.Tag:=I;
   mnuLng.Add(M);
  end;
 Lng.Free;

 FlipPage(0);
 Self.AlphaBlend:=True;
end;

{===============================PROCEDURE==================================}

procedure TfrmMain.TimerTimer(Sender: TObject);
begin
 // exclusive
 eEDate.Enabled:=eUseEDate.Checked;
 eMsgList.Enabled:=pAllowMsg.Checked;
 pnlNag.Enabled:=oCustomNAG.Checked;
 eNAGDlgCaption.Enabled:=oCustomNAG.Checked;
 eNAGLicCaption.Enabled:=oCustomNAG.Checked;
 eNAGKeyCaption.Enabled:=oCustomNAG.Checked;
 eNAGText.Enabled:=oCustomNAG.Checked;
 eNAGHelp.Enabled:=oCustomNAG.Checked;
 eNAGOK.Enabled:=oCustomNAG.Checked;
 eNAGBuy.Enabled:=oCustomNAG.Checked;
 eNagUserName.Enabled:=oCustomNAG.Checked;
 chkDelay.Enabled:=oCustomNAG.Checked;
 chkTextAlign.Enabled:=oCustomNAG.Checked;

 seDaysCount.Enabled:=chkUseDaysLimit.Checked;
 seExecCount.Enabled:=chkUseExecCount.Checked;
 seExecLimit.Enabled:=chkUseExecLimit.Checked;
end;

{===============================PROCEDURE==================================}

procedure TfrmMain.tvKgMsgDblClick(Sender: TObject);
Var
 I : Integer;
begin
 If tvKgMsg.Selected=NIL Then Exit;
 frmCode.eCode.Text:='';
 frmCode.Caption:=tvKgMsg.Selected.Text;

 I:= Integer(tvKgMsg.Selected.Data);

 Case I Of
  0: frmCode.eCode.Text:=Item.kgO1;
  1: frmCode.eCode.Text:=Item.kgO2;
  2: frmCode.eCode.Text:=Item.kgO3;
  3: frmCode.eCode.Text:=Item.kgO4;
  4: frmCode.eCode.Text:=Item.kgO5;
  5: frmCode.eCode.Text:=Item.kgO6;
  6: frmCode.eCode.Text:=Item.kgO7;
  7: frmCode.eCode.Text:=Item.kgO8;
 End;

 If frmCode.ShowModal=mrOK Then
  Begin
   Case I Of
    0: Item.kgO1:=frmCode.eCode.Text;
    1: Item.kgO2:=frmCode.eCode.Text;
    2: Item.kgO3:=frmCode.eCode.Text;
    3: Item.kgO4:=frmCode.eCode.Text;
    4: Item.kgO5:=frmCode.eCode.Text;
    5: Item.kgO6:=frmCode.eCode.Text;
    6: Item.kgO7:=frmCode.eCode.Text;
    7: Item.kgO8:=frmCode.eCode.Text;
   End;
  End;
end;

{===============================PROCEDURE==================================}

Procedure LogText(const T:String);
Begin
 frmMain.eResult.Lines.Add(T);
 Application.ProcessMessages;
End;

{===============================PROCEDURE==================================}

Procedure TfrmMain.FlipPage(Page:Integer);
Var
 P,P2, P3, P4 : TTabSheet;
 I    : Integer;
Begin
 Pages.Visible:=False;
 P:=NIL;
 P2:=NIL;
 P3:=NIL;
 P4:=nil;

 Case Page Of
  0:
   begin
    P:=shGeneral;
   end;
  1:
   Begin
    P:=shExcl;
   End;
  2:
   begin
    P:=shLic;
    P2:=shBlack;
    P3:=tsKG;
   end;
  3:
    begin
     P:=shMsg;
     P2:=shNAG;
    end;
 End;

 If P=NIL Then Exit;

 For I:=0 To Pages.PageCount-1 Do
  If Pages.Pages[I]<>P Then Pages.Pages[I].TabVisible:=False;

 P.TabVisible:=True;
 P.PageIndex:=0;
 P.Refresh;

 If P2<>NIL Then
  begin
   P2.PageIndex:=1;
   P2.TabVisible:=True;
   P2.Refresh;
  end;

 If P3<>NIL Then
  begin
   P3.PageIndex:=2;
   P3.TabVisible:=True;
   P3.Refresh
  end;

 If P4<>NIL Then
  begin
   P4.PageIndex:=3;
   P4.TabVisible:=True;
   P4.Refresh
  end;
 Pages.Visible:=True;
End;

{===============================PROCEDURE==================================}

Procedure TfrmMain.UpdateBlackList;
Var
 B : TStringList;
 I : Integer;
 L : String;
 P1, P2 : Integer;
begin
 eBlack.Clear;
 B:=TStringList.Create;
 B.Text:=Item.BlackList;
 For I:=0 To B.Count-1 Do
  begin
   With eBlack.Items.Add Do
    begin
     Data:=Pointer(I);
     P1:=Pos(black_delim, B[I]);
     P2:=PosEx(black_delim, B[I], P1+1);
     L:=Copy(B[I], 1, P1-1);
     Caption:=Trim(L);
     L:=Copy(B[I], P1+Length(black_delim), P2-(P1+Length(black_delim)));
     SubItems.Add(L);

     L:=Copy(B[I], P2+Length(black_delim), MaxInt);
     SubItems.Add(L);
    end;
  end;
 B.Free;
end;

{===============================PROCEDURE==================================}

procedure TfrmMain.shBlackShow(Sender: TObject);
begin
 UpdateBlackList;
end;

{===============================PROCEDURE==================================}

Procedure TfrmMain.UpdatePDCRC;
Var
 M : TMemoryStream;
begin
 M:=TMemoryStream.Create;
  M.WriteBuffer(Item.PrivateKey[0], Length(Item.PrivateKey));
  M.WriteBuffer(Item.PublicKey[0], Length(Item.PublicKey));
  M.WriteBuffer(Item.PrivateRC4[0], Length(Item.PrivateRC4));
  ePrivateData.Text:='Size: '+IntToStr(M.Size+8*4 {sizes})+
                     ', Signature: '+UIntToStr(ameCrC(M.Memory, M.Size));
 M.Free;
end;

{===============================PROCEDURE==================================}

procedure TfrmMain.btnDelBlackClick(Sender: TObject);
Var
 B : TStringList;
begin
 If eBlack.Selected=nil Then Exit;
 If uiConfirm(Language.ui(55))=False Then Exit;
 B:=TStringList.Create;
 B.Text:=Item.BlackList;
 B.Delete(Integer(eBlack.Selected.Data));
 Item.BlackList:=B.Text;
 B.Free;
 UpdateBlackList;
end;

{===============================PROCEDURE==================================}

procedure TfrmMain.btnNewBlackClick(Sender: TObject);
begin
 With frmNewBlack Do
  begin
   eUField.Clear;
   eReson.Clear;
   eKey.Clear;
   If ShowModal=mrOK Then
    begin
     Item.BlackList:=Item.BlackList+Trim(eUField.Text)+black_delim+
                     Trim(eReson.Text)+black_delim+Trim(eKey.Text)+sLineBreak;
     UpdateBlackList;
    end;
  end;
end;

{===============================PROCEDURE==================================}

procedure TfrmMain.eBlackDblClick(Sender: TObject);
Var
 B : TStringList;
 S : String;
 P1, P2 : Integer;
begin
 If eBlack.Selected=nil Then Exit;
 B:=TStringList.Create;
 B.Text:=Item.BlackList;
 S:= B[Integer(eBlack.Selected.Data)];

 With frmNewBlack Do
  begin
   P1:=Pos(black_delim, S);
   P2:=PosEx(black_delim, S, P1+1);
   eUField.Text:=Copy(S, 1, P1-1);
   eReson.Text:=Copy(S, P1+Length(black_delim), P2-(P1+Length(black_delim)));
   eKey.Text:=Copy(S, P2+Length(black_delim), MaxInt);

   If ShowModal=mrOK Then
    begin
     S:=Trim(eUField.Text)+black_delim+
        Trim(eReson.Text)+black_delim+Trim(eKey.Text);
     B[Integer(eBlack.Selected.Data)]:=S;
     Item.BlackList:=B.Text;
     UpdateBlackList;
    end;
  end;
 B.Free;
end;

{===============================PROCEDURE==================================}

procedure TfrmMain.btnNewClick(Sender: TObject);
begin
 FillChar(Item,SizeOf(Item),0);

 Item.MsgDbg:=Language.ui(84)+sLineBreak+sLineBreak+
              Language.ui(85)+sLineBreak+Language.ui(86);
 Item.MsgCrCfail:='Crc check failed !';
 Item.MsgSKey:=Language.ui(155);
 Item.MsgNotAdmin:=Language.ui(199);
 Item.MsgEDate:=Language.ui(156);
 Item.MsgExecLimit:='Execution time limit !';
 Item.MsgClockMan:='Manipulations with clocks are found !';
 Item.MsgTECount:='Trial period has expired !';
 Item.MsgTDCount:='Trial period has expired !';
 Item.MsgCopyLimit:='Another copy of this application is already started !';

 Item.nagDialog:=Language.ui(147);
 Item.nagLicenseID:=Language.ui(148);
 Item.nagActivateKey:=Language.ui(154);
 Item.nagText:=Language.ui(147);
 Item.nagHelp:=Language.ui(151);
 Item.nagOK:=Language.ui(153);
 Item.nagBuy:=Language.ui(152);
 Item.nagUserName:='User name:';

 Item.AppName:='Default Project';
 Item.AppVer:='1.0.0.0';
 Item.HomePage:='http://software.com';
 Item.PurchasePage:=Item.HomePage+'/buy/';

 Item.AllowMsg:=True;
 eEDate.DateTime:=Now;
 Item.DayLimit:=15;
 Item.ExecCount:=40;

 Item.ExecLimit:=120;
 Item.nagDelay:=10;
 Item.nagBackColor:=$000000;
 Item.nagFontColor:=$FFFFFF;

 btnGenPrivateDClick(Self);
 eResult.Clear;

 SetInfo(Self);
end;

{===============================PROCEDURE==================================}

procedure TfrmMain.btnOpenClick(Sender: TObject);
Var
 S   : String;
 Recent : TStringList;
begin
 If Sender<>NIL Then
  Begin
   S:=uiSelectOpenFile(Path,'',['Private exe Protector [*.pep]|*.pep']);
   If S='' Then Exit;
   ReadWriteIni(S,Item,False);
   Item.ProjectFile:=S;
  End
 Else S:=Item.ProjectFile;

 If Item.MsgDbg='' Then
  Item.MsgDbg:=Language.ui(84)+sLineBreak+sLineBreak+Language.ui(85)+sLineBreak+Language.ui(86);
 If Item.MsgSKey='' Then Item.MsgSKey:=Language.ui(155);
 If Item.MsgEDate='' Then Item.MsgEDate:=Language.ui(156);
 If Item.MsgNotAdmin='' Then Item.MsgNotAdmin:=Language.ui(199);

 FlipPage(0);
 SetInfo(Self);
 ConfigFile.WriteString('Run', 'AutoOpen', S);
 Recent:=TStringList.Create;
 Recent.Text:=br2nl(ConfigFile.ReadString('Run', 'Recent', ''));
 Recent.Add(S);
 DeleteEQLStrings(Recent, True);
 While Recent.Count>10 Do Recent.Delete(Recent.Count-1);
 ConfigFile.WriteString('Run', 'Recent', nl2br(Recent.Text));
 Recent.Free;
end;

{===============================PROCEDURE==================================}

procedure TfrmMain.btnSaveClick(Sender: TObject);
Var
 S:String;
begin
 If Item.ProjectFile='' Then
  Begin
   S:=uiSelectSaveFile(Path,'',['Private exe Protector [*.pep]|*.pep'],'.pep');
   If S='' Then Exit;
   Item.ProjectFile:=S;
  End;
 GetInfo(Self);
 ReadWriteIni(Item.ProjectFile,Item,True);
 eProjectName.Panels[0].Text:=Item.ProjectFile;
end;

{===============================PROCEDURE==================================}

procedure TfrmMain.mniSaveprojectasClick(Sender: TObject);
Var
 S:String;
begin
 S:=uiSelectSaveFile(Path,'',['Private exe Protector [*.pep]|*.pep'],'.pep');
 If S='' Then Exit;
 Item.ProjectFile:=S;
 btnSaveClick(Sender);
end;

{===============================PROCEDURE==================================}

procedure TfrmMain.btnSellAppClick(Sender: TObject);
Var
 S, D: String;
begin
 D:=ExtractFilePath(eFileName.Text);
 D:=Trim(D);
 If DirectoryExists(D, True)=False Then D:=Path;
 S:=uiSelectOpenFile(D, '', [Language.ui(157), Language.ui(205), Language.ui(158)]);
 If S='' Then Exit;
 eFileName.Text:=S;
end;

{===============================PROCEDURE==================================}

procedure TfrmMain.btnAppInfo2Click(Sender: TObject);
begin
 FlipPage(0);
end;

{===============================PROCEDURE==================================}

procedure TfrmMain.btnOptionsClick(Sender: TObject);
begin
 FlipPage(1);
end;

{===============================PROCEDURE==================================}

procedure TfrmMain.btnDialogsClick(Sender: TObject);
begin
 FlipPage(3);
end;

{===============================PROCEDURE==================================}

procedure TfrmMain.btnExportKeyClick(Sender: TObject);
Var
 S : string;
 M : TMemoryStream;
 I : Int64;
begin
 S:=uiSelectSaveFile(Path,Language.ui(275),
                     ['Private exe Protector License Block [*.pepkx]|*.pepkx'],'.pepkx');
 If S='' Then Exit;

 M:=TMemoryStream.Create;
 Try
  I:=Length(Item.PrivateKey);
  M.WriteBuffer(I, SizeOf(I));
  M.WriteBuffer(Item.PrivateKey[0], I);

  I:=Length(Item.PublicKey);
  M.WriteBuffer(I, SizeOf(I));
  M.WriteBuffer(Item.PublicKey[0], I);

  M.SaveToFile(S);
 Finally
  M.Free;
 End;
end;

{===============================PROCEDURE==================================}

procedure TfrmMain.btnGenPrivateDClick(Sender: TObject);
Var
 R : TameRSAHandle;
begin
 R:=rsaNewHandle();
 rsaGenerateKeys(R);
 rsaExportPrivateKey(R, Item.PrivateKey);
 rsaExportPublicKey(R, Item.PublicKey);
 rsaFreeHandle(R);
 rc4key(Item.PrivateRC4, 4096);
 UpdatePDCRC;
end;

{===============================PROCEDURE==================================}

procedure TfrmMain.btnImportKeyClick(Sender: TObject);
Var
 S : string;
 M : TMemoryStream;
 I : Int64;
begin
 S:=uiSelectOpenFile(Path,Language.ui(276),
                     ['Private exe Protector License Block [*.pepkx]|*.pepkx']);
 If S='' Then Exit;

 M:=TMemoryStream.Create;
 Try
  M.LoadFromFile(S);

  M.ReadBuffer(I, SizeOf(I));
  SetLength(Item.PrivateKey, I);
  M.ReadBuffer(Item.PrivateKey[0], I);

  M.ReadBuffer(I, SizeOf(I));
  SetLength(Item.PublicKey, I);
  M.ReadBuffer(Item.PublicKey[0], I);

 Finally
  M.Free;
 End;
 UpdatePDCRC;
end;

{===============================PROCEDURE==================================}

procedure TfrmMain.btnHomePageClick(Sender: TObject);
begin
 ShellExecute(0,'open', PChar('http://www.setisoft.com/?lang=en'),nil,nil,SW_NORMAL);
end;

{===============================PROCEDURE==================================}

procedure TfrmMain.btnProtectClick(Sender: TObject);
begin
 eResult.Clear;
 btnAppInfo2Click(Sender);
 Application.ProcessMessages;
 GetInfo(Self);
 If FileExists(Item.FileName)=False Then
  Begin
   uiError(Language.ui(91)+' '+Item.FileName);
   Exit;
  End;
 btnProtect.Enabled:=False;
 Try
  ProtectFile(Item,LogText);
  try eResult.Lines.SaveToFile(ChangeFileExt(Item.FileName,'.peplog')); except end;
 Finally
  btnProtect.Enabled:=True;
 End;
end;

{===============================PROCEDURE==================================}

function GetVersion(FileName:String): string;
var
 VerInfoSize: DWORD;
 VerInfo: Pointer;
 VerValueSize: DWORD;
 VerValue: PVSFixedFileInfo;
 Dummy: DWORD;
begin
 Result:='0.0.0.0';
 VerInfoSize := GetFileVersionInfoSize(PChar(FileName), Dummy);
 If VerInfoSize = 0 Then Exit;
 GetMem(VerInfo, VerInfoSize);
 Try
  GetFileVersionInfo(PChar(FileName), 0, VerInfoSize, VerInfo);
  VerQueryValue(VerInfo, '\', Pointer(VerValue), VerValueSize);
  with VerValue^ do
  begin
    Result := IntToStr(dwFileVersionMS shr 16);
    Result := Result + '.' + IntToStr(dwFileVersionMS and $FFFF);
    Result := Result + '.' + IntToStr(dwFileVersionLS shr 16);
    Result := Result + '.' + IntToStr(dwFileVersionLS and $FFFF);
  end;
 Except
 End;
 FreeMem(VerInfo, VerInfoSize);
end;

{===============================PROCEDURE==================================}

procedure TfrmMain.btnReadVersionClick(Sender: TObject);
begin
 If FileExists(eFileName.Text)=False Then Exit;
 eAppVer.Text:=GetVersion(eFileName.Text);
end;

{===============================PROCEDURE==================================}

procedure TfrmMain.btnRestoreClick(Sender: TObject);
begin
 GetInfo(Self);
 If FileExists(Item.FileName+'.bak')=True Then
  Begin
   If DeleteFile(Item.FileName)<>True Then
    begin
     LogText(SysErrorMessage(GetLastError));
     Exit;
    end;
   If CopyFile(PChar(Item.FileName+'.bak'),PChar(Item.FileName),False)<>True Then
    begin
     LogText(SysErrorMessage(GetLastError));
     Exit;
    end;
   If DeleteFile(Item.FileName+'.bak')<>True Then
    begin
     LogText(SysErrorMessage(GetLastError));
     Exit;
    end;
   LogText(Language.ui(92)+' '+ExtractFileName(Item.FileName));
   Exit;
  End;
end;

{===============================PROCEDURE==================================}

procedure TfrmMain.btnTestClick(Sender: TObject);
begin
 GetInfo(Self);
 If FileExists(Item.FileName)=True Then
  Begin
   LogText(Language.ui(93)+' '+ExtractFileName(Item.FileName));
   ShellExecute(0,NIL,PChar(Item.FileName),NIL,
                PChar(ExtractFilePath(Item.FileName)),SW_NORMAL);
   Exit;
  End;
end;

{===============================PROCEDURE==================================}

procedure TfrmMain.chkDelayClick(Sender: TObject);
var
 S : string;
begin
 If chkDelay.Checked=False Then
  begin
   Item.nagDelay:=0;
   Exit;
  end;
 S:='5';
 If Item.nagDelay>0 Then S:=IntToStr(Item.nagDelay);
 S:=InputBox('Delay','Value, in seconds:',S);
 Item.nagDelay:=Abs(StrToIntDef(S, 0));
end;

{===============================PROCEDURE==================================}

procedure TfrmMain.chkTextAlignClick(Sender: TObject);
begin
 If chkTextAlign.Checked Then eNAGText.Alignment:=taLeftJustify
  Else eNAGText.Alignment:=taCenter;
end;

{===============================PROCEDURE==================================}

procedure TfrmMain.eMsgListDblClick(Sender: TObject);
Var
 I : Integer;
begin
 If eMsgList.Selected=NIL Then Exit;
 frmCode.eCode.Text:='';
 frmCode.Caption:=eMsgList.Selected.Text;

 I:= Integer(eMsgList.Selected.Data);

 Case I Of
  0: frmCode.eCode.Text:=Item.MsgDbg;       // +
  1: frmCode.eCode.Text:=Item.MsgCrCfail;   // +
  2: frmCode.eCode.Text:=Item.MsgSKey;      // +
  3: frmCode.eCode.Text:=Item.MsgNotAdmin;  // +
  4: frmCode.eCode.Text:=Item.MsgEDate;     // +
  5: frmCode.eCode.Text:=Item.MsgExecLimit; // +
  6: frmCode.eCode.Text:=Item.MsgClockMan;  // +
  7: frmCode.eCode.Text:=Item.MsgTECount;   // +
  8: frmCode.eCode.Text:=Item.MsgTDCount;   // +
  9: frmCode.eCode.Text:=Item.MsgCopyLimit; // +
 End;

 If frmCode.ShowModal=mrOK Then
  Begin
   Case I Of
    0: Item.MsgDbg := frmCode.eCode.Text;       // +
    1: Item.MsgCrCfail := frmCode.eCode.Text;   // +
    2: Item.MsgSKey := frmCode.eCode.Text;      // +
    3: Item.MsgNotAdmin := frmCode.eCode.Text;  // +
    4: Item.MsgEDate := frmCode.eCode.Text;     // +
    5: Item.MsgExecLimit := frmCode.eCode.Text; // +
    6: Item.MsgClockMan := frmCode.eCode.Text;  // +
    7: Item.MsgTECount := frmCode.eCode.Text;   // +
    8: Item.MsgTDCount := frmCode.eCode.Text;   // +
    9: Item.MsgCopyLimit := frmCode.eCode.Text; // +
   End;
  End;
end;

{===============================PROCEDURE==================================}

procedure TfrmMain.eNAGTextChange(Sender: TObject);
begin
 If nlCount(eNAGText.Text)>10 Then eNAGText.ScrollBars:=ssVertical
  Else eNAGText.ScrollBars:=ssNone;
end;

{===============================PROCEDURE==================================}

procedure TfrmMain.btnLicClick(Sender: TObject);
begin
 FlipPage(2);
end;

{===============================PROCEDURE==================================}

procedure TfrmMain.SelectLangClick(Sender: TObject);
Var
 Lng : TuiLanguageFile;
begin
 Lng := TuiLanguageFile(Language.List[(Sender As TMenuItem).Tag]);
 ConfigFile.WriteString('Run','Language', Lng.IdName);
 Language.Select(Lng);
 UpdateUI;
end;

{===============================PROCEDURE==================================}

procedure TfrmMain.Exit1Click(Sender: TObject);
begin
 Close;
end;

{===============================PROCEDURE==================================}

procedure TfrmMain.mnuAboutClick(Sender: TObject);
begin
 {%CUT-BEGIN%}
 uiAbout();
 {%CUT-END%}
end;


{===============================PROCEDURE==================================}

procedure TfrmMain.Help2Click(Sender: TObject);
begin
 ShellExecute(0,'open',PChar(Path+fnHelp_en),NIL,nil,SW_NORMAL);
end;

{===============================PROCEDURE==================================}

procedure TfrmMain.btnOrderNowClick(Sender: TObject);
begin

end;

{===============================PROCEDURE==================================}

procedure TfrmMain.mnuNewProjectClick(Sender: TObject);
begin
 btnNewClick(Sender);
end;

{===============================PROCEDURE==================================}

procedure TfrmMain.mnuOpenProjectClick(Sender: TObject);
begin
 btnOpenClick(Sender);
end;

{===============================PROCEDURE==================================}

procedure TfrmMain.mnuSaveProjectClick(Sender: TObject);
begin
 btnSaveClick(Sender);
end;

{===============================PROCEDURE==================================}

procedure TfrmMain.nagBackColorClick(Sender: TObject);
begin
 GetInfo(Self);
 dlgColor.Color:=Item.nagBackColor;
 If dlgColor.Execute=False Then Exit;
 Item.nagBackColor:=dlgColor.Color;
 nagBackColor.Color:=Item.nagBackColor;
 nagFontColor.Color:=nagBackColor.Color;
end;

{===============================PROCEDURE==================================}

procedure TfrmMain.nagFontColorClick(Sender: TObject);
begin
 GetInfo(Self);
 dlgColor.Color:=Item.nagFontColor;
 If dlgColor.Execute=False Then Exit;
 Item.nagFontColor:=dlgColor.Color;
 nagFontColor.Font.Color:=Item.nagFontColor;
end;

{===============================PROCEDURE==================================}

procedure TfrmMain.recentPopPopup(Sender: TObject);
Label EEE;
Var
 Recent : TStringList;
 I      : Integer;
 M      : TMenuItem;
begin
 recentPop.Items.Clear;
 Recent:=TStringList.Create;
 Recent.Text:=br2nl(ConfigFile.ReadString('Run','Recent', ''));
 If Recent.Count=0 Then Goto EEE;
 Recent.Sort;
 DeleteEQLStrings(Recent);
 For I:=0 To Recent.Count-1 Do
  begin
   If FileExists(Recent[I])=False Then Continue;
   M:=TMenuItem.Create(recentPop);
   M.Caption:=ExtractFileName(Recent[I]);
   M.Hint:=Recent[I];
   M.OnClick:=recentMenuClick;
   recentPop.Items.Add(M);
  end;
EEE:  
 Recent.Free;
end;

{===============================PROCEDURE==================================}

procedure TfrmMain.recentMenuClick(Sender: TObject);
Var
 S: String;
begin
 If (Sender is TMenuItem)=False Then Exit;
 S:=TMenuItem(Sender).Hint;
 If FileExists(S)=False Then Exit;
 ReadWriteIni(S,Item,False);
 Item.ProjectFile:=S;
 btnOpenClick(NIL);
end;

{===============================PROCEDURE==================================}





 

end.

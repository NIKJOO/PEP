unit BlackUnit;

interface

uses
  Classes, Controls, Forms, StdCtrls, Buttons;

type
  TfrmNewBlack = class(TForm)
    lblUField: TLabel;
    eUField: TEdit;
    eReson: TEdit;
    lblReson: TLabel;
    lblAKey: TLabel;
    eKey: TMemo;
    btnOK: TBitBtn;
    btnCancel: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmNewBlack: TfrmNewBlack;

implementation
Uses HandleUnit;

{$R *.dfm}

{===============================PROCEDURE==================================}

procedure TfrmNewBlack.btnCancelClick(Sender: TObject);
begin
 ModalResult:=mrCancel;
end;

{===============================PROCEDURE==================================}

procedure TfrmNewBlack.btnOKClick(Sender: TObject);
begin
 ModalResult:=mrOK;
end;

{===============================PROCEDURE==================================}

procedure TfrmNewBlack.FormCreate(Sender: TObject);
begin
 Caption:=Language.ui(65);
 lblUField.Caption:=Language.ui(27);
 lblReson.Caption:=Language.ui(48);
 lblAKey.Caption:=Language.ui(68);
 btnOK.Caption:=Language.ui(49);
 btnCancel.Caption:=Language.ui(52);
end;

{===============================PROCEDURE==================================}

end.

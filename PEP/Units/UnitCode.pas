unit UnitCode;

interface

uses
  Classes, Controls, Forms, StdCtrls, Buttons;

type
  TfrmCode = class(TForm)
    eCode: TMemo;
    btnOK: TBitBtn;
    btnCancel: TBitBtn;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }

  end;

var
  frmCode: TfrmCode;





implementation
Uses HandleUnit;

{$R *.dfm}


{===============================PROCEDURE==================================}

procedure TfrmCode.FormCreate(Sender: TObject);
begin
 Caption:=Language.ui(33);
 btnOK.Caption:=Language.ui(49);
 btnCancel.Caption:=Language.ui(52);
end;

{===============================PROCEDURE==================================}

end.

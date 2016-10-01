unit PoiskForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RzButton, StdCtrls, Mask, RzEdit, ExtCtrls, RzPanel, RzRadGrp;

type
  TFrmPoisk = class(TForm)
    rgPoisk: TRzRadioGroup;
    edtPoisk: TRzEdit;
    BtnOk: TRzBitBtn;
    BtnCancel: TRzBitBtn;
    procedure BtnCancelClick(Sender: TObject);
    procedure BtnOkClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmPoisk: TFrmPoisk;

implementation

{$R *.dfm}

procedure TFrmPoisk.BtnCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmPoisk.BtnOkClick(Sender: TObject);
begin
  Close;
end;

end.

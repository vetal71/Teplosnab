unit UpUsersForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RzButton, StdCtrls, Mask, RzEdit, RzDBEdit, RzLabel, ExtCtrls,
  RzPanel;

type
  TFrmUpUsers = class(TForm)
    pnlMain: TRzPanel;
    RzLabel1: TRzLabel;
    RzLabel2: TRzLabel;
    RzLabel3: TRzLabel;
    RzPanel2: TRzPanel;
    BtnOk: TRzBitBtn;
    BtnCancel: TRzBitBtn;
    edtConfirm: TRzEdit;
    edtPassword: TRzEdit;
    edtUsers: TRzEdit;
    procedure FormShow(Sender: TObject);
    procedure BtnCancelClick(Sender: TObject);
    procedure BtnOkClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmUpUsers: TFrmUpUsers;

implementation

uses DataModule, MainForm;

{$R *.dfm}

procedure TFrmUpUsers.FormShow(Sender: TObject);
begin
  if FrmMain.CurRec = 1 then
  begin
    edtUsers.Text:=dm.qryUsers['name'];
    RzLabel3.Caption:='Новый пароль';
  end
  else
  begin
    edtPassword.Clear;
    edtConfirm.Clear;
  end;
end;

procedure TFrmUpUsers.BtnCancelClick(Sender: TObject);
begin
  FrmMain.CurRec1:=2;
  Close
end;

procedure TFrmUpUsers.BtnOkClick(Sender: TObject);
begin
  FrmMain.CurRec1:=1;
  Close
end;

end.

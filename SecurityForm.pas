unit SecurityForm;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls, 
  Buttons, RzButton, Mask, RzEdit, Animate, GIFCtrl, RzLabel, DBCtrls,
  RzDBCmbo, Dialogs, rxAnimate, rxGIFCtrl;

type
  TPasswordDlg = class(TForm)
    lcbUsers: TRzDBLookupComboBox;
    RzLabel1: TRzLabel;
    RxGIFAnimator1: TRxGIFAnimator;
    RzLabel2: TRzLabel;
    edtPassword: TRzEdit;
    RzBitBtn1: TRzBitBtn;
    RzBitBtn2: TRzBitBtn;
    procedure FormShow(Sender: TObject);
    procedure RzBitBtn1Click(Sender: TObject);
    procedure RzBitBtn2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  PasswordDlg: TPasswordDlg;

implementation

uses DataModule, ADODB;

{$R *.dfm}

procedure TPasswordDlg.FormShow(Sender: TObject);
begin
  with DM.qryUsers do
  begin
    if Not Active then
    try
      Open;
    except
      ShowMessage('Подключение к серверу утеряно...');
    end;
  end;    
end;

procedure TPasswordDlg.RzBitBtn1Click(Sender: TObject);
begin
  if (lcbUsers.Text='') or
     (edtPassword.Text='') then
    ShowMessage('Не заполнены параметры авторизации...')
  else Close;
end;

procedure TPasswordDlg.RzBitBtn2Click(Sender: TObject);
begin
  Close;
end;

procedure TPasswordDlg.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if (lcbUsers.Text='') or (edtPassword.Text='') then
  begin
    lcbUsers.KeyValue:=-1;
    edtPassword.Text:='';
  end;  
end;

end.
 

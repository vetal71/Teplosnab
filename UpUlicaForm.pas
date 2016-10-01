unit UpUlicaForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RzCommon, RzDBLook, RzDBBnEd, StdCtrls, Mask, RzEdit, RzDBEdit,
  RzButton, DBCtrls, RzDBCmbo, RzLabel, ExtCtrls, RzPanel;

type
  TFrmUpUlica = class(TForm)
    pnlMain: TRzPanel;
    RzLabel1: TRzLabel;
    RzLabel14: TRzLabel;
    lcbKoteln: TRzDBLookupComboBox;
    RzPanel2: TRzPanel;
    BtnOk: TRzBitBtn;
    BtnCancel: TRzBitBtn;
    edtNazv: TRzDBEdit;
    edtKodkot: TRzDBButtonEdit;
    dlgKoteln: TRzDBLookupDialog;
    procedure edtKodkotButtonClick(Sender: TObject);
    procedure edtKodkotChange(Sender: TObject);
    procedure BtnCancelClick(Sender: TObject);
    procedure BtnOkClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmUpUlica: TFrmUpUlica;

implementation

uses DataModule, MainForm;

{$R *.dfm}

procedure TFrmUpUlica.edtKodkotButtonClick(Sender: TObject);
begin
  dlgKoteln.Execute;
end;

procedure TFrmUpUlica.edtKodkotChange(Sender: TObject);
begin
  with dm.qryKoteln do
  begin
    if Not Active then
    try
      Open;
    except
      ShowMessage('Не удалось открыть таблицу "Участки"');
    end;
    Locate('kodkot',edtKodkot.Text,[]);
    lcbKoteln.KeyValue:=dm.qryKotelnkodkot.Value;
  end;
end;

procedure TFrmUpUlica.BtnCancelClick(Sender: TObject);
begin
  dm.qryUlic.Cancel;
  close;
end;

procedure TFrmUpUlica.BtnOkClick(Sender: TObject);
begin
  if Application.MessageBox('Сохранить изменения ?',
  'Предупреждение',mb_YesNo or mb_TaskModal or mb_IconQuestion)=idYes then
  begin
    with dm.qryUlic do
    begin
      try
        Post;
        Refresh;
      except
        ShowMessage('Не удалось сохранить изменения...');
      end;
    end;
  end
  else dm.qryUlic.Cancel;
  Close;
end;

end.

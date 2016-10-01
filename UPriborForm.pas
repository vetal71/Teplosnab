unit UPriborForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RzButton, DBCtrls, RzDBCmbo, StdCtrls, Mask, RzEdit, RzLabel,
  ExtCtrls, RzPanel, RzDBEdit, RzDBBnEd, RzCommon, RzDBLook, RzRadChk,
  RzDBChk, RzRadGrp, RzDBRGrp, DB;

type
  TFrmUPribor = class(TForm)
    pnlMain: TRzPanel;
    RzLabel1: TRzLabel;
    RzLabel15: TRzLabel;
    RzPanel2: TRzPanel;
    BtnOk: TRzBitBtn;
    BtnCancel: TRzBitBtn;
    dlgSearchOrg: TRzDBLookupDialog;
    edtKodOrg: TRzDBButtonEdit;
    edtNazv: TRzDBEdit;
    RzLabel2: TRzLabel;
    edtKoteln: TRzDBButtonEdit;
    dlgSearchKot: TRzDBLookupDialog;
    RzDBRadioGroup1: TRzDBRadioGroup;
    RzDBRadioGroup2: TRzDBRadioGroup;
    edtOrg: TRzEdit;
    edtKot: TRzEdit;
    procedure edtKodOrgButtonClick(Sender: TObject);
    procedure edtKodOrgChange(Sender: TObject);
    procedure edtKotelnButtonClick(Sender: TObject);
    procedure edtKotelnChange(Sender: TObject);
    procedure BtnCancelClick(Sender: TObject);
    procedure BtnOkClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmUPribor: TFrmUPribor;

implementation

uses DataModule, MainForm;

{$R *.dfm}

procedure TFrmUPribor.edtKodOrgButtonClick(Sender: TObject);
begin
  dlgSearchOrg.Execute;
end;

procedure TFrmUPribor.edtKodOrgChange(Sender: TObject);
begin
  with dm.qryOrg do
  begin
    if Not Active then
    try
      Open;
    except
      ShowMessage('Не удалось открыть таблицу "Организации"');
    end;
    Locate('kodorg',edtKodOrg.Text,[]);
    edtOrg.Text:=dm.qryOrgnazv.Value;
  end;
end;

procedure TFrmUPribor.edtKotelnButtonClick(Sender: TObject);
begin
  dlgSearchKot.Execute;
end;

procedure TFrmUPribor.edtKotelnChange(Sender: TObject);
begin
  with dm.qryKoteln do
  begin
    if Not Active then
    try
      Open;
    except
      ShowMessage('Не удалось открыть таблицу "Производственные участки"');
    end;
    Locate('kodkot',edtKoteln.Text,[]);
    edtKot.Text:=dm.qryKotelnnazk.AsString;
  end;
end;

procedure TFrmUPribor.BtnCancelClick(Sender: TObject);
begin
  dm.qryPribor.Cancel;
  close;
end;

procedure TFrmUPribor.BtnOkClick(Sender: TObject);
begin
  if Application.MessageBox('Сохранить изменения ?',
  'Предупреждение',mb_YesNo or mb_TaskModal or mb_IconQuestion)=idYes then
  begin
    with dm.qryPribor do
    begin
      try
        Post;
        Refresh;
      except
        ShowMessage('Не удалось сохранить изменения...');
      end;
    end;
  end
  else dm.qryPribor.Cancel;
  Close;
end;

procedure TFrmUPribor.FormShow(Sender: TObject);
begin
  if dm.qryPribor.State = dsInsert then
    Caption:='Новый прибор учета'
  else
    Caption:='Прибор учета:'+dm.qryPribornazp.Value;
end;

procedure TFrmUPribor.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  dm.qryPribor.Cancel;
end;

end.

unit ParamsFrame;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, RzCommon, RzDBLook, RzDBBnEd, RzDBEdit, RzEdit, StdCtrls, Mask,
  RzTabs, ExtCtrls, RzPanel, RzLabel, RzButton, Db, RzCmboBx, RzDBCmbo,
  Str_fun;

type
  TFmeParams = class(TFrame)
    RzLabel9: TRzLabel;
    pnlMain: TRzPanel;
    pcMain: TRzPageControl;
    TabOrg: TRzTabSheet;
    RzLabel3: TRzLabel;
    edtNazvOrg: TRzDBEdit;
    RzLabel4: TRzLabel;
    edtKodBank: TRzDBButtonEdit;
    dlgBank: TRzDBLookupDialog;
    edtNazvBank: TRzEdit;
    RzLabel5: TRzLabel;
    edtRSchet: TRzDBEdit;
    RzLabel6: TRzLabel;
    edtUnn: TRzDBEdit;
    RzLabel7: TRzLabel;
    edtAdresOrg: TRzDBEdit;
    RzLabel8: TRzLabel;
    edtDolgnChif: TRzDBEdit;
    edtFioChif: TRzDBEdit;
    RzLabel10: TRzLabel;
    edtDolgnBux: TRzDBEdit;
    edtFioBux: TRzDBEdit;
    RzLabel11: TRzLabel;
    RzLabel12: TRzLabel;
    edtDolgnIsp1: TRzDBEdit;
    edtFioIsp1: TRzDBEdit;
    RzLabel13: TRzLabel;
    edtDolgnIsp2: TRzDBEdit;
    edtFioIsp2: TRzDBEdit;
    RzPanel2: TRzPanel;
    BtnOk: TRzBitBtn;
    BtnCancel: TRzBitBtn;
    RzLabel14: TRzLabel;
    edtTelOrg: TRzDBEdit;
    RzLabel15: TRzLabel;
    RzLabel16: TRzLabel;
    edtTelIsp: TRzDBEdit;
    procedure edtKodBankChange(Sender: TObject);
    procedure BtnCancelClick(Sender: TObject);
    procedure BtnOkClick(Sender: TObject);
    procedure edtKodBankButtonClick(Sender: TObject);
    procedure FrameEnter(Sender: TObject);
  private

  public
    procedure Init;
  end;

implementation

uses DataModule, MainForm;

{$R *.dfm}

{ TFmeParams }

procedure TFmeParams.Init;
begin
  with dm.qryParamOrg do
  begin
    if Active then Close;
    try
      Open;
      if RecordCount<>0 then
        dm.qryParamOrg.Edit
      else
        dm.qryParamOrg.Insert;
    except
      ShowMessage('Не удалось открыть таблицу "Параметры организации...');
    end;
  end;
end;

procedure TFmeParams.edtKodBankChange(Sender: TObject);
begin
  with dm.qryBank do
  begin
    if Active then Close;
    try
      Open;
      Locate('kod_bank',edtKodBank.Text,[]);
      edtNazvBank.Text:=dm.qryBank['nazv_bank'];
    except
      ShowMessage('Не удалось открыть таблицу "Банки...');
    end;
  end;
end;

procedure TFmeParams.BtnCancelClick(Sender: TObject);
begin
  dm.qryParamOrg.Cancel;
  FrmMain.pgcWork.ActivePage:=frmMain.TabWelcome;
end;

procedure TFmeParams.BtnOkClick(Sender: TObject);
begin
  if TabOrg.Visible then
  begin
    dm.qryParamOrg.Post;
    dm.qryParamOrg.Refresh;
  end;
  FrmMain.pgcWork.ActivePage:=frmMain.TabWelcome;
end;

procedure TFmeParams.edtKodBankButtonClick(Sender: TObject);
begin
  dlgBank.Execute;
end;

procedure TFmeParams.FrameEnter(Sender: TObject);
begin
  Init;
end;

end.

unit EditNacOrgForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RzButton, DBAccess, MSAccess, StdCtrls, Mask, RzEdit, RzLabel,
  ExtCtrls, RzPanel;
  
type
  TFrmEditNacOrg = class(TForm)
    pnlMain: TRzPanel;
    RzLabel3: TRzLabel;
    RzLabel7: TRzLabel;
    RzLabel1: TRzLabel;
    RzLabel2: TRzLabel;
    RzLabel4: TRzLabel;
    neGkt: TRzNumericEdit;
    neGkv: TRzNumericEdit;
    edtName: TRzEdit;
    UpPokPrib: TMSSQL;
    RzPanel2: TRzPanel;
    BtnOk: TRzBitBtn;
    BtnCancel: TRzBitBtn;
    procedure FormShow(Sender: TObject);
    procedure BtnCancelClick(Sender: TObject);
    procedure BtnOkClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmEditNacOrg: TFrmEditNacOrg;

implementation

uses DataModule, MainForm;

{$R *.dfm}

procedure TFrmEditNacOrg.FormShow(Sender: TObject);
begin
  with dm do
  begin
    edtName.Text:=qryRezCalcObkOtnzv_obk.Value;
    neGkt.Value:=qryRezCalcObkOts_gkt.Value;
    neGkv.Value:=qryRezCalcObkOts_gkv.Value;
  end;
end;

procedure TFrmEditNacOrg.BtnCancelClick(Sender: TObject);
begin
  FrmMain.MR:=2;
  // Close
end;

procedure TFrmEditNacOrg.BtnOkClick(Sender: TObject);
begin
  with UpPokPrib do
  begin
    ParamByName('kod').AsInteger:=dm.qryRezCalcObkOtkodobk.Value;
    ParamByName('data').AsDate:=StrToDate(FrmMain.WorkDate);
    ParamByName('gkt').AsFloat:=neGkt.Value;
    ParamByName('gkv').AsFloat:=neGkv.Value;
    try
      Execute;
      FrmMain.MR:=1;
    except
      ShowMessage('Не удалось обновить начисление...');
    end;
  end;
  // Close;
end;

end.

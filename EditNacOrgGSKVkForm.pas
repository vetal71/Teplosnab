unit EditNacOrgGSKVkForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RzButton, DBAccess, MSAccess, StdCtrls, Mask, RzEdit, RzLabel,
  ExtCtrls, RzPanel;
  
type
  TFrmEditNacOrgGSKVk = class(TForm)
    pnlMain: TRzPanel;
    RzLabel1: TRzLabel;
    edtName: TRzEdit;
    UpPokPrib: TMSSQL;
    RzPanel2: TRzPanel;
    BtnOk: TRzBitBtn;
    BtnCancel: TRzBitBtn;
    RzGroupBox1: TRzGroupBox;
    RzLabel3: TRzLabel;
    neGkt: TRzNumericEdit;
    RzLabel2: TRzLabel;
    RzLabel5: TRzLabel;
    neLgkt: TRzNumericEdit;
    RzLabel6: TRzLabel;
    RzLabel8: TRzLabel;
    neSv: TRzNumericEdit;
    RzLabel9: TRzLabel;
    RzLabel10: TRzLabel;
    neLsv: TRzNumericEdit;
    RzLabel11: TRzLabel;
    RzGroupBox2: TRzGroupBox;
    RzLabel7: TRzLabel;
    neGkv: TRzNumericEdit;
    RzLabel4: TRzLabel;
    RzLabel12: TRzLabel;
    neLgkv: TRzNumericEdit;
    RzLabel13: TRzLabel;
    RzLabel14: TRzLabel;
    neSk: TRzNumericEdit;
    RzLabel15: TRzLabel;
    RzLabel16: TRzLabel;
    neLsk: TRzNumericEdit;
    RzLabel17: TRzLabel;
    procedure FormShow(Sender: TObject);
    procedure BtnCancelClick(Sender: TObject);
    procedure BtnOkClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmEditNacOrgGSKVk: TFrmEditNacOrgGSKVk;

implementation

uses DataModule, MainForm;

{$R *.dfm}

procedure TFrmEditNacOrgGSKVk.FormShow(Sender: TObject);
begin
  with dm do
  begin
    edtName.Text:=qryRezCalcObkVknzv_obk.Value;
    neGkt.Value:=qryRezCalcObkVks_kybv.Value;
    neLgkt.Value := qryRezCalcObkVks_lkybv.Value;
    neSv.Value := qryRezCalcObkVks_symh.Value;
    neLsv.Value := qryRezCalcObkVks_lsymh.Value;

    neGkv.Value:=qryRezCalcObkVks_kybk.Value;
    neLgkv.Value := qryRezCalcObkVks_lkybk.Value;
    neSk.Value := qryRezCalcObkVks_symkk.Value;
    neLsk.Value := qryRezCalcObkVks_lsymkk.Value;
  end;
end;

procedure TFrmEditNacOrgGSKVk.BtnCancelClick(Sender: TObject);
begin
  FrmMain.MR:=2;
end;

procedure TFrmEditNacOrgGSKVk.BtnOkClick(Sender: TObject);
begin
  with UpPokPrib do
  begin
    ParamByName('kod').AsInteger:=dm.qryRezCalcObkVkkodobk.Value;
    ParamByName('data').AsDate:=StrToDate(FrmMain.WorkDate);
    ParamByName('kybv').AsFloat  := neGkt.Value;
    ParamByName('lkybv').AsFloat := neLGkt.Value;
    ParamByName('symh').AsFloat  := neSv.Value;
    ParamByName('lsymh').AsFloat := neLsv.Value;
    ParamByName('kybk').AsFloat  := neGkv.Value;
    ParamByName('lkybk').AsFloat := neLGkt.Value;
    ParamByName('symkk').AsFloat := neSk.Value;
    ParamByName('lsymkk').AsFloat:= neLsk.Value;
    try
      Execute;
      FrmMain.MR:=1;
    except
      ShowMessage('Не удалось обновить начисление...');
    end;
  end;
end;

end.

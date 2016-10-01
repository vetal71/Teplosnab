unit CalcBanForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DateUtils, RzButton, DBAccess, MSAccess, RzPanel, StdCtrls,
  Mask, RzEdit, RzDBLbl, RzLabel, ExtCtrls, Math;
  
type
  TFrmCalcBan = class(TForm)
    RzPanel1: TRzPanel;
    RzLabel8: TRzLabel;
    RzLabel7: TRzLabel;
    RzDBLabel1: TRzDBLabel;
    RzLabel2: TRzLabel;
    neItog: TRzNumericEdit;
    neQgv: TRzNumericEdit;
    RzGroupBox2: TRzGroupBox;
    RzLabel1: TRzLabel;
    RzLabel3: TRzLabel;
    RzLabel4: TRzLabel;
    neTemp: TRzNumericEdit;
    neKdg: TRzNumericEdit;
    neKcg: TRzNumericEdit;
    MQuery: TMSSQL;
    RzPanel2: TRzPanel;
    BtnOk: TRzBitBtn;
    BtnCancel: TRzBitBtn;
    procedure FormShow(Sender: TObject);
    procedure neKdgChange(Sender: TObject);
    procedure BtnCancelClick(Sender: TObject);
    procedure BtnOkClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmCalcBan: TFrmCalcBan;

implementation

uses DataModule, MainForm;

{$R *.dfm}

procedure TFrmCalcBan.FormShow(Sender: TObject);
begin
  if FrmMain.CurRec1=1 then
  RzDBLabel1.DataSource:=dm.dsRezCalcObkOt;
  neKdg.Value:=0;
  neKcg.Value:=9;
  if (MonthOf(StrToDate(FrmMain.WorkDate))<5) or
  (MonthOf(StrToDate(FrmMain.WorkDate))>9) then
    neQgv.Value:=310290
  else neQgv.Value:=251549; 
end;

procedure TFrmCalcBan.neKdgChange(Sender: TObject);
begin
  neItog.Value:=RoundTo(neQgv.Value/50*neTemp.Value*neKdg.Value*neKcg.Value/
  1000000,-2);
end;

procedure TFrmCalcBan.BtnCancelClick(Sender: TObject);
begin
  FrmMain.MR:=2;
  Close
end;

procedure TFrmCalcBan.BtnOkClick(Sender: TObject);
begin
  with MQuery do
  begin
    SQL.Clear;
    SQL.Add('UPDATE dataobekt SET gkv=:gkv, dgv=:dgv, sv=1 WHERE kodobk=:kodobk and '+
    'datan = :data');
    try
      if FrmMain.CurRec1=0 then
      ParamByName('kodobk').AsInteger:=dm.qryRezCalcObkkodobk.Value
      else
      ParamByName('kodobk').AsInteger:=dm.qryRezCalcObkOtkodobk.Value;
      ParamByName('gkv').AsFloat:=neItog.Value;
      ParamByName('dgv').AsFloat:=neKdg.Value;
      ParamByName('data').AsDate:=StrToDate(FrmMain.WorkDate);
      Execute;
      FrmMain.MR:=1;
    except
      ShowMessage('Не удалось сохранить данные...');
    end;
  end;
  Close;
end;

end.

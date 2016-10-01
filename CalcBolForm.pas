unit CalcBolForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RzButton, RzPanel, StdCtrls, Mask, RzEdit, RzDBLbl, RzLabel,
  ExtCtrls, DBAccess, MSAccess, DateUtils, Math;
  
type
  TFrmCalcBol = class(TForm)
    MQuery: TMSSQL;
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
  FrmCalcBol: TFrmCalcBol;

implementation

uses DataModule, MainForm;

{$R *.dfm}

procedure TFrmCalcBol.FormShow(Sender: TObject);
begin
  if FrmMain.CurRec1=1 then
  RzDBLabel1.DataSource:=dm.dsRezCalcObkOt;
  neKdg.Value:=0;
  neKcg.Value:=9;
  if (MonthOf(StrToDate(FrmMain.WorkDate))<5) or
  (MonthOf(StrToDate(FrmMain.WorkDate))>9) then
    neQgv.Value:=165153
  else neQgv.Value:=129361;
end;

procedure TFrmCalcBol.neKdgChange(Sender: TObject);
begin
  neItog.Value:=RoundTo(neQgv.Value/50*neTemp.Value*neKdg.Value*neKcg.Value/
  1000000,-2);
end;

procedure TFrmCalcBol.BtnCancelClick(Sender: TObject);
begin
  FrmMain.MR:=2;
  Close
end;

procedure TFrmCalcBol.BtnOkClick(Sender: TObject);
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

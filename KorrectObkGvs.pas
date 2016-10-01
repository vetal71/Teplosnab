unit KorrectObkGvs;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RzDBEdit, RzPanel, DBAccess, MSAccess, RzButton, StdCtrls, Mask,
  RzEdit, RzDBLbl, RzLabel, ExtCtrls, Math;

type
  TFrmKorrectObkGvs = class(TForm)
    RzPanel1: TRzPanel;
    RzLabel8: TRzLabel;
    RzLabel7: TRzLabel;
    RzDBLabel1: TRzDBLabel;
    neItog: TRzNumericEdit;
    RzPanel2: TRzPanel;
    BtnOk: TRzBitBtn;
    BtnCancel: TRzBitBtn;
    MQuery: TMSSQL;
    RzLabel2: TRzLabel;
    nePrj: TRzNumericEdit;
    RzGroupBox2: TRzGroupBox;
    RzLabel1: TRzLabel;
    RzLabel3: TRzLabel;
    RzLabel10: TRzLabel;
    RzLabel11: TRzLabel;
    RzLabel4: TRzLabel;
    neTemp: TRzNumericEdit;
    neKdg: TRzNumericEdit;
    neKcg: TRzNumericEdit;
    neNgv: TRzNumericEdit;
    neNormativ_Gv: TRzNumericEdit;
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
  FrmKorrectObkGvs: TFrmKorrectObkGvs;

implementation

uses DataModule, MainForm;

{$R *.dfm}

procedure TFrmKorrectObkGvs.FormShow(Sender: TObject);
begin
  if FrmMain.CurRec1=0 then
  begin
    with dm.qryOrg do
    begin
      if Active then Close;
      try
        Open;
        Locate('kodorg',dm.qryRezCalcObk['kodorg'],[]);
      except
        exit;
      end;
    end;
    with dm.qryObekt do
    begin
      if Active then Close;
      try
        Open;
        Locate('kodobk',dm.qryRezCalcObk['kodobk'],[]);
        nePrj.Value:=dm.qryObektprj.Value+dm.qryObektprjl.Value;
      except
        exit;
      end;
    end;
    neKdg.Value:=dm.qryCalcKotKDG.Value;
    neKcg.Value:=dm.qryCalcKotKCG.Value;
    neNgv.Value:=dm.qryCalcKotN_GV.Value;
    neNormativ_gv.Value:=dm.qryCalcKotNORMATIV_GV.Value;
  end
  else
  begin
    RzDBLabel1.DataSource:=dm.dsRezCalcObkOt;
    with dm.qryOrg do
    begin
      if Active then Close;
      try
        Open;
        Locate('kodorg',dm.qryRezCalcObkOt['kodorg'],[]);
      except
        exit;
      end;
    end;
    with dm.qryObekt do
    begin
      if Active then Close;
      try
        Open;
        Locate('kodobk',dm.qryRezCalcObkOt['kodobk'],[]);
        nePrj.Value:=dm.qryObektprj.Value+dm.qryObektprjl.Value;
      except
        exit;
      end;
    end;
  end;
end;

procedure TFrmKorrectObkGvs.neKdgChange(Sender: TObject);
begin
  {Расчет Гкал}
  neItog.Value:=RoundTo(nePrj.Value*neNgv.Value/1000*neKdg.Value*
  (neNormativ_Gv.Value/50*neTemp.Value),-2);
end;

procedure TFrmKorrectObkGvs.BtnCancelClick(Sender: TObject);
begin
  FrmMain.MR:=2;
  Close
end;

procedure TFrmKorrectObkGvs.BtnOkClick(Sender: TObject);
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

unit PredoplataFrame;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, Str_fun, TBXExtItems, TB2ExtItems, DB, DBAccess, MSAccess,
  MemDS, Grids, DBGridEh, ExtCtrls, RzPanel, StdCtrls, RzCmboBx, TB2Item,
  TBX, TB2Dock, TB2Toolbar, RzLabel, GridsEh, DBGridEhGrouping;

type
  TFrmPredoplata = class(TFrame)
    lblCaption: TRzLabel;
    TBXDock1: TTBXDock;
    TBXToolbar2: TTBXToolbar;
    Filter: TTBXItem;
    TBXSeparatorItem6: TTBXSeparatorItem;
    TBControlItem1: TTBControlItem;
    TBXSeparatorItem4: TTBXSeparatorItem;
    DelFilter: TTBXItem;
    cboTipOrg: TRzComboBox;
    TBXItem1: TTBXItem;
    RzPanel1: TRzPanel;
    qryPredoplata: TMSQuery;
    MQuery: TMSSQL;
    dsPredoplata: TDataSource;
    qryOrg: TMSQuery;
    dsOrg: TDataSource;
    TBXLabelItem1: TTBXLabelItem;
    TBXSeparatorItem1: TTBXSeparatorItem;
    TBXSeparatorItem2: TTBXSeparatorItem;
    TBXItem2: TTBXItem;
    TBXSeparatorItem3: TTBXSeparatorItem;
    TBXItem3: TTBXItem;
    TBControlItem2: TTBControlItem;
    cboMonth: TRzComboBox;
    RzPanel2: TRzPanel;
    DBGridEh1: TDBGridEh;
    RzPanel3: TRzPanel;
    dbgOrg: TDBGridEh;
    procedure FilterClick(Sender: TObject);
    procedure cboTipOrgChange(Sender: TObject);
    procedure DelFilterClick(Sender: TObject);
    procedure TBXItem1Click(Sender: TObject);
    procedure TBXItem2Click(Sender: TObject);
    procedure TBXItem3Click(Sender: TObject);
    procedure cboMonthChange(Sender: TObject);
    procedure dbgOrgColumns3UpdateData(Sender: TObject; var Text: String;
      var Value: Variant; var UseText, Handled: Boolean);
  private
    { Private declarations }
  public
    procedure Init;
  end;

implementation

uses DataModule, DataPrint, MainForm;

{$R *.dfm}

{ TFrmPredoplata }

procedure TFrmPredoplata.Init;
begin
  ShowMessage('Не забудьте указать исходный месяц...');
  GetItemsPeriod(cboMonth.Items);
  with qryOrg do
  begin
    if Active then Close;
    Open;
  end;  
end;

procedure TFrmPredoplata.FilterClick(Sender: TObject);
begin
  {Фильтр}
  with cboTipOrg do
    Enabled:=True;
end;

procedure TFrmPredoplata.cboTipOrgChange(Sender: TObject);
begin
  with qryOrg do
    FilterSQL:='tiporg='+IntToStr(cboTipOrg.ItemIndex);
end;

procedure TFrmPredoplata.DelFilterClick(Sender: TObject);
begin
  with cboTipOrg do
    Enabled:=False;
  with qryOrg do
    FilterSQL:='';
end;

procedure TFrmPredoplata.TBXItem1Click(Sender: TObject);
begin    
  // Формирование счет-фактуры и расшифровки
  if cboMonth.ItemIndex = -1 then
  begin
    ShowMessage('Не выбран месяц...');
    exit;
  end;
  if (VarIsNull(qryPredoplata['Фиксированная сумма за тепло']) or
      VarIsNull(qryPredoplata['Фиксированная сумма за воду']) or
      VarIsNull(qryPredoplata['Фиксированная сумма за стоки']) or
      VarIsNull(qryPredoplata['Фиксированная сумма за мусор'])) and
     (VarIsNull(qryPredoplata['% за тепло']) or
      VarIsNull(qryPredoplata['% за воду']) or
      VarIsNull(qryPredoplata['% за стоки']) or
      VarIsNull(qryPredoplata['% за мусор'])) then
  begin
     ShowMessage('Не введены параметры начисления...');
     exit;
  end;
  if qryPredoplata.State = dsEdit then qryPredoplata.Post;
  with dp.qryParam do
  begin
    if Active then Close;
    Open;
  end;
  with MQuery do
  begin
    SQL.Clear;
    SQL.Add('EXECUTE sp_create_sf_pred :kod,:data');
    ParamByName('kod').AsInteger:=qryOrg['kodorg'];
    ParamByName('data').AsDate:=DateOfPeriod(cboMonth.ItemIndex);
    try
      Execute;
    except
      ShowMessage('Расчет не удался...');
    end;
  end;
  with dp.qrySchet do
  begin
    Open;
  end;
  with dp.qryLicev do
    begin
      SQL.Clear;
      SQL.Add('SELECT a.kodobk, a.nazv, a.kodorg,');
      SQL.Add('sum(b.gkt+b.pgkt) AS gkal_t,sum(b.gkv+b.pgkv) AS gkal_v,');
      SQL.Add('avg(b.rastarift) AS tarif_t,');
      SQL.Add('sum(b.pert+b.perv) AS per,');
      SQL.Add('sum(b.symt+b.symv+(b.pert-b.pertnds)+(b.perv-b.pervnds)) AS symbeznds,');
      SQL.Add('sum(b.symtnds+b.symvnds+b.pertnds+b.pervnds) AS symnds,');
      SQL.Add('sum(b.symk+b.symgv+b.pert+b.perv) AS symsnds,');
      SQL.Add('sum(b.lgkt) AS lgkal_t,');
      SQL.Add('sum(b.lgkv) AS lgkal_v,');
      SQL.Add('sum(b.lsymt) AS lsumt,');
      SQL.Add('sum(b.lsymv) AS lsumgv,');
      SQL.Add('sum(b.kybv+b.pkybv) AS kyb_v,');
      SQL.Add('sum(b.kybk+b.pkybk) AS kyb_k,');
      SQL.Add('avg(b.rastarifv) AS tarif_v,');
      SQL.Add('avg(b.rastarifk) AS tarif_k,');
      SQL.Add('sum(b.perh+b.perk) AS perhv,');
      SQL.Add('sum(b.symh+b.symkk+(b.perh-b.perhnds)+(b.perk-b.perknds)) AS symbezndshv,');
      SQL.Add('sum(b.symhnds+b.symknds+b.perhnds+b.perknds) AS symndshv,');
      SQL.Add('sum(b.symhs+b.symks+b.perh+b.perk) AS symsndshv,');
      SQL.Add('sum(b.lkybv) AS lkyb_v,');
      SQL.Add('sum(b.lkybk) AS lkyb_k,');
      SQL.Add('sum(b.lsymh) AS lsumh,');
      SQL.Add('sum(b.lsymkk) AS lsumk,');

      SQL.Add('sum(b.kybg) AS kyb_g,');
      SQL.Add('avg(b.rastarifg) AS tarif_g,');
      SQL.Add('sum(b.perg) AS perg,');
      SQL.Add('sum(b.symg+(b.perg-b.pergnds)) AS symbezndsg,');
      SQL.Add('sum(b.symgnds+b.pergnds) AS symndsg,');
      SQL.Add('sum(b.symgs+b.perg) AS symsndsg,');
      SQL.Add('sum(b.lkybg) AS lkyb_g,');
      SQL.Add('sum(b.lsymg) AS lsumg');

      SQL.Add('FROM OBEKT a,pr_obekt b');
      SQL.Add('WHERE a.kodobk=b.kodobk');
      SQL.Add('GROUP BY a.kodobk, a.nazv, a.kodorg');
      SQL.Add('ORDER BY a.kodobk');
    Open;
  end;
  dp.Report.LoadFromFile(FrmMain.RPath+'Счет-фактура (полная).fr3');
  FrmMain.Data1:=Date();
  dp.Report.Variables['period']:=PeriodStr(FrmMain.Data1,Null);
  dp.Report.ShowReport;
end;

procedure TFrmPredoplata.TBXItem2Click(Sender: TObject);
begin
  if qryPredoplata.State = dsEdit then qryPredoplata.Post;
  with MQuery do
  begin
    SQL.Clear;
    SQL.Add('EXECUTE sp_update_tPredoplata');
    try
      Execute;
      qryPredoplata.Refresh;
    except
      ShowMessage('Расчет не удался...');
    end;
  end;
end;

procedure TFrmPredoplata.TBXItem3Click(Sender: TObject);
begin
  FrmMain.pgcWork.ActivePage:=FrmMain.TabWelcome;
end;

procedure TFrmPredoplata.cboMonthChange(Sender: TObject);
begin
  if DateOfPeriod(cboMonth.ItemIndex) > StrToDate(FrmMain.WorkDate) then
    ShowMessage('А выбранный месяц больше текущего...')
  else
  begin
    // Выполняем процедуру по предоплате
    with MQuery do
    begin
      SQL.Add('EXECUTE sp_predoplata :kod, :data');
      ParamByName('kod').AsInteger:=qryOrg['kodorg'];
      ParamByName('data').AsDate:=DateOfPeriod(cboMonth.ItemIndex);
      try
        Execute;
        with qryPredoplata do
        begin
          if Active then Close;
          Open;
          ShowMessage('Фиксированную сумму или проценты указывайте в таблице...');
        end;
      except
        ShowMessage('Не удалось сформировать данные по предоплате...');
      end;
    end;
  end;
end;

procedure TFrmPredoplata.dbgOrgColumns3UpdateData(Sender: TObject;
  var Text: String; var Value: Variant; var UseText, Handled: Boolean);
begin
  ShowMessage('Не забудьте нажать кнопочку "Обновить"');
end;

end.


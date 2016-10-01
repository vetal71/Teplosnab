unit ArhCalcOrgFrame;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, RzTabs, Grids, DBGridEh, ExtCtrls, RzPanel, StdCtrls, RzCmboBx,
  TBX, TB2Item, TB2Dock, TB2Toolbar, RzLabel, Str_fun, DBAccess, MSAccess,
  ChangePeriodArhForm, GridsEh, DBGridEhGrouping;
  
type
  TFmeArhCalcOrg = class(TFrame)
    lblCaption: TRzLabel;
    TBXDock1: TTBXDock;
    TBXToolbar2: TTBXToolbar;
    Filter: TTBXItem;
    TBXSeparatorItem6: TTBXSeparatorItem;
    TBControlItem1: TTBControlItem;
    TBXSeparatorItem4: TTBXSeparatorItem;
    DelFilter: TTBXItem;
    Print: TTBXSubmenuItem;
    PrintSchet: TTBXItem;
    PrintRash: TTBXItem;
    cboTipOrg: TRzComboBox;
    RzPanel1: TRzPanel;
    Splitter1: TSplitter;
    RzPanel2: TRzPanel;
    dbgOrg: TDBGridEh;
    RzPanel3: TRzPanel;
    pgcMain: TRzPageControl;
    TabOt: TRzTabSheet;
    dbgObekt: TDBGridEh;
    TabVk: TRzTabSheet;
    dbgObektVk: TDBGridEh;
    MQuery2: TMSSQL;
    TBXItem1: TTBXItem;
    TabSheet1: TRzTabSheet;
    RzPanel4: TRzPanel;
    dbgDoma: TDBGridEh;
    RzPanel5: TRzPanel;
    dbgKvart: TDBGridEh;
    TabG: TRzTabSheet;
    dbgObektG: TDBGridEh;
    procedure FilterClick(Sender: TObject);
    procedure cboTipOrgChange(Sender: TObject);
    procedure DelFilterClick(Sender: TObject);
    procedure PrintSchetClick(Sender: TObject);
    procedure PrintRashClick(Sender: TObject);
    procedure TBXItem1Click(Sender: TObject);
    procedure FrameEnter(Sender: TObject);
  private
    CP:TFrmChangePeriodArh;
  public
    procedure Init;
  end;

implementation

uses DataModule, MainForm, DataPrint;

{$R *.dfm}

{ TFrame1 }

procedure TFmeArhCalcOrg.Init;
begin
  {Инициализация}
  lblCaption.Caption:='Архив по организациям за '+
  PeriodStr(FrmMain.Data1,FrmMain.Data2);
  with dm.qryCalcOrg do
  begin
    if Active then Close;
    try
      FilterSQL:='b.datan between '''+DateToStr(FrmMain.Data1)+''' and '''+
                 DateToStr(EndOfMonth(FrmMain.Data2))+'''';
      Open;
    except
      ShowMessage('Не удалось открыть таблицу "Организации"');
    end;
  end;
  with dm.qryRezCalcObkOtArh do
  begin
    if Active then Close;
    try
      FilterSQL:='a.datan between '''+DateToStr(FrmMain.Data1)+''' and '''+
                 DateToStr(EndOfMonth(FrmMain.Data2))+'''';
      Open;
    except
      ShowMessage('Не удалось открыть таблицу "Начисление за тепло"');
    end;
  end;
  with dm.qryRezCalcObkVkArh do
  begin
    if Active then Close;
    try
      FilterSQL:='a.datan between '''+DateToStr(FrmMain.Data1)+''' and '''+
                 DateToStr(EndOfMonth(FrmMain.Data2))+'''';
      Open;
    except
      ShowMessage('Не удалось открыть таблицу "Начисление за воду"');
    end;
  end;
  with dm.qryRezCalcObkGArh do
  begin
    if Active then Close;
    try
      FilterSQL:='a.datan between '''+DateToStr(FrmMain.Data1)+''' and '''+
                 DateToStr(EndOfMonth(FrmMain.Data2))+'''';
      Open;
    except
      ShowMessage('Не удалось открыть таблицу "Начисление за мусор"');
    end;
  end;
  with dm.qryArhCalcNas do
  begin
    if Active then Close;
    try
      FilterSQL:='a.datan between '''+DateToStr(FrmMain.Data1)+''' and '''+
                 DateToStr(EndOfMonth(FrmMain.Data2))+'''';
      Open;
    except
      ShowMessage('Не удалось открыть таблицу "Начисление по домам"');
    end;
  end;
  with dm.qryArhCalcKvart do
  begin
    if Active then Close;
    try
      FilterSQL:='a.datan between '''+DateToStr(FrmMain.Data1)+''' and '''+
                 DateToStr(EndOfMonth(FrmMain.Data2))+'''';
      Open;
    except
      ShowMessage('Не удалось открыть таблицу "Начисление по квартирам"');
    end;
  end;
  pgcMain.ActivePage:=TabOt;
end;

procedure TFmeArhCalcOrg.FilterClick(Sender: TObject);
begin
  {Фильтр}
  with cboTipOrg do
    Enabled:=True;
end;

procedure TFmeArhCalcOrg.cboTipOrgChange(Sender: TObject);
begin
  FrmMain.FilterData:='b.datan between '''+DateToStr(FrmMain.Data1)+''' and '''+
               DateToStr(EndOfMonth(FrmMain.Data2))+'''';
  with dm.qryCalcOrg do
    FilterSQL:=FrmMain.FilterData+' and a.tiporg='+IntToStr(cboTipOrg.ItemIndex);
end;

procedure TFmeArhCalcOrg.DelFilterClick(Sender: TObject);
begin
  with cboTipOrg do
    Enabled:=False;
  with dm.qryCalcOrg do
    FilterSQL:='b.datan between '''+DateToStr(FrmMain.Data1)+''' and '''+
               DateToStr(EndOfMonth(FrmMain.Data2))+'''';
end;

procedure TFmeArhCalcOrg.PrintSchetClick(Sender: TObject);
begin
  {Счет-фактура}
  CP:=TFrmChangePeriodArh.Create(Application);
  try
    CP.cboEnd.Enabled:=False;
    CP.RzLabel1.Caption:='За';
    CP.ShowModal;
    with dp.qryParam do
    begin
      if Active then Close;
      Open;
    end;
    with MQuery2 do
    begin
      ParamByName('kod').AsInteger:=dm.qryCalcOrg['kodorg'];
      ParamByName('data').AsDate:=FrmMain.Data1;
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

      SQL.Add('sum(b.kybg+b.pkybg) AS kyb_g,');
      SQL.Add('avg(b.rastarifg) AS tarif_g,');
      SQL.Add('sum(b.perg) AS perg,');
      SQL.Add('sum(b.symg+b.perg-b.pergnds) AS symbezndsg,');
      SQL.Add('sum(b.symgnds+b.pergnds) AS symndsg,');
      SQL.Add('sum(b.symgs+b.perg) AS symsndsg,');
      SQL.Add('sum(b.lkybg) AS lkyb_g,');
      SQL.Add('sum(b.lsymg) AS lsumg');

      SQL.Add('FROM OBEKT a,arh_dataobekt b');
      SQL.Add('WHERE a.kodobk=b.kodobk');
      SQL.Add('GROUP BY a.kodobk, a.nazv, a.kodorg');
      SQL.Add('ORDER BY a.kodobk');
      FilterSQL:='b.datan = '''+DateToStr(FrmMain.Data1)+'''';
      Open;
    end;
    dp.Report.LoadFromFile(FrmMain.RPath+'Счет-фактура (полная).fr3');
    dp.Report.Variables['period']:=PeriodStr(FrmMain.Data1,Null);
    dp.Report.ShowReport;
  finally
    CP.Free;
  end;
end;

procedure TFmeArhCalcOrg.PrintRashClick(Sender: TObject);
begin
  {Расшифровка}
  CP:=TFrmChangePeriodArh.Create(Application);
  try
    CP.ShowModal;
    with dm.qryOrg do
    begin
      if Active then Close;
      Open;
      Locate('kodorg',dm.qryRezCalcObkOt['kodorg'],[]);
    end;
    with dp.qryLicevRasArh do
    begin
      FilterSQL:='b.datan between '''+DateToStr(FrmMain.Data1)+''' and '''+
               DateToStr(EndOfMonth(FrmMain.Data2))+'''';
      Open;
    end;
    dp.LicevRasSet.DataSource:=dp.dsLicevRasArh;
    dp.Report.LoadFromFile(FrmMain.RPath+'Расшифровка по объектам.fr3');
    dp.Report.ShowReport;
  finally
    CP.Free;
  end;
end;

procedure TFmeArhCalcOrg.TBXItem1Click(Sender: TObject);
begin
  FrmMain.pgcWork.ActivePage:=FrmMain.TabWelcome;
end;

procedure TFmeArhCalcOrg.FrameEnter(Sender: TObject);
begin
  Init;
end;

end.

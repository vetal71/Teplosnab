unit RezCalcNasForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DBCtrls, RzDBCmbo, TB2Item, TBX, TB2Dock, TB2Toolbar, Menus,
  StdCtrls, RzLabel, Grids, DBGridEh, ExtCtrls, RzPanel, DateUtils, Str_fun,
  TBXStatusBars, LookDanDomaForm,LookDanKvartForm, DBAccess, MSAccess,
  EditNacNasForm, KorrectNasOtForm, KorrectNasGvsForm, ChangePeriodForm, GridsEh,
  DBGridEhGrouping;

type
  TFrmRezCalcNas = class(TForm)
    lblCaption: TRzLabel;
    pmObekt: TTBXPopupMenu;
    TBXDock1: TTBXDock;
    TBXToolbar1: TTBXToolbar;
    CalcNas: TTBXSubmenuItem;
    EditNac: TTBXItem;
    TBXSeparatorItem1: TTBXSeparatorItem;
    KorOtObk: TTBXItem;
    KorGvsObk: TTBXItem;
    TBXSeparatorItem5: TTBXSeparatorItem;
    Filter: TTBXItem;
    TBXSeparatorItem6: TTBXSeparatorItem;
    TBControlItem1: TTBControlItem;
    TBXSeparatorItem4: TTBXSeparatorItem;
    DelFilter: TTBXItem;
    Print: TTBXSubmenuItem;
    PrintLic: TTBXItem;
    PrintRez: TTBXItem;
    ChangePeriod: TTBXItem;
    ReturnPeriod: TTBXItem;
    lcbFilter: TRzDBLookupComboBox;
    DanNas: TTBXSubmenuItem;
    DanDoma: TTBXItem;
    DanKvart: TTBXItem;
    RzPanel1: TRzPanel;
    Splitter1: TSplitter;
    RzPanel2: TRzPanel;
    dbgDoma: TDBGridEh;
    RzPanel3: TRzPanel;
    dbgKvart: TDBGridEh;
    sb: TTBXStatusBar;
    MQuery: TMSSQL;
    procedure FormShow(Sender: TObject);
    procedure FilterClick(Sender: TObject);
    procedure DelFilterClick(Sender: TObject);
    procedure lcbFilterCloseUp(Sender: TObject);
    procedure DanDomaClick(Sender: TObject);
    procedure DanKvartClick(Sender: TObject);
    procedure EditNacClick(Sender: TObject);
    procedure KorOtObkClick(Sender: TObject);
    procedure KorGvsObkClick(Sender: TObject);
    procedure PrintLicClick(Sender: TObject);
    procedure PrintRezClick(Sender: TObject);
    procedure ChangePeriodClick(Sender: TObject);
    procedure ReturnPeriodClick(Sender: TObject);
  private
    FD:TFrmLookDoma;
    FK:TFrmDanKvart;
    FE:TFrmEditNacDom;
    FKO:TFrmKorrectNasOt;
    FKG:TFrmKorrectNasGvs;
    CP:TFrmChangePeriod;
    FlagEdt, FlagCalc:Boolean;
    procedure StatusObekt;
  public
    { Public declarations }
  end;

var
  FrmRezCalcNas: TFrmRezCalcNas;

implementation

uses MainForm, DataModule, DataPrint;

{$R *.dfm}

procedure TFrmRezCalcNas.FormShow(Sender: TObject);
begin
  Caption:='Участок:'+dm.qryKotelnnazk.Value;
  if MonthOf(FrmMain.Data1) = MonthOf(FrmMain.Data2) then
  lblCaption.Caption:='Результаты по населению за '+
  PeriodStr(FrmMain.Data1,Null) else
  lblCaption.Caption:='Результаты по населению за '+
  PeriodStr(FrmMain.Data1,FrmMain.Data2);
  with dm.qryRezCalcNas do
  begin
    FilterSQL:=FrmMain.FilterData;
    if Active then Close;
    try
      Open;
    except
      ShowMessage('Не удалось открыть таблицу "Результаты начислений по домам"');
    end;
  end;
  with dm.qryRezCalcKvart do
  begin
    FilterSQL:='a.datan between '''+DateToStr(FrmMain.Data1)+''' and '''+
    DateToStr(EndOfMonth(FrmMain.Data2))+'''';
    if Active then Close;
    try
      Open;
    except
      ShowMessage('Не удалось открыть таблицу "Результаты начислений по квартирам"');
    end;
  end;
  CalcNas.Enabled:=FrmMain.FlagEdit;
  lcbFilter.Enabled:=False;
  StatusObekt;
end;

procedure TFrmRezCalcNas.StatusObekt;
begin
  if dm.qryRezCalcNaskodpr.Value>1 then
  begin
  with dm.qryPokPrib do
  begin
    if Active then Close;
    FilterSQL:='b.datan between '''+DateToStr(FrmMain.Data1)+''' and '''+
    DateToStr(EndOfMonth(FrmMain.Data2))+'''';
    Open;
    Locate('kod',dm.qryRezCalcNaskodpr.Value,[]);
    sb.Panels[0].Caption:='На объекте установлен прибор учета '+dm.qryPokPribnazp.Value+
    ', показания за период составили '+dm.qryPokPribgk_t.AsString+' Гкал по отоплению и '+
    dm.qryPokPribgk_v.AsString+' Гкал по ГВС';
  end;
  end else sb.Panels[0].Caption:='На объекте нет прибора учета';
end;

procedure TFrmRezCalcNas.FilterClick(Sender: TObject);
begin
  {Фильтр}
  with lcbFilter do
  begin
    with dm.qryUlKot do
    begin
      if Active then Close;
      FilterSQl:='kodkot='+IntToStr(dm.qryKotelnkodkot.Value);
      Open;
    end;
    Enabled:=True;
  end;
end;

procedure TFrmRezCalcNas.DelFilterClick(Sender: TObject);
begin
  {Убираем фильтр}
  with dm.qryRezCalcNas do
    FilterSQL:=FrmMain.FilterData;
  lcbFilter.Enabled:=False;  
end;

procedure TFrmRezCalcNas.lcbFilterCloseUp(Sender: TObject);
begin
  {Применяем фильтр}
  with dm.qryRezCalcNas do
    FilterSQL:=FilterSQL+' and b.kodul='+IntToStr(lcbFilter.KeyValue);
end;

procedure TFrmRezCalcNas.DanDomaClick(Sender: TObject);
begin
  {Данные по дому}
  FD:=TFrmLookDoma.Create(Application);
  try
    FD.ShowModal;
  except
    FD.Free;
  end;
end;

procedure TFrmRezCalcNas.DanKvartClick(Sender: TObject);
begin
  {Данные по квартире}
  FK:=TFrmDanKvart.Create(Application);
  try
    FK.ShowModal;
  except
    FK.Free;
  end;
end;

procedure TFrmRezCalcNas.EditNacClick(Sender: TObject);
begin
  {Ввод начисления}
  if dm.qryRezCalcNaskodpr.Value>1 then
    if Application.MessageBox('По объекту ведется приборный учет. Продолжить?',
    'Предупреждение',mb_YesNo or mb_TaskModal or mb_IconQuestion)=idYes then
      FlagEdt:=True else FlagEdt:=False
  else FlagEdt:=True;
  if FlagEdt = True then
  begin
    FE:=TFrmEditNacDom.Create(Application);
    try
      FE.ShowModal;
      if FrmMain.MR = 1 then FlagCalc:=True else FlagCalc:=False;
    except
      FE.Free;
    end;
    with MQuery do
    begin
      ParamByName('data').AsDate:=StrToDate(FrmMain.WorkDate);
      try
        if FlagCalc then Execute;
      except
        ShowMessage('Расчет не удался...');
      end;
    end;
  end;
  dm.qryRezCalcNas.Refresh; dbgDoma.SumList.RecalcAll;
  dm.qryRezCalcKvart.Refresh; dbgKvart.SumList.RecalcAll;
end;

procedure TFrmRezCalcNas.KorOtObkClick(Sender: TObject);
begin
  {Кооректировка по дням}
  with dm.qryDoma do
  begin
    if Not Active then Open;
    Locate('koddom',dm.qryRezCalcNas['koddom'],[]);
    if Not dm.qryKvart.Active then dm.qryKvart.Open;
  end;
  FKO:=TFrmKorrectNasOt.Create(Application);
  try
    if dbgDoma.Focused then
    begin
      FKO.neQot.Value:=dm.qryDomaso.Value;
      FrmMain.CurRec1:=1;
    end
    else
    begin
      FKO.neQot.Value:=dm.qryKvartso.Value;
      FrmMain.CurRec1:=2;
    end;
    FKO.ShowModal;
    if FrmMain.MR = 1 then FlagCalc:=True else FlagCalc:=False;
  except
    FKO.Free;
  end;
  with MQuery do
  begin
    ParamByName('data').AsDate:=StrToDate(FrmMain.WorkDate);
    try
      if FlagCalc then Execute;
    except
      ShowMessage('Расчет не удался...');
    end;
  end;
  dm.qryRezCalcNas.Refresh; dbgDoma.SumList.RecalcAll;
  dm.qryRezCalcKvart.Refresh; dbgKvart.SumList.RecalcAll;
end;

procedure TFrmRezCalcNas.KorGvsObkClick(Sender: TObject);
begin
  {Корректировка ГВС}
  with dm.qryDoma do
  begin
    if Not Active then Open;
    Locate('koddom',dm.qryRezCalcNas['koddom'],[]);
    if Not dm.qryKvart.Active then dm.qryKvart.Open;
  end;
  if dm.qryDomapodklgv.Value = 0 then
  begin
    FKG:=TFrmKorrectNasGvs.Create(Application);
    try
      if dbgDoma.Focused then
      begin
        FKG.neQot.Value:=dm.qryDomaprj.Value;
        FrmMain.CurRec1:=1;
      end
      else
      begin
        FKG.neQot.Value:=dm.qryKvartprj.Value;
        FrmMain.CurRec1:=2;
      end;
      FKG.ShowModal;
      if FrmMain.MR = 1 then FlagCalc:=True else FlagCalc:=False;
    except
      FKG.Free;
    end;
    with MQuery do
    begin
      ParamByName('data').AsDate:=StrToDate(FrmMain.WorkDate);
      try
        if FlagCalc then Execute;
      except
        ShowMessage('Расчет не удался...');
      end;
    end;
  end else ShowMessage('Объект не подключен к ГВС...');
  dm.qryRezCalcNas.Refresh; dbgDoma.SumList.RecalcAll;
  dm.qryRezCalcKvart.Refresh; dbgKvart.SumList.RecalcAll;
end;

procedure TFrmRezCalcNas.PrintLicClick(Sender: TObject);
begin
  {Лицевой по дому}
  CP:=TFrmChangePeriod.Create(Application);
  try
    CP.ShowModal;
    with dp.qryObk do
    begin
      if Active then Close;
      Open;
    end;
    with dp.qryLicDoma do
    begin
      FilterSQL:='datan between '''+DateToStr(FrmMain.Data1)+''' and '''+
      DateToStr(EndOfMonth(FrmMain.Data2))+'''';
      Open;
    end;
    with dp.qryLicKvart do
    begin
      FilterSQL:='datan between '''+DateToStr(FrmMain.Data1)+''' and '''+
      DateToStr(EndOfMonth(FrmMain.Data2))+'''';
      Open;
    end;
    dp.Report.LoadFromFile(FrmMain.RPath+'Лицевой по дому1.fr3');
    dp.Report.Variables['data1']:=StrToDate(DateToStr(FrmMain.Data1));
    dp.Report.Variables['data2']:=StrToDate(DateToStr(FrmMain.Data2));
    dp.Report.ShowReport;
  finally
    CP.Free;
  end;
end;

procedure TFrmRezCalcNas.PrintRezClick(Sender: TObject);
begin
  {Результаты начисления}
  CP:=TFrmChangePeriod.Create(Application);
  try
    CP.ShowModal;
    with dp.qryRezKotDoma do
    begin
      FilterSQL:='datan between '''+DateToStr(FrmMain.Data1)+''' and '''+
      DateToStr(EndOfMonth(FrmMain.Data2))+'''';
      Open;
    end;
    dp.Report.LoadFromFile(FrmMain.RPath+'Результаты по участку (дом).fr3');
    dp.Report.Variables['data1']:=StrToDate(DateToStr(FrmMain.Data1));
    dp.Report.Variables['data2']:=StrToDate(DateToStr(FrmMain.Data2));
    dp.Report.ShowReport;
  finally
    CP.Free;
  end;
end;

procedure TFrmRezCalcNas.ChangePeriodClick(Sender: TObject);
begin
  {Смена периода}
  CP:=TFrmChangePeriod.Create(Application);
  try
    CP.ShowModal;
    FrmMain.FilterData:='b.kodkot = '+IntToStr(dm.qryKotelnkodkot.Value)+' and '+
          'a.datan between '''+DateToStr(FrmMain.Data1)+''' and '''+
          DateToStr(EndOfMonth(FrmMain.Data2))+'''';
    with dm.qryRezCalcNas do
      FilterSQL:=FrmMain.FilterData;
    if FrmMain.Data1 = FrmMain.Data2 then
    lblCaption.Caption:='Результаты по населению за '+
    PeriodStr(FrmMain.Data1,Null) else
    lblCaption.Caption:='Результаты по населению за '+
    PeriodStr(FrmMain.Data1,FrmMain.Data2);
    with dm.qryRezCalcKvart do
      FilterSQL:='a.datan between '''+DateToStr(FrmMain.Data1)+''' and '''+
      DateToStr(EndOfMonth(FrmMain.Data2))+'''';
  finally
    CP.Free;
  end;
end;

procedure TFrmRezCalcNas.ReturnPeriodClick(Sender: TObject);
begin
  {Возврат периода}
  FrmMain.Data1:=StrToDate(FrmMain.WorkDate);
  FrmMain.Data2:=StrToDate(FrmMain.WorkDate);
  FrmMain.FilterData:='b.kodkot = '+IntToStr(dm.qryKotelnkodkot.Value)+' and '+
          'a.datan between '''+DateToStr(FrmMain.Data1)+''' and '''+
          DateToStr(EndOfMonth(FrmMain.Data2))+'''';
  with dm.qryRezCalcNas do
    FilterSQL:=FrmMain.FilterData;
  if FrmMain.Data1 = FrmMain.Data2 then
    lblCaption.Caption:='Результаты по населению за '+
    PeriodStr(FrmMain.Data1,Null) else
    lblCaption.Caption:='Результаты по населению за '+
    PeriodStr(FrmMain.Data1,FrmMain.Data2);
   with dm.qryRezCalcKvart do
     FilterSQL:='a.datan between '''+DateToStr(FrmMain.Data1)+''' and '''+
     DateToStr(EndOfMonth(FrmMain.Data2))+'''';
end;

end.

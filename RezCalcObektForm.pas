unit RezCalcObektForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGridEh, RzPanel, DBCtrls, RzDBCmbo, RzButton, ExtCtrls,
  StdCtrls, RzLabel, Menus, ImgList, Str_fun, LookObektForm,
  EditNacForm, DBAccess, MSAccess, TBXExtItems, TB2ExtItems, TB2Item, TBX,
  TB2Dock, TB2Toolbar, KorrectObkOtForm, TBXStatusBars, KorrectObkSlivForm,
  KorrectObkGvs, CalcBanForm, CalcBolForm, PerCalcForm, ChangePeriodForm,
  HistoryObektNacForm, DateUtils, GridsEh, DBGridEhGrouping;

type
  TFrmRezCalcObekt = class(TForm)
    lblCaption: TRzLabel;
    RzPanel1: TRzPanel;
    dbgObekt: TDBGridEh;
    MQuery: TMSSQL;
    TBXDock1: TTBXDock;
    TBXToolbar1: TTBXToolbar;
    DanObk: TTBXItem;
    CalcObk: TTBXSubmenuItem;
    KorOtObk: TTBXItem;
    KorGvsObk: TTBXItem;
    EditPerObk: TTBXItem;
    EditNacobk: TTBXItem;
    TBXSeparatorItem1: TTBXSeparatorItem;
    TBXSeparatorItem2: TTBXSeparatorItem;
    pmObekt: TTBXPopupMenu;
    DelFilter: TTBXItem;
    TBXSeparatorItem4: TTBXSeparatorItem;
    TBXSeparatorItem5: TTBXSeparatorItem;
    Print: TTBXSubmenuItem;
    ChangePeriod: TTBXItem;
    ReturnPeriod: TTBXItem;
    History: TTBXItem;
    Filter: TTBXItem;
    TBXSeparatorItem6: TTBXSeparatorItem;
    lcbFilter: TRzDBLookupComboBox;
    TBControlItem1: TTBControlItem;
    sb: TTBXStatusBar;
    PrintLic: TTBXItem;
    PrintRez: TTBXItem;
    procedure FormShow(Sender: TObject);
    procedure BtnDanObkClick(Sender: TObject);
    procedure BtnEditObkClick(Sender: TObject);
    procedure FilterClick(Sender: TObject);
    procedure DelFilterClick(Sender: TObject);
    procedure lcbFilterCloseUp(Sender: TObject);
    procedure KorOtObkClick(Sender: TObject);
    procedure dbgObektCellClick(Column: TColumnEh);
    procedure dbgObektKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure KorGvsObkClick(Sender: TObject);
    procedure EditPerObkClick(Sender: TObject);
    procedure ChangePeriodClick(Sender: TObject);
    procedure ReturnPeriodClick(Sender: TObject);
    procedure HistoryClick(Sender: TObject);
    procedure PrintLicClick(Sender: TObject);
    procedure PrintRezClick(Sender: TObject);
  private
    FO:TFrmLookObekt;
    FN:TFrmEditNac;
    FK:TFrmKorrectObkOt;
    FKS:TFrmKorrectObkSliv;
    FKG:TFrmKorrectObkGvs;
    FB:TFrmCalcBan;
    FBl:TFrmCalcBol;
    FlagEdt, FlagEdit, FlagCalc:Boolean;
    FP:TFrmPerCalc;
    CP:TFrmChangePeriod;
    FH:TFrmHistoryObekt;
    procedure StatusObekt;
  public
    { Public declarations }
  end;

var
  FrmRezCalcObekt: TFrmRezCalcObekt;

implementation

uses DataModule, MainForm, DataPrint;

{$R *.dfm}

procedure TFrmRezCalcObekt.FormShow(Sender: TObject);
begin
  Caption:='Участок:'+dm.qryKotelnnazk.Value;
  if MonthOf(FrmMain.Data1) = MonthOf(FrmMain.Data2) then
  lblCaption.Caption:='Результаты по объектам за '+
  PeriodStr(FrmMain.Data1,Null) else
  lblCaption.Caption:='Результаты по объектам за '+
  PeriodStr(FrmMain.Data1,FrmMain.Data2);
  with dm.qryRezCalcObk do
  begin
    FilterSQL:=FrmMain.FilterData;
    if Active then Close;
    try
      Open;
    except
      ShowMessage('Не удалось открыть таблицу "Результаты начислений по объектам"');
    end;
  end;
  CalcObk.Enabled:=FrmMain.FlagEdit;
  lcbFilter.Enabled:=False;
  StatusObekt;
end;

procedure TFrmRezCalcObekt.BtnDanObkClick(Sender: TObject);
begin
  {Данные по объекту}
  with dm.qryOrg do
  begin
    if Active then Close;
    Open;
    Locate('kodorg',dm.qryRezCalcObk['kodorg'],[]);
  end;
  with dm.qryObekt do
  begin
    if Active then Close;
    try
      Open;
      Locate('kodobk',dm.qryRezCalcObk['kodobk'],[]);
      FO:=TFrmLookObekt.Create(Application);
      try
        FO.ShowModal;
      finally
        FO.Free;
      end;
    except
      ShowMessage('Не удалось получить данные по объекту...');
    end;
  end;
end;

procedure TFrmRezCalcObekt.BtnEditObkClick(Sender: TObject);
begin
  {Ручной ввод}
  if dm.qryRezCalcObkkodpr.Value>1 then
    if Application.MessageBox('По объекту ведется приборный учет. Продолжить?',
    'Предупреждение',mb_YesNo or mb_TaskModal or mb_IconQuestion)=idYes then
      FlagEdt:=True else FlagEdt:=False
  else FlagEdt:=True;
  if FlagEdt = True then
  begin
    FN:=TFrmEditNac.Create(Application);
    try
      FN.ShowModal;
      if FrmMain.MR = 1 then FlagEdit:=True else FlagEdit:=False;
    finally
      FN.Free;
    end;
    {Расчет начисления}
    with MQuery do
    begin
      ParamByName('data').AsDate:=StrToDate(FrmMain.WorkDate);
      try
        if FlagEdit then Execute;
      except
        ShowMessage('Расчет не удался...');
      end;
    end;
  end;
  dm.qryRezCalcObk.Refresh; dbgObekt.SumList.RecalcAll;
end;

procedure TFrmRezCalcObekt.FilterClick(Sender: TObject);
begin
  {Фильтр}
  with lcbFilter do
  begin
    with dm.qryOrgKot do
    begin
      if Active then Close;
      FilterSQl:='kodkot='+IntToStr(dm.qryKotelnkodkot.Value);
      Open;
    end;
    Enabled:=True;
  end;
end;

procedure TFrmRezCalcObekt.DelFilterClick(Sender: TObject);
begin
  {Убираем фильтр}
  with dm.qryRezCalcObk do
    FilterSQL:=FrmMain.FilterData;
  lcbFilter.Enabled:=False;
end;

procedure TFrmRezCalcObekt.lcbFilterCloseUp(Sender: TObject);
begin
  {Применяем фильтр}
  with dm.qryRezCalcObk do
    FilterSQL:=FilterSQL+' and b.kodorg='+IntToStr(lcbFilter.KeyValue);
end;

procedure TFrmRezCalcObekt.KorOtObkClick(Sender: TObject);
begin
  {Корректировка по дням отопления}
  // Проверяем котельную
  if (dm.qryKotelnkodkot.Value<8) or (dm.qryKotelnkodkot.Value>10) then
  begin
    if dm.qryRezCalcObkkodpr.Value>1 then
      if Application.MessageBox('По объекту ведется приборный учет. Продолжить?',
      'Предупреждение',mb_YesNo or mb_TaskModal or mb_IconQuestion)=idYes then
        FlagEdt:=True else FlagEdt:=False
    else FlagEdt:=True;
    if FlagEdt = True then
    begin
      FrmMain.CurRec1:=0;
      FK:=TFrmKorrectObkOt.Create(Application);
      try
        FK.ShowModal;
        if FrmMain.MR = 1 then FlagCalc:=True else FlagCalc:=False;
      finally
        FK.Free;
      end;
    end;
  end;
  if (dm.qryKotelnkodkot.Value=10) then
  begin
    // Слив
    FrmMain.CurRec1:=0;
    FKS:=TFrmKorrectObkSliv.Create(Application);
    try
      FKS.ShowModal;
      if FrmMain.MR = 1 then FlagCalc:=True else FlagCalc:=False;
    finally
      FKS.Free;
    end;
  end;
  {Расчет начисления}
  with MQuery do
  begin
    ParamByName('data').AsDate:=StrToDate(FrmMain.WorkDate);
    try
      if FlagCalc then Execute;
    except
      ShowMessage('Расчет не удался...');
    end;
  end;
  dm.qryRezCalcObk.Refresh; dbgObekt.SumList.RecalcAll;
end;

procedure TFrmRezCalcObekt.dbgObektCellClick(Column: TColumnEh);
begin
  StatusObekt;
end;

procedure TFrmRezCalcObekt.StatusObekt;
begin
  if dm.qryRezCalcObkkodpr.Value>1 then
  begin
  with dm.qryPokPrib do
  begin
    if Active then Close;
    FilterSQL:='b.datan between '''+DateToStr(FrmMain.Data1)+''' and '''+
    DateToStr(EndOfMonth(FrmMain.Data2))+'''';
    Open;
    Locate('kod',dm.qryRezCalcObkkodpr.Value,[]);
    sb.Panels[0].Caption:='На объекте установлен прибор учета '+dm.qryPokPribnazp.Value+
    ', показания за период составили '+dm.qryPokPribgk_t.AsString+' Гкал по отоплению и '+
    dm.qryPokPribgk_v.AsString+' Гкал по ГВС';
  end;
  end else sb.Panels[0].Caption:='На объекте нет прибора учета';
end;

procedure TFrmRezCalcObekt.dbgObektKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  StatusObekt;
end;

procedure TFrmRezCalcObekt.KorGvsObkClick(Sender: TObject);
begin
  {Корректировка по дням ГВС}
  if (dm.qryKotelnkodkot.Value<>8) and (dm.qryKotelnkodkot.Value<>9) then
  begin
    // Остальные
    //1. Проверяем, а есть ли вода горячая
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
      except
        exit;
      end;
    end;
    if dm.qryObektpodklgv.Value = 0 then
    begin
      FrmMain.CurRec1:=0;
      FKG:=TFrmKorrectObkGvs.Create(Application);
      try
        FKG.ShowModal;
        if FrmMain.MR = 1 then FlagCalc:=True else FlagCalc:=False;
      finally
        FKG.Free;
      end;
    end else ShowMessage('Объект не подключен к ГВС...');
  end;
  if (dm.qryKotelnkodkot.Value=8) then
  begin
    // Баня
    FrmMain.CurRec1:=0;
    FB:=TFrmCalcBan.Create(Application);
    try
      FB.ShowModal;
      if FrmMain.MR = 1 then FlagCalc:=True else FlagCalc:=False;
    finally
      FB.Free;
    end;
  end;
  if (dm.qryKotelnkodkot.Value=9) then
  begin
    // Больница
    FrmMain.CurRec1:=0;
    FBl:=TFrmCalcBol.Create(Application);
    try
      FBl.ShowModal;
      if FrmMain.MR = 1 then FlagCalc:=True else FlagCalc:=False;
    finally
      FBl.Free;
    end;
  end;
  {Расчет начисления}
  with MQuery do
  begin
    ParamByName('data').AsDate:=StrToDate(FrmMain.WorkDate);
    try
      if FlagCalc then Execute;
    except
      ShowMessage('Расчет не удался...');
    end;
  end;
  dm.qryRezCalcObk.Refresh; dbgObekt.SumList.RecalcAll;
end;

procedure TFrmRezCalcObekt.EditPerObkClick(Sender: TObject);
begin
  {Ввод перерасчетов}
  FP:=TFrmPerCalc.Create(Application);
  try
    FP.ShowModal;
    if FrmMain.MR = 1 then FlagCalc:=True else FlagCalc:=False;
  finally
    FP.Free;
  end;
  {Расчет начисления}
  with MQuery do
  begin
    ParamByName('data').AsDate:=StrToDate(FrmMain.WorkDate);
    try
      if FlagCalc then Execute;
    except
      ShowMessage('Расчет не удался...');
    end;
  end;
  dm.qryRezCalcObk.Refresh; dbgObekt.SumList.RecalcAll;
end;

procedure TFrmRezCalcObekt.ChangePeriodClick(Sender: TObject);
begin
  {Смена периода}
  CP:=TFrmChangePeriod.Create(Application);
  try
    CP.ShowModal;
    FrmMain.FilterData:='b.kodkot = '+IntToStr(dm.qryKotelnkodkot.Value)+' and '+
          'a.datan between '''+DateToStr(FrmMain.Data1)+''' and '''+
          DateToStr(EndOfMonth(FrmMain.Data2))+'''';
    with dm.qryRezCalcObk do
      FilterSQL:=FrmMain.FilterData;
    if FrmMain.Data1 = FrmMain.Data2 then
    lblCaption.Caption:='Результаты по объектам за '+
    PeriodStr(FrmMain.Data1,Null) else
    lblCaption.Caption:='Результаты по объектам за '+
    PeriodStr(FrmMain.Data1,FrmMain.Data2);
  finally
    CP.Free;
  end;
end;

procedure TFrmRezCalcObekt.ReturnPeriodClick(Sender: TObject);
begin
  FrmMain.Data1:=StrToDate(FrmMain.WorkDate);
  FrmMain.Data2:=StrToDate(FrmMain.WorkDate);
  FrmMain.FilterData:='b.kodkot = '+IntToStr(dm.qryKotelnkodkot.Value)+' and '+
          'a.datan between '''+DateToStr(FrmMain.Data1)+''' and '''+
          DateToStr(EndOfMonth(FrmMain.Data2))+'''';
  with dm.qryRezCalcObk do
    FilterSQL:=FrmMain.FilterData;
  if MonthOf(FrmMain.Data1) = MonthOf(FrmMain.Data2) then
  lblCaption.Caption:='Результаты по объектам за '+
  PeriodStr(FrmMain.Data1,Null) else
  lblCaption.Caption:='Результаты по объектам за '+
  PeriodStr(FrmMain.Data1,FrmMain.Data2);
end;

procedure TFrmRezCalcObekt.HistoryClick(Sender: TObject);
begin
  {История по объекту}
  FH:=TFrmHistoryObekt.Create(Application);
  try
    FH.ShowModal;
  finally
    FH.Free;
  end;
end;

procedure TFrmRezCalcObekt.PrintLicClick(Sender: TObject);
begin
  {Лицевой счет объекта}
  CP:=TFrmChangePeriod.Create(Application);
  try
    CP.ShowModal;
    with dp.qryObk do
    begin
      if Active then Close;
      Open;
    end;
    with dp.qryLicObekt do
    begin
      FilterSQL:='datan between '''+DateToStr(FrmMain.Data1)+''' and '''+
      DateToStr(EndOfMonth(FrmMain.Data2))+'''';
      Open;
    end;
    dp.Report.LoadFromFile(FrmMain.RPath+'Лицевой по объекту.fr3');
    dp.Report.Variables['data1']:=StrToDate(DateToStr(FrmMain.Data1));
    dp.Report.Variables['data2']:=StrToDate(DateToStr(FrmMain.Data2));
    dp.Report.ShowReport;
  finally
    CP.Free;
  end;
end;

procedure TFrmRezCalcObekt.PrintRezClick(Sender: TObject);
begin
  {Результаты начисления}
  CP:=TFrmChangePeriod.Create(Application);
  try
    CP.ShowModal;
    with dp.qryKoteln do
    begin
      FilterSQL:='kodkot = '+dm.qryKotelnkodkot.AsString;
      Open;
    end;  
    with dp.qryRezKot do
    begin
      FilterSQL:='datan between '''+DateToStr(FrmMain.Data1)+''' and '''+
      DateToStr(EndOfMonth(FrmMain.Data2))+'''';
      Open;
    end;
    dp.Report.LoadFromFile(FrmMain.RPath+'Результаты по участку.fr3');
    dp.Report.Variables['data1']:=StrToDate(DateToStr(FrmMain.Data1));
    dp.Report.Variables['data2']:=StrToDate(DateToStr(FrmMain.Data2));
    dp.Report.ShowReport;
  finally
    CP.Free;
  end;
end;

end.

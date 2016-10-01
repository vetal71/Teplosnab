unit PokPribFrame;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, Grids, DBGridEh, ExtCtrls, RzPanel, StdCtrls, RzLabel, DBCtrls,
  RzDBCmbo, RzDBNav, RzButton, ImgList, Str_fun, Menus, EditPokForm,
  ChangePeriodForm, CalcPribForDayForm, CalcPribForGvs, CalcPribForOtGvs,
  DB, MemDS, DBAccess, MSAccess, WaitScreenForm, frxClass, frxDBSet,
  HistoryPokPribForm, GridsEh, DBGridEhGrouping;

type
  TFmePokPrib = class(TFrame)
    ImageList1: TImageList;
    lblCaption: TRzLabel;
    RzPanel1: TRzPanel;
    Splitter1: TSplitter;
    Splitter2: TSplitter;
    RzPanel3: TRzPanel;
    dbgObekt: TDBGridEh;
    RzPanel2: TRzPanel;
    dbgPribor: TDBGridEh;
    RzPanel4: TRzPanel;
    dbgDoma: TDBGridEh;
    RzToolbar1: TRzToolbar;
    pmCalc: TPopupMenu;
    CalcForDays: TMenuItem;
    CalcForRashod: TMenuItem;
    N3: TMenuItem;
    Delenie: TMenuItem;
    N5: TMenuItem;
    CalcCurentPrib: TMenuItem;
    CalcAllPrib: TMenuItem;
    pmFilter: TPopupMenu;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    BtnEditPok: TRzToolButton;
    RzSpacer2: TRzSpacer;
    BtnCalc: TRzToolButton;
    RzSpacer12: TRzSpacer;
    BtnFilterOrg: TRzToolButton;
    RzSpacer3: TRzSpacer;
    lcbFilter: TRzDBLookupComboBox;
    RzSpacer4: TRzSpacer;
    btnDelFilter: TRzToolButton;
    RzSpacer7: TRzSpacer;
    BtnPrint: TRzToolButton;
    RzSpacer5: TRzSpacer;
    btnPeriod: TRzToolButton;
    RzSpacer6: TRzSpacer;
    BtnUndo: TRzToolButton;
    RzSpacer8: TRzSpacer;
    BtnHistoryPok: TRzToolButton;
    RzSpacer9: TRzSpacer;
    MQuery: TMSSQL;
    RzToolButton1: TRzToolButton;
    spQprib: TMSQuery;
    procedure BtnEditPokClick(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
    procedure lcbFilterCloseUp(Sender: TObject);
    procedure btnDelFilterClick(Sender: TObject);
    procedure btnPeriodClick(Sender: TObject);
    procedure BtnUndoClick(Sender: TObject);
    procedure CalcForDaysClick(Sender: TObject);
    procedure CalcForRashodClick(Sender: TObject);
    procedure DelenieClick(Sender: TObject);
    procedure CalcCurentPribClick(Sender: TObject);
    procedure CalcAllPribClick(Sender: TObject);
    procedure BtnPrintClick(Sender: TObject);
    procedure BtnHistoryPokClick(Sender: TObject);
    procedure RzToolButton1Click(Sender: TObject);
  private
    W:TFrmWaitScreen;
    F:TFrmEditPok;
    CP:TFrmChangePeriod;
    FCD:TFrmCalcPribForDay;
    FCG:TFrmCalcPribForGvs;
    FCOG:TFrmCalcGvsOt;
    FH:TFrmHistoryPokPrib;
  public
    procedure Init;
  end;

implementation

uses DataModule, MainForm, DataPrint;

{$R *.dfm}

{ TFmePokPrib }

procedure TFmePokPrib.Init;
begin
  lblCaption.Caption:='Показания приборов учета за '+
  FormatDateTime('mmmm, yyyy "г."',StrToDate(FrmMain.WorkDate));
  with dm.qryPokPrib do
  begin
    FilterSQL:='b.datan between '''+FrmMain.WorkDate+''' and '''+
    DateToStr(EndOfMonth(StrToDate(FrmMain.WorkDate)))+'''';
    try
      Open;
    except
      ShowMessage('Не удалось открыть таблицу "Показания приборов"');
    end;
  end;
  with dm.qryPokObk do
  begin
    FilterSQL:='b.datan between '''+FrmMain.WorkDate+''' and '''+
    DateToStr(EndOfMonth(StrToDate(FrmMain.WorkDate)))+'''';
    try
      Open;
    except
      ShowMessage('Не удалось открыть таблицу "Показания приборов по объектам"');
    end;
  end;
  with dm.qryPokDoma do
  begin
    FilterSQL:='c.datan between '''+FrmMain.WorkDate+''' and '''+
    DateToStr(EndOfMonth(StrToDate(FrmMain.WorkDate)))+'''';
    try
      Open;
    except
      ShowMessage('Не удалось открыть таблицу "Показания приборов по домам"');
    end;
  end;
end;

procedure TFmePokPrib.BtnEditPokClick(Sender: TObject);
begin
  {Редактируем показание}
  if BtnEditPok.Enabled then
  begin
    FrmMain.CurRec:=dm.qryPokPribkod.Value;
    F:=TFrmEditPok.Create(Application);
    try
      F.ShowModal;
    finally
      F.Free;
    end;
    dm.qryPokPrib.Refresh;
    dbgPribor.SumList.RecalcAll;
    dm.qryPokPrib.Locate('kod',FrmMain.CurRec,[]);
  end;
end;

procedure TFmePokPrib.MenuItem2Click(Sender: TObject);
begin
  {Фильтр по организации}
  with lcbFilter do
  begin
    ListSource:=dm.dsOrg;
    ListField:='nazv';
    KeyField:='kodorg';
    Enabled:=True;
  end;
  with dm.qryOrg do
  begin
    if Active then Close;
    try
      Open;
    except
      ShowMessage('Не удалось открыть таблицу "Организации"');
    end;
  end;
end;

procedure TFmePokPrib.MenuItem1Click(Sender: TObject);
begin
  {Фильтр по котельной}
  with lcbFilter do
  begin
    ListSource:=dm.dsKoteln;
    ListField:='nazk';
    KeyField:='kodkot';
    Enabled:=True;
  end;
  with dm.qryKoteln do
  begin
    if Active then Close;
    try
      Open;
    except
      ShowMessage('Не удалось открыть таблицу "Котельные"');
    end;
  end;
end;

procedure TFmePokPrib.lcbFilterCloseUp(Sender: TObject);
begin
  if lcbFilter.ListSource = dm.dsOrg then
    with dm.qryPokPrib do
      FilterSQL:=FilterSQL+' and a.kodorg='+IntToStr(lcbFilter.KeyValue);
  if lcbFilter.ListSource = dm.dsKoteln then
    with dm.qryPokPrib do
      FilterSQL:=FilterSQL+' and a.kodkot='+IntToStr(lcbFilter.KeyValue);
end;

procedure TFmePokPrib.btnDelFilterClick(Sender: TObject);
begin
  with dm.qryPokPrib do
    FilterSQL:='b.datan between '''+FrmMain.WorkDate+''' and '''+
    DateToStr(EndOfMonth(StrToDate(FrmMain.WorkDate)))+'''';
  with lcbFilter do
  begin
    KeyField:='';
    ListField:='';
    ListSource:=nil;
    Enabled:=False;
  end;
end;

procedure TFmePokPrib.btnPeriodClick(Sender: TObject);
begin
  BtnCalc.Enabled:=False;
  BtnEditPok.Enabled:=False;
  CP:=TFrmChangePeriod.Create(Application);
  try
    CP.ShowModal;
    with dm.qryPokPrib do
      FilterSQL:='b.datan between '''+DateToStr(FrmMain.Data1)+''' and '''+
      DateToStr(FrmMain.Data2)+'''';
    with dm.qryPokObk do
      FilterSQL:='b.datan between '''+DateToStr(FrmMain.Data1)+''' and '''+
      DateToStr(FrmMain.Data2)+'''';
    with dm.qryPokDoma do
      FilterSQL:='c.datan between '''+DateToStr(FrmMain.Data1)+''' and '''+
      DateToStr(FrmMain.Data2)+'''';
    lblCaption.Caption:='Показания приборов с '+
    FormatDateTime('mmmm, yyyy "г."',FrmMain.Data1)+
    ' по '+FormatDateTime('mmmm, yyyy "г."',FrmMain.Data2);
  finally
    CP.Free;
  end;
end;

procedure TFmePokPrib.BtnUndoClick(Sender: TObject);
begin
  BtnCalc.Enabled:=True;
  BtnEditPok.Enabled:=True;
  lblCaption.Caption:='Показания приборов учета за '+
  FormatDateTime('mmmm, yyyy "г."',StrToDate(FrmMain.WorkDate));
  with dm.qryPokPrib do
    FilterSQL:='b.datan between '''+FrmMain.WorkDate+''' and '''+
    DateToStr(EndOfMonth(StrToDate(FrmMain.WorkDate)))+'''';
  with dm.qryPokObk do
    FilterSQL:='b.datan between '''+FrmMain.WorkDate+''' and '''+
    DateToStr(EndOfMonth(StrToDate(FrmMain.WorkDate)))+'''';
  with dm.qryPokDoma do
    FilterSQL:='c.datan between '''+FrmMain.WorkDate+''' and '''+
    DateToStr(EndOfMonth(StrToDate(FrmMain.WorkDate)))+'''';
end;

procedure TFmePokPrib.CalcForDaysClick(Sender: TObject);
begin
  {Расчет по дням}
//  FrmMain.CurRec:=dm.qryPokPribkod.Value;
  FCD:=TFrmCalcPribForDay.Create(Application);
  try
    FCD.ShowModal;
  finally
    FCD.Free;
  end;
  dm.qryPokPrib.Refresh;
  dbgPribor.SumList.RecalcAll;
//  dm.qryPokPrib.Locate('kod',FrmMain.CurRec,[]);
end;

procedure TFmePokPrib.CalcForRashodClick(Sender: TObject);
begin
  {Расчет ГВС по кубам}
  if dm.qryPribortgv.Value = 0 then
  begin
  FCG:=TFrmCalcPribForGvs.Create(Application);
  try
    FCG.ShowModal;
    dbgPribor.SumList.Activate(True);
  finally
    FCG.Free;
  end;
  dm.qryPokPrib.Refresh;
  dbgPribor.SumList.RecalcAll;
  end
  else
    ShowMessage('А горячей воды то нету...');
end;

procedure TFmePokPrib.DelenieClick(Sender: TObject);
begin
  {Делим показания}
  with dm.qryPribor do
  begin
    if Active then Close;
    FilterSQl:='kod='+IntToStr(dm.qryPokPribkod.Value);
  end;
  if dm.qryPribortgv.Value = 0 then
  begin
    FCOG:=TFrmCalcGvsOt.Create(Application);
    try
      FCOG.ShowModal;
    finally
      FCOG.Free;
    end;
    dm.qryPokPrib.Refresh;
    dbgPribor.SumList.RecalcAll;
  end
  else
    ShowMessage('А горячей воды то нету...');
end;

procedure TFmePokPrib.CalcCurentPribClick(Sender: TObject);
begin
  {Расчет текущего прибора учета}
  with spQprib do
  begin
    ParamByName('kod').AsInteger:=dm.qryPokPribkod.Value;
    ParamByName('data').AsDate:=StrToDate(FrmMain.WorkDate);
    try
      Execute;
      dm.qryPokObk.Refresh;  dbgObekt.SumList.RecalcAll;
      dm.qryPokDoma.Refresh; dbgDoma.SumList.RecalcAll;
      ShowMessage('Расчет окончен...');
    except
      ShowMessage('Не удалось расчитать прибор учета...');
    end;
  end;
end;

procedure TFmePokPrib.CalcAllPribClick(Sender: TObject);
begin
  {Расчет всех}
  W:=TFrmWaitScreen.Create(Application);
  W.Show;
  W.Update;
  with spQprib do
  begin
    ParamByName('kod').AsInteger:=0;
    ParamByName('data').AsDate:=StrToDate(FrmMain.WorkDate);
    try
      Execute;
    except
      ShowMessage('Не удалось расчитать прибор учета...');
    end;
  end;
  W.Free;
end;

procedure TFmePokPrib.BtnPrintClick(Sender: TObject);
begin
  {Лицевой по прибору}
  CP:=TFrmChangePeriod.Create(Application);
  try
    CP.ShowModal;
    CP.cboEnd.Enabled:=False;
    with dp.qryLicevPrObekt do
    begin
      Params.ParamValues['data1']:=FrmMain.Data1;
    end;
    with dp.qryLicevPrDoma do
    begin
      Params.ParamValues['data1']:=FrmMain.Data1;
    end;
    dp.Report.LoadFromFile(FrmMain.RPath+'Показания приборов.fr3');
    dp.Report.Variables['period']:=PeriodStr(FrmMain.Data1,Null);
    dp.Report.ShowReport;
  finally
    CP.Free;
  end;
end;

procedure TFmePokPrib.BtnHistoryPokClick(Sender: TObject);
begin
  {История показаний прибора учета}
  FH:=TFrmHistoryPokPrib.Create(Application);
  try
    FH.ShowModal;
  finally
    FH.Free;
  end;
end;

procedure TFmePokPrib.RzToolButton1Click(Sender: TObject);
begin
  FrmMain.pgcWork.ActivePage:=FrmMain.TabWelcome;
end;

end.

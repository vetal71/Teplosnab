unit PokPribForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGridEh, RzPanel, DBCtrls, RzDBCmbo, RzButton, ExtCtrls,
  ImgList, StdCtrls, RzLabel, Str_fun, DB, MemDS, DBAccess, MSAccess, Menus,
  EditPokForm,ChangePeriodForm, CalcPribForDayForm, CalcPribForGvs,
  CalcPribForOtGvs, WaitScreenForm, HistoryPokPribForm, GridsEh,
  DBGridEhGrouping;

type
  TFrmPokPrib = class(TForm)
    lblCaption: TRzLabel;
    ImageList1: TImageList;
    RzToolbar1: TRzToolbar;
    BtnEditPok: TRzToolButton;
    RzSpacer1: TRzSpacer;
    BtnCalc: TRzToolButton;
    RzSpacer12: TRzSpacer;
    BtnFilterOrg: TRzToolButton;
    RzSpacer3: TRzSpacer;
    RzSpacer2: TRzSpacer;
    btnDelFilter: TRzToolButton;
    RzSpacer7: TRzSpacer;
    BtnPrint: TRzToolButton;
    RzSpacer4: TRzSpacer;
    btnPeriod: TRzToolButton;
    RzSpacer5: TRzSpacer;
    BtnUndo: TRzToolButton;
    RzSpacer6: TRzSpacer;
    BtnHistoryPok: TRzToolButton;
    RzSpacer8: TRzSpacer;
    lcbFilter: TRzDBLookupComboBox;
    RzPanel1: TRzPanel;
    dbgPribor: TDBGridEh;
    pmCalc: TPopupMenu;
    CalcForDays: TMenuItem;
    CalcForRashod: TMenuItem;
    N3: TMenuItem;
    Delenie: TMenuItem;
    N5: TMenuItem;
    CalcCurentPrib: TMenuItem;
    CalcAllPrib: TMenuItem;
    spQprib: TMSStoredProc;
    procedure FormShow(Sender: TObject);
    procedure BtnFilterOrgClick(Sender: TObject);
    procedure btnDelFilterClick(Sender: TObject);
    procedure lcbFilterCloseUp(Sender: TObject);
    procedure BtnEditPokClick(Sender: TObject);
    procedure CalcForDaysClick(Sender: TObject);
    procedure CalcForRashodClick(Sender: TObject);
    procedure DelenieClick(Sender: TObject);
    procedure CalcCurentPribClick(Sender: TObject);
    procedure CalcAllPribClick(Sender: TObject);
    procedure btnPeriodClick(Sender: TObject);
    procedure BtnUndoClick(Sender: TObject);
    procedure BtnHistoryPokClick(Sender: TObject);
    procedure BtnPrintClick(Sender: TObject);
  private
    W:TFrmWaitScreen;
    F:TFrmEditPok;
    CP:TFrmChangePeriod;
    FCD:TFrmCalcPribForDay;
    FCG:TFrmCalcPribForGvs;
    FCOG:TFrmCalcGvsOt;
    FH:TFrmHistoryPokPrib;
  public
    { Public declarations }
  end;

var
  FrmPokPrib: TFrmPokPrib;

implementation

uses DataModule, MainForm, DataPrint;

{$R *.dfm}

procedure TFrmPokPrib.FormShow(Sender: TObject);
begin
  Caption:='Участок:'+dm.qryKotelnnazk.Value;
  lblCaption.Caption:='Показания приборов учета за '+
  PeriodStr(StrToDate(FrmMain.WorkDate),Null);
  with dm.qryPokPrib do
  begin
    FilterSQL:='a.kodkot = '+IntToStr(dm.qryKotelnkodkot.Value)+
    ' and '+FrmMain.FilterData;
    try
      Open;
    except
      ShowMessage('Не удалось открыть таблицу "Показания приборов"');
    end;
  end;
  BtnEditPok.Enabled:=FrmMain.FlagEdit;
  BtnCalc.Enabled:=FrmMain.FlagEdit;
end;

procedure TFrmPokPrib.BtnFilterOrgClick(Sender: TObject);
begin
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

procedure TFrmPokPrib.btnDelFilterClick(Sender: TObject);
begin
  with dm.qryPokPrib do
    FilterSQL:='a.kodkot = '+IntToStr(dm.qryKotelnkodkot.Value)+
    ' and '+FrmMain.FilterData;
  with lcbFilter do
  begin
    KeyField:='';
    ListField:='';
    ListSource:=nil;
    Enabled:=False;
  end;  
end;

procedure TFrmPokPrib.lcbFilterCloseUp(Sender: TObject);
begin
 if Not VarIsNull(lcbFilter.KeyValue) then
  with dm.qryPokPrib do
    FilterSQL:=FilterSQL+' and a.kodorg='+IntToStr(lcbFilter.KeyValue)
 else ShowMessage('Оргнаизацию надо выбрать...');
end;

procedure TFrmPokPrib.BtnEditPokClick(Sender: TObject);
begin
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

procedure TFrmPokPrib.CalcForDaysClick(Sender: TObject);
begin
  {Расчет по дням}
  FrmMain.CurRec:=dm.qryPokPribkod.Value;
  FCD:=TFrmCalcPribForDay.Create(Application);
  try
    FCD.ShowModal;
  finally
    FCD.Free;
  end;
  dm.qryPokPrib.Refresh;
  dbgPribor.SumList.RecalcAll;
  dm.qryPokPrib.Locate('kod',FrmMain.CurRec,[]);
end;

procedure TFrmPokPrib.CalcForRashodClick(Sender: TObject);
begin
  {Расчет ГВС по кубам}
  FrmMain.CurRec:=dm.qryPokPribkod.Value;
  FCG:=TFrmCalcPribForGvs.Create(Application);
  try
    FCG.ShowModal;
    dbgPribor.SumList.Activate(True);
  finally
    FCG.Free;
  end;
  dm.qryPokPrib.Refresh;
  dbgPribor.SumList.RecalcAll;
  dm.qryPokPrib.Locate('kod',FrmMain.CurRec,[]);
end;

procedure TFrmPokPrib.DelenieClick(Sender: TObject);
begin
  {Делим показания}
  FrmMain.CurRec:=dm.qryPokPribkod.Value;
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
    dm.qryPokPrib.Locate('kod',FrmMain.CurRec,[]);
  end
  else
    ShowMessage('Прибор учета не учитывает горячее водоснабжение...');
end;

procedure TFrmPokPrib.CalcCurentPribClick(Sender: TObject);
begin
  {Расчет текущего прибора учета}
  with spQprib do
  begin
    ParamByName('kod').AsInteger:=dm.qryPokPribkod.Value;
    //ParamByName('kod_kot').AsInteger:=0;
    ParamByName('data').AsDate:=StrToDate(FrmMain.WorkDate);
    //try
      ExecProc;
      ShowMessage('Расчет произведен...');
    //except
    //  ShowMessage('Не удалось расчитать прибор учета...');
    //end;
  end;
end;

procedure TFrmPokPrib.CalcAllPribClick(Sender: TObject);
begin
  {Расчет всех}
  W:=TFrmWaitScreen.Create(Application);
  W.Show;
  W.Update;
  with spQprib do
  begin
    ParamByName('kod').AsInteger:=-1;
    ParamByName('data').AsDate:=StrToDate(FrmMain.WorkDate);
    try
      ExecProc;
      ShowMessage('Расчет произведен...');      
    except
      ShowMessage('Не удалось расчитать прибор учета...');
    end;
  end;
  W.Free;
end;

procedure TFrmPokPrib.btnPeriodClick(Sender: TObject);
begin
  BtnCalc.Enabled:=False;
  BtnEditPok.Enabled:=False;
  CP:=TFrmChangePeriod.Create(Application);
  try
    CP.ShowModal;
    with dm.qryPokPrib do
      FilterSQL:='a.kodkot = '+IntToStr(dm.qryKotelnkodkot.Value)+' and '+
      'b.datan between '''+DateToStr(FrmMain.Data1)+''' and '''+
      DateToStr(FrmMain.Data2)+'''';
    lblCaption.Caption:='Показания приборов с '+
    PeriodStr(FrmMain.Data1,FrmMain.Data2);
  finally
    CP.Free;
  end;
end;

procedure TFrmPokPrib.BtnUndoClick(Sender: TObject);
begin
  BtnCalc.Enabled:=True;
  BtnEditPok.Enabled:=True;
  lblCaption.Caption:='Показания приборов учета за '+
  PeriodStr(StrToDate(FrmMain.WorkDate),null);
  with dm.qryPokPrib do
    FilterSQL:='a.kodkot = '+IntToStr(dm.qryKotelnkodkot.Value)+' and '+
    FrmMain.FilterData;
end;

procedure TFrmPokPrib.BtnHistoryPokClick(Sender: TObject);
begin
  {История показаний прибора учета}
  FH:=TFrmHistoryPokPrib.Create(Application);
  try
    FH.ShowModal;
  finally
    FH.Free;
  end;
end;

procedure TFrmPokPrib.BtnPrintClick(Sender: TObject);
begin
  {Лицевой по прибору}
  CP:=TFrmChangePeriod.Create(Application);
  try
    CP.ShowModal;
    with dp.qryLicevPr do
    begin
      if Active then Close;
      Params.ParamValues['data1']:=FrmMain.Data1;
      Params.ParamValues['data2']:=FrmMain.Data2;
      FilterSQL:='a.kod='+IntToStr(dm.qryPokPribkod.Value);
      Open;
    end;
    with dp.qryLicevPrObekt do
    begin
      Params.ParamValues['data1']:=FrmMain.Data1;
      Params.ParamValues['data2']:=FrmMain.Data2;
    end;
    with dp.qryLicevPrDoma do
    begin
      Params.ParamValues['data1']:=FrmMain.Data1;
      Params.ParamValues['data2']:=FrmMain.Data2;
    end;
    dp.Report.LoadFromFile(FrmMain.RPath+'Лицевой прибора учета.fr3');
    dp.Report.Variables['data1']:=StrToDate(DateToStr(FrmMain.Data1));
    dp.Report.Variables['data2']:=StrToDate(DateToStr(FrmMain.Data2));
    dp.Report.ShowReport;
  finally
    CP.Free;
  end;
end;

end.

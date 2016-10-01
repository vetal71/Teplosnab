unit MainForm;

// {$DEFINE SHOW_AGENT}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RzPanel, RzTabs, RzGroupBar, ExtCtrls, RzSplit, StdCtrls,
  RzLabel, RzCommon, ActnList, {XPMenu, } RzForms, RzBHints, ImgList, Menus,
  OrganizationFrame, RzStatus, ADODB, MSAccess, OLEDBAccess,
  OLEDBC, OLEDBIntf, DBAccess, MemDS, DateUtils, Math, Str_fun,
  VerifyBaseFrame, NaselenieFrame, KotelnFrame, PriborFrame, TarifFrame,
  VidTopFrame, UlicaFrame, ParamsFrame, PerexodFrame, RefreshMonthFrame,
  SrTempFrame, PokPribFrame, ExecSQLFrame, CalcKotelnFrame,
  TB2Item, TB2Dock, TB2Toolbar, TBX, TBXSwitcher, TBXStatusBars, TBXMDI, DB,
  RzBckgnd, ChangePeriodForm, CalcOrgFrame, SelectOrgForm,
  WaitScreenForm, ArhCalcOrgFrame, PredoplataFrame, PlanFrame, ChangePeriodArhForm,
  CalcOrgIdxFrame, scExcelExport, ExcelXP,
  OleCtrls, UsersFrame, RzDBCmbo;

type
  TFrmMain = class(TForm)
    ImageList: TImageList;
    ActionList1: TActionList;
    ActOrganization: TAction;
    ActNaselenie: TAction;
    ActKoteln: TAction;
    ActPribor: TAction;
    ActWindowCloseAll: TAction;
    ActTarif: TAction;
    ActUlica: TAction;
    ExitFromApp: TAction;
    pgcWork: TRzPageControl;
    tabOrganization: TRzTabSheet;
    TabWelcome: TRzTabSheet;
    TabVerify: TRzTabSheet;
    IniFile: TRzRegIniFile;
    ActVerifyDatabase: TAction;
    TabNaselenie: TRzTabSheet;
    TabKoteln: TRzTabSheet;
    ActVidTop: TAction;
    TabPribor: TRzTabSheet;
    TabTarif: TRzTabSheet;
    TabVidTop: TRzTabSheet;
    TabUlica: TRzTabSheet;
    ActParamApp: TAction;
    TabParams: TRzTabSheet;
    ActInputSrTemp: TAction;
    ActNewMonth: TAction;
    ActCloseMonth: TAction;
    TabPerexod: TRzTabSheet;
    ActRefreshNewMonth: TAction;
    TabRefreshMonth: TRzTabSheet;
    ActImportData: TAction;
    TabImport: TRzTabSheet;
    TabSrTemp: TRzTabSheet;
    ActPokPrib: TAction;
    TabPokPrib: TRzTabSheet;
    ActSQLExec: TAction;
    TabExec: TRzTabSheet;
    ActUsers: TAction;
    ActCalcKot: TAction;
    ActCalcOrg: TAction;
    TabCalcKoteln: TRzTabSheet;
    ImageList1: TImageList;
    Docker: TTBXDock;
    TBXSwitcher1: TTBXSwitcher;
    tbrMain: TTBXToolbar;
    Spravochniki: TTBXSubmenuItem;
    TBXItem4: TTBXItem;
    TBXItem1: TTBXItem;
    TBXItem5: TTBXItem;
    TBXSeparatorItem1: TTBXSeparatorItem;
    TBXItem2: TTBXItem;
    TBXSeparatorItem2: TTBXSeparatorItem;
    TBXItem6: TTBXItem;
    TBXItem15: TTBXItem;
    TBXItem7: TTBXItem;
    TBXSeparatorItem3: TTBXSeparatorItem;
    Operation: TTBXSubmenuItem;
    IshData: TTBXSubmenuItem;
    TBXItem16: TTBXItem;
    TBXItem17: TTBXItem;
    Nachislenie: TTBXSubmenuItem;
    TBXItem23: TTBXItem;
    TBXItem26: TTBXItem;
    TBXSeparatorItem16: TTBXSeparatorItem;
    tbrSpr: TTBXToolbar;
    TBXItem3: TTBXItem;
    TBXItem9: TTBXItem;
    TBXSeparatorItem4: TTBXSeparatorItem;
    TBXItem10: TTBXItem;
    TBXItem11: TTBXItem;
    TBXSeparatorItem6: TTBXSeparatorItem;
    TBXItem12: TTBXItem;
    TBXSeparatorItem7: TTBXSeparatorItem;
    TBXItem13: TTBXItem;
    TBXSeparatorItem8: TTBXSeparatorItem;
    TBXItem14: TTBXItem;
    TBXToolbar1: TTBXToolbar;
    TBXToolbar2: TTBXToolbar;
    TBXSubmenuItem3: TTBXSubmenuItem;
    Servis: TTBXSubmenuItem;
    TBXItem22: TTBXItem;
    tbrAdmin: TTBXToolbar;
    RzBackground2: TRzBackground;
    TBXSubmenuItem4: TTBXSubmenuItem;
    TBXItem24: TTBXItem;
    TBXItem28: TTBXItem;
    TBXToolbar4: TTBXToolbar;
    TBXSubmenuItem5: TTBXSubmenuItem;
    qryExec: TMSSQL;
    TabCalcOrg: TRzTabSheet;
    TBXItem29: TTBXItem;
    TBXItem30: TTBXItem;
    TBXSeparatorItem9: TTBXSeparatorItem;
    Admin: TTBXSubmenuItem;
    TBXItem31: TTBXItem;
    TBXItem32: TTBXItem;
    TBXItem33: TTBXItem;
    TBXItem34: TTBXItem;
    TBXSeparatorItem10: TTBXSeparatorItem;
    TBXSeparatorItem11: TTBXSeparatorItem;
    TBXToolbar5: TTBXToolbar;
    TBXSubmenuItem6: TTBXSubmenuItem;
    TBXItem27: TTBXItem;
    TBXItem37: TTBXItem;
    TBXSubmenuItem7: TTBXSubmenuItem;
    TBXItem38: TTBXItem;
    TBXItem39: TTBXItem;
    ACtObSvodOt: TAction;
    ActObSvodVk: TAction;
    TBXItem25: TTBXItem;
    TBXItem35: TTBXItem;
    TBXItem36: TTBXItem;
    TBXSubmenuItem9: TTBXSubmenuItem;
    TBXItem42: TTBXItem;
    TBXItem43: TTBXItem;
    TBXItem44: TTBXItem;
    TBXItem45: TTBXItem;
    TBXItem46: TTBXItem;
    TBXItem47: TTBXItem;
    TBXItem48: TTBXItem;
    TBXSeparatorItem12: TTBXSeparatorItem;
    ActCopyBd: TAction;
    ActBackupBd: TAction;
    ActNac: TAction;
    TBXItem8: TTBXItem;
    ActRasKot: TAction;
    TBXSubmenuItem1: TTBXSubmenuItem;
    TBXItem18: TTBXItem;
    TBXItem19: TTBXItem;
    ActRasUslugi: TAction;
    ActRasMesto: TAction;
    TBXItem20: TTBXItem;
    ActEcNalog: TAction;
    TBXItem21: TTBXItem;
    TBXItem40: TTBXItem;
    TBXSubmenuItem2: TTBXSubmenuItem;
    TBXItem41: TTBXItem;
    TBXItem49: TTBXItem;
    ActAnalizPrib: TAction;
    ActAnalizKot: TAction;
    ActAnalizOrg: TAction;
    TBXItem50: TTBXItem;
    TBXItem51: TTBXItem;
    TBXItem52: TTBXItem;
    ActNormativ: TAction;
    ActSchet: TAction;
    TBXItem53: TTBXItem;
    TBXSeparatorItem5: TTBXSeparatorItem;
    TBXSeparatorItem13: TTBXSeparatorItem;
    TBXItem54: TTBXItem;
    TBXSeparatorItem14: TTBXSeparatorItem;
    ActArhPotr: TAction;
    TBXToolbar3: TTBXToolbar;
    ActRecalc: TAction;
    ActPlan: TAction;
    ActPlanSchet: TAction;
    TBXItem55: TTBXItem;
    TabCalcOrgArh: TRzTabSheet;
    TabPredoplata: TRzTabSheet;
    TabPlan: TRzTabSheet;
    TabUsers: TRzTabSheet;
    ActVed: TAction;
    TBXItem56: TTBXItem;
    TBXSeparatorItem15: TTBXSeparatorItem;
    TBXSeparatorItem17: TTBXSeparatorItem;
    TBXItem57: TTBXItem;
    TBXSeparatorItem18: TTBXSeparatorItem;
    TBXItem58: TTBXItem;
    ActCrArh: TAction;
    ActTop: TAction;
    TBXSeparatorItem19: TTBXSeparatorItem;
    TBXItem59: TTBXItem;
    TBXSeparatorItem20: TTBXSeparatorItem;
    TBXItem60: TTBXItem;
    spVerifyTop: TMSStoredProc;
    RzBalloonHints1: TRzBalloonHints;
    actEcNalogLg: TAction;
    TBXItem61: TTBXItem;
    TBXItem62: TTBXItem;
    SB: TTBXStatusBar;
    RzLabel9: TRzLabel;
    TBXItem63: TTBXItem;
    TBXItem64: TTBXItem;
    TBXSeparatorItem21: TTBXSeparatorItem;
    TBXItem65: TTBXItem;
    TabCalcIdxOrg: TRzTabSheet;
    TBXSeparatorItem22: TTBXSeparatorItem;
    IdxReport: TTBXItem;
    TBXSeparatorItem23: TTBXSeparatorItem;
    TBXItem66: TTBXItem;
    actPropis: TAction;
    TBXSeparatorItem24: TTBXSeparatorItem;
    TBXItem67: TTBXItem;
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ActOrganizationExecute(Sender: TObject);
    procedure ExitFromAppExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ActVerifyDatabaseExecute(Sender: TObject);
    procedure ActNaselenieExecute(Sender: TObject);
    procedure ActKotelnExecute(Sender: TObject);
    procedure ActPriborExecute(Sender: TObject);
    procedure ActTarifExecute(Sender: TObject);
    procedure ActVidTopExecute(Sender: TObject);
    procedure ActUlicaExecute(Sender: TObject);
    procedure ActParamAppExecute(Sender: TObject);
    procedure ActCloseMonthExecute(Sender: TObject);
    procedure ActNewMonthExecute(Sender: TObject);
    procedure ActRefreshNewMonthExecute(Sender: TObject);
    procedure ActImportDataExecute(Sender: TObject);
    procedure ActInputSrTempExecute(Sender: TObject);
    procedure ActPokPribExecute(Sender: TObject);
    procedure ActSQLExecExecute(Sender: TObject);
    procedure ActCalcKotExecute(Sender: TObject);
    procedure TBXItem8Click(Sender: TObject);
    procedure ActCalcOrgExecute(Sender: TObject);
    procedure ACtObSvodOtExecute(Sender: TObject);
    procedure ActObSvodVkExecute(Sender: TObject);
    procedure ActNacExecute(Sender: TObject);
    procedure ActRasKotExecute(Sender: TObject);
    procedure ActRasUslugiExecute(Sender: TObject);
    procedure ActRasMestoExecute(Sender: TObject);
    procedure ActEcNalogExecute(Sender: TObject);
    procedure ActAnalizPribExecute(Sender: TObject);
    procedure ActAnalizKotExecute(Sender: TObject);
    procedure ActAnalizOrgExecute(Sender: TObject);
    procedure ActNormativExecute(Sender: TObject);
    procedure ActSchetExecute(Sender: TObject);
    procedure ActArhPotrExecute(Sender: TObject);
    procedure ActRecalcExecute(Sender: TObject);
    procedure ActPlanExecute(Sender: TObject);
    procedure ActPlanSchetExecute(Sender: TObject);
    procedure ActCopyBdExecute(Sender: TObject);
    procedure ActBackupBdExecute(Sender: TObject);
    procedure ActUsersExecute(Sender: TObject);
    procedure ActVedExecute(Sender: TObject);
    procedure ActCrArhExecute(Sender: TObject);
    procedure ActTopExecute(Sender: TObject);
    procedure actEcNalogLgExecute(Sender: TObject);
    procedure TBXItem63Click(Sender: TObject);
    procedure CalcIdxClick(Sender: TObject);
    procedure IdxReportClick(Sender: TObject);
    procedure Export2Excel(KindUsluga: Integer; ReportSet: TDataSet);
    procedure actPropisExecute(Sender: TObject);
  private
    FORganization:TFmeOrganization;
    FVerify:TFmeVerifyBase;
    FNas:TFmeNaselenie;
    FKot:TFmeKoteln;
    FPr:TFmePribor;
    FT:TFmeTarif;
    FV:TFmeVidTop;
    FU:TFmeUlica;
    FP:TFmeParams;
    FX:TFmePerexod;
    FR:TFmeRefreshMonth;
//    FI:TFmeImport;
    FS:TFmeSrTemp;
    FPK:TFmePokPrib;
    FE:TFmeExecSQL;
    FCK:TFmeCalcKoteln;
    FCp:TFrmChangePeriod;
    FCA:TFrmChangePeriodArh;
    FO:TFmeCalcOrg;
    FI:TFmeCalcIdxOrg;
    FA:TFmeArhCalcOrg;
    FSP:TFrmSelectOrg;
    WS:TFrmWaitScreen;
    FPD:TFrmPredoplata;
    FPL:TFmePlan;
    FUS:TFmeUsers;
  public
    DBState, CurRec, CurRec1, MR:Integer;
    DBQuery:TMSQuery;
    DBField, ServerName, User, WorkDate:string;
    ProgPath, RPath, UsrName, FilterData:String;
    CloseMonth, Perexod, FlagEdit, FlagDesign:Boolean;
    Data1, Data2:double;
    procedure ReadIniFile;
  end;

var
  FrmMain: TFrmMain;

implementation

uses DataModule, DataPrint, DBCtrls, uWaitForm, ShellAPI, EditPropis;

{$R *.dfm}

procedure TFrmMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose:=Application.MessageBox('Вы хотите выйти из программы?',
  'Предупреждение',mb_YesNo or mb_TaskModal or mb_IconQuestion)=idYes;
end;

procedure TFrmMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  dm.Conect.Connected:=False;
end;

procedure TFrmMain.ActOrganizationExecute(Sender: TObject);
begin
  // Работа со справочником Организации
  if FOrganization = nil then
  begin
    FOrganization := TFmeOrganization.Create( Application );
    FOrganization.Parent := tabOrganization;
    FOrganization.Align := alClient;
    FOrganization.Init;
  end;
  PgcWork.ActivePage := tabOrganization;
end;

procedure TFrmMain.ExitFromAppExecute(Sender: TObject);
begin
  close;
end;

procedure TFrmMain.FormShow(Sender: TObject);
begin
  with dm.Conect do
  begin
    Database:='Teplosnab';
    try
      Connect;
      if not Connected then
        Application.Terminate;
    except
      Application.Terminate;
    end;
    // Устанавливает параметры
    with qryExec do
    begin
      SQL.Clear;
      SQL.Add(Format('exec sp_defaultlanguage %s, %s',[UserName, 'русский']));  
      Execute;
    end;
    User:=Username;
    sb.Panels[0].Caption:='К серверу подключен...'+User;
    if User = 'admin' then
    begin
      tbrAdmin.Visible:=True;
      Admin.Visible:=True;
    end
    else
    begin
      tbrAdmin.Visible:=False;
      Admin.Visible:=False;
    end;
    sb.Panels[2].Caption:=FormatDateTime('"Сегодня:" dddd, d mmmm yyyy "г."',Now());
    with dm.qryKoteln do
      if Not Active then Open;
  end;
  ProgPath := ExtractFilePath(Application.ExeName);
  RPath    := ProgPath + 'Template\';
  pgcWork.SetFocus;
  ReadIniFile;

end;

procedure TFrmMain.ReadIniFile;
begin
  with dm.qryParamOrg do
  begin
    if Active then Close;
    try
      Open;
      SB.Panels[1].Caption:='Расчетный период '+dm.qryParamOrg['period_name']+' г.';
      WorkDate:=DateToStr(DateOfPeriod(dm.qryParamOrg['rasch_period']));
    except
      ShowMessage('Не удалось прочитать параметры системы...');
    end;
  end;
  with IniFile do
    FlagDesign := ReadBool('Configuration','IsDesign',False);
end;

procedure TFrmMain.ActVerifyDatabaseExecute(Sender: TObject);
begin
  // Проверка базы данных
  if FVerify = nil then
  begin
    FVerify := TFmeVerifyBase.Create( Application );
    FVerify.Parent := TabVerify;
    FVerify.Align := alClient;
    FVerify.Init;
  end;
  PgcWork.ActivePage := TabVerify;
end;

procedure TFrmMain.ActNaselenieExecute(Sender: TObject);
begin
  // Население
  if FNas = nil then 
  begin
    FNas := TFmeNaselenie.Create( Application );
    FNas.Parent := TabNaselenie;
    FNas.Align := alClient;
    FNas.Init;
  end;
  PgcWork.ActivePage := TabNaselenie;
end;

procedure TFrmMain.ActKotelnExecute(Sender: TObject);
begin
  {Работа со справочником Котельные}
  if FKot = nil then
  begin
    FKot := TFmeKoteln.Create( Application );
    FKot.Parent := TabKoteln;
    FKot.Align := alClient;
    FKot.Init;
  end;
  PgcWork.ActivePage := TabKoteln;
end;

procedure TFrmMain.ActPriborExecute(Sender: TObject);
begin
  {Приборы учета}
  if Fpr = nil then
  begin
    Fpr := TFmePribor.Create( Application );
    Fpr.Parent := TabPribor;
    Fpr.Align := alClient;
    Fpr.Init;
  end;
  PgcWork.ActivePage := TabPribor;
end;

procedure TFrmMain.ActTarifExecute(Sender: TObject);
begin
  {Тарифы}
  if FT = nil then
  begin
    FT := TFmeTarif.Create( Application );
    FT.Parent := TabTarif;
    FT.Align := alClient;
    FT.Init;
  end;
  PgcWork.ActivePage := TabTarif;
end;

procedure TFrmMain.ActVidTopExecute(Sender: TObject);
begin
  {Виды топлива}
  if FV = nil then
  begin
    FV := TFmeVidTop.Create( Application );
    FV.Parent := TabVidTop;
    FV.Align := alClient;
    FV.Init;
  end;
  PgcWork.ActivePage := TabVidTop;
end;

procedure TFrmMain.ActUlicaExecute(Sender: TObject);
begin
  {Улицы}
  if FU = nil then
  begin
    FU := TFmeUlica.Create( Application );
    FU.Parent := TabUlica;
    FU.Align := alClient;
    FU.Init;
  end;
  PgcWork.ActivePage := TabUlica;
end;

procedure TFrmMain.ActParamAppExecute(Sender: TObject);
begin
  {Настройка параметров}
  if FP = nil then
  begin
    FP := TFmeParams.Create( Application );
    FP.Parent := TabParams;
    FP.Align := alClient;
    FP.Init;
  end;   
  PgcWork.ActivePage := TabParams;
end;

procedure TFrmMain.ActCloseMonthExecute(Sender: TObject);
Var
   s:string;
   p:PChar;
begin
  {Закрытие месяца}
  p:=StrAlloc(250*SizeOf(Char));
  s:='Вы действительно хотите закрыть '+
      FormatDateTime('"расчетный период:" mmmm, yyyy "г."',StrToDate(WorkDate))+#10#13+
      'Все расчеты текущего периода будут недоступны!'+#10#13+
      'Сейчас будет закрыт доступ к базе данных, поэтому пользователям'+
      ' нужно выйти из приложения!!!';
  StrPCopy(p,s);
  if Application.MessageBox(p,
  'Предупреждение',mb_YesNo or mb_TaskModal or mb_IconQuestion)=idYes then
  try
//    StatusText.Caption:='ЗАКРЫТИЕ МЕСЯЦА.ВСЕМ ВЫЙТИ...';
//    StatusText.Blinking:=True;
    Beep;
    if Application.MessageBox('Все вышли из программы ?',
    'Предупреждение',mb_YesNo or mb_TaskModal or mb_IconQuestion)=idYes then
    begin
      dm.Conect.Connected:=False;
      with IniFile do
        WriteBool('Configuration','CloseMonth',True);
      ShowMessage(FormatDateTime('"Расчетный период:" mmmm, yyyy "г. закрыт. Переходите в новый месяц..."',StrToDate(WorkDate)));
      dm.Conect.Connected:=True;
//      StatusText.Caption:='К серверу подключен...'+User;
//      StatusText.Blinking:=False;
      ReadIniFile;
    end;
  except
    ShowMessage('Не удалось закрыть период...');
  end;
end;

procedure TFrmMain.ActNewMonthExecute(Sender: TObject);
begin
  {Переход на новый месяц}
  if FX = nil then
  begin
    FX := TFmePerexod.Create( Application );
    FX.Parent := TabPerexod;
    FX.Align := alClient;
    FX.Init;
  end;
  PgcWork.ActivePage := TabPerexod;
end;

procedure TFrmMain.ActRefreshNewMonthExecute(Sender: TObject);
begin
  {Обновление на новый месяц}
  if FR = nil then
  begin
    FR := TFmeRefreshMonth.Create( Application );
    FR.Parent := TabRefreshMonth;
    FR.Align := alClient;
    FR.Init;
  end;
  PgcWork.ActivePage := TabRefreshMonth;
end;

procedure TFrmMain.ActImportDataExecute(Sender: TObject);
begin
  {импорт данных}
//  if FI = nil then
//  begin
//    FI := TFmeImport.Create( Application );
//    FI.Parent := TabImport;
//    FI.Align := alClient;
//    FI.Init;
//  end;
//  PgcWork.ActivePage := TabImport;
end;

procedure TFrmMain.ActInputSrTempExecute(Sender: TObject);
begin
  {Средние температуры}
  if FS = nil then
  begin
    FS := TFmeSrTemp.Create( Application );
    FS.Parent := TabSrTemp;
    FS.Align := alClient;
    FS.Init;
  end;
  PgcWork.ActivePage := TabSrTemp;
end;

procedure TFrmMain.ActPokPribExecute(Sender: TObject);
begin
  {Показания приборов}
  if FPK = nil then
  begin
    FPK := TFmePokPrib.Create( Application );
    FPK.Parent := TabPokPrib;
    FPK.Align := alClient;
    FPK.Init;
  end;
  PgcWork.ActivePage := TabPokPrib;
end;

procedure TFrmMain.ActSQLExecExecute(Sender: TObject);
begin
  {SQL Executor}
  if FE = nil then
  begin
    FE := TFmeExecSQL.Create( Application );
    FE.Parent := TabExec;
    FE.Align := alClient;
    FE.Init;
  end;
  PgcWork.ActivePage := TabExec;
end;

procedure TFrmMain.ActCalcKotExecute(Sender: TObject);
begin
  {Начисления по котельным}
  if FCK = nil then
  begin
    FCK := TFmeCalcKoteln.Create( Application );
    FCK.Parent := TabCalcKoteln;
    FCK.Align := alClient;
    FCK.Init;
  end;
  PgcWork.ActivePage := TabCalcKoteln;
end;

procedure TFrmMain.TBXItem8Click(Sender: TObject);
begin
  FCp:=TFrmChangePeriod.Create(Application);
  try
    FCp.ShowModal;
  finally
    FCP.Free;
  end;   
end;

procedure TFrmMain.ActCalcOrgExecute(Sender: TObject);
begin
  {Расчеты по организациям}
  if FO = nil then
  begin
    FO := TFmeCalcOrg.Create( Application );
    FO.Parent := TabCalcOrg;
    FO.Align := alClient;
    FO.Init;
  end;
  PgcWork.ActivePage := TabCalcOrg;
end;

procedure TFrmMain.ACtObSvodOtExecute(Sender: TObject);
begin
  {Общий свод}
  FCP:=TFrmChangePeriod.Create(Application);
  try
    FCP.ShowModal;
    with qryExec do
    begin
      SQL.Clear;
      SQL.Add('EXECUTE sp_general_report :data1,:data2');
      ParamByName('data1').AsDate:=Data1;
      ParamByName('data2').AsDate:=Data2;
      Execute;
    end;
    with dp.qryObSvodOt do
    begin
      if Active then Close;
      Open;
    end;
    dp.Report.LoadFromFile(FrmMain.RPath+'Общий свод.fr3');
    dp.Report.Variables['period']:=PeriodStr(Data2,Data2);
    if not FlagDesign then
      dp.Report.ShowReport
    else
      dp.Report.DesignReport();
  finally
    FCP.Free;
  end;
end;

procedure TFrmMain.ActObSvodVkExecute(Sender: TObject);
begin
  {Общий свод вода и канализация}
  FCP:=TFrmChangePeriod.Create(Application);
  try
    FCP.ShowModal;
    with qryExec do
    begin
      SQL.Clear;
      SQL.Add('EXECUTE sp_ob_svod_vk :data1,:data2');
      ParamByName('data1').AsDate:=Data1;
      ParamByName('data2').AsDate:=Data2;
      Execute;
    end;
    with dp.qryObSvodVk do
    begin
      if Active then Close;
      Open;
    end;
    dp.Report.LoadFromFile(FrmMain.RPath+'Общий свод (вода).fr3');
    dp.Report.Variables['period']:=PeriodStr(Data2,Data2);
    if not FlagDesign then
      dp.Report.ShowReport
    else
      dp.Report.DesignReport();
  finally
    FCP.Free;
  end;
end;

procedure TFrmMain.ActNacExecute(Sender: TObject);
begin
  {Расшифровка начислений}
  FCP:=TFrmChangePeriod.Create(Application);
  try
    FCP.ShowModal;
    with qryExec do
    begin
      SQL.Clear;
      SQL.Add('EXECUTE sp_ras_nac :data1,:data2');
      SQL.Add('EXECUTE sp_ras_nac_vk :data1,:data2');
      SQL.Add('EXECUTE sp_ras_nac_g :data1,:data2');
      ParamByName('data1').AsDate:=Data1;
      ParamByName('data2').AsDate:=Data2;
      Execute;
    end;
    with dp.qryRasNacOt do
    begin
      if Active then Close;
      Open;
    end;
    with dp.qryRasNacVk do
    begin
      if Active then Close;
      Open;
    end;
    with dp.qryRasNacG do
    begin
      if Active then Close;
      Open;
    end;
    dp.Report.LoadFromFile(FrmMain.RPath+'Начисление (тепло).fr3');
    dp.Report.Variables['period']:=PeriodStr(Data2,Data2);
    if not FlagDesign then
      dp.Report.ShowReport
    else
      dp.Report.DesignReport();
  finally
    FCP.Free;
  end;
end;

procedure TFrmMain.ActRasKotExecute(Sender: TObject);
begin
  {Расшифровка по участкам}
  FCP:=TFrmChangePeriod.Create(Application);
  try
    FCP.ShowModal;
    with qryExec do
    begin
      SQL.Clear;
      SQL.Add('EXECUTE sp_ras_kot_ot :data1,:data2');
      SQL.Add('EXECUTE sp_ras_kot_vk :data1,:data2');
      SQL.Add('EXECUTE sp_ras_kot_g :data1,:data2');
      ParamByName('data1').AsDate:=Data1;
      ParamByName('data2').AsDate:=Data2;
      Execute;
    end;
    with dp.qryRasKotOt do
    begin
      if Active then Close;
      Open;
    end;
    with dp.qryRasKotVk do
    begin
      if Active then Close;
      Open;
    end;
    with dp.qryRasKotG do
    begin
      if Active then Close;
      Open;
    end;
    dp.Report.LoadFromFile(FrmMain.RPath+'Расшифровка (участки).fr3');
    dp.Report.Variables['period']:=PeriodStr(Data2,Data2);
    if not FlagDesign then
      dp.Report.ShowReport
    else
      dp.Report.DesignReport();
  finally
    FCP.Free;
  end;
end;

procedure TFrmMain.ActRasUslugiExecute(Sender: TObject);
begin
  {по услугам}
  FCP:=TFrmChangePeriod.Create(Application);
  try
    FCP.ShowModal;
  finally
    FCP.Free;
  end;
  with qryExec do
  begin
    SQL.Clear;
    SQL.Add('EXECUTE sp_ras_ot :data1,:data2');
    SQL.Add('EXECUTE sp_ras_vk :data1,:data2');
    ParamByName('data1').AsDate:=Data1;
    ParamByName('data2').AsDate:=Data2;
    Execute;
  end;
  with dp.qryRasOt do
  begin
    if Active then Close;
    Open;
  end;
  with dp.qryRasVk do
  begin
    if Active then Close;
    Open;
  end;
  dp.Report.LoadFromFile(FrmMain.RPath+'Расшифровка (услуги).fr3');
  dp.Report.Variables['period']:=PeriodStr(Data2,Data2);
  if not FlagDesign then
      dp.Report.ShowReport
    else
      dp.Report.DesignReport();
end;

procedure TFrmMain.ActRasMestoExecute(Sender: TObject);
begin
  {по местоположению}
  FCP:=TFrmChangePeriod.Create(Application);
  try
    FCP.ShowModal;
    with qryExec do
    begin
      SQL.Clear;
      SQL.Add('EXECUTE sp_ras_kot_ot_m :data1,:data2');
      SQL.Add('EXECUTE sp_ras_kot_vk_m :data1,:data2');
      ParamByName('data1').AsDate:=Data1;
      ParamByName('data2').AsDate:=Data2;
      Execute;
    end;
    with dp.qryRasKotOtMesto do
    begin
      if Active then Close;
      Open;
    end;
    with dp.qryRasKotVkMesto do
    begin
      if Active then Close;
      Open;
    end;
    dp.Report.LoadFromFile(FrmMain.RPath+'Расшифровка (место).fr3');
    dp.Report.Variables['period']:=PeriodStr(Data2,Data2);
    if not FlagDesign then
      dp.Report.ShowReport
    else
      dp.Report.DesignReport();
  finally
    FCP.Free;
  end;
end;

procedure TFrmMain.ActEcNalogExecute(Sender: TObject);
begin
  {экология}
  FCP:=TFrmChangePeriod.Create(Application);
  try
    FCP.ShowModal;
    with qryExec do
    begin
      SQL.Clear;
      SQL.Add('EXECUTE sp_ecnal :data1,:data2');
      ParamByName('data1').AsDate:=Data1;
      ParamByName('data2').AsDate:=Data2;
      Execute;
    end;
    with dp.qryEcnal do
    begin
      if Active then Close;
      Open;
    end;
    dp.Report.LoadFromFile(FrmMain.RPath+'Экология.fr3');
    dp.Report.Variables['period']:=PeriodStr(Data2,Data2);
    if not FlagDesign then
      dp.Report.ShowReport
    else
      dp.Report.DesignReport();
  finally
    FCP.Free;
  end;
end;

procedure TFrmMain.actEcNalogLgExecute(Sender: TObject);
begin
  // Отчет по экологии (льготы)
  FCP:=TFrmChangePeriod.Create(Application);
  try
    FCP.ShowModal;
    with qryExec do
    begin
      SQL.Clear;
      SQL.Add('EXECUTE sp_ras_kot_el :data1,:data2');
      ParamByName('data1').AsDate:=Data1;
      ParamByName('data2').AsDate:=Data2;
      Execute;
    end;
    with dp.qryEcLgot do
    begin
      if Active then Close;
      Open;
    end;
    dp.Report.LoadFromFile(FrmMain.RPath+'Экология (льготы).fr3');
    dp.Report.Variables['period']:=PeriodStr(Data2,Data2);
    if not FlagDesign then
      dp.Report.ShowReport
    else
      dp.Report.DesignReport();
  finally
    FCP.Free;
  end;
end;

procedure TFrmMain.ActAnalizPribExecute(Sender: TObject);
begin
  {Анализ приборов}
  FCP:=TFrmChangePeriod.Create(Application);
  try
    FCP.ShowModal;
    with qryExec do
    begin
      SQL.Clear;
      SQL.Add('EXECUTE sp_analiz_prib :data1,:data2');
      ParamByName('data1').AsDate:=Data1;
      ParamByName('data2').AsDate:=Data2;
      Execute;
    end;
    with dp.qryAnalizPrib do
    begin
      if Active then Close;
      Open;
    end;
    dp.Report.LoadFromFile(FrmMain.RPath+'Анализ приборов.fr3');
    dp.Report.Variables['period']:=PeriodStr(Data2,Data2);
    if not FlagDesign then
      dp.Report.ShowReport
    else
      dp.Report.DesignReport();
  finally
    FCP.Free;
  end;
end;

procedure TFrmMain.ActAnalizKotExecute(Sender: TObject);
begin
  {Анализ по участкам}
  FCP:=TFrmChangePeriod.Create(Application);
  try
    FCP.ShowModal;
    with qryExec do
    begin
      SQL.Clear;
      SQL.Add('EXECUTE sp_analiz_kot :data');
      ParamByName('data').AsDate:=Data2;
      Execute;
    end;
    with dp.qryAnalizKot do
    begin
      if Active then Close;
      Open;
    end;
    dp.Report.LoadFromFile(FrmMain.RPath+'Анализ участков.fr3');
    dp.Report.Variables['period']:=PeriodStr(Data2,Null);
    if not FlagDesign then
      dp.Report.ShowReport
    else
      dp.Report.DesignReport();
  finally
    FCP.Free;
  end;
end;

procedure TFrmMain.ActAnalizOrgExecute(Sender: TObject);
begin
  {Анализ по предприятию}
  FCP:=TFrmChangePeriod.Create(Application);
  try
    FCP.ShowModal;
    with qryExec do
    begin
      SQL.Clear;
      SQL.Add('EXECUTE sp_analiz_org :data');
      ParamByName('data').AsDate:=Data2;
      Execute;
    end;
    with dp.qryAnalizKot do
    begin
      if Active then Close;
      Open;
    end;
    dp.Report.LoadFromFile(FrmMain.RPath+'Анализ предприятия.fr3');
    dp.Report.Variables['period']:=PeriodStr(Data2,Null);
    if not FlagDesign then
      dp.Report.ShowReport
    else
      dp.Report.DesignReport();
  finally
    FCP.Free;
  end;
end;

procedure TFrmMain.ActNormativExecute(Sender: TObject);
begin
  {Норматив}
  FCP:=TFrmChangePeriod.Create(Application);
  try
    FCP.cboEnd.Enabled:=False;
    FCP.RzLabel1.Caption:='За';
    FCP.ShowModal;
    with qryExec do
    begin
      SQL.Clear;
      SQL.Add('EXECUTE sp_normativ :data');
      ParamByName('data').AsDate:=Data2;
      Execute;
    end;
    with dp.qryNormativ do
    begin
      if Active then Close;
      Open;
    end;
    dp.Report.LoadFromFile(FrmMain.RPath+'Фактический норматив.fr3');
    dp.Report.Variables['period']:=PeriodStr(Data1,Null);
    if not FlagDesign then
      dp.Report.ShowReport
    else
      dp.Report.DesignReport();
  finally
    FCP.Free;
  end;
end;

procedure TFrmMain.ActSchetExecute(Sender: TObject);
begin
  {Счет-фактура}
  FSP:=TFrmSelectOrg.Create(Application);
  try
    FSP.cboEnd.Enabled:=False;
    FSP.RzLabel1.Caption:='За';
    FSP.ShowModal;
    with dp.qryParam do
    begin
      if Active then Close;
      Open;
    end;
    with qryExec do
    begin
      SQL.Clear;
      SQL.Add('EXECUTE sp_create_sf :kod,:data');
      ParamByName('kod').AsInteger:=StrToInt(FSP.edtKodOrg.Text);
      ParamByName('data').AsDate:=Data1;
      Execute;
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

      SQL.Add('FROM OBEKT a,dataobekt b');
      SQL.Add('WHERE a.kodobk=b.kodobk');
      SQL.Add('GROUP BY a.kodobk, a.nazv, a.kodorg');
      SQL.Add('ORDER BY a.kodobk');
      FilterSQL:='b.datan = '''+DateToStr(FrmMain.Data1)+'''';
      Open;
    end;
    dp.Report.LoadFromFile(FrmMain.RPath + 'Счет-фактура (полная).fr3');
    dp.Report.Variables['period']:=PeriodStr(FrmMain.Data1,Null);
    if FSP.chkDesign.Checked then
     dp.Report.DesignReport()
    else
     dp.Report.ShowReport;
  finally
    FSP.Free;
  end;
end;

procedure TFrmMain.ActArhPotrExecute(Sender: TObject);
begin
  {Архив потребителей}
  with dp.qryParam do
  begin
    if Active then Close;
    Open;
  end;
  ShowMessage('Архив начислений содержит данные по '
  +DateToStr(dp.qryParam['arh_data'])+'...');
  FCA:=TFrmChangePeriodArh.Create(Application);
  try
    FCA.ShowModal;
  finally
    FCA.Free;
  end;
  if FA = nil then
  begin
    FA := TFmeArhCalcOrg.Create( Application );
    FA.Parent := TabCalcOrgArh;
    FA.Align := alClient;
    FA.Init;
  end;
  PgcWork.ActivePage := TabCalcOrgArh;
end;

procedure TFrmMain.ActRecalcExecute(Sender: TObject);
begin
  {Пересчет}
  if MessageDlg('Будет выполнен пересчет. Продолжить ?', mtConfirmation,
    [mbOK, mbCancel], 0) = mrOK then
  begin
    ShowWait(clGreen);
    try
      with qryExec do
      begin
        SQL.Clear;
        SQL.Add('EXECUTE sp_calc_obk :data1');
        SQL.Add('EXECUTE sp_calc_obk_vk :data1');
        SQL.Add('EXECUTE sp_calc_obk_g :data1');
        SQL.Add('EXECUTE sp_calc_org :data1');
        SQL.Add('EXECUTE sp_calc_org_vk :data1');
        SQL.Add('EXECUTE sp_calc_org_g :data1');
        ParamByName('data1').AsDate:=StrToDate(WorkDate);
        try
          Execute;
        except
          ShowMessage('Ошибка выполнения пересчета...');
        end;
      end;
    finally
      HideWait;
    end;
  end;
end;

procedure TFrmMain.ActPlanExecute(Sender: TObject);
begin
  {Предварительное начисление}
  if FPL = nil then
  begin
    FPL := TFmePlan.Create( Application );
    FPL.Parent := TabPlan;
    FPL.Align := alClient;
    FPL.Init;
  end;
  PgcWork.ActivePage := TabPlan;
end;

procedure TFrmMain.ActPlanSchetExecute(Sender: TObject);
begin
  {Предварительный счет}
  if FPD = nil then
  begin
    FPD := TFrmPredoplata.Create( Application );
    FPD.Parent := TabPredoplata;
    FPD.Align := alClient;
    FPD.Init;
  end;
  PgcWork.ActivePage := TabPredoplata;
end;

procedure TFrmMain.ActCopyBdExecute(Sender: TObject);
begin
  {Резервное копирование}
  WS:=TFrmWaitScreen.Create(Application);
  WS.RzLabel9.Caption:='Выполняется копирование БД';
  WS.Show;
  WS.Update;
  with qryExec do
  begin
    SQL.Clear;
    SQL.Add('EXECUTE sp_backup');
    try
      Execute;
      ShowMessage('Резервное копирование выполнено успешно...');
    except
      ShowMessage('Не удалось выполнить резервное копирование БД...');
    end;
  end;
  WS.Free;
end;

procedure TFrmMain.ActBackupBdExecute(Sender: TObject);
begin
  {Восстановление}
  WS:=TFrmWaitScreen.Create(Application);
  WS.RzLabel9.Caption:='Выполняется восстановление БД';
  WS.Show;
  WS.Update;
  with qryExec do
  begin
    SQL.Clear;
    SQL.Add('EXECUTE sp_restore');
    try
      Execute;
      ShowMessage('Восстановление БД выполнено успешно...');
    except
      ShowMessage('Не удалось выполнить восстановление БД...');
    end;
  end;
  WS.Free;
end;

procedure TFrmMain.ActUsersExecute(Sender: TObject);
begin
  {Юзеры}
  if FUS = nil then
  begin
    FUS := TFmeUsers.Create( Application );
    FUS.Parent := TabUsers;
    FUS.Align := alClient;
    FUS.Init;
  end;
  PgcWork.ActivePage := TabUsers;
end;

procedure TFrmMain.ActVedExecute(Sender: TObject);
Var
  NewLcb: TRzDBLookupComboBox;
  NewLbl:TRzLabel;
begin
  {Вед.жилфонд}
  FCP:=TFrmChangePeriod.Create(Application);
  FCP.Height:=FCP.Height+30;
  NewLbl:=TRzLabel.Create(FCP.RzPanel1);
  NewLbl.Top:=93; NewLbl.Left:=9;
  NewLbl.Caption:='Выбор участка:';
  NewLbl.Parent:=FCP.RzPanel1;
  NewLcb:=TRzDBLookupComboBox.Create(FCP.RzPanel1);
  NewLcb.Top:=FCP.cboEnd.Top+FCP.cboEnd.Height+6;
  NewLcb.Left:=FCP.cboEnd.Left;
  NewLcb.Width:=FCP.cboEnd.Width;
  NewLcb.ListSource:=dm.dsKoteln;
  NewLcb.ListField:='nazk';
  NewLcb.KeyField:='kodkot';
  NewLcb.FrameVisible:=True;
  NewLcb.FlatButtons:=True;
  NewLcb.FrameColor:=clBlack;
  NewLcb.Parent:=FCP.RzPanel1;
  try
    FCP.ShowModal;
    if (NewLcb.KeyValue <> 0) or (NewLcb.KeyValue <> Null) then
    begin
      with dp.qryVed do
      begin
        if Active then Close;
        FilterSQL:='d.prin = 1';
        ParamByName('kod').AsInteger:=NewLcb.KeyValue;
        ParamByName('data').AsDate:=StrToDate(WorkDate);
        Open;
      end;
      dp.Report.LoadFromFile(FrmMain.RPath+'Ведомственный жилфонд.fr3');
      FrmMain.DBField:=NewLcb.Text;
      dp.Report.Variables['koteln']:=NewLcb.Text;
      dp.Report.Variables['period']:=PeriodStr(FrmMain.Data1,Null);
      dp.Report.ShowReport;
    end else ShowMessage('Не выбран участок...');
  finally
    FCP.Free;
  end;
end;

procedure TFrmMain.ActCrArhExecute(Sender: TObject);
begin
  if User = 'admin' then
  begin
  WS:=TFrmWaitScreen.Create(Application);
  WS.RzLabel9.Caption:='Выполняется архивирование БД';
  WS.Show;
  WS.Update;
  with qryExec do
  begin
    SQL.Clear;
    SQL.Add('EXEC sp_create_arh :data');
    ParamByName('data').AsDate:=Date();
    try
      Execute;
    except
      ShowMessage('Не удалось создать архив...');
      exit;
    end;
  end;
  WS.Free;
  end else ShowMessage('У Вас недостаточно прав...');
end;

procedure TFrmMain.ActTopExecute(Sender: TObject);
begin
  {Отчет по топливу}
  FCP:=TFrmChangePeriod.Create(Application);
  FCP.RzLabel1.Caption:='За';
  FCP.RzLabel3.Visible:=False;
  FCP.cboEnd.Visible:=False;
  try
    FCP.ShowModal;
    with spVerifyTop do
    begin
      ParamByName('data').AsDate:=Data1;
      ExecProc;
      ShowMessage(ParamByName('rez').AsString);
    end;
    with qryExec do
    begin
      SQL.Clear;
      SQL.Add('EXECUTE sp_create_vyr :data');
      ParamByName('data').AsDate:=Data1;
      Execute;
    end;
    with dp.qryKot do
    begin
      FilterSQL:='';
      if Active then Close;
      FilterSQL:='datan = '''+DateToStr(Data1)+'''';
      Open;
    end;
    with dp.qryVyr do
    begin
      if Active then Close;
      Open;
    end;
    with dp.qryTop do
    begin
      if Active then Close;
      Open;
    end;
    dp.Report.LoadFromFile(FrmMain.RPath+'Отчет по выработке.fr3');
    dp.Report.Variables['period']:=PeriodStr(FrmMain.Data1,Null);
    if not FlagDesign then
      dp.Report.ShowReport
    else
      dp.Report.DesignReport();
  finally
    FCP.Free;
  end;
end;

procedure TFrmMain.TBXItem63Click(Sender: TObject);
begin
  {Общий свод мусор}
  FCP:=TFrmChangePeriod.Create(Application);
  try
    FCP.ShowModal;
    with qryExec do
    begin
      SQL.Clear;
      SQL.Add('EXECUTE sp_ob_svod_g :data1,:data2');
      ParamByName('data1').AsDate:=Data1;
      ParamByName('data2').AsDate:=Data2;
      Execute;
    end;
    with dp.qryObSvodVk do
    begin
      if Active then Close;
      Open;
    end;
    dp.Report.LoadFromFile(FrmMain.RPath+'Общий свод (мусор).fr3');
    dp.Report.Variables['period']:=PeriodStr(Data2,Data2);
    if not FlagDesign then
      dp.Report.ShowReport
    else
      dp.Report.DesignReport();
  finally
    FCP.Free;
  end;

end;

procedure TFrmMain.CalcIdxClick(Sender: TObject);
begin
  // Индексация
  if FI = nil then
  begin
    FI := TFmeCalcIdxOrg.Create( Application );
    FI.Parent := TabCalcIdxOrg;
    FI.Align := alClient;
    FI.Init;
  end;
  PgcWork.ActivePage := TabCalcIdxOrg;
end;

procedure TFrmMain.Export2Excel(KindUsluga: Integer; ReportSet: TDataSet);
var
  FileName, MailPath, MailClient, usl: string;
begin
  case KindUsluga of
  1: usl := 'Теплоснабжение';
  2: usl := 'Водоснабжение';
  3: usl := 'Водоотведение';
  end;

  MailPath := ProgPath + 'gmail\Mail\Outbox\';
  ForceDirectories(MailPath);

  FileName := usl + '_' + PeriodStr(Data2,null) + '.xls';

  try
    dp.exReport.ExcelVisible     := False;
    dp.exReport.WorksheetName    := 'Report';
    dp.exReport.Dataset          := ReportSet;
    dp.exReport.StyleColumnWidth := cwAutoFit;
    dp.exReport.BeginRowTitles   := 1;
    dp.exReport.ExportDataset;
    dp.exReport.ExcelWorkSheet.Range[ 'A' + IntToStr( dp.exReport.BeginRowTitles ),
      Char( Integer( 'A' ) + ReportSet.Fields.Count - 1 ) +
          IntToStr( dp.exReport.EndRowData ) ].Borders.LineStyle := xlContinuous;
    dp.exReport.SaveAs(MailPath + FileName, ffXLS);
  finally
    dp.exReport.Disconnect;
  end;

end;

procedure TFrmMain.IdxReportClick(Sender: TObject);
var
  qryReport: TMSQuery;
  MailClient: string;
begin
  {Общий свод мусор}
  qryReport := TMSQuery.Create(nil);
  qryReport.Connection := DM.Conect;
  try
    FCP:=TFrmChangePeriod.Create(Application);
    try
      if FCP.ShowModal <> mrOK then Exit;
    finally
      FCP.Free;
    end;
    // Экпорт
    try
      ShowWait(clGreen);
      // отопление
      qryReport.Close;
      qryReport.SQL.Text := 'SELECT a.kodorg, a.nazv, d.kodtt, ' +
          '(SUM(ISNULL(b.gkt,0)+ISNULL(b.gkv,0))+SUM(ISNULL(b.pgkt,0)+ISNULL(b.pgkv,0))) as kol, ' +
          '(SUM(ISNULL(b.symk,0)+ISNULL(b.symgv,0))+SUM(ISNULL(b.pert,0)+ISNULL(b.perv,0))) as summa ' +
          'FROM org a, dataobekt b, obekt c, tarift d ' +
          'WHERE a.kodorg = c.kodorg and c.kodobk = b.kodobk and c.kodtt = d.kodtt ' +
          'and b.datan between :data1 and :data2 ' +
          'and a.tiporg < 2 ' +
          'GROUP BY a.kodorg, a.nazv, d.kodtt ' +
          'HAVING SUM(ISNULL(b.symk,0)+ISNULL(b.symgv,0))+SUM(ISNULL(b.pert,0)+ISNULL(b.perv,0)) !=0 ' +
          'ORDER BY a.nazv';
      qryReport.ParamByName('data1').AsDate := Data1;
      qryReport.ParamByName('data2').AsDate := Data2;
      qryReport.Open;
      Export2Excel(1, qryReport);

      // вода
      qryReport.Close;
      qryReport.SQL.Text := 'SELECT a.kodorg, a.nazv, d.kodtv, ' +
          '(SUM(ISNULL(b.kybv,0))+SUM(ISNULL(b.pkybv,0))) as kol, ' +
          '(SUM(ISNULL(b.symhs,0))+SUM(ISNULL(b.perh,0))) as summa ' +
          'FROM org a, dataobekt b, obekt c, tarifv d ' +
          'WHERE a.kodorg = c.kodorg and c.kodobk = b.kodobk and c.kodtv = d.kodtv ' +
          'and b.datan between :data1 and :data2 ' +
          'and a.tiporg < 2 ' +
          'GROUP BY a.kodorg, a.nazv, d.kodtv ' +
          'HAVING SUM(ISNULL(b.symhs,0))+SUM(ISNULL(b.perh,0)) !=0 ' +
          'ORDER BY a.nazv';
      qryReport.ParamByName('data1').AsDate := Data1;
      qryReport.ParamByName('data2').AsDate := Data2;
      qryReport.Open;
      Export2Excel(2, qryReport);

      // стоки
      qryReport.Close;
      qryReport.SQL.Text := 'SELECT a.kodorg, a.nazv, d.kodtv, ' +
          '(SUM(ISNULL(b.kybk,0))+SUM(ISNULL(b.pkybk,0))) as kol, ' +
          '(SUM(ISNULL(b.symks,0))+SUM(ISNULL(b.perk,0))) as summa ' +
          'FROM org a, dataobekt b, obekt c, tarifv d ' +
          'WHERE a.kodorg = c.kodorg and c.kodobk = b.kodobk and c.kodtv = d.kodtv ' +
          'and b.datan between :data1 and :data2 ' +
          'and a.tiporg < 2 ' +
          'GROUP BY a.kodorg, a.nazv, d.kodtv ' +
          'HAVING SUM(ISNULL(b.symks,0))+SUM(ISNULL(b.perk,0)) !=0 ' +
          'ORDER BY a.nazv';
      qryReport.ParamByName('data1').AsDate := Data1;
      qryReport.ParamByName('data2').AsDate := Data2;
      qryReport.Open;
      Export2Excel(3, qryReport);
      qryReport.Close;
    finally
      HideWait;
    end;
  finally
    qryReport.Free;
  end;

  // Отправка файлов
  MailClient := ProgPath + 'gmail\gmail.exe';
  ShellExecute(Handle, nil, PChar(MailClient), '-s', nil, SW_SHOWNORMAL);

  ShowMessage('Готово!');

end;

procedure TFrmMain.actPropisExecute(Sender: TObject);
begin
  with TfPropis.Create(Application) do begin
    qryPropis.Open;
    qryPropis.Edit;
    if ShowModal = mrOk then
      qryPropis.Post
    else
      qryPropis.Cancel;

    Free;    
  end;
end;

end.

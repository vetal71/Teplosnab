unit NaselenieFrame;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, Grids, DBGridEh, ExtCtrls, RzPanel, StdCtrls, RzCmboBx, DBCtrls,
  RzDBNav, RzButton, Menus, ImgList, RzLabel, RzDBCmbo, UDomaForm, UKvartForm,
  LookHistoryNasForm, frxClass, frxDBSet, DB, MemDS, DBAccess, MSAccess,
  ChangePeriodForm, GridsEh, DBGridEhGrouping;

type
  TFmeNaselenie = class(TFrame)
    RzLabel9: TRzLabel;
    ImageList1: TImageList;
    pmPrint: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    tbrOrg: TRzToolbar;
    RzSpacer1: TRzSpacer;
    BtnFilterOrg: TRzToolButton;
    NavigateOrg: TRzDBNavigator;
    RzPanel1: TRzPanel;
    Splitter1: TSplitter;
    RzPanel2: TRzPanel;
    dbgDoma: TDBGridEh;
    RzPanel3: TRzPanel;
    dbgObekt: TDBGridEh;
    tbrObekt: TRzToolbar;
    RzSpacer2: TRzSpacer;
    BtnHistoryKv: TRzToolButton;
    RzSpacer6: TRzSpacer;
    BtnFreeFilterObk: TRzToolButton;
    RzSpacer9: TRzSpacer;
    NavigateObk: TRzDBNavigator;
    RzSpacer3: TRzSpacer;
    lcbUlica: TRzDBLookupComboBox;
    RzSpacer4: TRzSpacer;
    btnDelFilter: TRzToolButton;
    RzSpacer7: TRzSpacer;
    RzToolButton2: TRzToolButton;
    RzSpacer5: TRzSpacer;
    BtnHistoryDom: TRzToolButton;
    RzSpacer8: TRzSpacer;
    BtnFreeFilterDom: TRzToolButton;
    RzSpacer10: TRzSpacer;
    qryKvart: TMSQuery;
    dsKvart: TDataSource;
    qryLicev: TMSQuery;
    dsLicev: TDataSource;
    qryDoma: TMSQuery;
    dsDoma: TDataSource;
    DomaSet: TfrxDBDataset;
    ObektSet: TfrxDBDataset;
    LicevSet: TfrxDBDataset;
    N5: TMenuItem;
    N8: TMenuItem;
    Report: TfrxReport;
    BtnCalc: TRzToolButton;
    RzSpacer11: TRzSpacer;
    sp_UpQot: TMSStoredProc;
    BtnDeleteDom: TRzToolButton;
    RzSpacer12: TRzSpacer;
    BtnDeleteKvart: TRzToolButton;
    RzSpacer13: TRzSpacer;
    RzToolButton1: TRzToolButton;
    RzToolButton3: TRzToolButton;
    RzSpacer14: TRzSpacer;
    sp_UpQotDoma: TMSStoredProc;
    procedure BtnFilterOrgClick(Sender: TObject);
    procedure btnDelFilterClick(Sender: TObject);
    procedure lcbUlicaCloseUp(Sender: TObject);
    procedure BtnHistoryDomClick(Sender: TObject);
    procedure BtnHistoryKvClick(Sender: TObject);
    procedure BtnFreeFilterDomClick(Sender: TObject);
    procedure BtnFreeFilterObkClick(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure N4Click(Sender: TObject);
    procedure RzToolButton2Click(Sender: TObject);
    procedure N7Click(Sender: TObject);
    procedure N8Click(Sender: TObject);
    procedure BtnCalcClick(Sender: TObject);
    procedure BtnDeleteDomClick(Sender: TObject);
    procedure BtnDeleteKvartClick(Sender: TObject);
    procedure RzToolButton1Click(Sender: TObject);
    procedure RzToolButton3Click(Sender: TObject);
    procedure NavigateOrgClick(Sender: TObject; Button: TRzNavigatorButton);
    procedure NavigateObkClick(Sender: TObject; Button: TRzNavigatorButton);
  private
    RPath:String;
    F:TFrmUDoma;
    FK:TFrmUKvart;
    LH:TFrmLookHistoryNas;
    sql_flt:String;
    CP:TFrmChangePeriod;
  public
    procedure Init;
  end;

implementation

uses DataModule, MainForm;

{$R *.dfm}

{ TFmeNaselenie }

procedure TFmeNaselenie.Init;
begin
  RPath:=ExtractFilePath(Application.ExeName)+'Template\';
  with dm do begin
    if qryDoma.Active then qryDoma.Close;
    try
      qryDoma.Open;
    except
      ShowMessage('Не удалось открыть таблицу "Дома"');
    end;
    if qryKvart.Active then qryKvart.Close;
    try
      qryKvart.Open;
    except
      ShowMessage('Не удалось открыть таблицу "Квартиры"');
    end;
  end;
end;

procedure TFmeNaselenie.BtnFilterOrgClick(Sender: TObject);
begin
  with dm.qryUlica do
  if Active then Refresh else Open;
  lcbUlica.Enabled:=True;
end;

procedure TFmeNaselenie.btnDelFilterClick(Sender: TObject);
begin
  with dm.qryDoma do
  begin
    FilterSQL:='';
  end;
  dm.qryUlica.Close;
  lcbUlica.Enabled:=False;
end;

procedure TFmeNaselenie.lcbUlicaCloseUp(Sender: TObject);
begin
  with dm.qryDoma do
  begin
    FilterSQL:='a.kodul='+IntToStr(lcbUlica.KeyValue);
  end;
end;

procedure TFmeNaselenie.BtnHistoryDomClick(Sender: TObject);
begin
  LH := TFrmLookHistoryNas.Create( Application );
  try
    LH.dbgNas.DataSource:=dm.dsHistoryDom;
    dm.qryHistoryDom.Open;
    LH.Caption:='История изменения данных по дому '+dm.qryDomaadres.Value;
    LH.ShowModal;
  finally
    LH.Free;
  end;
end;

procedure TFmeNaselenie.BtnHistoryKvClick(Sender: TObject);
begin
  LH := TFrmLookHistoryNas.Create( Application );
  try
    LH.dbgNas.DataSource:=dm.dsHistoryKv;
    LH.Caption:='История изменения данных по кв.№'+dm.qryKvartkv.Value;
    dm.qryHistoryKv.Open;
    LH.ShowModal;
  finally
    LH.Free;
  end;
end;

procedure TFmeNaselenie.BtnFreeFilterDomClick(Sender: TObject);
begin
  // Произвольный фильтр по организации
  sql_flt:=InputBox('Введите условие фильтра:','Произвольный фильтр','');
  with dm.qryDoma do
  begin    
    try
      FilterSQL:=sql_flt;
    except
      ShowMessage('Неверное условие фильтра...');
    end;
  end;
end;

procedure TFmeNaselenie.BtnFreeFilterObkClick(Sender: TObject);
begin
  sql_flt:=InputBox('Введите условие фильтра:','Произвольный фильтр','');
  with dm.qryKv do
  begin    
    try
      Close;
      FilterSQL:=sql_flt;
      Open;
      if dm.qryDoma.Locate('koddom',dm.qryKv['koddom'],[]) then
        dm.qryKvart.Locate('kodkv',dm.qryKv['kodkv'],[])
      else
        ShowMessage('Квартира по введенному условию не найдена...');
    except
      ShowMessage('Неверное условие фильтра...');
    end;
  end;
end;

procedure TFmeNaselenie.N1Click(Sender: TObject);
begin
  // Отчет по домам в разрезе котельных
  Report.LoadFromFile(RPath+'Дома.fr3');
  Report.ShowReport;
  qryDoma.Close;
end;

procedure TFmeNaselenie.N2Click(Sender: TObject);
begin
  // Отчет по квартирам в разрезе домов
  Report.LoadFromFile(RPath+'Квартиры.fr3');
  Report.ShowReport;
  qryKvart.Close;
end;

procedure TFmeNaselenie.N4Click(Sender: TObject);
begin
  // Шаблон по отоплению
  Report.LoadFromFile(RPath+'Дома (отопление).fr3');
  Report.ShowReport;
  qryDoma.Close;
end;

procedure TFmeNaselenie.RzToolButton2Click(Sender: TObject);
begin
  qryKvart.FilterSQL:='a.koddom='+dm.qryDomakoddom.AsString;
  Report.LoadFromFile(RPath+'Квартиры.fr3');
  Report.ShowReport;
  qryKvart.Close;
end;

procedure TFmeNaselenie.N7Click(Sender: TObject);
begin
  // Печать лицевого счета
  with qryKvart do
  begin
    if Active then Close;
    FilterSQL:='a.koddom='+IntToStr(dm.qryDomakoddom.Value);
    Open;
  end;
  CP:=TFrmChangePeriod.Create(Application);
  try
    CP.ShowModal;
    with qryLicev do
    begin
      Params.ParamValues['data1']:=FrmMain.Data1;
      Params.ParamValues['data2']:=FrmMain.Data2;
    end;
    Report.LoadFromFile(RPath+'Лицевой по дому.fr3');
    Report.Variables['data1']:=StrToDate(DateToStr(FrmMain.Data1));
    Report.Variables['data2']:=StrToDate(DateToStr(FrmMain.Data2));
    Report.ShowReport;
  finally
    CP.Free;
  end;
end;

procedure TFmeNaselenie.N8Click(Sender: TObject);
begin
  Report.LoadFromFile(RPath+'Пустые реквизиты (дома).fr3');
  Report.ShowReport;
end;

procedure TFmeNaselenie.NavigateObkClick(Sender: TObject;
  Button: TRzNavigatorButton);
begin
  if (Button in [nbInsert,nbEdit]) then
  begin
    FK := TFrmUKvart.Create( Application );
    try
      FK.ShowModal;
    finally
      FK.Free;
    end;
  end;
end;

procedure TFmeNaselenie.NavigateOrgClick(Sender: TObject;
  Button: TRzNavigatorButton);
begin
  if (Button in [nbInsert,nbEdit]) then
  begin
    F := TFrmUDoma.Create( Application );
    try
      F.ShowModal;
    finally
      F.Free;
    end;
  end;
end;

procedure TFmeNaselenie.BtnCalcClick(Sender: TObject);
Var
   s:string;
   p:PChar;
begin
  {Пересчет нагрузки по квартирам}
  p:=StrAlloc(250*SizeOf(Char));
  s:='Вы действительно хотите рассчитать нагрузку по квартирам дома '+
  dm.qryDoma['adres']+' ?';
  StrPCopy(p,s);
  if Application.MessageBox(p,
  'Предупреждение',mb_YesNo or mb_TaskModal or mb_IconQuestion)=idYes then
  begin
    with sp_UpQot do
    begin
      ParamByName('qs').AsFloat:=dm.qryDomaqot.Value/dm.qryDomaso.Value;
      ParamByName('koddom').AsInteger:=dm.qryDomakoddom.Value;
      try
        ExecProc;
        dm.qryKvart.Refresh;
      except
        ShowMessage('не удалось выполнить пересчет нагрузки...');
      end;
    end;
  end;
end;

procedure TFmeNaselenie.BtnDeleteDomClick(Sender: TObject);
Var
   s:string;
   p:PChar;
begin
  // Проверяем права на удаление
  if FrmMain.UsrName = 'admin' then
  begin
    p:=StrAlloc(250*SizeOf(Char));
    s:='Вы действительно хотите удалить '+dm.qryObekt['nazv']+' ?'+#10#13+
       'Вместе с объектом будут удалены все начисления...';
    StrPCopy(p,s);
    if Application.MessageBox(p,
    'Предупреждение',mb_YesNo or mb_TaskModal or mb_IconQuestion)=idYes then
    try
      dm.qryObekt.Delete;
      dm.qryObekt.Refresh;
    except
       ShowMessage('Не удалось удалить запись. Повторите...');
    end;
  end
  else
    ShowMessage('У пользователя '+FrmMain.UsrName+' отсутствуют права на удаление записей...');
end;

procedure TFmeNaselenie.BtnDeleteKvartClick(Sender: TObject);
Var
  s:string;
  p:PChar;
begin
  // Проверяем права на удаление
  if FrmMain.UsrName = 'admin' then
  begin
    p:=StrAlloc(250*SizeOf(Char));
    s:='Вы действительно хотите удалить '+dm.qryDoma['adres']+'/'+dm.qryKvart['kv']+' ?'+#10#13+
       'Вместе с квартирой будут удалены все начисления...';
    StrPCopy(p,s);
    if Application.MessageBox(p,
    'Предупреждение',mb_YesNo or mb_TaskModal or mb_IconQuestion)=idYes then
    try
      dm.qryKvart.Delete;
      dm.qryKvart.Refresh;
    except
       ShowMessage('Не удалось удалить запись. Повторите...');
    end;
  end
  else
    ShowMessage('У пользователя '+FrmMain.UsrName+' отсутствуют права на удаление записей...');
end;

procedure TFmeNaselenie.RzToolButton1Click(Sender: TObject);
begin
  FrmMain.pgcWork.ActivePage:=FrmMain.TabWelcome;
end;

procedure TFmeNaselenie.RzToolButton3Click(Sender: TObject);
Var
   s:string;
   p:PChar;
begin
  {Пересчет нагрузки по квартирам}
  p:=StrAlloc(250*SizeOf(Char));
  s:='Вы действительно хотите пересчитать нагрузку дома '+
  dm.qryDoma['adres']+' ?';
  StrPCopy(p,s);
  if Application.MessageBox(p,
  'Предупреждение',mb_YesNo or mb_TaskModal or mb_IconQuestion)=idYes then
  begin
    with sp_UpQotDoma do
    begin
      ParamByName('koddom').AsInteger:=dm.qryDomakoddom.Value;
      try
        ExecProc;
        dm.qryDoma.Refresh;
      except
        ShowMessage('не удалось выполнить пересчет нагрузки...');
      end;
    end;
  end;
end;

end.

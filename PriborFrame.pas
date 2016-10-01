unit PriborFrame;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, Grids, DBGridEh, ExtCtrls, RzPanel, DBCtrls, RzDBNav, RzButton,
  Menus, ImgList, StdCtrls, RzLabel, RzDBCmbo, UPriborForm, frxClass,
  frxDBSet, DB, MemDS, DBAccess, MSAccess, ChangePeriodForm, GridsEh,
  DBGridEhGrouping;

type
  TFmePribor = class(TFrame)
    RzLabel9: TRzLabel;
    ImageList1: TImageList;
    pmPrint: TPopupMenu;
    N1: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    tbrOrg: TRzToolbar;
    RzSpacer1: TRzSpacer;
    NavigateOrg: TRzDBNavigator;
    RzPanel1: TRzPanel;
    Splitter1: TSplitter;
    RzPanel3: TRzPanel;
    dbgObekt: TDBGridEh;
    RzPanel2: TRzPanel;
    dbgPribor: TDBGridEh;
    RzPanel4: TRzPanel;
    dbgDoma: TDBGridEh;
    Splitter2: TSplitter;
    BtnFilterOrg: TRzToolButton;
    RzSpacer3: TRzSpacer;
    lcbFilter: TRzDBLookupComboBox;
    RzSpacer2: TRzSpacer;
    btnDelFilter: TRzToolButton;
    RzSpacer7: TRzSpacer;
    RzToolButton2: TRzToolButton;
    RzSpacer5: TRzSpacer;
    pmFilter: TPopupMenu;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    qryPrObekt: TMSQuery;
    dsPrObekt: TDataSource;
    qryLicevPrObekt: TMSQuery;
    dsLicevPrObekt: TDataSource;
    PriborSet: TfrxDBDataset;
    ObektSet: TfrxDBDataset;
    LicevSet: TfrxDBDataset;
    qryPrDoma: TMSQuery;
    dsPrDoma: TDataSource;
    qryLicevPrDoma: TMSQuery;
    dsLicevPrDoma: TDataSource;
    qryPribor: TMSQuery;
    dsPribor: TDataSource;
    LicevPrObekt: TfrxDBDataset;
    LicevPrDoma: TfrxDBDataset;
    qryLicevPr: TMSQuery;
    dsLicevPr: TDataSource;
    LicevPrSet: TfrxDBDataset;
    Report: TfrxReport;
    BtnDeletePr: TRzToolButton;
    RzSpacer12: TRzSpacer;
    RzToolButton1: TRzToolButton;
    procedure MenuItem1Click(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure lcbFilterCloseUp(Sender: TObject);
    procedure btnDelFilterClick(Sender: TObject);
    procedure N4Click(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure BtnDeletePrClick(Sender: TObject);
    procedure RzToolButton1Click(Sender: TObject);
    procedure NavigateOrgClick(Sender: TObject; Button: TRzNavigatorButton);
  private
    RPath:string;
    F:TFrmUPribor;
    CP:TFrmChangePeriod;
  public
    procedure Init;
  end;

implementation

uses DataModule, MainForm;

{$R *.dfm}

{ TFmePribor }

procedure TFmePribor.Init;
begin
  {Инициализация}
  RPath:=ExtractFilePath(Application.ExeName)+'Template\';
  with dm do
  begin
    with qryPribor do
    begin
      if Active then Close;
      try
        Open;
      except
        ShowMessage('Не удалось открыть таблицу "Приборы учета"');
      end;
    end;
    with qryObektPr do
    begin
      if Active then Close;
      try
        Open;
      except
        ShowMessage('Не удалось открыть таблицу "Объекты"');
      end;
    end;
    with qryDomaPr do
    begin
      if Active then Close;
      try
        Open;
      except
        ShowMessage('Не удалось открыть таблицу "Дома"');
      end;
    end;
  end;
  lcbFilter.Enabled:=False;
end;

procedure TFmePribor.MenuItem1Click(Sender: TObject);
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

procedure TFmePribor.MenuItem2Click(Sender: TObject);
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

procedure TFmePribor.lcbFilterCloseUp(Sender: TObject);
begin
  if lcbFilter.ListSource = dm.dsOrg then
    with dm.qryPribor do
      FilterSQL:='kodorg='+IntToStr(lcbFilter.KeyValue);
  if lcbFilter.ListSource = dm.dsKoteln then
    with dm.qryPribor do
      FilterSQL:='kodkot='+IntToStr(lcbFilter.KeyValue);
end;

procedure TFmePribor.btnDelFilterClick(Sender: TObject);
begin
  with dm.qryPribor do
      FilterSQL:='';
  with lcbFilter do
  begin
    KeyField:='';
    ListField:='';
    ListSource:=nil;
    Enabled:=False;
  end;
end;

procedure TFmePribor.N4Click(Sender: TObject);
begin
  {Лицевой по прибору}
  CP:=TFrmChangePeriod.Create(Application);
  try
    CP.ShowModal;
    with qryLicevPr do
    begin
      if Active then Close;
      Params.ParamValues['data1']:=FrmMain.Data1;
      Params.ParamValues['data2']:=FrmMain.Data2;
      FilterSQL:='a.kod='+IntToStr(dm.qryPriborkod.Value);
      Open;
    end;
    with qryLicevPrObekt do
    begin
      Params.ParamValues['data1']:=FrmMain.Data1;
      Params.ParamValues['data2']:=FrmMain.Data2;
    end;
    with qryLicevPrDoma do
    begin
      Params.ParamValues['data1']:=FrmMain.Data1;
      Params.ParamValues['data2']:=FrmMain.Data2;
    end;
    Report.LoadFromFile(RPath+'Лицевой прибора учета.fr3');
    Report.Variables['data1']:=StrToDate(DateToStr(FrmMain.Data1));
    Report.Variables['data2']:=StrToDate(DateToStr(FrmMain.Data2));
    Report.ShowReport;
  finally
    CP.Free;
  end;
end;

procedure TFmePribor.NavigateOrgClick(Sender: TObject;
  Button: TRzNavigatorButton);
begin
  if (Button in [nbInsert,nbEdit]) then
  begin
    F := TFrmUPribor.Create( Application );
    try
      F.ShowModal;
    finally
      F.Free;
    end;   
  end;
end;

procedure TFmePribor.N1Click(Sender: TObject);
begin
  {Перечень приборов учета}
  Report.LoadFromFile(RPath+'Приборы учета.fr3');
  Report.ShowReport;
end;

procedure TFmePribor.BtnDeletePrClick(Sender: TObject);
Var
   s:string;
   p:PChar;
begin
  // Проверяем права на удаление
  if FrmMain.UsrName = 'admin' then
  begin
    p:=StrAlloc(250*SizeOf(Char));
    s:='Вы действительно хотите удалить '+dm.qryPribor['nazp']+' ?'+#10#13+
       'Вместе с прибором учета будут удалены все объекты и начисления...';
    StrPCopy(p,s);
    if Application.MessageBox(p,
    'Предупреждение',mb_YesNo or mb_TaskModal or mb_IconQuestion)=idYes then
    try
      dm.qryPribor.Delete;
      dm.qryPribor.Refresh;
    except
      ShowMessage('Не удалось удалить. Повторите...');
    end;
  end
  else
    ShowMessage('У пользователя '+FrmMain.UsrName+' отсутствуют права на удаление записей...');
end;

procedure TFmePribor.RzToolButton1Click(Sender: TObject);
begin
  FrmMain.pgcWork.ActivePage:=FrmMain.TabWelcome;
end;

end.

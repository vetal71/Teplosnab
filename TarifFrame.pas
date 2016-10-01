unit TarifFrame;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, Grids, DBGridEh, RzTabs, RzPanel, DBCtrls, RzDBNav, RzButton,
  ExtCtrls, Menus, ImgList, StdCtrls, RzLabel, UTariftForm, UTarifvForm,
  UTarifgForm,
  frxClass, frxDBSet, DB, MemDS, DBAccess, MSAccess, GridsEh,
  DBGridEhGrouping ;

type
  TFmeTarif = class(TFrame)
    RzLabel9: TRzLabel;
    ImageList1: TImageList;
    tbrTarif: TRzToolbar;
    RzSpacer7: TRzSpacer;
    NavigateTarif: TRzDBNavigator;
    pnlMain: TRzPanel;
    pcTarif: TRzPageControl;
    TabTarif_t: TRzTabSheet;
    TabTarif_v: TRzTabSheet;
    dbgTarif_v: TDBGridEh;
    dbgTarif_t: TDBGridEh;
    RzToolButton2: TRzToolButton;
    RzSpacer2: TRzSpacer;
    qryTarif_t: TMSQuery;
    dsTarif_t: TDataSource;
    Tarif_tSet: TfrxDBDataset;
    qryTarif_v: TMSQuery;
    dsTarif_v: TDataSource;
    Tarif_vSet: TfrxDBDataset;
    Report: TfrxReport;
    BtnDeleteTrf: TRzToolButton;
    RzSpacer12: TRzSpacer;
    RzToolButton1: TRzToolButton;
    TabTarif_g: TRzTabSheet;
    dbgTarif_g: TDBGridEh;
    qryTarif_g: TMSQuery;
    dsTarif_g: TDataSource;
    Tarif_gSet: TfrxDBDataset;
    procedure pcTarifChange(Sender: TObject);
    procedure RzToolButton2Click(Sender: TObject);
    procedure BtnDeleteTrfClick(Sender: TObject);
    procedure RzToolButton1Click(Sender: TObject);
    procedure NavigateTarifClick(Sender: TObject; Button: TRzNavigatorButton);
  private
    RPath:string;
    FT:TFrmUTarif_t;
    FV:TFrmUTarif_v;
    FG:TFrmUTarif_g;
  public
    procedure Init;
  end;

implementation

uses DataModule, MainForm;

{$R *.dfm}

{ TFmeTarif }

procedure TFmeTarif.Init;
begin
  {Инициализация формы}
  RPath:=ExtractFilePath(Application.ExeName)+'Template\';
  with dm do
  begin
    with qryTarif_t do
    begin
      if Active then Close;
      try
        ParamByName('data1').AsDate:=StrToDate(FrmMain.WorkDate);
        Open;
      except
        ShowMessage('Не удалось открыть таблицу "Тарифы (отопление)"');
      end;
    end;
    with qryTarif_v do
    begin
      if Active then Close;
      try
        ParamByName('data1').AsDate:=StrToDate(FrmMain.WorkDate);
        Open;
      except
        ShowMessage('Не удалось открыть таблицу "Тарифы (водосн.)"');
      end;
    end;
    with qryTarif_g do
    begin
      if Active then Close;
      try
        ParamByName('data1').AsDate:=StrToDate(FrmMain.WorkDate);
        Open;
      except
        ShowMessage('Не удалось открыть таблицу "Тарифы (мусор)"');
      end;
    end;
  end;
  pcTarif.ActivePage:= TabTarif_t;
  NavigateTarif.DataSource:=dm.dsTarif_t;
end;

procedure TFmeTarif.NavigateTarifClick(Sender: TObject;
  Button: TRzNavigatorButton);
begin
  if (Button in [nbInsert,nbEdit]) then
  begin
    if pcTarif.ActivePage = TabTarif_t then
    begin
      FT := TFrmUTarif_t.Create( Application );
      try
        FT.ShowModal;
      finally
        FT.Free;
      end;
    end;
    if pcTarif.ActivePage = TabTarif_v then
    begin
      FV := TFrmUTarif_v.Create( Application );
      try
        FV.ShowModal;
      finally
        FV.Free;
      end;
    end;
    if pcTarif.ActivePage = TabTarif_g then
    begin
      FG := TFrmUTarif_g.Create( Application );
      try
        FG.ShowModal;
      finally
        FG.Free;
      end;
    end;
  end;
end;

procedure TFmeTarif.pcTarifChange(Sender: TObject);
begin
  if pcTarif.ActivePage = TabTarif_t then
    NavigateTarif.DataSource:=dm.dsTarif_t;
  if pcTarif.ActivePage = TabTarif_v then
    NavigateTarif.DataSource:=dm.dsTarif_v;
  if pcTarif.ActivePage = TabTarif_g then
    NavigateTarif.DataSource:=dm.dsTarif_g;
end;

procedure TFmeTarif.RzToolButton2Click(Sender: TObject);
begin
  with qryTarif_t do
  begin
    if Active then Close;
    ParamByName('data').AsDate:=StrToDate(FrmMain.WorkDate);
    try
      Open;
    except
      ShowMessage('Не удалось сформировать отчет...');
      exit;
    end;
  end;
  with qryTarif_v do
  begin
    if Active then Close;
    ParamByName('data').AsDate:=StrToDate(FrmMain.WorkDate);
    try
      Open;
    except
      ShowMessage('Не удалось сформировать отчет...');
      exit;
    end;
  end;
  with qryTarif_g do
  begin
    if Active then Close;
    ParamByName('data').AsDate:=StrToDate(FrmMain.WorkDate);
    try
      Open;
    except
      ShowMessage('Не удалось сформировать отчет...');
      exit;
    end;
  end;
  Report.LoadFromFile(RPath+'Тарифы.fr3');
  Report.Variables['data1']:=StrToDate(FrmMain.WorkDate);
  Report.ShowReport;
end;

procedure TFmeTarif.BtnDeleteTrfClick(Sender: TObject);
Var
   s:string;
   p:PChar;
begin
  // Проверяем права на удаление
  if FrmMain.UsrName = 'admin' then
  begin
    if pcTarif.ActivePage = TabTarif_t then
    begin
      p:=StrAlloc(250*SizeOf(Char));
      s:='Вы действительно хотите удалить тариф '+dm.qryTarif_t['nazt']+' ?'+#10#13+
         'Это приведет к непредсказуемым последствиям! Продолжить...';
      StrPCopy(p,s);
      if Application.MessageBox(p,
      'Предупреждение',mb_YesNo or mb_TaskModal or mb_IconQuestion)=idYes then
      try
        dm.qryTarif_t.Delete;
        dm.qryTarif_t.Refresh;
      except
        ShowMessage('Не удалось удалить запись. Повторите...');
      end;
    end;
    if pcTarif.ActivePage = TabTarif_v then
    begin
      p:=StrAlloc(250*SizeOf(Char));
      s:='Вы действительно хотите удалить тариф '+dm.qryTarif_v['nazt']+' ?'+#10#13+
         'Это приведет к непредсказуемым последствиям! Продолжить...';
      StrPCopy(p,s);
      if Application.MessageBox(p,
      'Предупреждение',mb_YesNo or mb_TaskModal or mb_IconQuestion)=idYes then
      try
        dm.qryTarif_v.Delete;
        dm.qryTarif_v.Refresh;
      except
        ShowMessage('Не удалось удалить запись. Повторите...');
      end;
    end;
    if pcTarif.ActivePage = TabTarif_g then
    begin
      p:=StrAlloc(250*SizeOf(Char));
      s:='Вы действительно хотите удалить тариф '+dm.qryTarif_g['nazt']+' ?'+#10#13+
         'Это приведет к непредсказуемым последствиям! Продолжить...';
      StrPCopy(p,s);
      if Application.MessageBox(p,
      'Предупреждение',mb_YesNo or mb_TaskModal or mb_IconQuestion)=idYes then
      try
        dm.qryTarif_g.Delete;
        dm.qryTarif_g.Refresh;
      except
        ShowMessage('Не удалось удалить запись. Повторите...');
      end;
    end;
  end
  else
    ShowMessage('У пользователя '+FrmMain.UsrName+' отсутствуют права на удаление записей...');
end;

procedure TFmeTarif.RzToolButton1Click(Sender: TObject);
begin
  FrmMain.pgcWork.ActivePage:=FrmMain.TabWelcome;
end;

end.

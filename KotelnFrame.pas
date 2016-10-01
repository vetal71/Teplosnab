unit KotelnFrame;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, StdCtrls, RzLabel, Grids, DBGridEh, RzPanel, RzCmboBx, DBCtrls,
  RzDBNav, RzButton, ExtCtrls, Menus, ImgList, UKotelnForm,
  LookHistoryKotelnForm, DB, MemDS,
  DBAccess, MSAccess, frxClass, frxDBSet, frxExportXLS, GridsEh,
  DBGridEhGrouping;

type
  TFmeKoteln = class(TFrame)
    RzLabel9: TRzLabel;
    ImageList1: TImageList;
    pmPrint: TPopupMenu;
    N1: TMenuItem;
    tbrOrg: TRzToolbar;
    RzSpacer1: TRzSpacer;
    BtnPrint: TRzToolButton;
    NavigateOrg: TRzDBNavigator;
    RzPanel1: TRzPanel;
    RzSpacer2: TRzSpacer;
    BtnHistoryKot: TRzToolButton;
    RzSpacer3: TRzSpacer;
    RzPanel2: TRzPanel;
    dbgOrg: TDBGridEh;
    ObkSet: TfrxDBDataset;
    DomaSet: TfrxDBDataset;
    qryObekt: TMSQuery;
    dsObekt: TDataSource;
    dsDoma: TDataSource;
    qryDoma: TMSQuery;
    frxXLSExport1: TfrxXLSExport;
    BtnDeleteKot: TRzToolButton;
    RzSpacer12: TRzSpacer;
    RzToolButton1: TRzToolButton;
    Report: TfrxReport;
    procedure BtnHistoryKotClick(Sender: TObject);
    procedure BtnHistoryClick(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure BtnDeleteKotClick(Sender: TObject);
    procedure BtnPrintClick(Sender: TObject);
    procedure RzToolButton1Click(Sender: TObject);
    procedure NavigateOrgClick(Sender: TObject; Button: TRzNavigatorButton);
  private
    RPath:String;
    FK:TFrmUKoteln;
    LH:TFrmLookHistoryKot;
  public
    procedure Init;
  end;

implementation

uses DataModule, MainForm;

{$R *.dfm}

{ TFmeKoteln }

procedure TFmeKoteln.Init;
begin
  RPath:=ExtractFilePath(Application.ExeName)+'Template\';
  with dm do begin
    if qryKoteln.Active then qryKoteln.Close;
    try
      qryKoteln.Open;
    except
      ShowMessage('Не удалось открыть таблицу "Котельные"');
    end;
  end;
end;

procedure TFmeKoteln.BtnHistoryKotClick(Sender: TObject);
begin
  {История по котельной}
  LH := TFrmLookHistoryKot.Create( Application );
  try
    LH.ShowModal;
  finally
    LH.Free;
  end;
end;

procedure TFmeKoteln.BtnHistoryClick(Sender: TObject);
begin
  {История по котельной}
  
end;

procedure TFmeKoteln.N1Click(Sender: TObject);
begin
  Report.LoadFromFile(RPath+'Потребители по участкам.fr3');
  Report.ShowReport;
end;

procedure TFmeKoteln.NavigateOrgClick(Sender: TObject;
  Button: TRzNavigatorButton);
begin
  if (Button in [nbInsert,nbEdit]) then
  begin
    FK := TFrmUKoteln.Create( Application );
    try
      FK.ShowModal;
    finally
      FK.Free;
    end;
  end;
end;

procedure TFmeKoteln.BtnDeleteKotClick(Sender: TObject);
Var
   s:string;
   p:PChar;
begin
  // Проверяем права на удаление
  if FrmMain.UsrName = 'admin' then
  begin
    p:=StrAlloc(250*SizeOf(Char));
    s:='Вы действительно хотите удалить '+dm.qryKoteln['nazk']+' ?'+#10#13+
       'Вместе с котельной будут удалены все объекты и начисления...';
    StrPCopy(p,s);
    if Application.MessageBox(p,
    'Предупреждение',mb_YesNo or mb_TaskModal or mb_IconQuestion)=idYes then
    try
      dm.qryKoteln.Delete;
      dm.qryKoteln.Refresh;
    except
      ShowMessage('Не удалось удалить запись. Повторите...');
    end;
  end
  else
    ShowMessage('У пользователя '+FrmMain.UsrName+' отсутствуют права на удаление записей...');
end;

procedure TFmeKoteln.BtnPrintClick(Sender: TObject);
begin
  Report.LoadFromFile(RPath+'Потребители по участкам.fr3');
  Report.ShowReport;
end;

procedure TFmeKoteln.RzToolButton1Click(Sender: TObject);
begin
  FrmMain.pgcWork.ActivePage:=FrmMain.TabWelcome;
end;

end.

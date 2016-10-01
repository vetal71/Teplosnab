unit UlicaFrame;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, Grids, DBGridEh, RzPanel, ImgList, DBCtrls, RzDBNav, RzButton,
  ExtCtrls, StdCtrls, RzLabel, UpUlicaForm, frxClass, frxDBSet, DB, MemDS,
  DBAccess, MSAccess, GridsEh, DBGridEhGrouping;

type
  TFmeUlica = class(TFrame)
    RzLabel9: TRzLabel;
    tbrTarif: TRzToolbar;
    RzSpacer7: TRzSpacer;
    RzToolButton2: TRzToolButton;
    RzSpacer2: TRzSpacer;
    NavigateTarif: TRzDBNavigator;
    ImageList1: TImageList;
    pnlMain: TRzPanel;
    dbgUlica: TDBGridEh;
    BtnDeleteUl: TRzToolButton;
    RzSpacer12: TRzSpacer;
    qryUlica: TMSQuery;
    dsUlica: TDataSource;
    UlicaSet: TfrxDBDataset;
    Report: TfrxReport;
    RzToolButton1: TRzToolButton;
    procedure BtnDeleteUlClick(Sender: TObject);
    procedure RzToolButton2Click(Sender: TObject);
    procedure RzToolButton1Click(Sender: TObject);
    procedure NavigateTarifClick(Sender: TObject; Button: TRzNavigatorButton);
  private
    FK:TFrmUpUlica;
  public
    procedure Init;
  end;

implementation

uses DataModule, MainForm;

{$R *.dfm}

{ TFmeUlica }

procedure TFmeUlica.Init;
begin
  with dm.qryUlic do
  begin
    if Active then Close;
    try
      Open;
    except
      ShowMessage('Не удалось открыть таблицу "Улицы"');
    end;
  end;
end;

procedure TFmeUlica.NavigateTarifClick(Sender: TObject;
  Button: TRzNavigatorButton);
begin
  if (Button in [nbInsert,nbEdit]) then
  begin
    FK := TFrmUpUlica.Create( Application );
    try
      FK.ShowModal;
    finally
      FK.Free;
    end;
  end;
end;

procedure TFmeUlica.BtnDeleteUlClick(Sender: TObject);
Var
   s:string;
   p:PChar;
begin
  // Проверяем права на удаление
  if FrmMain.UsrName = 'admin' then
  begin
    p:=StrAlloc(250*SizeOf(Char));
    s:='Вы действительно хотите удалить '+dm.qryUlic['nazvul']+' ?';
    StrPCopy(p,s);
    if Application.MessageBox(p,
    'Предупреждение',mb_YesNo or mb_TaskModal or mb_IconQuestion)=idYes then
    try
      dm.qryUlic.Delete;
      dm.qryUlic.Refresh;
    except
      ShowMessage('Не удалось удалить запись. Повторите...');
    end;
  end
  else
    ShowMessage('У пользователя '+FrmMain.UsrName+' отсутствуют права на удаление записей...');
end;

procedure TFmeUlica.RzToolButton2Click(Sender: TObject);
begin
  Report.LoadFromFile(FrmMain.RPath+'Улицы.fr3');
  Report.ShowReport;
end;

procedure TFmeUlica.RzToolButton1Click(Sender: TObject);
begin
  FrmMain.pgcWork.ActivePage:=FrmMain.TabWelcome;
end;

end.

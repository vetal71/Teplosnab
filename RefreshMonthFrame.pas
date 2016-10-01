unit RefreshMonthFrame;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, DB, MemDS, DBAccess, MSAccess, ComCtrls, RzListVw, RzButton,
  ExtCtrls, RzPanel, StdCtrls, RzLabel, Str_fun, WaitScreenForm,
  Grids, DBGrids, RzDBGrid, DBGridEh, GridsEh, DBGridEhGrouping;

type
  TFmeRefreshMonth = class(TFrame)
    RzLabel9: TRzLabel;
    RzPanel2: TRzPanel;
    BtnOk: TRzBitBtn;
    BtnCancel: TRzBitBtn;
    pnlMain: TRzPanel;
    spPerexod: TMSStoredProc;
    qryUpNewMonth: TMSQuery;
    dsUpNewMonth: TDataSource;
    dbgObekt: TDBGridEh;
    procedure BtnCancelClick(Sender: TObject);
    procedure BtnOkClick(Sender: TObject);
  private
    WS:TFrmWaitScreen;
  public
    procedure Init;
  end;

implementation

uses DataModule, MainForm;

{$R *.dfm}

{ TFmeRefreshMonth }

procedure TFmeRefreshMonth.Init;
begin
  //ShowMessage('Будет месяц обновлять...')
end;

procedure TFmeRefreshMonth.BtnCancelClick(Sender: TObject);
begin
  FrmMain.pgcWork.ActivePage:=FrmMain.TabWelcome;
end;

procedure TFmeRefreshMonth.BtnOkClick(Sender: TObject);
begin
  WS:=TFrmWaitScreen.Create(Application);
  WS.Show;
  WS.Update;
  with spPerexod do
  begin
    ParamByName('oper').AsInteger:=2;
    ParamByName('data').AsDate:=StrToDate(FrmMain.WorkDate);
    try
      ExecProc;
    except
      ShowMessage('Не удалось обновить данные...');
    end;
  end;
  with qryUpNewMonth do
  begin
    if Active then Close;
    try
      Open;
    except
      ShowMessage('Не удалось получить отчет об изменениях...');
    end;
  end;
  WS.Free;
end;

end.

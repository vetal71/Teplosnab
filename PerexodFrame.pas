unit PerexodFrame;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, RzButton, ExtCtrls, RzPanel, StdCtrls, RzLabel, DB, MemDS,
  DBAccess, MSAccess, DateUtils, Str_fun, ComCtrls, WaitScreenForm,
  Grids, DBGridEh, RzCmboBx, GridsEh, DBGridEhGrouping;

type
  TFmePerexod = class(TFrame)
    RzLabel9: TRzLabel;
    pnlMain: TRzPanel;
    RzPanel2: TRzPanel;
    BtnOk: TRzBitBtn;
    BtnCancel: TRzBitBtn;
    spPerexod: TMSStoredProc;
    dbgObekt: TDBGridEh;
    qryUpNewMonth: TMSQuery;
    dsUpNewMonth: TDataSource;
    RzPanel1: TRzPanel;
    RzLabel1: TRzLabel;
    cboStart: TRzComboBox;
    procedure BtnCancelClick(Sender: TObject);
    procedure BtnOkClick(Sender: TObject);
  private
    WS:TFrmWaitScreen;
  public
    procedure Init;
  end;

implementation

uses MainForm, DataModule, RzCommon;

{$R *.dfm}

{ TFmePerexod }

procedure TFmePerexod.Init;
begin
  {Инициализация}
  GetItemsPeriod(cboStart.Items);
  with dm.qryParamOrg do
  begin
    if Active then Close;
    try
      Open;
      cboStart.ItemIndex:=dm.qryParamOrg['rasch_period']+1;
      cboStart.Enabled:=False;
    except
      ShowMessage('Не удалось прочитать параметры...');
    end;
  end;
end;

procedure TFmePerexod.BtnCancelClick(Sender: TObject);
begin
  FrmMain.pgcWork.ActivePage:=FrmMain.TabWelcome;
end;

procedure TFmePerexod.BtnOkClick(Sender: TObject);
begin
  if Application.MessageBox(PChar('Вы хотите перейти на '+cboStart.Text+' ?'),
  'Предупреждение',mb_YesNo or mb_TaskModal or mb_IconQuestion)=idYes then
  begin
    WS:=TFrmWaitScreen.Create(Application);
    WS.Show;
    WS.Update;
    with spPerexod do
    begin
      ParamByName('oper').AsInteger:=1;
      ParamByName('data').AsDate:=DateOfPeriod(cboStart.ItemIndex);
      try
        ExecProc;
        with dm.qryParamOrg do
        begin
          Edit;
          dm.qryParamOrg.FieldByName('rasch_period').AsInteger:=cboStart.ItemIndex;
          dm.qryParamOrg.FieldByName('period_name').AsString:=cboStart.Text;
          Post;
        end;
        FrmMain.WorkDate:=DateToStr(DateOfPeriod(cboStart.ItemIndex));
        FrmMain.ReadIniFile;
      except
        ShowMessage('Жаль. Не удалось перейти на новый месяц...');
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
  ShowMessage('Новый месяц '+cboStart.Text);
end;

end.

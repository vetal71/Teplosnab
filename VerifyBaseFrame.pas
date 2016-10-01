unit VerifyBaseFrame;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, RzButton, StdCtrls, RzCmboBx, Grids, DBGridEh, ExtCtrls,
  RzPanel, RzLabel, DB, MemDS, DBAccess, MSAccess,
  frxClass, frxDBSet, WaitScreenForm, GridsEh, DBGridEhGrouping;

type
  TFmeVerifyBase = class(TFrame)
    RzLabel9: TRzLabel;
    RzPanel1: TRzPanel;
    dbgError: TDBGridEh;
    RzPanel2: TRzPanel;
    RzLabel1: TRzLabel;
    cboObject: TRzComboBox;
    RzPanel3: TRzPanel;
    BtnVerify: TRzBitBtn;
    BtnPrint: TRzBitBtn;
    BtnEditError: TRzBitBtn;
    sp_Verify: TMSStoredProc;
    ErrorSet: TfrxDBDataset;
    Report: TfrxReport;
    sp_CheckError: TMSStoredProc;
    RzBitBtn1: TRzBitBtn;
    procedure BtnVerifyClick(Sender: TObject);
    procedure BtnPrintClick(Sender: TObject);
    procedure BtnEditErrorClick(Sender: TObject);
    procedure RzBitBtn1Click(Sender: TObject);
  private
    RPath:String;
    WS:TFrmWaitScreen;
  public
    procedure Init;
  end;

implementation

uses DataModule, MainForm;

{$R *.dfm}

procedure TFmeVerifyBase.Init;
begin
  RPath:=ExtractFilePath(Application.ExeName)+'Template\';
  if dm.qryError.Active then dm.qryError.Close;
end;

procedure TFmeVerifyBase.BtnVerifyClick(Sender: TObject);
begin
  if cboObject.ItemIndex<>-1 then
  begin
    WS:=TFrmWaitScreen.Create(Application);
    WS.Show;
    WS.Update;
    with sp_Verify do
    begin
      Params.ParamByName('id_object').AsInteger:=cboObject.ItemIndex;
      try
        ExecProc;
        with dm.qryError do
        begin
          if Active then Close;
          try
            WS.Free;
            Open;
          except
            ShowMessage('Не удалось открыть таблицу ошибок...');
          end;
        end;
      except
        ShowMessage('Не удалось сформировать ошибки по '+cboObject.Text);
      end;
    end;
  end
  else
  begin
    ShowMessage('Выберите объект для проверки...');
    cboObject.SetFocus;
  end;
end;

procedure TFmeVerifyBase.BtnPrintClick(Sender: TObject);
begin
  Report.LoadFromFile(RPath+'Ошибки проверки.fr3');
  Report.ShowReport;
end;

procedure TFmeVerifyBase.BtnEditErrorClick(Sender: TObject);
begin
  if Application.MessageBox('Вы дествительно хотите исправить ошибки автоматически ?',
    'Предупреждение',mb_YesNo or mb_TaskModal or mb_IconQuestion)=idYes then
  begin
    WS:=TFrmWaitScreen.Create(Application);
    WS.Show;
    WS.Update;
    with sp_CheckError do
    begin
      try
        ExecProc;
        DM.qryError.Refresh;
        WS.Free;
        ShowMessage('Операция звершена успешно...');
      except
        ShowMessage('Операция не удалась...');
      end;
    end;
  end;  
end;

procedure TFmeVerifyBase.RzBitBtn1Click(Sender: TObject);
begin
  FrmMain.pgcWork.ActivePage:=frmMain.TabWelcome;
end;

end.

unit UNormaForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DBCtrls, RzDBCmbo, RzButton, StdCtrls, Mask, RzEdit, RzLabel,
  ExtCtrls, RzPanel, DB;

type
  TFrmUNorma = class(TForm)
    pnlMain: TRzPanel;
    RzLabel1: TRzLabel;
    RzLabel2: TRzLabel;
    neNel: TRzNumericEdit;
    RzPanel2: TRzPanel;
    BtnOk: TRzBitBtn;
    BtnCancel: TRzBitBtn;
    lcbVidtop: TRzDBLookupComboBox;
    procedure FormShow(Sender: TObject);
    procedure BtnCancelClick(Sender: TObject);
    procedure BtnOkClick(Sender: TObject);
  private
    procedure ClearControl;
    function VerifyData:Boolean;
  public
    { Public declarations }
  end;

var
  FrmUNorma: TFrmUNorma;

implementation

uses DataModule, MainForm;

{$R *.dfm}

procedure TFrmUNorma.ClearControl;
Var
  I:integer;
begin
  for I := 0 To PnlMain.ControlCount-1 do
  begin
    if PnlMain.Controls[i] Is TRzEdit then
    TRzEdit(PnlMain.Controls[i]).Text:='';
    if PnlMain.Controls[i] Is TRzNumericEdit then
    TRzNumericEdit(PnlMain.Controls[i]).Value:=0;
    if PnlMain.Controls[i] Is TRzDBLookupComboBox then
    TRzDBLookupComboBox(PnlMain.Controls[i]).KeyValue:=-1;
  end;
end;

procedure TFrmUNorma.FormShow(Sender: TObject);
begin
  with dm.qryVidTop do
  begin
    if Active then Close;
    try
      Open;
    except
      ShowMessage('не удалось открыть таблицу "Виды топлива"');
      Close;
    end;
  end;
  if dm.qryNorma.State = dsInsert then
  begin
    Caption:='Новая норма расхода топлива';
    ClearControl;
  end;
  if dm.qryNorma.State = dsEdit then
  begin
    with dm do
    begin
      FrmMain.CurRec:=qryNormaid_norma.Value;
      Caption:='Норма рсхода '+dm.qryNormanaztop.Value;
      lcbVidtop.KeyValue:=dm.qryNormakodtop.Value;
      neNel.Value:=qryNormanorma.Value;
    end;
  end;
end;

function TFrmUNorma.VerifyData: Boolean;
Var
  I:integer;
begin
  VerifyData:=False;
  for I := 0 To PnlMain.ControlCount-1 do
  begin
    if PnlMain.Controls[i] Is TRzNumericEdit then
      if TRzNumericEdit(PnlMain.Controls[i]).Value=0 then
      begin
        VerifyData:=False;
        TRzNumericEdit(PnlMain.Controls[i]).SetFocus;
        exit;
      end else VerifyData:=True;
    if PnlMain.Controls[i] Is TRzDBLookupComboBox then
      if TRzDBLookupComboBox(PnlMain.Controls[i]).KeyValue=-1 then
      begin
        VerifyData:=False;
        TRzDBLookupComboBox(PnlMain.Controls[i]).SetFocus;
        exit;
      end else VerifyData:=True;
  end;
end;

procedure TFrmUNorma.BtnCancelClick(Sender: TObject);
begin
  close
end;

procedure TFrmUNorma.BtnOkClick(Sender: TObject);
begin
  // Проверяем заполение полей
  if Not VerifyData then
  begin
    ShowMessage('Не заполнены все поля...');
    exit;
  end;
  try
    with dm do
    begin
      qryNormakodtop.Value:=lcbVidtop.KeyValue;
      qryNormanorma.Value:=neNel.Value;
      if Application.MessageBox('Сохранить изменения ?',
      'Предупреждение',mb_YesNo or mb_TaskModal or mb_IconQuestion)=idYes then
      begin
        qryNorma.Post;
        qryNorma.Refresh;
        if qryNorma.State = dsEdit then dm.qryNorma.Locate('id_norma',FrmMain.CurRec,[]);
      end;
    end;
  except
    ShowMessage('Невозможно выполнить изменения. Повторите...');
  end;
  Close;
end;

end.

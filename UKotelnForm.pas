unit UKotelnForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RzButton, RzEdit, StdCtrls, RzCmboBx, Mask, RzLabel, ExtCtrls,
  RzPanel, Db, DBCtrls, RzDBCmbo;

type
  TFrmUKoteln = class(TForm)
    pnlMain: TRzPanel;
    RzLabel1: TRzLabel;
    RzLabel9: TRzLabel;
    edtName: TRzEdit;
    cboTipFinans: TRzComboBox;
    RzPanel2: TRzPanel;
    BtnOk: TRzBitBtn;
    BtnCancel: TRzBitBtn;
    neNel: TRzNumericEdit;
    RzLabel2: TRzLabel;
    RzLabel3: TRzLabel;
    nePs: TRzNumericEdit;
    RzLabel4: TRzLabel;
    edtMaster: TRzEdit;
    RzLabel15: TRzLabel;
    lcbPribor: TRzDBLookupComboBox;
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
  FrmUKoteln: TFrmUKoteln;

implementation

uses DataModule, MainForm;

{$R *.dfm}

procedure TFrmUKoteln.ClearControl;
Var
  I:integer;
begin
  for I := 0 To PnlMain.ControlCount-1 do
  begin
    if PnlMain.Controls[i] Is TRzEdit then
    TRzEdit(PnlMain.Controls[i]).Text:='';
    if PnlMain.Controls[i] Is TRzNumericEdit then
    TRzNumericEdit(PnlMain.Controls[i]).Value:=0;
    if PnlMain.Controls[i] Is TRzComboBox then
    TRzComboBox(PnlMain.Controls[i]).ItemIndex:=0;
    if PnlMain.Controls[i] Is TRzDBLookupComboBox then
    TRzDBLookupComboBox(PnlMain.Controls[i]).KeyValue:=-1;
  end;
end;

procedure TFrmUKoteln.FormShow(Sender: TObject);
begin
  with dm.qryPribor do
  begin
    if Active then Close;
    try
      Open;
    except
      ShowMessage('Не удалось открыть таблицу "Приборы учета"');
    end;
  end;
  if dm.qryKoteln.State = dsInsert then
  begin
    Caption:='Новый участок';
    ClearControl;
  end;
  if dm.qryKoteln.State = dsEdit then
  begin
    with dm do
    begin
      FrmMain.CurRec:=qryKotelnkodkot.Value;
      Caption:='Участок: '+dm.qryKotelnnazk.Value;
      edtName.Text:=qryKotelnnazk.Value;
      neNel.Value:=qryKotelnnel.Value;
      nePs.Value:=qryKotelnps.Value;
      cboTipFinans.ItemIndex:=qryKotelnmesto.AsInteger-1;
      edtMaster.Text:=qryKotelnmaster.Value;
      lcbPribor.KeyValue:=qryKotelnkodpr.Value;
    end;
  end;
end;

function TFrmUKoteln.VerifyData: Boolean;
Var
  I:integer;
begin
  result:=False;
  for I := 0 To PnlMain.ControlCount-1 do
  begin
    if PnlMain.Controls[i] Is TRzEdit then
      if TRzEdit(PnlMain.Controls[i]).Text='' then
      begin
        result:=False;
        TRzEdit(PnlMain.Controls[i]).SetFocus;
        exit;
      end else result:=True;
    if PnlMain.Controls[i] Is TRzNumericEdit then
      if TRzNumericEdit(PnlMain.Controls[i]).Value=0 then
      begin
        result:=False;
        TRzNumericEdit(PnlMain.Controls[i]).SetFocus;
        exit;
      end else result:=True;
    if PnlMain.Controls[i] Is TRzComboBox then
      if TRzComboBox(PnlMain.Controls[i]).ItemIndex=-1 then
      begin
        result:=False;
        TRzComboBox(PnlMain.Controls[i]).SetFocus;
        exit;
      end else result:=True;
    if PnlMain.Controls[i] Is TRzDBLookupComboBox then
      if TRzDBLookupComboBox(PnlMain.Controls[i]).KeyValue=-1 then
      begin
        result:=False;
        TRzDBLookupComboBox(PnlMain.Controls[i]).SetFocus;
        exit;
      end else result:=True;
  end;
end;

procedure TFrmUKoteln.BtnCancelClick(Sender: TObject);
begin
  close;
end;

procedure TFrmUKoteln.BtnOkClick(Sender: TObject);
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
      qryKotelnnazk.Value:=edtName.Text;
      qryKotelnnel.Value:=neNel.Value;
      qryKotelnps.Value:=nePs.Value;
      qryKotelnmesto.Value:=cboTipFinans.ItemIndex+1;
      qryKotelnmaster.Value:=edtMaster.Text;
      qryKotelnkodpr.Value:=lcbPribor.KeyValue;
      if Application.MessageBox('Сохранить изменения ?',
      'Предупреждение',mb_YesNo or mb_TaskModal or mb_IconQuestion)=idYes then
      begin
        qryKoteln.Post;
        qryKoteln.Refresh;
        if qryKoteln.State = dsEdit then dm.qryKoteln.Locate('kodkot',FrmMain.CurRec,[]);
      end;
    end;
  except
    ShowMessage('Невозможно выполнить изменения. Повторите...');
  end;
  Close;
end;

end.

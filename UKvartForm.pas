unit UKvartForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, RzCmboBx, RzButton, RzRadChk, DBCtrls, RzDBCmbo,
  RzEdit, Mask, RzLabel, ExtCtrls, RzPanel, DB;

type
  TFrmUKvart = class(TForm)
    pnlMain: TRzPanel;
    RzLabel2: TRzLabel;
    RzLabel4: TRzLabel;
    RzLabel7: TRzLabel;
    RzLabel9: TRzLabel;
    RzLabel14: TRzLabel;
    RzLabel15: TRzLabel;
    edtDom: TRzEdit;
    neQot: TRzNumericEdit;
    neProj: TRzNumericEdit;
    neSpl: TRzNumericEdit;
    lcbOrg: TRzDBLookupComboBox;
    lcbObekt: TRzDBLookupComboBox;
    chkPodklOt: TRzCheckBox;
    RzPanel2: TRzPanel;
    BtnOk: TRzBitBtn;
    BtnCancel: TRzBitBtn;
    RzLabel13: TRzLabel;
    cboPrin: TRzComboBox;
    chkPriv: TRzCheckBox;
    chkGvs: TRzCheckBox;
    procedure FormShow(Sender: TObject);
    procedure BtnCancelClick(Sender: TObject);
    procedure BtnOkClick(Sender: TObject);
    procedure lcbOrgCloseUp(Sender: TObject);
  private
    function VerifyData:Boolean;
    procedure ClearControl;
  public
    { Public declarations }
  end;

var
  FrmUKvart: TFrmUKvart;

implementation

uses DataModule, MainForm;

{$R *.dfm}

procedure TFrmUKvart.ClearControl;
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
    if PnlMain.Controls[i] Is TRzComboBox then
    TRzComboBox(PnlMain.Controls[i]).ItemIndex:=-1;
  end;
end;

procedure TFrmUKvart.FormShow(Sender: TObject);
begin
  // Открываем таблицу "Организации"
  with dm do begin
    with qryOrg do begin
      if Not Active then
      try
        Open;
      except
        ShowMessage('Не удалось открыть таблицу "Организации". Повторите попытку...');
        exit;
      end;
    end;
    with qryObk do begin
      if Not Active then
      try
        Open;
      except
        ShowMessage('Не удалось открыть таблицу "Объекты". Повторите попытку...');
        exit;
      end;
    end;
  end;
  if dm.qryKvart.State = dsInsert then
  begin
    Caption:='Новая квартира по адресу '+dm.qryDoma['adres'];
    ClearControl;
  end;
  if dm.qryKvart.State = dsEdit then
  begin
    FrmMain.CurRec:=dm.qryKvartkodkv.Value;
    Caption:='Квартира №'+dm.qryKvartkv.Value+' по адресу:'+dm.qryDoma['adres'];
    edtDom.Text:=dm.qryKvartkv.Value;
    neQot.Value:=dm.qryKvartqot.Value;
    neProj.Value:=dm.qryKvartprj.Value;
    neSpl.Value:=dm.qryKvartso.Value;
    lcbObekt.KeyValue:=dm.qryKvartkodobk.Value;
    dm.qryOrg.Locate('kodorg',dm.qryObk['kodorg'],[]);
    lcbOrg.KeyValue:=dm.qryOrgkodorg.Value;
    cboPrin.ItemIndex:=dm.qryKvartprin.Value;
    if dm.qryKvartpodkl.Value=0 then chkPodklOt.Checked:=True
    else chkPodklOt.Checked:=False;
    if dm.qryKvartpriv.Value=0 then chkPriv.Checked:=True
    else chkPriv.Checked:=False;
    if dm.qryKvartpodklgv.Value=0 then chkGvs.Checked:=True
    else chkGvs.Checked:=False;
  end;
end;

function TFrmUKvart.VerifyData: Boolean;
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
    if PnlMain.Controls[i] Is TRzDBLookupComboBox then
      if TRzDBLookupComboBox(PnlMain.Controls[i]).KeyValue=-1 then
      begin
        result:=False;
        TRzDBLookupComboBox(PnlMain.Controls[i]).SetFocus;
        exit;
      end else result:=True;
    if PnlMain.Controls[i] Is TRzComboBox then
      if TRzComboBox(PnlMain.Controls[i]).ItemIndex=-1 then
      begin
        result:=False;
        TRzComboBox(PnlMain.Controls[i]).SetFocus;
        exit;
      end else result:=True;
  end;
end;

procedure TFrmUKvart.BtnCancelClick(Sender: TObject);
begin
  close;
end;

procedure TFrmUKvart.BtnOkClick(Sender: TObject);
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
      qryKvartkv.Value:=edtDom.Text;
      qryKvartqot.Value:=neQot.Value;
      qryKvartprj.Value:=neProj.Value;
      qryKvartso.Value:=neSpl.Value;
      qryKvartprin.Value:=cboPrin.ItemIndex;
      qryKvartkodobk.Value:=lcbObekt.KeyValue;
      if chkPodklOt.Checked=True then qryKvartpodkl.Value:=0
      else qryKvartpodkl.Value:=1;
      if chkPriv.Checked=True then qryKvartpriv.Value:=0
      else qryKvartpriv.Value:=1;
      if chkGvs.Checked=True then qryKvartpodklgv.Value:=0
      else qryKvartpodklgv.Value:=1;
      if Application.MessageBox('Сохранить изменения ?',
      'Предупреждение',mb_YesNo or mb_TaskModal or mb_IconQuestion)=idYes then
      begin
        qryKvart.Post;
        qryKvart.Refresh;
        if qryKvart.State = dsEdit then dm.qryKvart.Locate('kodkv',FrmMain.CurRec,[]);
      end;
    end;
  except
    ShowMessage('Невозможно выполнить изменения. Повторите...');
  end;
  Close;
end;

procedure TFrmUKvart.lcbOrgCloseUp(Sender: TObject);
begin
  with dm.qryObk do
  begin
    FilterSQL:='kodorg='+IntToStr(lcbOrg.KeyValue);
  end;  
end;

end.

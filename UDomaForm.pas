unit UDomaForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ImgList, RzRadChk, RzEdit, DBCtrls, RzDBCmbo, RzButton,
  StdCtrls, Mask, RzLabel, ExtCtrls, RzPanel, DB, CalcQotForm;

type
  TFrmUDoma = class(TForm)
    pnlMain: TRzPanel;
    RzLabel1: TRzLabel;
    RzLabel2: TRzLabel;
    edtDom: TRzEdit;
    RzPanel2: TRzPanel;
    BtnOk: TRzBitBtn;
    BtnCancel: TRzBitBtn;
    lcbUlica: TRzDBLookupComboBox;
    RzLabel3: TRzLabel;
    neVolume: TRzNumericEdit;
    RzLabel4: TRzLabel;
    neQot: TRzNumericEdit;
    RzLabel7: TRzLabel;
    neProj: TRzNumericEdit;
    RzLabel9: TRzLabel;
    neSpl: TRzNumericEdit;
    RzLabel14: TRzLabel;
    lcbKoteln: TRzDBLookupComboBox;
    RzLabel15: TRzLabel;
    lcbPribor: TRzDBLookupComboBox;
    chkUTeplo: TRzCheckBox;
    chkUGvoda: TRzCheckBox;
    chkPodklOt: TRzCheckBox;
    BtnCalc: TRzBitBtn;
    ImageList1: TImageList;
    chkGvs: TRzCheckBox;
    procedure FormShow(Sender: TObject);
    procedure BtnOkClick(Sender: TObject);
    procedure BtnCancelClick(Sender: TObject);
    procedure BtnCalcClick(Sender: TObject);
  private
    function VerifyData:Boolean;
    procedure ClearControl;    
  public
    FC:TFrmCalcQot;
  end;

var
  FrmUDoma: TFrmUDoma;

implementation

uses MainForm, DataModule;

{$R *.dfm}

procedure TFrmUDoma.ClearControl;
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
    TRzDBLookupComboBox(PnlMain.Controls[i]).KeyValue:=0;
    if PnlMain.Controls[i] Is TRzDBLookupComboBox then
    TRzDBLookupComboBox(PnlMain.Controls[i]).KeyValue:=-1;
  end;
end;

procedure TFrmUDoma.FormShow(Sender: TObject);
begin
  // Открываем таблицу "Улицы"
  with dm do begin
    with qryUlica do begin
      if Not Active then
      try
        Open;
      except
        ShowMessage('Не удалось открыть таблицу "Улицы". Повторите попытку...');
        exit;
      end;
    end;
    with qryKoteln do begin
      if Not Active then
      try
        Open;
      except
        ShowMessage('Не удалось открыть таблицу "Произв.участки". Повторите попытку...');
        exit;
      end;
    end;
    with qryPribor do begin
      if Not Active then
      try
        Open;
      except
        ShowMessage('Не удалось открыть таблицу "Приборы учета". Повторите попытку...');
        exit;
      end;
    end;
  end;
  if dm.qryDoma.State = dsInsert then
  begin
    Caption:='Новый дом';
    ClearControl;
  end;
  if dm.qryDoma.State = dsEdit then
  begin
    FrmMain.CurRec:=dm.qryDomakoddom.Value;
    Caption:='Дом по адресу:'+dm.qryDoma['adres'];
    lcbUlica.KeyValue:=dm.qryDomakodul.Value;
    edtDom.Text:=dm.qryDomandom.Value;
    neVolume.Value:=dm.qryDomaVd.Value;
    neQot.Value:=dm.qryDomaqot.Value;
    neProj.Value:=dm.qryDomaprj.Value;
    neSpl.Value:=dm.qryDomaso.Value;
    lcbKoteln.KeyValue:=dm.qryDomakodkot.Value;
    lcbPribor.KeyValue:=dm.qryDomakodpr.Value;
    if dm.qryDomapodkl.Value=0 then chkPodklOt.Checked:=True
    else chkPodklOt.Checked:=False;
    if dm.qryDomalot.Value=0 then chkUTeplo.Checked:=True
    else chkUTeplo.Checked:=False;
    if dm.qryDomalgv.Value=0 then chkUGvoda.Checked:=True
    else chkUGvoda.Checked:=False;
    if dm.qryDomapodklgv.Value=0 then chkGvs.Checked:=True
    else chkGvs.Checked:=False;
  end;
end;

procedure TFrmUDoma.BtnOkClick(Sender: TObject);
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
      qryDomakodul.Value:=lcbUlica.KeyValue;
      qryDomandom.Value:=edtDom.Text;
      qryDomaVd.Value:=neVolume.Value;
      qryDomaqot.Value:=neQot.Value;
      qryDomaprj.Value:=neProj.Value;
      qryDomaso.Value:=neSpl.Value;
      qryDomakodkot.Value:=lcbKoteln.KeyValue;
      qryDomakodpr.Value:=lcbPribor.KeyValue;
      if chkPodklOt.Checked=True then qryDomapodkl.Value:=0
      else qryDomapodkl.Value:=1;
      if chkUTeplo.Checked=True then qryDomalot.Value:=0
      else qryDomalot.Value:=1;
      if chkUGvoda.Checked=True then qryDomalgv.Value:=0
      else qryDomalgv.Value:=1;
      if chkGvs.Checked=True then qryDomapodklgv.Value:=0
      else qryDomapodklgv.Value:=1;
      if Application.MessageBox('Сохранить изменения ?',
      'Предупреждение',mb_YesNo or mb_TaskModal or mb_IconQuestion)=idYes then
      begin
        qryDoma.Post;
        qryDoma.Refresh;
        if qryDoma.State = dsEdit then dm.qryDoma.Locate('koddom',FrmMain.CurRec,[]);
      end;
    end;
  except
    ShowMessage('Невозможно выполнить изменения. Повторите...');
  end;
  Close;
end;

function TFrmUDoma.VerifyData: Boolean;
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
  end;
end;

procedure TFrmUDoma.BtnCancelClick(Sender: TObject);
begin
  close
end;

procedure TFrmUDoma.BtnCalcClick(Sender: TObject);
begin
  // Расчет нагрузки на отопление
  FC := TFrmCalcQot.Create( Application );
  try
    //*** Рассчитываем нагрузку по объекту
    if Not VarIsNull(neVolume.Value) then
    FC.neVolume.Value:=neVolume.Value
    else FC.neVolume.Value:=0;
    FC.seTemp.Value:=18;
    FC.ShowModal;
    neQot.Value:=FC.neQot.Value;
  finally
    FC.Free;
  end;
end;

end.

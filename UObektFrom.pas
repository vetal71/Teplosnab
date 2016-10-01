unit UObektFrom;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RzLine, StdCtrls, Mask, RzEdit, RzLabel, RzButton, ExtCtrls,
  RzPanel, DBCtrls, RzDBCmbo, RzSpnEdt, ImgList, RzCmboBx, RzRadChk, DB,
  CalcQotForm,Math;

type
  TFrmUObekt = class(TForm)
    pnlMain: TRzPanel;
    RzPanel2: TRzPanel;
    BtnOk: TRzBitBtn;
    BtnCancel: TRzBitBtn;
    RzLabel1: TRzLabel;
    edtName: TRzEdit;
    RzLine1: TRzLine;
    RzLabel2: TRzLabel;
    neVolume: TRzNumericEdit;
    BtnCalc: TRzBitBtn;
    ImageList1: TImageList;
    RzLabel3: TRzLabel;
    neQot: TRzNumericEdit;
    seTemp: TRzSpinEdit;
    RzLabel4: TRzLabel;
    RzLabel5: TRzLabel;
    neQhv: TRzNumericEdit;
    neQkan: TRzNumericEdit;
    RzLabel6: TRzLabel;
    RzLabel7: TRzLabel;
    neProj: TRzNumericEdit;
    RzLabel8: TRzLabel;
    neProj_l: TRzNumericEdit;
    RzLabel9: TRzLabel;
    neSpl: TRzNumericEdit;
    RzLabel10: TRzLabel;
    neSpl_l: TRzNumericEdit;
    lcbTarifOt: TRzDBLookupComboBox;
    RzLabel11: TRzLabel;
    RzLabel12: TRzLabel;
    lcbTarifVoda: TRzDBLookupComboBox;
    cboNds: TRzComboBox;
    RzLabel13: TRzLabel;
    RzLabel14: TRzLabel;
    lcbKoteln: TRzDBLookupComboBox;
    RzLabel15: TRzLabel;
    lcbPribor: TRzDBLookupComboBox;
    chkUTeplo: TRzCheckBox;
    chkUGvoda: TRzCheckBox;
    chkPodklOt: TRzCheckBox;
    chkPodklVoda: TRzCheckBox;
    chkRaschEcnal: TRzCheckBox;
    RzLabel16: TRzLabel;
    cbPrinObk: TRzComboBox;
    chkGvs: TRzCheckBox;
    RzLabel17: TRzLabel;
    neNds: TRzNumericEdit;
    RzLabel18: TRzLabel;
    lcbTarifGarbage: TRzDBLookupComboBox;
    chkGarbage: TRzCheckBox;
    RzLabel19: TRzLabel;
    neQgar: TRzNumericEdit;
    procedure FormShow(Sender: TObject);
    procedure BtnCancelClick(Sender: TObject);
    procedure BtnOkClick(Sender: TObject);
    procedure BtnCalcClick(Sender: TObject);
    procedure cboNdsChange(Sender: TObject);
  private
    function VerifyData:Boolean;
    procedure ClearControl;
  public
    FC:TFrmCalcQot;
  end;

var
  FrmUObekt: TFrmUObekt;

implementation

uses DataModule, MainForm;

{$R *.dfm}

procedure TFrmUObekt.FormShow(Sender: TObject);
begin
  // Открываем таблицу "Тарифы"
  with dm do begin
    with qryTarifTeplo do begin
      if Not Active then
      try
        Open;
      except
        ShowMessage('Не удалось открыть таблицу "Тарифы (отопление)". Повторите попытку...');
        exit;
      end;
    end;
    with qryTarifVoda do begin
      if Not Active then
      try
        Open;
      except
        ShowMessage('Не удалось открыть таблицу "Тарифы (х.вода)". Повторите попытку...');
        exit;
      end;
    end;
    with qryTarifGarbage do begin
      if Not Active then
      try
        Open;
      except
        ShowMessage('Не удалось открыть таблицу "Тарифы (мусор)". Повторите попытку...');
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
  if dm.qryObekt.State = dsInsert then
  begin
    Caption:='Новый объект организации '+dm.qryOrg['nazv'];
    ClearControl;
  end;
  if dm.qryObekt.State = dsEdit then
  begin
    FrmMain.CurRec:=dm.qryObektkodobk.Value;
    Caption:='Объект:'+dm.qryObekt['nazv']+' - Организация:'+dm.qryOrg['nazv'];
    edtName.Text:=dm.qryObektnazv.Value;
    neVolume.Value:=dm.qryObektV.Value;
    seTemp.Value:=dm.qryObektT.Value;
    neQot.Value:=dm.qryObektq.Value;
    neQhv.Value:=dm.qryObektqv.Value;
    neQkan.Value:=dm.qryObektqk.Value;
    neQgar.Value:=DM.qryObektqg.Value;
    neProj.Value:=dm.qryObektprj.Value;
    neProj_l.Value:=dm.qryObektprjl.Value;
    neSpl.Value:=dm.qryObektspl.Value;
    neSpl_l.Value:=dm.qryObektspll.Value;
    lcbTarifOt.KeyValue:=dm.qryObektkodtt.Value;
    lcbTarifVoda.KeyValue:=dm.qryObektkodtv.Value;
    lcbTarifGarbage.KeyValue:=dm.qryObektkodtg.Value;
    lcbKoteln.KeyValue:=dm.qryObektkodkot.Value;
    lcbPribor.KeyValue:=dm.qryObektkodpr.Value;
    cboNds.ItemIndex:=dm.qryObektrasch.Value;
    neNds.Value:=dm.qryObektnds.Value;
    cbPrinObk.ItemIndex:=dm.qryObektprin.Value;
    if dm.qryObektpodkl.Value=0 then chkPodklOt.Checked:=True
    else chkPodklOt.Checked:=False;
    if dm.qryObektpodklv.Value=0 then chkPodklVoda.Checked:=True
    else chkPodklVoda.Checked:=False;
    if dm.qryObektpodklg.Value=0 then chkGarbage.Checked:=True
    else chkGarbage.Checked:=False;
    if dm.qryObektnalprib.Value=0 then chkUTeplo.Checked:=True
    else chkUTeplo.Checked:=False;
    if dm.qryObektnalpribgv.Value=0 then chkUGvoda.Checked:=True
    else chkUGvoda.Checked:=False;
    if dm.qryObektecnal.Value=0 then chkRaschEcnal.Checked:=True
    else chkRaschEcnal.Checked:=False;
    if dm.qryObektpodklgv.Value=0 then chkGvs.Checked:=True
    else chkGvs.Checked:=False;
  end;
end;

function TFrmUObekt.VerifyData:Boolean;
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

procedure TFrmUObekt.ClearControl;
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

procedure TFrmUObekt.BtnCancelClick(Sender: TObject);
begin
  close;
end;

procedure TFrmUObekt.BtnOkClick(Sender: TObject);
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
      qryObektnazv.Value:=edtName.Text;
      qryObektV.Value:=neVolume.Value;
      qryObektT.Value:=seTemp.Value;
      qryObektq.Value:=neQot.Value;
      qryObektqv.Value:=neQhv.Value;
      qryObektqk.Value:=neQkan.Value;
      qryObektqg.Value:=neQgar.Value;
      qryObektprj.Value:=neProj.Value;
      qryObektprjl.Value:=neProj_l.Value;
      qryObektspl.Value:=neSpl.Value;
      qryObektspll.Value:=neSpl_l.Value;
      qryObektkodtt.Value:=lcbTarifOt.KeyValue;
      qryObektkodtv.Value:=lcbTarifVoda.KeyValue;
      qryObektkodtg.Value:=lcbTarifGarbage.KeyValue;
      qryObektkodkot.Value:=lcbKoteln.KeyValue;
      qryObektkodpr.Value:=lcbPribor.KeyValue;
      qryObektrasch.Value:=cboNds.ItemIndex;
      qryObektnds.Value:=Ceil(neNds.Value);
      qryObektprin.Value:=cbPrinObk.ItemIndex;
      if chkPodklOt.Checked=True then qryObektpodkl.Value:=0
      else qryObektpodkl.Value:=1;
      if chkPodklVoda.Checked=True then qryObektpodklv.Value:=0
      else qryObektpodklv.Value:=1;
      if chkGarbage.Checked=True then qryObektpodklg.Value:=0
      else qryObektpodklg.Value:=1;
      if chkUTeplo.Checked=True then qryObektnalprib.Value:=0
      else qryObektnalprib.Value:=1;
      if chkUGvoda.Checked=True then qryObektnalpribgv.Value:=0
      else qryObektnalpribgv.Value:=1;
      if chkRaschEcnal.Checked=True then qryObektecnal.Value:=0
      else qryObektecnal.Value:=1;
      if chkGvs.Checked=True then qryObektpodklgv.Value:=0
      else qryObektpodklgv.Value:=1;
      if Application.MessageBox('Сохранить изменения ?',
      'Предупреждение',mb_YesNo or mb_TaskModal or mb_IconQuestion)=idYes then
      begin
        qryObekt.Post;
        qryObekt.Refresh;
        if qryObekt.State = dsEdit then dm.qryObekt.Locate('kodobk',FrmMain.CurRec,[]);
      end;
    end;
  except
    ShowMessage('Невозможно выполнить изменения. Повторите...');
  end;
  Close;
end;

procedure TFrmUObekt.BtnCalcClick(Sender: TObject);
begin
  //*** Расчет нагрузки на отопление
  FC := TFrmCalcQot.Create( Application );
  try
    //*** Рассчитываем нагрузку по объекту
    if Not VarIsNull(neVolume.Value) then
    FC.neVolume.Value:=neVolume.Value
    else FC.neVolume.Value:=0;
    if Not VarIsNull(seTemp.Value) then
    FC.seTemp.Value:=seTemp.Value
    else FC.seTemp.Value:=10;
    FC.ShowModal;
    neQot.Value:=FC.neQot.Value;
  finally
    FC.Free;
  end;
end;

procedure TFrmUObekt.cboNdsChange(Sender: TObject);
begin
  if cboNds.ItemIndex = 0 then neNds.Value := 20 else neNds.Value := 0; 
end;

end.

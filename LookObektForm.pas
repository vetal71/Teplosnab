unit LookObektForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RzButton, RzRadChk, StdCtrls, RzCmboBx, DBCtrls, RzDBCmbo,
  RzSpnEdt, RzEdit, Mask, RzLine, RzLabel, ExtCtrls, RzPanel;

type
  TFrmLookObekt = class(TForm)
    pnlMain: TRzPanel;
    RzLabel1: TRzLabel;
    RzLine1: TRzLine;
    RzLabel2: TRzLabel;
    RzLabel3: TRzLabel;
    RzLabel4: TRzLabel;
    RzLabel5: TRzLabel;
    RzLabel6: TRzLabel;
    RzLabel7: TRzLabel;
    RzLabel8: TRzLabel;
    RzLabel9: TRzLabel;
    RzLabel10: TRzLabel;
    RzLabel11: TRzLabel;
    RzLabel12: TRzLabel;
    RzLabel13: TRzLabel;
    RzLabel14: TRzLabel;
    RzLabel15: TRzLabel;
    RzLabel16: TRzLabel;
    RzLabel17: TRzLabel;
    edtName: TRzEdit;
    neVolume: TRzNumericEdit;
    neQot: TRzNumericEdit;
    seTemp: TRzSpinEdit;
    neQhv: TRzNumericEdit;
    neQkan: TRzNumericEdit;
    neProj: TRzNumericEdit;
    neProj_l: TRzNumericEdit;
    neSpl: TRzNumericEdit;
    neSpl_l: TRzNumericEdit;
    lcbTarifOt: TRzDBLookupComboBox;
    lcbTarifVoda: TRzDBLookupComboBox;
    cboNds: TRzComboBox;
    lcbKoteln: TRzDBLookupComboBox;
    lcbPribor: TRzDBLookupComboBox;
    chkUTeplo: TRzCheckBox;
    chkUGvoda: TRzCheckBox;
    chkPodklOt: TRzCheckBox;
    chkPodklVoda: TRzCheckBox;
    chkRaschEcnal: TRzCheckBox;
    cbPrinObk: TRzComboBox;
    chkGvs: TRzCheckBox;
    neNds: TRzNumericEdit;
    RzPanel2: TRzPanel;
    BtnOk: TRzBitBtn;
    procedure FormShow(Sender: TObject);
    procedure BtnOkClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmLookObekt: TFrmLookObekt;

implementation

uses DataModule, MainForm;

{$R *.dfm}

procedure TFrmLookObekt.FormShow(Sender: TObject);
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
      Caption:='Объект:'+dm.qryObekt['nazv']+' - Организация:'+dm.qryOrg['nazv'];
      edtName.Text:=dm.qryObektnazv.Value;
      neVolume.Value:=dm.qryObektV.Value;
      seTemp.Value:=dm.qryObektT.Value;
      neQot.Value:=dm.qryObektq.Value;
      neQhv.Value:=dm.qryObektqv.Value;
      neQkan.Value:=dm.qryObektqk.Value;
      neProj.Value:=dm.qryObektprj.Value;
      neProj_l.Value:=dm.qryObektprjl.Value;
      neSpl.Value:=dm.qryObektspl.Value;
      neSpl_l.Value:=dm.qryObektspll.Value;
      lcbTarifOt.KeyValue:=dm.qryObektkodtt.Value;
      lcbTarifVoda.KeyValue:=dm.qryObektkodtv.Value;
      lcbKoteln.KeyValue:=dm.qryObektkodkot.Value;
      lcbPribor.KeyValue:=dm.qryObektkodpr.Value;
      cboNds.ItemIndex:=dm.qryObektrasch.Value;
      neNds.Value:=dm.qryObektnds.Value;
      cbPrinObk.ItemIndex:=dm.qryObektprin.Value;
      if dm.qryObektpodkl.Value=0 then chkPodklOt.Checked:=True
      else chkPodklOt.Checked:=False;
      if dm.qryObektpodklv.Value=0 then chkPodklVoda.Checked:=True
      else chkPodklVoda.Checked:=False;
      if dm.qryObektnalprib.Value=0 then chkUTeplo.Checked:=True
      else chkUTeplo.Checked:=False;
      if dm.qryObektnalpribgv.Value=0 then chkUGvoda.Checked:=True
      else chkUGvoda.Checked:=False;
      if dm.qryObektecnal.Value=0 then chkRaschEcnal.Checked:=True
      else chkRaschEcnal.Checked:=False;
      if dm.qryObektpodklgv.Value=0 then chkGvs.Checked:=True
      else chkGvs.Checked:=False;
    
end;

procedure TFrmLookObekt.BtnOkClick(Sender: TObject);
begin
  Close;
end;

end.

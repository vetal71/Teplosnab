unit LookDanKvartForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RzButton, StdCtrls, RzCmboBx, RzRadChk, DBCtrls, RzDBCmbo,
  RzEdit, Mask, RzLabel, ExtCtrls, RzPanel;

type
  TFrmDanKvart = class(TForm)
    pnlMain: TRzPanel;
    RzLabel2: TRzLabel;
    RzLabel4: TRzLabel;
    RzLabel7: TRzLabel;
    RzLabel9: TRzLabel;
    RzLabel14: TRzLabel;
    RzLabel15: TRzLabel;
    RzLabel13: TRzLabel;
    edtDom: TRzEdit;
    neQot: TRzNumericEdit;
    neProj: TRzNumericEdit;
    neSpl: TRzNumericEdit;
    lcbOrg: TRzDBLookupComboBox;
    lcbObekt: TRzDBLookupComboBox;
    chkPodklOt: TRzCheckBox;
    cboPrin: TRzComboBox;
    chkPriv: TRzCheckBox;
    chkGvs: TRzCheckBox;
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
  FrmDanKvart: TFrmDanKvart;

implementation

uses DataModule, MainForm;

{$R *.dfm}

procedure TFrmDanKvart.FormShow(Sender: TObject);
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
  with dm.qryKvart do
  begin
    Open;
    Locate('kodkv',dm.qryRezCalcKvart['kodkv'],[]);
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

procedure TFrmDanKvart.BtnOkClick(Sender: TObject);
begin
  Close;
end;

end.

unit LookDanDomaForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RzButton, RzRadChk, RzEdit, DBCtrls, RzDBCmbo, StdCtrls, Mask,
  RzLabel, ExtCtrls, RzPanel;

type
  TFrmLookDoma = class(TForm)
    pnlMain: TRzPanel;
    RzLabel1: TRzLabel;
    RzLabel2: TRzLabel;
    RzLabel3: TRzLabel;
    RzLabel4: TRzLabel;
    RzLabel7: TRzLabel;
    RzLabel9: TRzLabel;
    RzLabel14: TRzLabel;
    RzLabel15: TRzLabel;
    edtDom: TRzEdit;
    lcbUlica: TRzDBLookupComboBox;
    neVolume: TRzNumericEdit;
    neQot: TRzNumericEdit;
    neProj: TRzNumericEdit;
    neSpl: TRzNumericEdit;
    lcbKoteln: TRzDBLookupComboBox;
    lcbPribor: TRzDBLookupComboBox;
    chkUTeplo: TRzCheckBox;
    chkUGvoda: TRzCheckBox;
    chkPodklOt: TRzCheckBox;
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
  FrmLookDoma: TFrmLookDoma;

implementation

uses DataModule, MainForm;

{$R *.dfm}

procedure TFrmLookDoma.FormShow(Sender: TObject);
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
  with dm.qryDoma do
  begin
    Open;
    Locate('koddom',dm.qryRezCalcNas['koddom'],[]);
    Caption:='Дом по адресу:'+dm.qryRezCalcNas['adres'];
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

procedure TFrmLookDoma.BtnOkClick(Sender: TObject);
begin
  Close;
end;

end.

unit CalcPribForOtGvs;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, MSAccess, DB, MemDS, DBAccess, RzButton, StdCtrls, Mask, RzEdit,
  RzPanel, RzLabel, ExtCtrls, Math;
  
type
  TFrmCalcGvsOt = class(TForm)
    RzPanel1: TRzPanel;
    RzLabel8: TRzLabel;
    RzGroupBox1: TRzGroupBox;
    RzLabel3: TRzLabel;
    RzLabel4: TRzLabel;
    RzLabel5: TRzLabel;
    RzLabel6: TRzLabel;
    RzLabel7: TRzLabel;
    RzLabel1: TRzLabel;
    RzLabel2: TRzLabel;
    nePokPrib: TRzNumericEdit;
    neNorma: TRzNumericEdit;
    neNormativ: TRzNumericEdit;
    neCalc: TRzNumericEdit;
    nePrj: TRzNumericEdit;
    neItogGvs: TRzNumericEdit;
    RzPanel2: TRzPanel;
    BtnOk: TRzBitBtn;
    BtnCancel: TRzBitBtn;
    UpPokPrib: TMSQuery;
    RzLabel9: TRzLabel;
    neKdgv_p: TRzNumericEdit;
    RzLabel10: TRzLabel;
    neKdgv_r: TRzNumericEdit;
    RzLabel11: TRzLabel;
    neItogOt: TRzNumericEdit;
    spQprib: TMSQuery;
    procedure FormShow(Sender: TObject);
    procedure neKdgv_pChange(Sender: TObject);
    procedure BtnCancelClick(Sender: TObject);
    procedure BtnOkClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmCalcGvsOt: TFrmCalcGvsOt;

implementation

uses DataModule, MainForm;

{$R *.dfm}

procedure TFrmCalcGvsOt.FormShow(Sender: TObject);
begin
  {»щем людей по прибору}
  with spQprib do
  begin
    ParamByName('kod').AsInteger:=dm.qryPokPribkod.Value;
    try
      Execute;
      nePrj.Value:=ParamByName('cnt').AsInteger;
    except
      ShowMessage('Ќе удалось получить проживающих по прибору учета...');
    end;
  end;
end;

procedure TFrmCalcGvsOt.neKdgv_pChange(Sender: TObject);
begin
  neCalc.Value:=RoundTo(neNorma.Value*nePrj.Value/1000*neNormativ.Value*neKdgv_r.Value,-2)+
  RoundTo(neNorma.Value*nePrj.Value/1000*neNormativ.Value*neKdgv_p.Value,-2);
  neItogGvs.Value:=neCalc.Value;
  neItogOt.Value:=nePokPrib.Value-neCalc.Value;
end;

procedure TFrmCalcGvsOt.BtnCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmCalcGvsOt.BtnOkClick(Sender: TObject);
begin
  with UpPokPrib do
  begin
    ParamByName('kod').AsInteger:=dm.qryPokPribkod.Value;
    ParamByName('data').AsDate:=StrToDate(FrmMain.WorkDate);
    ParamByName('gkv').AsFloat:=neItogGvs.Value;
    ParamByName('gkt').AsFloat:=neItogOt.Value;
    ParamByName('gkrv').AsFloat:=neCalc.Value;
    ParamByName('n_gv').AsFloat:=neNorma.Value;
    ParamByName('normativ').AsFloat:=neNormativ.Value;
    ParamByName('k_prj').AsFloat:=nePrj.Value;
    try
      Execute;
    except
      ShowMessage('Ќе удалось обновить показани€ прибора учета...');
    end;
  end;
  Close;
end;

end.

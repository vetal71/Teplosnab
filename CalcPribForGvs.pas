unit CalcPribForGvs;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RzButton, RzEdit, StdCtrls, Mask, RzPanel, RzLabel, ExtCtrls,
  MSAccess, DB, MemDS, DBAccess, Math;
  
type
  TFrmCalcPribForGvs = class(TForm)
    RzPanel1: TRzPanel;
    RzLabel8: TRzLabel;
    RzGroupBox1: TRzGroupBox;
    RzLabel3: TRzLabel;
    RzLabel4: TRzLabel;
    RzLabel5: TRzLabel;
    RzLabel6: TRzLabel;
    RzLabel7: TRzLabel;
    nePokPrib: TRzNumericEdit;
    neNorma: TRzNumericEdit;
    neNormativ: TRzNumericEdit;
    neCalc: TRzNumericEdit;
    nePrj: TRzNumericEdit;
    neItog: TRzNumericEdit;
    RzPanel2: TRzPanel;
    BtnOk: TRzBitBtn;
    BtnCancel: TRzBitBtn;
    RzLabel1: TRzLabel;
    RzLabel2: TRzLabel;
    UpPokPrib: TMSQuery;
    spQprib: TMSQuery;
    RzLabel10: TRzLabel;
    neKdgv_r: TRzNumericEdit;
    procedure FormShow(Sender: TObject);
    procedure neNormaChange(Sender: TObject);
    procedure BtnCancelClick(Sender: TObject);
    procedure BtnOkClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmCalcPribForGvs: TFrmCalcPribForGvs;

implementation

uses DataModule, MainForm;

{$R *.dfm}

procedure TFrmCalcPribForGvs.FormShow(Sender: TObject);
begin
  {Ищем людей по прибору}
  with spQprib do
  begin
    ParamByName('kod').AsInteger:=dm.qryPokPribkod.Value;
    try
      Execute;
      nePrj.Value:=ParamByName('cnt').AsInteger;
    except
      ShowMessage('Не удалось получить проживающих по прибору учета...');
    end;
  end;
  ShowMessage('Внимание! Для данного расчета нужно ввести количество проживающих,'+
  'которые не подали показания своих счетчиков...');
end;

procedure TFrmCalcPribForGvs.neNormaChange(Sender: TObject);
begin
  neCalc.Value:=RoundTo(neNorma.Value*nePrj.Value/1000*neNormativ.Value*neKdgv_r.Value,-2);
  neItog.Value:=neCalc.Value+RoundTo(nePokPrib.Value*neNormativ.Value,-2);
end;

procedure TFrmCalcPribForGvs.BtnCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmCalcPribForGvs.BtnOkClick(Sender: TObject);
begin
  with UpPokPrib do
  begin
    ParamByName('kod').AsInteger:=dm.qryPokPribkod.Value;
    ParamByName('data').AsDate:=StrToDate(FrmMain.WorkDate);
    ParamByName('gkv').AsFloat:=neItog.Value;
    ParamByName('gkrv').AsFloat:=neCalc.Value;
    ParamByName('pok_kub').AsFloat:=nePokPrib.Value;
    ParamByName('n_gv').AsFloat:=neNorma.Value;
    ParamByName('normativ').AsFloat:=neNormativ.Value;
    ParamByName('k_prj').AsFloat:=nePrj.Value;
    try
      Execute;
    except
      ShowMessage('Не удалось обновить показания прибора учета...');
    end;
  end;
  Close;
end;

end.

unit PerCalcForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DBAccess, MSAccess, RzDBLbl, RzButton, StdCtrls, Mask, RzEdit,
  RzLabel, ExtCtrls, RzPanel;
  
type
  TFrmPerCalc = class(TForm)
    pnlMain: TRzPanel;
    RzLabel3: TRzLabel;
    RzLabel7: TRzLabel;
    RzLabel1: TRzLabel;
    RzLabel2: TRzLabel;
    RzLabel4: TRzLabel;
    neGkt: TRzNumericEdit;
    neGkv: TRzNumericEdit;
    RzPanel2: TRzPanel;
    BtnOk: TRzBitBtn;
    BtnCancel: TRzBitBtn;
    RzDBLabel1: TRzDBLabel;
    RzLabel5: TRzLabel;
    nePert: TRzNumericEdit;
    RzLabel6: TRzLabel;
    nePerv: TRzNumericEdit;
    UpPokPrib: TMSSQL;
    procedure FormShow(Sender: TObject);
    procedure BtnCancelClick(Sender: TObject);
    procedure BtnOkClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmPerCalc: TFrmPerCalc;

implementation

uses DataModule, MainForm;

{$R *.dfm}

procedure TFrmPerCalc.FormShow(Sender: TObject);
begin
  with dm do
  begin
    neGkt.Value:=qryRezCalcObks_pgkt.Value;
    neGkv.Value:=qryRezCalcObks_pgkv.Value;
    nePert.Value:=qryRezCalcObks_pert.Value;
    nePerv.Value:=qryRezCalcObks_perv.Value;
  end;
end;

procedure TFrmPerCalc.BtnCancelClick(Sender: TObject);
begin
  FrmMain.MR:=2;
  Close;
end;

procedure TFrmPerCalc.BtnOkClick(Sender: TObject);
begin
  with UpPokPrib do
  begin
    SQL.Clear;
    SQL.Add('update dataobekt set pgkt = :pgkt, pgkv = :pgkv, pert = :pert,'+
    'perv = :perv where kodobk = :kod and datan = :data');
    ParamByName('kod').AsInteger:=dm.qryRezCalcObkkodobk.Value;
    ParamByName('data').AsDate:=StrToDate(FrmMain.WorkDate);
    ParamByName('pgkt').AsFloat:=neGkt.Value;
    ParamByName('pgkv').AsFloat:=neGkv.Value;
    ParamByName('pert').AsFloat:=nePert.Value;
    ParamByName('perv').AsFloat:=nePerv.Value;
    try
      Execute;
      FrmMain.MR:=1;
    except
      ShowMessage('Не удалось обновить начисление...');
    end;
  end;
  Close;
end;

end.

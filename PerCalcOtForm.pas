unit PerCalcOtForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DBAccess, MSAccess, RzButton, StdCtrls, Mask, RzEdit, RzDBLbl,
  RzLabel, ExtCtrls, RzPanel;
  
type
  TFrmPerCalcOt = class(TForm)
    pnlMain: TRzPanel;
    RzLabel3: TRzLabel;
    RzLabel7: TRzLabel;
    RzLabel1: TRzLabel;
    RzLabel2: TRzLabel;
    RzLabel4: TRzLabel;
    RzDBLabel1: TRzDBLabel;
    RzLabel5: TRzLabel;
    RzLabel6: TRzLabel;
    neGkt: TRzNumericEdit;
    neGkv: TRzNumericEdit;
    nePert: TRzNumericEdit;
    nePerv: TRzNumericEdit;
    RzPanel2: TRzPanel;
    BtnOk: TRzBitBtn;
    BtnCancel: TRzBitBtn;
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
  FrmPerCalcOt: TFrmPerCalcOt;

implementation

uses DataModule, MainForm;

{$R *.dfm}

procedure TFrmPerCalcOt.FormShow(Sender: TObject);
begin
  with dm do
  begin
    neGkt.Value:=qryRezCalcObkOts_pgkt.Value;
    neGkv.Value:=qryRezCalcObkOts_pgkv.Value;
    nePert.Value:=qryRezCalcObkOts_pert.Value;
    nePerv.Value:=qryRezCalcObkOts_perv.Value;
  end;
end;

procedure TFrmPerCalcOt.BtnCancelClick(Sender: TObject);
begin
  FrmMain.MR:=2;
  Close
end;

procedure TFrmPerCalcOt.BtnOkClick(Sender: TObject);
begin
  with UpPokPrib do
  begin
    SQL.Clear;
    SQL.Add('update dataobekt set pgkt = :pgkt, pgkv = :pgkv, pert = :pert,'+
    'perv = :perv where kodobk = :kod and datan = :data');
    ParamByName('kod').AsInteger:=dm.qryRezCalcObkOtkodobk.Value;
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

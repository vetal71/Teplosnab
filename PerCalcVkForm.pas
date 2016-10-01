unit PerCalcVkForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RzButton, DBAccess, MSAccess, StdCtrls, Mask, RzEdit, RzDBLbl,
  RzLabel, ExtCtrls, RzPanel;
  
type
  TFrmPerCalcVk = class(TForm)
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
    UpPokPrib: TMSSQL;
    RzPanel2: TRzPanel;
    BtnOk: TRzBitBtn;
    BtnCancel: TRzBitBtn;
    procedure FormShow(Sender: TObject);
    procedure BtnCancelClick(Sender: TObject);
    procedure BtnOkClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmPerCalcVk: TFrmPerCalcVk;

implementation

uses DataModule, MainForm;

{$R *.dfm}

procedure TFrmPerCalcVk.FormShow(Sender: TObject);
begin
  with dm do
  begin
    neGkt.Value:=qryRezCalcObkVks_pkybv.Value;
    neGkv.Value:=qryRezCalcObkVks_pkybk.Value;
    nePert.Value:=qryRezCalcObkVks_perh.Value;
    nePerv.Value:=qryRezCalcObkVks_perk.Value;
  end;
end;

procedure TFrmPerCalcVk.BtnCancelClick(Sender: TObject);
begin
  FrmMain.MR:=2;
  Close
end;

procedure TFrmPerCalcVk.BtnOkClick(Sender: TObject);
begin
  with UpPokPrib do
  begin
    SQL.Clear;
    SQL.Add('update dataobekt set pkybv = :pgkt, pkybk = :pgkv, perh = :pert,'+
    'perk = :perv where kodobk = :kod and datan = :data');
    ParamByName('kod').AsInteger:=dm.qryRezCalcObkVkkodobk.Value;
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

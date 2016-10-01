unit PerCalcGForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RzButton, DBAccess, MSAccess, StdCtrls, Mask, RzEdit, RzDBLbl,
  RzLabel, ExtCtrls, RzPanel;
  
type
  TFrmPerCalcG = class(TForm)
    pnlMain: TRzPanel;
    RzLabel3: TRzLabel;
    RzLabel1: TRzLabel;
    RzLabel2: TRzLabel;
    RzDBLabel1: TRzDBLabel;
    RzLabel5: TRzLabel;
    neGkt: TRzNumericEdit;
    nePert: TRzNumericEdit;
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
  FrmPerCalcG: TFrmPerCalcG;

implementation

uses DataModule, MainForm;

{$R *.dfm}

procedure TFrmPerCalcG.FormShow(Sender: TObject);
begin
  with dm do
  begin
    neGkt.Value:=qryRezCalcObkGs_pkybg.Value;
    nePert.Value:=qryRezCalcObkGs_perg.Value;
  end;
end;

procedure TFrmPerCalcG.BtnCancelClick(Sender: TObject);
begin
  FrmMain.MR:=2;
  Close
end;

procedure TFrmPerCalcG.BtnOkClick(Sender: TObject);
begin
  with UpPokPrib do
  begin
    SQL.Clear;
    SQL.Add('update dataobekt set pkybg = :pgkt, perg = :pert'+
    ' where kodobk = :kod and datan = :data');
    ParamByName('kod').AsInteger:=dm.qryRezCalcObkGkodobk.Value;
    ParamByName('data').AsDate:=StrToDate(FrmMain.WorkDate);
    ParamByName('pgkt').AsFloat:=neGkt.Value;
    ParamByName('pert').AsFloat:=nePert.Value;
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

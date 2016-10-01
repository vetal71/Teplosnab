unit EditNacNasForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RzDBLbl, RzButton, DBAccess, MSAccess, StdCtrls, Mask, RzEdit,
  RzLabel, ExtCtrls, RzPanel;
  
type
  TFrmEditNacDom = class(TForm)
    pnlMain: TRzPanel;
    RzLabel3: TRzLabel;
    RzLabel7: TRzLabel;
    RzLabel1: TRzLabel;
    RzLabel2: TRzLabel;
    RzLabel4: TRzLabel;
    neGkt: TRzNumericEdit;
    neGkv: TRzNumericEdit;
    UpPokPrib: TMSSQL;
    RzPanel2: TRzPanel;
    BtnOk: TRzBitBtn;
    BtnCancel: TRzBitBtn;
    RzDBLabel1: TRzDBLabel;
    procedure FormShow(Sender: TObject);
    procedure BtnCancelClick(Sender: TObject);
    procedure BtnOkClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmEditNacDom: TFrmEditNacDom;

implementation

uses DataModule, MainForm;

{$R *.dfm}

procedure TFrmEditNacDom.FormShow(Sender: TObject);
begin
  with dm do
  begin
    neGkt.Value:=qryRezCalcNass_gkt.Value;
    neGkv.Value:=qryRezCalcNass_gkv.Value;
  end;
end;

procedure TFrmEditNacDom.BtnCancelClick(Sender: TObject);
begin
  FrmMain.MR:=2;
  Close;
end;

procedure TFrmEditNacDom.BtnOkClick(Sender: TObject);
begin
  with UpPokPrib do
  begin
    ParamByName('kod').AsInteger:=dm.qryRezCalcNaskoddom.Value;
    ParamByName('data').AsDate:=StrToDate(FrmMain.WorkDate);
    ParamByName('gkt').AsFloat:=neGkt.Value;
    ParamByName('gkv').AsFloat:=neGkv.Value;
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

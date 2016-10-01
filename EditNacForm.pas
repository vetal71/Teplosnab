unit EditNacForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DBAccess, MSAccess, RzButton, StdCtrls, Mask, RzEdit, RzLabel,
  ExtCtrls, RzPanel;
  
type
  TFrmEditNac = class(TForm)
    pnlMain: TRzPanel;
    RzLabel3: TRzLabel;
    RzLabel7: TRzLabel;
    RzLabel1: TRzLabel;
    RzLabel2: TRzLabel;
    RzLabel4: TRzLabel;
    neGkt: TRzNumericEdit;
    neGkv: TRzNumericEdit;
    edtName: TRzEdit;
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
  FrmEditNac: TFrmEditNac;

implementation

uses DataModule, MainForm;

{$R *.dfm}

procedure TFrmEditNac.FormShow(Sender: TObject);
begin
  with dm do
  begin
    edtName.Text:=qryRezCalcObknzv_obk.Value;
    neGkt.Value:=qryRezCalcObks_gkt.Value;
    neGkv.Value:=qryRezCalcObks_gkv.Value;
  end;
end;

procedure TFrmEditNac.BtnCancelClick(Sender: TObject);
begin
  FrmMain.MR:=2;
  Close;
end;

procedure TFrmEditNac.BtnOkClick(Sender: TObject);
begin
  with UpPokPrib do
  begin
    ParamByName('kod').AsInteger:=dm.qryRezCalcObkkodobk.Value;
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

unit EditNacOrgVkForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RzButton, DBAccess, MSAccess, StdCtrls, Mask, RzEdit, RzLabel,
  ExtCtrls, RzPanel;
  
type
  TFrmEditNacOrgVk = class(TForm)
    pnlMain: TRzPanel;
    RzLabel3: TRzLabel;
    RzLabel7: TRzLabel;
    RzLabel1: TRzLabel;
    RzLabel2: TRzLabel;
    RzLabel4: TRzLabel;
    neGkt: TRzNumericEdit;
    neGkv: TRzNumericEdit;
    edtName: TRzEdit;
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
  FrmEditNacOrgVk: TFrmEditNacOrgVk;

implementation

uses DataModule, MainForm;

{$R *.dfm}

procedure TFrmEditNacOrgVk.FormShow(Sender: TObject);
begin
  with dm do
  begin
    edtName.Text:=qryRezCalcObkVknzv_obk.Value;
    neGkt.Value:=qryRezCalcObkVks_kybv.Value;
    neGkv.Value:=qryRezCalcObkVks_kybk.Value;
  end;
end;

procedure TFrmEditNacOrgVk.BtnCancelClick(Sender: TObject);
begin
  FrmMain.MR:=2;
  
end;

procedure TFrmEditNacOrgVk.BtnOkClick(Sender: TObject);
begin
  with UpPokPrib do
  begin
    ParamByName('kod').AsInteger:=dm.qryRezCalcObkVkkodobk.Value;
    ParamByName('data').AsDate:=StrToDate(FrmMain.WorkDate);
    ParamByName('kybv').AsFloat:=neGkt.Value;
    ParamByName('kybk').AsFloat:=neGkv.Value;
    try
      Execute;
      FrmMain.MR:=1;
    except
      ShowMessage('Не удалось обновить начисление...');
    end;
  end;

end;

end.

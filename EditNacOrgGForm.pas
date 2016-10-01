unit EditNacOrgGForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RzButton, DBAccess, MSAccess, StdCtrls, Mask, RzEdit, RzLabel,
  ExtCtrls, RzPanel;
  
type
  TFrmEditNacOrgG = class(TForm)
    pnlMain: TRzPanel;
    RzLabel3: TRzLabel;
    RzLabel1: TRzLabel;
    RzLabel2: TRzLabel;
    neGkt: TRzNumericEdit;
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
  FrmEditNacOrgG: TFrmEditNacOrgG;

implementation

uses DataModule, MainForm;

{$R *.dfm}

procedure TFrmEditNacOrgG.FormShow(Sender: TObject);
begin
  with dm do
  begin
    edtName.Text:=qryRezCalcObkGnzv_obk.Value;
    neGkt.Value :=qryRezCalcObkGs_kybg.Value;
  end;
end;

procedure TFrmEditNacOrgG.BtnCancelClick(Sender: TObject);
begin
  FrmMain.MR:=2;
end;

procedure TFrmEditNacOrgG.BtnOkClick(Sender: TObject);
begin
  with UpPokPrib do
  begin
    ParamByName('kod').AsInteger:=dm.qryRezCalcObkGkodobk.Value;
    ParamByName('data').AsDate:=StrToDate(FrmMain.WorkDate);
    ParamByName('kybg').AsFloat:=neGkt.Value;
    try
      Execute;
      FrmMain.MR:=1;
    except
      ShowMessage('Не удалось обновить начисление...');
    end;
  end;
end;

end.

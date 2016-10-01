unit EditPokForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RzButton, StdCtrls, Mask, RzEdit, RzLabel, ExtCtrls, RzPanel,
  DBAccess, MSAccess;
  
type
  TFrmEditPok = class(TForm)
    pnlMain: TRzPanel;
    RzLabel3: TRzLabel;
    RzLabel7: TRzLabel;
    neGkt: TRzNumericEdit;
    neGkv: TRzNumericEdit;
    RzPanel2: TRzPanel;
    BtnOk: TRzBitBtn;
    BtnCancel: TRzBitBtn;
    RzLabel1: TRzLabel;
    edtName: TRzEdit;
    RzLabel2: TRzLabel;
    RzLabel4: TRzLabel;
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
  FrmEditPok: TFrmEditPok;

implementation

uses DataModule, MainForm;

{$R *.dfm}

procedure TFrmEditPok.FormShow(Sender: TObject);
begin
  with dm do
  begin
    edtName.Text:=qryPokPribnazp.Value;
    neGkt.Value:=qryPokPribgk_t.Value;
    neGkv.Value:=qryPokPribgk_v.Value;
  end;  
end;

procedure TFrmEditPok.BtnCancelClick(Sender: TObject);
begin
  Close
end;

procedure TFrmEditPok.BtnOkClick(Sender: TObject);
begin
  with UpPokPrib do
  begin
    ParamByName('kod').AsInteger:=dm.qryPokPribkod.Value;
    ParamByName('data').AsDate:=StrToDate(FrmMain.WorkDate);
    ParamByName('gkt').AsFloat:=neGkt.Value;
    ParamByName('gkv').AsFloat:=neGkv.Value;
    try
      Execute;
    except
      ShowMessage('Ќе удалось обновить показани€ прибора учета...');
    end;
  end;
  Close;
end;

end.

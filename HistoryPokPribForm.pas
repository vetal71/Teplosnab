unit HistoryPokPribForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RzLine, RzDBEdit, DBCtrls, RzDBNav, RzButton, StdCtrls, Mask,
  RzEdit, RzLabel, ExtCtrls, RzPanel;

type
  TFrmHistoryPokPrib = class(TForm)
    pnlMain: TRzPanel;
    RzLabel3: TRzLabel;
    RzLabel7: TRzLabel;
    RzLabel1: TRzLabel;
    RzLabel2: TRzLabel;
    RzLabel4: TRzLabel;
    edtName: TRzEdit;
    RzPanel2: TRzPanel;
    BtnOk: TRzBitBtn;
    RzDBNavigator1: TRzDBNavigator;
    RzLabel5: TRzLabel;
    RzLabel6: TRzLabel;
    RzLabel8: TRzLabel;
    RzLabel9: TRzLabel;
    RzLabel10: TRzLabel;
    neKdr: TRzDBNumericEdit;
    neKcr: TRzDBNumericEdit;
    neStr: TRzDBNumericEdit;
    neGkr: TRzDBNumericEdit;
    RzLine1: TRzLine;
    RzLabel11: TRzLabel;
    RzLabel12: TRzLabel;
    nePok_Kub: TRzDBNumericEdit;
    RzLabel13: TRzLabel;
    nePrj: TRzDBNumericEdit;
    RzLabel14: TRzLabel;
    neNgv: TRzDBNumericEdit;
    RzLabel15: TRzLabel;
    neNormativ: TRzDBNumericEdit;
    RzLine2: TRzLine;
    RzLine3: TRzLine;
    lblPeriod: TRzLabel;
    neGkv: TRzDBNumericEdit;
    neGkt: TRzDBNumericEdit;
    procedure FormShow(Sender: TObject);
    procedure BtnOkClick(Sender: TObject);
    procedure RzDBNavigator1Click(Sender: TObject; Button: TRzNavigatorButton);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmHistoryPokPrib: TFrmHistoryPokPrib;

implementation

uses DataModule, MainForm;

{$R *.dfm}

procedure TFrmHistoryPokPrib.FormShow(Sender: TObject);
begin
  with dm.qryHistPok do
  begin
    if ACtive then Close;
    try
      Open;
      lblPeriod.Caption:=FormatDateTime('mmmm yyyy "г."',dm.qryHistPok['datan']);
    except
      ShowMessage('Не удалось открыть историю изменения показаний прибора...');
    end;
  end;
  edtName.Text:=dm.qryPokPribnazp.Value;
end;

procedure TFrmHistoryPokPrib.BtnOkClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmHistoryPokPrib.RzDBNavigator1Click(Sender: TObject;
  Button: TRzNavigatorButton);
begin
  lblPeriod.Caption:=FormatDateTime('mmmm yyyy "г."',dm.qryHistPok['datan']);
end;

end.

unit HistoryObektNacForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RzDBLbl, DBCtrls, RzDBNav, RzButton, StdCtrls, Mask, RzEdit,
  RzDBEdit, RzLine, RzLabel, ExtCtrls, RzPanel;

type
  TFrmHistoryObekt = class(TForm)
    pnlMain: TRzPanel;
    RzLabel1: TRzLabel;
    RzLabel5: TRzLabel;
    RzLabel6: TRzLabel;
    RzLabel8: TRzLabel;
    RzLabel9: TRzLabel;
    RzLabel10: TRzLabel;
    RzLine1: TRzLine;
    RzLabel11: TRzLabel;
    RzLine3: TRzLine;
    lblPeriod: TRzLabel;
    neKdr: TRzDBNumericEdit;
    neKcr: TRzDBNumericEdit;
    neStr: TRzDBNumericEdit;
    neGkr: TRzDBNumericEdit;
    RzPanel2: TRzPanel;
    BtnOk: TRzBitBtn;
    RzDBNavigator1: TRzDBNavigator;
    RzDBLabel1: TRzDBLabel;
    RzLabel16: TRzLabel;
    RzDBNumericEdit1: TRzDBNumericEdit;
    RzLabel17: TRzLabel;
    RzDBNumericEdit2: TRzDBNumericEdit;
    RzLabel18: TRzLabel;
    RzDBNumericEdit3: TRzDBNumericEdit;
    RzLabel19: TRzLabel;
    RzDBNumericEdit4: TRzDBNumericEdit;
    RzLabel20: TRzLabel;
    RzDBNumericEdit5: TRzDBNumericEdit;
    RzLabel21: TRzLabel;
    RzDBNumericEdit6: TRzDBNumericEdit;
    RzLabel2: TRzLabel;
    RzDBNumericEdit7: TRzDBNumericEdit;
    RzLabel3: TRzLabel;
    RzDBNumericEdit8: TRzDBNumericEdit;
    RzLabel4: TRzLabel;
    RzLabel7: TRzLabel;
    RzDBNumericEdit9: TRzDBNumericEdit;
    RzDBNumericEdit10: TRzDBNumericEdit;
    RzLabel13: TRzLabel;
    RzLabel14: TRzLabel;
    RzLabel15: TRzLabel;
    RzDBNumericEdit12: TRzDBNumericEdit;
    RzDBNumericEdit13: TRzDBNumericEdit;
    RzDBNumericEdit14: TRzDBNumericEdit;
    procedure FormShow(Sender: TObject);
    procedure RzDBNavigator1Click(Sender: TObject; Button: TRzNavigatorButton);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmHistoryObekt: TFrmHistoryObekt;

implementation

uses DataModule, MainForm;

{$R *.dfm}

procedure TFrmHistoryObekt.FormShow(Sender: TObject);
begin
  with dm.qryHistObekt do
  begin
    if ACtive then Close;
    try
      Open;
      lblPeriod.Caption:=FormatDateTime('mmmm yyyy "г."',dm.qryHistObekt['datan']);
    except
      ShowMessage('Не удалось открыть историю изменения показаний прибора...');
    end;
  end;
end;

procedure TFrmHistoryObekt.RzDBNavigator1Click(Sender: TObject;
  Button: TRzNavigatorButton);
begin
  lblPeriod.Caption:=FormatDateTime('mmmm yyyy "г."',dm.qryHistObekt['datan']);
end;

end.

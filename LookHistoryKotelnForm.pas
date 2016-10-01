unit LookHistoryKotelnForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGridEh, GridsEh, DBGridEhGrouping;

type
  TFrmLookHistoryKot = class(TForm)
    dbgNas: TDBGridEh;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmLookHistoryKot: TFrmLookHistoryKot;

implementation

uses DataModule;

{$R *.dfm}

procedure TFrmLookHistoryKot.FormShow(Sender: TObject);
begin
  with dm do
  begin
    if Not qryHistKot.Active then Close;
    try
      qryHistKot.Open;
      Caption:='История по участку '+qryKotelnnazk.Value;
    except
      ShowMessage('не удалось открыть историю объекта '+qryKotelnnazk.Value);
    end;
  end;
end;

end.

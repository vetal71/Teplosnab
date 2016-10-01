unit LookHistoryNasForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGridEh, GridsEh, DBGridEhGrouping;

type
  TFrmLookHistoryNas = class(TForm)
    dbgNas: TDBGridEh;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmLookHistoryNas: TFrmLookHistoryNas;

implementation

{$R *.dfm}

procedure TFrmLookHistoryNas.FormShow(Sender: TObject);
begin
  ///
end;

end.

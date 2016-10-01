unit LookHistoryObektForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGridEh, DB, GridsEh, DBGridEhGrouping;

type
  TFrmLookHistoryObekt = class(TForm)
    dbgOrg: TDBGridEh;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmLookHistoryObekt: TFrmLookHistoryObekt;

implementation

uses DataModule;

{$R *.dfm}

procedure TFrmLookHistoryObekt.FormShow(Sender: TObject);
begin
  with dm do
  begin
    if Not qryHistObk.Active then Close;
    try
      qryHistObk.Open;
      Caption:='История изменения данных по '+qryObektnazv.Value;
    except
      ShowMessage('не удалось открыть историю объекта '+qryObektnazv.Value);
    end;
  end;
end;

end.

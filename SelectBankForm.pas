unit SelectBankForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, RzDBGrid, ExtCtrls, RzPanel, RzRadGrp, StdCtrls,
  Mask, RzEdit, DB, RzButton;

type
  TfrmSelectBank = class(TForm)
    dbgBank: TRzDBGrid;
    ePoisk: TRzEdit;
    rgPoisk: TRzRadioGroup;
    BtnChoose: TRzBitBtn;
    procedure FormShow(Sender: TObject);
    procedure dbgBankDblClick(Sender: TObject);
    procedure rgPoiskClick(Sender: TObject);
    procedure ePoiskChange(Sender: TObject);
    procedure BtnChooseClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmSelectBank: TfrmSelectBank;

implementation

uses DataModule;

{$R *.dfm}

procedure TfrmSelectBank.FormShow(Sender: TObject);
begin
  with dm do begin
    with qryBank do begin
      if Not Active then
      try
        Open;
      except
        ShowMessage('Не удалось открыть таблицу "Банки"');
      end;
    end;
  end;
end;

procedure TfrmSelectBank.dbgBankDblClick(Sender: TObject);
begin
  // Выбор банка
  Close;
end;

procedure TfrmSelectBank.rgPoiskClick(Sender: TObject);
begin
  ePoisk.SetFocus;
end;

procedure TfrmSelectBank.ePoiskChange(Sender: TObject);
Var SearchField:string;
begin
  case rgPoisk.ItemIndex of
  0:SearchField:='kod_bank';
  1:SearchField:='nazv_bank';
  end;
  if VarIsNull(ePoisk.Text) then ePoisk.Text:='1' else
  if dm.qryBank.Locate(SearchField,ePoisk.Text,[loCaseInsensitive, loPartialKey]) then
  dbgBank.SetFocus;
end;

procedure TfrmSelectBank.BtnChooseClick(Sender: TObject);
begin
  // Выбор банка
  Close;
end;

end.

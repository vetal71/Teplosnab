unit EditPropis;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DataModule, StdCtrls, Mask, RzEdit, RzDBEdit, RzButton, ExtCtrls, RzPanel,
  RzLabel, RzRadChk, RzDBChk, DB, MemDS, DBAccess, MSAccess;

type
  TfPropis = class(TForm)
    RzLabel1: TRzLabel;
    RzPanel2: TRzPanel;
    BtnOk: TRzBitBtn;
    BtnCancel: TRzBitBtn;
    RzLabel2: TRzLabel;
    edtRuble: TRzDBEdit;
    edtKopeika: TRzDBEdit;
    qryPropis: TMSQuery;
    dsPropis: TDataSource;
    RzDBCheckBox1: TRzDBCheckBox;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fPropis: TfPropis;

implementation

{$R *.dfm}

end.

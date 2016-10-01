unit VerifyBaseForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, Grids, DBGridEh, RzButton, StdCtrls, RzCmboBx,
  RzLabel, RzPanel, RzStatus, Animate, GIFCtrl, GridsEh, DBGridEhGrouping;

type
  TFrmVerifyBase = class(TForm)
    RzStatusBar1: TRzStatusBar;
    RzStatusPane1: TRzStatusPane;
    RzPanel1: TRzPanel;
    RzPanel2: TRzPanel;
    RzLabel1: TRzLabel;
    RzComboBox1: TRzComboBox;
    RzBitBtn1: TRzBitBtn;
    RzBitBtn2: TRzBitBtn;
    DBGridEh1: TDBGridEh;
    RzBitBtn3: TRzBitBtn;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmVerifyBase: TFrmVerifyBase;

implementation

{$R *.dfm}

end.

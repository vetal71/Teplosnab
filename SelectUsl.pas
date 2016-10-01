unit SelectUsl;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Mask, StdCtrls, RzLabel, Str_fun,
  RzButton, ExtCtrls, RzPanel, RzEdit, RzCmboBx, RzRadGrp;
  
type
  TfrmUsluga = class(TForm)
    RzPanel2: TRzPanel;
    BtnOk: TRzBitBtn;
    BtnCancel: TRzBitBtn;
    RzRadioGroup1: TRzRadioGroup;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmUsluga: TfrmUsluga;

implementation

uses MainForm, DataModule;

{$R *.dfm}

end.

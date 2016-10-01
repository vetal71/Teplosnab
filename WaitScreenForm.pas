unit WaitScreenForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, RzLabel, Animate, GIFCtrl, rxAnimate, rxGIFCtrl;

type
  TFrmWaitScreen = class(TForm)
    RxGIFAnimator1: TRxGIFAnimator;
    RzLabel9: TRzLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmWaitScreen: TFrmWaitScreen;

implementation

{$R *.dfm}

end.

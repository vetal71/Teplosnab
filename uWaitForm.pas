unit uWaitForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, uAnimationThread;
  
type
  TfrmWait = class(TForm)
    grp1: TGroupBox;
    pnl1: TPanel;
    lblCaption: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

procedure ShowWait(AColor: TColor);
procedure UpdateCaption(TextCaption: string);
procedure HideWait;

implementation

{$R *.dfm}

var
  WaitForm: TfrmWait = nil;
  FormList: Pointer;
  ani: TAnimationThread;
  R: TRect;

procedure ShowWait(AColor: TColor);
begin
  if not Assigned(WaitForm) then
    WaitForm := TfrmWait.Create(Application.MainForm)
  else
    WaitForm.BringToFront;

  WaitForm.Show;

  FormList := DisableTaskWindows(WaitForm.Handle);
  WaitForm.Update;

  r := WaitForm.pnl1.clientrect;
  InflateRect(r, - WaitForm.pnl1.bevelwidth, - WaitForm.pnl1.bevelwidth);
  ani := TanimationThread.Create(WaitForm.pnl1, r, WaitForm.pnl1.color, AColor, 10);
  Application.ProcessMessages;
end;

procedure UpdateCaption(TextCaption: string);
begin
  if Assigned(WaitForm) then
  begin
    WaitForm.lblCaption.Caption := TextCaption;
    WaitForm.Update;
    Application.ProcessMessages;
  end;
end;

procedure HideWait;
begin
  if not Assigned(WaitForm) then Exit;

  // Останавливаем поток
  ani.Terminate;

  EnableTaskWindows(FormList);
  
  WaitForm.Hide;
  Application.ProcessMessages;
  WaitForm.Free;
  WaitForm := nil;
end;

end.

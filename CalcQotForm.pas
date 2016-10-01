unit CalcQotForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, RzPanel, RzSpnEdt, StdCtrls, Mask, RzEdit, RzLabel,
  RzRadGrp, RzButton;
  
type
  TfrmCalcQot = class(TForm)
    pnlMain: TRzPanel;
    RzPanel2: TRzPanel;
    RzLabel2: TRzLabel;
    neVolume: TRzNumericEdit;
    RzLabel4: TRzLabel;
    seTemp: TRzSpinEdit;
    rgTipZd: TRzRadioGroup;
    rgTipMat: TRzRadioGroup;
    RzLabel3: TRzLabel;
    neQot: TRzNumericEdit;
    BtnOk: TRzBitBtn;
    BtnCancel: TRzBitBtn;
    BtnCalc: TRzBitBtn;
    procedure FormShow(Sender: TObject);
    procedure BtnCalcClick(Sender: TObject);
    procedure BtnCancelClick(Sender: TObject);
    procedure BtnOkClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCalcQot: TfrmCalcQot;

implementation

uses DataModule, MainForm;

{$R *.dfm}

procedure TfrmCalcQot.FormShow(Sender: TObject);
begin
  rgTipZd.ItemIndex:=0;
  rgTipMat.ItemIndex:=0;
end;

procedure TfrmCalcQot.BtnCalcClick(Sender: TObject);
begin
  if Not dm.qryOtChar.Active then
  dm.qryOtChar.Open;
  if Not VarIsNull(neVolume.Value) then
  begin
    dm.qryOtChar.Filtered:=False;
    dm.qryOtChar.Filter:='vot<'+FloatToStr(neVolume.Value)+
    ' and vdo>'+FloatToStr(neVolume.Value);
    dm.qryOtChar.Filtered:=True;
  end
  else
  begin
    ShowMessage('Необходимо ввести объем здания...');
    neVolume.SetFocus;
  end;
  //Новое здание
  if rgTipzd.ItemIndex=0 then
  begin
    //Кирпичное или деревянное
    if rgTipMat.ItemIndex=0 then
    neQot.Value:=Int(1.15*neVolume.Value*dm.qryOtChar['qnewk']*(seTemp.Value+27)) else
    neQot.Value:=Int(1.15*neVolume.Value*dm.qryOtChar['qnewd']*(seTemp.Value+27));
  end;
  //Старое здание
  if rgTipzd.ItemIndex=0 then
  begin
  //Кирпичное или деревянное
    if rgTipMat.ItemIndex=0 then
    neQot.Value:=Int(1.15*neVolume.Value*dm.qryOtChar['qoldk']*(seTemp.Value+27)) else
    neQot.Value:=Int(1.15*neVolume.Value*dm.qryOtChar['qoldd']*(seTemp.Value+27));
  end;     
end;

procedure TfrmCalcQot.BtnCancelClick(Sender: TObject);
begin
  close
end;

procedure TfrmCalcQot.BtnOkClick(Sender: TObject);
begin
  Close;
end;

end.

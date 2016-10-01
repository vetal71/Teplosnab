unit ChangePeriodForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Mask, StdCtrls, RzLabel, Str_fun,
  RzButton, ExtCtrls, RzPanel, RzEdit, RzCmboBx, RzRadGrp;
  
type
  TFrmChangePeriod = class(TForm)
    RzPanel2: TRzPanel;
    BtnOk: TRzBitBtn;
    BtnCancel: TRzBitBtn;
    RzPanel1: TRzPanel;
    RzLabel2: TRzLabel;
    RzLabel1: TRzLabel;
    RzLabel3: TRzLabel;
    edtPeriodStr: TEdit;
    cboStart: TRzComboBox;
    cboEnd: TRzComboBox;
    procedure FormShow(Sender: TObject);
    procedure BtnCancelClick(Sender: TObject);
    procedure BtnOkClick(Sender: TObject);
    procedure cboStartChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmChangePeriod: TFrmChangePeriod;

implementation

uses MainForm, DataModule;

{$R *.dfm}

procedure TFrmChangePeriod.FormShow(Sender: TObject);
begin
  GetItemsPeriod(cboStart.Items);
  GetItemsPeriod(cboEnd.Items);
  with dm.qryParamOrg do
  begin
    if Active then Close;
    try
      Open;
      cboStart.ItemIndex:=dm.qryParamOrg['rasch_period'];
      cboEnd.ItemIndex:=dm.qryParamOrg['rasch_period'];
      edtPeriodStr.Text:='Выбран период с '+
      DateToStr(DateOfPeriod(cboStart.ItemIndex))+
      ' по '+DateToStr(DateOfPeriod(cboEnd.ItemIndex));
    except
      ShowMessage('Не удалось прочитать параметры системы...');
    end;
  end;
end;

procedure TFrmChangePeriod.BtnCancelClick(Sender: TObject);
begin
  //close;
end;

procedure TFrmChangePeriod.BtnOkClick(Sender: TObject);
begin
  if cboEnd.ItemIndex<cboStart.ItemIndex then
  begin
    ShowMessage('Проверьте период...');
    exit;
  end  
  else
  begin
    FrmMain.Data1:=DateOfPeriod(cboStart.ItemIndex);
    FrmMain.Data2:=DateOfPeriod(cboEnd.ItemIndex);
  end;
  //close;
end;

procedure TFrmChangePeriod.cboStartChange(Sender: TObject);
begin
  if cboEnd.Enabled then
    edtPeriodStr.Text:='Выбран период с '+DateToStr(DateOfPeriod(cboStart.ItemIndex))+
    ' по '+DateToStr(DateOfPeriod(cboEnd.ItemIndex))
  else
    edtPeriodStr.Text:='Выбран период '+PeriodStr(DateOfPeriod(cboStart.ItemIndex),Null);
end;

end.

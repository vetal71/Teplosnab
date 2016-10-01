unit ChangePeriodArhForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RzButton, StdCtrls, RzCmboBx, RzLabel,
  ExtCtrls, RzPanel, Str_fun;
  
type
  TFrmChangePeriodArh = class(TForm)
    RzPanel1: TRzPanel;
    RzLabel2: TRzLabel;
    RzLabel1: TRzLabel;
    RzLabel3: TRzLabel;
    edtPeriodStr: TEdit;
    cboStart: TRzComboBox;
    cboEnd: TRzComboBox;
    RzPanel2: TRzPanel;
    BtnOk: TRzBitBtn;
    BtnCancel: TRzBitBtn;
    procedure FormShow(Sender: TObject);
    procedure BtnOkClick(Sender: TObject);
    procedure BtnCancelClick(Sender: TObject);
    procedure cboStartChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmChangePeriodArh: TFrmChangePeriodArh;

implementation

uses DataModule, MainForm;

{$R *.dfm}

procedure TFrmChangePeriodArh.FormShow(Sender: TObject);
begin
  with dm.qryParamOrg do
  begin
    if Active then Close;
    try
      Open;
      GetItemsPeriodNew(cboStart.Items,dm.qryParamOrg['arh_data']);
      GetItemsPeriodNew(cboEnd.Items,dm.qryParamOrg['arh_data']);
      cboStart.ItemIndex:=GetIndexOfDate(dm.qryParamOrg['arh_data']);
      cboEnd.ItemIndex:=GetIndexOfDate(dm.qryParamOrg['arh_data']);
      edtPeriodStr.Text:='Выбран период с '+
      DateToStr(DateOfPeriod(cboStart.ItemIndex))+
      ' по '+DateToStr(DateOfPeriod(cboEnd.ItemIndex));
    except
      ShowMessage('Не удалось прочитать параметры системы...');
    end;
  end;
end;

procedure TFrmChangePeriodArh.BtnOkClick(Sender: TObject);
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
  close;
end;

procedure TFrmChangePeriodArh.BtnCancelClick(Sender: TObject);
begin
  Close
end;

procedure TFrmChangePeriodArh.cboStartChange(Sender: TObject);
begin
  if cboEnd.Enabled then
    edtPeriodStr.Text:='Выбран период с '+DateToStr(DateOfPeriod(cboStart.ItemIndex))+
    ' по '+DateToStr(DateOfPeriod(cboEnd.ItemIndex))
  else
    edtPeriodStr.Text:='Выбран период '+PeriodStr(DateOfPeriod(cboStart.ItemIndex),Null);
end;

end.

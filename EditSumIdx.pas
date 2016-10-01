unit EditSumIdx;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RzEdit, Mask, RzDBEdit, RzDBBnEd, RzCommon, RzDBLook, RzButton,
  StdCtrls, RzCmboBx, RzLabel, ExtCtrls, RzPanel, Str_fun,
  RzBtnEdt, RzRadChk;

type
  TFrmSelectOrg = class(TForm)
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
    RzLabel4: TRzLabel;
    edtNazvOrg: TRzEdit;
    dlgSearchOrg: TRzDBLookupDialog;
    edtKodOrg: TRzButtonEdit;
    chkDesign: TRzCheckBox;
    procedure edtKodOrgButtonClick(Sender: TObject);
    procedure edtKodOrgChange(Sender: TObject);
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
  FrmSelectOrg: TFrmSelectOrg;

implementation

uses DataModule, MainForm;

{$R *.dfm}

procedure TFrmSelectOrg.edtKodOrgButtonClick(Sender: TObject);
begin
  dlgSearchOrg.Execute;
end;

procedure TFrmSelectOrg.edtKodOrgChange(Sender: TObject);
begin
  with dm.qryOrg do
  begin
    if Not Active then
    try
      Open;
    except
      ShowMessage('Не удалось открыть таблицу "Организации"');
    end;
    Locate('kodorg',edtKodOrg.Text,[]);
    edtNazvOrg.Text:=dm.qryOrgnazv.Value;
  end;
end;

procedure TFrmSelectOrg.FormShow(Sender: TObject);
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

procedure TFrmSelectOrg.BtnOkClick(Sender: TObject);
begin
  if cboEnd.ItemIndex<cboStart.ItemIndex then
    ShowMessage('Проверьте период...')
  else
  begin
    FrmMain.Data1:=DateOfPeriod(cboStart.ItemIndex);
    FrmMain.Data2:=DateOfPeriod(cboEnd.ItemIndex);
  end;
  close;
end;

procedure TFrmSelectOrg.BtnCancelClick(Sender: TObject);
begin
  close;
end;

procedure TFrmSelectOrg.cboStartChange(Sender: TObject);
begin
  if cboEnd.Enabled then
    edtPeriodStr.Text:='Выбран период с '+DateToStr(DateOfPeriod(cboStart.ItemIndex))+
    ' по '+DateToStr(DateOfPeriod(cboEnd.ItemIndex))
  else
    edtPeriodStr.Text:='Выбран период '+PeriodStr(DateOfPeriod(cboStart.ItemIndex),Null);
end;

end.

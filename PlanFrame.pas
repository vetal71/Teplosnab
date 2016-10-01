unit PlanFrame;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, StdCtrls, Mask, RzEdit, ExtCtrls, RzPanel, RzRadGrp, RzTabs,
  RzCmboBx, TBX, TB2Item, TBXExtItems, TB2Dock, TB2Toolbar, RzLabel,
  Str_fun, DBAccess, MSAccess;

type
  TFmePlan = class(TFrame)
    lblCaption: TRzLabel;
    TBXDock1: TTBXDock;
    TBXToolbar2: TTBXToolbar;
    TBXLabelItem1: TTBXLabelItem;
    TBControlItem2: TTBControlItem;
    TBXSeparatorItem2: TTBXSeparatorItem;
    TBXItem1: TTBXItem;
    TBXItem3: TTBXItem;
    cboMonth: TRzComboBox;
    pgcMain: TRzPageControl;
    TabTeplo: TRzTabSheet;
    TabVoda: TRzTabSheet;
    TabStok: TRzTabSheet;
    rgTep: TRzRadioGroup;
    RzLabel1: TRzLabel;
    neProcent: TRzNumericEdit;
    rgVoda: TRzRadioGroup;
    RzLabel2: TRzLabel;
    neProcentV: TRzNumericEdit;
    rgStok: TRzRadioGroup;
    RzLabel3: TRzLabel;
    neProcentK: TRzNumericEdit;
    MQuery: TMSSQL;
    rgTip1: TRzRadioGroup;
    rgTip2: TRzRadioGroup;
    rgTip3: TRzRadioGroup;
    TabGarbage: TRzTabSheet;
    RzLabel4: TRzLabel;
    rgGarbage: TRzRadioGroup;
    neProcentG: TRzNumericEdit;
    rgTip4: TRzRadioGroup;
    procedure TBXItem3Click(Sender: TObject);
    procedure TBXItem1Click(Sender: TObject);
    procedure rgTip1Click(Sender: TObject);
    procedure rgTip2Click(Sender: TObject);
    procedure rgTip3Click(Sender: TObject);
  private
    { Private declarations }
  public
    procedure Init;
  end;

implementation

uses DataModule, DataPrint, MainForm, uWaitForm;

{$R *.dfm}

{ TFmePlan }

procedure TFmePlan.Init;
begin
  pgcMain.ActivePage:=TabTeplo;
  GetItemsPeriod(cboMonth.Items);
  ShowMessage('Не забудьте выбрать месяц и указать процент...');
end;

procedure TFmePlan.TBXItem3Click(Sender: TObject);
begin
  FrmMain.pgcWork.ActivePage:=FrmMain.TabWelcome;
end;

procedure TFmePlan.TBXItem1Click(Sender: TObject);
begin
  {Процедура формирования печати}
  ShowWait(clGreen);
  try
    if cboMonth.ItemIndex = -1 then
    begin
      ShowMessage('Не выбран месяц...');
      exit;
    end;
    if (neProcent.Value+neProcentV.Value+neProcentK.Value) = 0 then
    begin
      ShowMessage('Не введены проценты...');
      exit;
    end;
    with MQuery do
    begin
      SQL.Clear;
      SQL.Add('EXECUTE sp_create_plan :tip1, :tip2, :tip3, :tip4, :v1, :v2, :v3, :v4, :k1, :k2, :k3, :k4,:data');
      ParamByName('tip1').AsInteger:=rgTep.ItemIndex;
      ParamByName('tip2').AsInteger:=rgVoda.ItemIndex;
      ParamByName('tip3').AsInteger:=rgStok.ItemIndex;
      ParamByName('tip4').AsInteger:=rgGarbage.ItemIndex;

      ParamByName('v1').AsInteger:=rgTip1.ItemIndex;
      ParamByName('v2').AsInteger:=rgTip2.ItemIndex;
      ParamByName('v3').AsInteger:=rgTip3.ItemIndex;
      ParamByName('v4').AsInteger:=rgTip4.ItemIndex;

      ParamByName('k1').AsFloat:=neProcent.Value;
      ParamByName('k2').AsFloat:=neProcentV.Value;
      ParamByName('k3').AsFloat:=neProcentK.Value;
      ParamByName('k4').AsFloat:=neProcentG.Value;

      ParamByName('data').asDate:=DateOfPeriod(cboMonth.ItemIndex);
      try
        Execute;
      except
        ShowMessage('Не удалось сформировать данные для отчета...');
        exit;
      end;
    end;
    with dp.qryPlanTeplo do
    begin
      if Active then Close;
      try
        Open;
      except
        ShowMessage('Не удалось сформировать данные по теплу...');
        exit;
      end;
    end;
    with dp.qryPlanVoda do
    begin
      if Active then Close;
      try
        Open;
      except
        ShowMessage('Не удалось сформировать данные по воде...');
        exit;
      end;
    end;
    with dp.qryPlanStok do
    begin
      if Active then Close;
      try
        Open;
      except
        ShowMessage('Не удалось сформировать данные по стокам...');
        exit;
      end;
    end;
    with dp.qryPlanG do
    begin
      if Active then Close;
      try
        Open;
      except
        ShowMessage('Не удалось сформировать данные по мусору...');
        exit;
      end;
    end;
  finally
    HideWait;
  end;
  dp.Report.LoadFromFile(FrmMain.RPath+'Плановое начисление.fr3');
  FrmMain.Data1:=Date();
  dp.Report.Variables['period']:=PeriodStr(FrmMain.Data1,Null);
  dp.Report.Variables['tip1']:=''''+rgTep.Items[rgTep.ItemIndex]+'''';
  dp.Report.Variables['tip2']:=''''+rgVoda.Items[rgVoda.ItemIndex]+'''';
  dp.Report.Variables['tip3']:=''''+rgStok.Items[rgStok.ItemIndex]+'''';
  dp.Report.Variables['tip4']:=''''+rgGarbage.Items[rgGarbage.ItemIndex]+'''';
  dp.Report.ShowReport;
end;

procedure TFmePlan.rgTip1Click(Sender: TObject);
begin
  if rgTip1.ItemIndex = 0 then
    RzLabel1.Caption:='Введите процент изменения начисления:'
  else
    RzLabel1.Caption:='Введите новый тариф:';
end;

procedure TFmePlan.rgTip2Click(Sender: TObject);
begin
  if rgTip2.ItemIndex = 0 then
    RzLabel2.Caption:='Введите процент изменения начисления:'
  else
    RzLabel2.Caption:='Введите новый тариф:';
end;

procedure TFmePlan.rgTip3Click(Sender: TObject);
begin
  if rgTip3.ItemIndex = 0 then
    RzLabel3.Caption:='Введите процент изменения начисления:'
  else
    RzLabel3.Caption:='Введите новый тариф:';
end;

end.


unit SrTempFrame;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, RzButton, ExtCtrls, RzPanel, StdCtrls, RzLabel, Grids, DBGridEh,
  Str_fun, DB, MemDS, DBAccess, MSAccess, DateUtils, frxClass, frxDBSet,
  DBGrids, ChangePeriodForm, GridsEh, DBGridEhGrouping;

type
  TFmeSrTemp = class(TFrame)
    lblCaption: TRzLabel;
    pnlMain: TRzPanel;
    pnlBtn: TRzPanel;
    BtnOk: TRzBitBtn;
    dbgSrTemp: TDBGridEh;
    qryAvto: TMSQuery;
    BtnPrint: TRzBitBtn;
    qryTemp: TMSQuery;
    dsTemp: TDataSource;
    TempSet: TfrxDBDataset;
    qryParamOrg: TMSQuery;
    dsParamOrg: TDataSource;
    ParamOrgSet: TfrxDBDataset;
    BtnChoosePeriod: TRzBitBtn;
    BtnUndoPeriod: TRzBitBtn;
    RzBitBtn1: TRzBitBtn;
    Report: TfrxReport;
    procedure BtnOkClick(Sender: TObject);
    procedure BtnPrintClick(Sender: TObject);
    procedure ReportGetValue(const VarName: String; var Value: Variant);
    procedure BtnChoosePeriodClick(Sender: TObject);
    procedure BtnUndoPeriodClick(Sender: TObject);
    procedure RzBitBtn1Click(Sender: TObject);
  private
    CP:TFrmChangePeriod;
    procedure AvtoInsertPeriod(data1,data2:double);    
  public
    procedure Init;
  end;

implementation

uses MainForm, DataModule;

{$R *.dfm}

{ TFmeSrTemp }

procedure TFmeSrTemp.AvtoInsertPeriod(data1, data2: double);
Var data:double;
begin
  data:=data1;
  while data <= data2 do
  begin
    with qryAvto do
    begin
      ParamByName('data').AsDate:=StrToDate(DateToStr(data));
      try
        Execute;
      except
        ShowMessage('Не удалось автоматически заполнить период...');
      end;
    end;
    data:= data+1;
  end;
end;

procedure TFmeSrTemp.Init;
begin
  lblCaption.Caption:='Среднесуточные температуры за '+
  FormatDateTime('mmmm, yyyy "г."',StrToDate(FrmMain.WorkDate));
  with dm.qrySrTemp do
  begin
    FilterSQL:='data between '''+FrmMain.WorkDate+''' and '''+
    DateToStr(EndOfMonth(StrToDate(FrmMain.WorkDate)))+'''';
    try
      Open;
    except
      ShowMessage('Не удалось открыть таблицу "Средние температуры"');
    end;
  end;
  dbgSrTemp.ReadOnly:=False;
end;

procedure TFmeSrTemp.BtnOkClick(Sender: TObject);
Var data:double;
begin
  if (MonthOf(StrToDate(FrmMain.WorkDate)) = 10) or
  (MonthOf(StrToDate(FrmMain.WorkDate)) = 4) then
    data:=StrToDate(InputBox('Введите дату', 'Дата начала периода',FrmMain.WorkDate))
  else
    data:=StrToDate(FrmMain.WorkDate);
  AvtoInsertPeriod(data,EndOfMonth(StrToDate(FrmMain.WorkDate)));
  dm.qrySrTemp.Close;
  dm.qrySrTemp.Open;
end;

procedure TFmeSrTemp.BtnPrintClick(Sender: TObject);
begin
  with qryParamOrg do
  try
    Open;
  except

  end;
  with qryTemp do
  begin
    FilterSQL:='data between '''+FrmMain.WorkDate+''' and '''+
    DateToStr(EndOfMonth(StrToDate(FrmMain.WorkDate)))+'''';
    try
      Open;
    except

    end;
  end;
  Report.LoadFromFile(FrmMain.RPath+'Средние температуры.fr3');
  Report.ShowReport();
end;

procedure TFmeSrTemp.ReportGetValue(const VarName: String;
  var Value: Variant);
begin
  if CompareText(VarName,'Data1') = 0 then
    Value:=PeriodStr(StrToDate(FrmMain.WorkDate),Null);
end;

procedure TFmeSrTemp.BtnChoosePeriodClick(Sender: TObject);
begin
  BtnOk.Enabled:=False;
  CP:=TFrmChangePeriod.Create(Application);
  try
    CP.ShowModal;
    with dm.qrySrTemp do
      FilterSQL:='data between '''+DateToStr(FrmMain.Data1)+''' and '''+
      DateToStr(EndOfMonth(FrmMain.Data2))+'''';
    dbgSrTemp.ReadOnly:=True;
    lblCaption.Caption:='Среднесуточные температуры с '+
    FormatDateTime('mmmm, yyyy "г."',FrmMain.Data1)+
    ' по '+FormatDateTime('mmmm, yyyy "г."',EndOfMonth(FrmMain.Data2));
  finally
    CP.Free;
  end;
end;

procedure TFmeSrTemp.BtnUndoPeriodClick(Sender: TObject);
begin
  lblCaption.Caption:='Среднесуточные температуры за '+
  FormatDateTime('mmmm, yyyy "г."',StrToDate(FrmMain.WorkDate));
  with dm.qrySrTemp do
    FilterSQL:='data between '''+FrmMain.WorkDate+''' and '''+
    DateToStr(EndOfMonth(StrToDate(FrmMain.WorkDate)))+'''';
  dbgSrTemp.ReadOnly:=False;
end;

procedure TFmeSrTemp.RzBitBtn1Click(Sender: TObject);
begin
  FrmMain.pgcWork.ActivePage:=FrmMain.TabWelcome;
end;

end.

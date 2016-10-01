unit DataPrint;

interface

uses
  SysUtils, Classes, frxClass, frxDBSet, DB, MemDS, DBAccess, MSAccess,
  frxChart, frxBarcode, frxGZip, frxExportXLS, frxDesgn, Str_Fun, Variants,
  frxCross, scExcelExport;

type
  TDP = class(TDataModule)
    qryLicevPr: TMSQuery;
    dsLicevPr: TDataSource;
    qryLicevPrObekt: TMSQuery;
    dsLicevPrObekt: TDataSource;
    qryLicevPrDoma: TMSQuery;
    dsLicevPrDoma: TDataSource;
    LicevPrObekt: TfrxDBDataset;
    LicevPrDoma: TfrxDBDataset;
    LicevPrSet: TfrxDBDataset;
    qryLicObekt: TMSQuery;
    dsLicObekt: TDataSource;
    qryObk: TMSQuery;
    dsObk: TDataSource;
    LicObk: TfrxDBDataset;
    Obk: TfrxDBDataset;
    qryRezKot: TMSQuery;
    dsRezKot: TDataSource;
    RezKot: TfrxDBDataset;
    Koteln: TfrxDBDataset;
    qryLicDoma: TMSQuery;
    dsLicDoma: TDataSource;
    qryLicKvart: TMSQuery;
    dsLicKvart: TDataSource;
    LicDom: TfrxDBDataset;
    LicKv: TfrxDBDataset;
    qryRezKotDoma: TMSQuery;
    dsRezKotDom: TDataSource;
    RezKotDom: TfrxDBDataset;
    qryKoteln: TMSQuery;
    dsKoteln: TDataSource;
    qryObSvodOt: TMSQuery;
    dsObSvodOt: TDataSource;
    ObSvodOt: TfrxDBDataset;
    qrySchet: TMSQuery;
    dsSchet: TDataSource;
    Schet: TfrxDBDataset;
    qryParam: TMSQuery;
    dsParam: TDataSource;
    Param: TfrxDBDataset;
    frxXLSExport1: TfrxXLSExport;
    frxBarCodeObject1: TfrxBarCodeObject;
    frxDesigner1: TfrxDesigner;
    qryLicev: TMSQuery;
    dsLicev: TDataSource;
    LicevSet: TfrxDBDataset;
    qryLicevRas: TMSQuery;
    dsLicevRas: TDataSource;
    LicevRasSet: TfrxDBDataset;
    OrgSet: TfrxDBDataset;
    qryObSvodVk: TMSQuery;
    dsObSvodVk: TDataSource;
    ObSvodVk: TfrxDBDataset;
    qryRasNacOt: TMSQuery;
    dsRasNacOt: TDataSource;
    qryRasNacVk: TMSQuery;
    dsRasNacVk: TDataSource;
    RasNacOt: TfrxDBDataset;
    RasNacVk: TfrxDBDataset;
    qryRasKotOt: TMSQuery;
    dsRasKotOt: TDataSource;
    qryRasKotVk: TMSQuery;
    dsRasKotVk: TDataSource;
    RasKotOt: TfrxDBDataset;
    RasKotVk: TfrxDBDataset;
    frxCrossObject1: TfrxCrossObject;
    qryRasOt: TMSQuery;
    dsRasOt: TDataSource;
    qryRasVk: TMSQuery;
    dsRasVk: TDataSource;
    CrossOt: TfrxDBDataset;
    CrossVk: TfrxDBDataset;
    qryRasKotOtMesto: TMSQuery;
    dsRasKotOtMesto: TDataSource;
    qryRasKotVkMesto: TMSQuery;
    dsRasKotVkMesto: TDataSource;
    RasKotOtMesto: TfrxDBDataset;
    RasKotVkMesto: TfrxDBDataset;
    qryEcnal: TMSQuery;
    dsEcnal: TDataSource;
    Ecnal: TfrxDBDataset;
    qryAnalizPrib: TMSQuery;
    dsAnalizPrib: TDataSource;
    AnalizPrib: TfrxDBDataset;
    qryAnalizKot: TMSQuery;
    dsAnalizKot: TDataSource;
    AnalizKot: TfrxDBDataset;
    qryAnalizOrg: TMSQuery;
    dsAnalizOrg: TDataSource;
    AnalizOrg: TfrxDBDataset;
    qryNormativ: TMSQuery;
    dsNormativ: TDataSource;
    Normativ: TfrxDBDataset;
    qryLicevRasArh: TMSQuery;
    dsLicevRasArh: TDataSource;
    qryPlanTeplo: TMSQuery;
    dsPlanTeplo: TDataSource;
    PlanTeplo: TfrxDBDataset;
    qryPlanVoda: TMSQuery;
    dsPlanVoda: TDataSource;
    qryPlanStok: TMSQuery;
    dsPlanStok: TDataSource;
    PlanVoda: TfrxDBDataset;
    PlanStok: TfrxDBDataset;
    qryKot: TMSQuery;
    dsKot: TDataSource;
    Kot: TfrxDBDataset;
    qryVed: TMSQuery;
    dsVed: TDataSource;
    Ved: TfrxDBDataset;
    qryVyr: TMSQuery;
    dsVyr: TDataSource;
    Vyr: TfrxDBDataset;
    qryTop: TMSQuery;
    dsTop: TDataSource;
    Top: TfrxDBDataset;
    Report: TfrxReport;
    qryEcLgot: TMSQuery;
    dsEcLgot: TDataSource;
    EcLgot: TfrxDBDataset;
    qryPlanG: TMSQuery;
    dsPlanG: TDataSource;
    frxDBDataset1: TfrxDBDataset;
    qryObSvodG: TMSQuery;
    dsObSvodG: TDataSource;
    ObSvodG: TfrxDBDataset;
    qryRasKotG: TMSQuery;
    dsRasKotG: TDataSource;
    RasKotG: TfrxDBDataset;
    qryRasNacG: TMSQuery;
    dsRasNacG: TDataSource;
    RasNacG: TfrxDBDataset;
    exReport: TscExcelExport;
    qryPropis: TMSQuery;
    dsPropis: TDataSource;
    Propis: TfrxDBDataset;
    procedure ReportGetValue(const VarName: String; var Value: Variant);
    function ReportUserFunction(const MethodName: String;
      var Params: Variant): Variant;
    procedure ReportBeforePrint(Sender: TfrxReportComponent);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DP: TDP;

implementation

uses DataModule, MainForm, FunForFR;

{$R *.dfm}

procedure TDP.ReportGetValue(const VarName: String; var Value: Variant);
begin
  if CompareText(VarName,'Period') = 0 then
    Value:=PeriodStr(FrmMain.Data1,Null);
  if CompareText(VarName,'Per') = 0 then
    Value:=PeriodStr(FrmMain.Data1,FrmMain.Data2);
  if CompareText(VarName,'Koteln') = 0 then
    Value:=FrmMain.DBField;
end;


function TDP.ReportUserFunction(const MethodName: String;
  var Params: Variant): Variant;
begin
  if MethodName = 'DATEOFPERIOD' then
    Result := DateOfPeriod(Params[0]);
end;

procedure TDP.ReportBeforePrint(Sender: TfrxReportComponent);
begin
  Report.AddFunction('function DateOfPeriod(AValue: Integer): Double');
end;

end.

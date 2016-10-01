unit CalcPribForDayForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RzEdit, StdCtrls, Mask, RzLabel, RzPanel, RzButton, ExtCtrls,
  DB, MemDS, DBAccess, MSAccess, Math;
  
type
  TFrmCalcPribForDay = class(TForm)
    RzPanel1: TRzPanel;
    RzPanel2: TRzPanel;
    BtnOk: TRzBitBtn;
    BtnCancel: TRzBitBtn;
    RzGroupBox1: TRzGroupBox;
    RzLabel1: TRzLabel;
    deStart: TRzDateTimeEdit;
    RzLabel2: TRzLabel;
    deEnd: TRzDateTimeEdit;
    RzLabel3: TRzLabel;
    nePokPrib: TRzNumericEdit;
    RzLabel4: TRzLabel;
    neKdo: TRzNumericEdit;
    RzLabel5: TRzLabel;
    neSrT: TRzNumericEdit;
    RzLabel6: TRzLabel;
    neCalc: TRzNumericEdit;
    RzLabel7: TRzLabel;
    neQot: TRzNumericEdit;
    RzLabel8: TRzLabel;
    neItog: TRzNumericEdit;
    spSrTemp: TMSStoredProc;
    spQprib: TMSStoredProc;
    spVerifyTemper: TMSStoredProc;
    UpPokPrib: TMSQuery;
    RzLabel9: TRzLabel;
    neKco: TRzNumericEdit;
    procedure FormShow(Sender: TObject);
    procedure BtnOkClick(Sender: TObject);
    procedure deEndChange(Sender: TObject);
    procedure nePokPribChange(Sender: TObject);
    procedure BtnCancelClick(Sender: TObject);
  private
    t:integer;
  public
    { Public declarations }
  end;

var
  FrmCalcPribForDay: TFrmCalcPribForDay;

implementation

uses DataModule, MainForm;

{$R *.dfm}

procedure TFrmCalcPribForDay.FormShow(Sender: TObject);
begin
  {Ищем нагрузку по прибору}
  t:=0;
  with spQprib do
  begin
    ParamByName('kod').AsInteger:=dm.qryPokPribkod.Value;
    try
      ExecProc;
      neQot.Value:=ParamByName('qot').AsInteger;
      t:=ParamByName('tvn').AsInteger;
    except
      ShowMessage('Не удалось получить нагрузку по прибору учета...');
    end;
  end;      
end;

procedure TFrmCalcPribForDay.BtnOkClick(Sender: TObject);
begin
  with UpPokPrib do
  begin
    ParamByName('kod').AsInteger:=dm.qryPokPribkod.Value;
    ParamByName('data').AsDate:=StrToDate(FrmMain.WorkDate);
    ParamByName('gkt').AsFloat:=neItog.Value;
    ParamByName('gkr').AsFloat:=neCalc.Value;
    ParamByName('kdr').AsFloat:=neKdo.Value;
    ParamByName('kcr').AsFloat:=neKco.Value;
    ParamByName('str').AsFloat:=neSrT.Value;
    try
      Execute;
    except
      ShowMessage('Не удалось обновить показания прибора учета...');
    end;
  end;
  Close;
end;

procedure TFrmCalcPribForDay.deEndChange(Sender: TObject);
begin
  {Проверяем даты}
  if deEnd.Date<deStart.Date then
  begin
    ShowMessage('Дата окончания периода не может бать меньше даты начала периода...');
    exit;
    deEnd.SetFocus;
  end
  else
  begin
    if Not VarIsNull(deStart.Date) then
    begin
      with spVerifyTemper do
      begin
        ParamByName('data1').AsDate:=deStart.Date;
        ParamByName('data2').AsDate:=deEnd.Date;
        try
          ExecProc;
          if ParamByName('kol').AsInteger > 0 then
            ShowMessage(ParamByName('str').AsString+'Введите...');
        except
          ShowMessage('Не удалось проверить среднюю температуру...');
        end;
      end;
      with spSrTemp do
      begin
        ParamByName('data1').AsDate:=deStart.Date;
        ParamByName('data2').AsDate:=deEnd.Date;
        try
          ExecProc;
          neKdo.Value:=ParamByName('c_day').AsInteger;
          neSrT.Value:=ParamByName('c_tmp').AsFloat;
        except
          ShowMessage('Не удалось получить среднюю температуру...');
        end;
      end;
    end
    else
    begin
      ShowMessage('Введите начальную дату...');
      exit;
      deStart.SetFocus;
    end;
  end;
end;

procedure TFrmCalcPribForDay.nePokPribChange(Sender: TObject);
begin
  neCalc.Value:=RoundTo(neQot.Value*neKdo.Value*neKco.Value*(t-neSrT.Value)/
  (t+27)/1000000,-2);
  neItog.Value:=neCalc.Value+nePokPrib.Value;
end;

procedure TFrmCalcPribForDay.BtnCancelClick(Sender: TObject);
begin
  Close;
end;

end.

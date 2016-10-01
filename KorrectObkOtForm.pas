unit KorrectObkOtForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RzRadChk, RzButton, RzEdit, StdCtrls, Mask, RzPanel, RzLabel,
  ExtCtrls, DBAccess, MSAccess, Str_fun, DB, MemDS, Math;

type
  TFrmKorrectObkOt = class(TForm)
    RzPanel1: TRzPanel;
    RzLabel8: TRzLabel;
    rgKor: TRzGroupBox;
    RzLabel1: TRzLabel;
    RzLabel2: TRzLabel;
    RzLabel4: TRzLabel;
    RzLabel5: TRzLabel;
    RzLabel6: TRzLabel;
    RzLabel9: TRzLabel;
    deStart: TRzDateTimeEdit;
    deEnd: TRzDateTimeEdit;
    neKdo: TRzNumericEdit;
    neSrT: TRzNumericEdit;
    neCalc: TRzNumericEdit;
    neKco: TRzNumericEdit;
    neItog: TRzNumericEdit;
    RzPanel2: TRzPanel;
    BtnOk: TRzBitBtn;
    BtnCancel: TRzBitBtn;
    chkDopKor: TRzCheckBox;
    deStart1: TRzDateTimeEdit;
    RzLabel3: TRzLabel;
    deEnd1: TRzDateTimeEdit;
    RzLabel7: TRzLabel;
    neQot: TRzNumericEdit;
    RzLabel10: TRzLabel;
    neTvn: TRzNumericEdit;
    rgBKor: TRzGroupBox;
    RzLabel11: TRzLabel;
    RzLabel12: TRzLabel;
    RzLabel13: TRzLabel;
    RzLabel14: TRzLabel;
    RzLabel15: TRzLabel;
    RzLabel16: TRzLabel;
    RzLabel17: TRzLabel;
    RzLabel18: TRzLabel;
    deBStart: TRzDateTimeEdit;
    deBEnd: TRzDateTimeEdit;
    neBKdo: TRzNumericEdit;
    neBSrt: TRzNumericEdit;
    neBCalc: TRzNumericEdit;
    neBKco: TRzNumericEdit;
    chkDopBKor: TRzCheckBox;
    deBStart1: TRzDateTimeEdit;
    deBEnd1: TRzDateTimeEdit;
    neBTvn: TRzNumericEdit;
    MQuery: TMSSQL;
    qryTemper: TMSQuery;
    procedure FormShow(Sender: TObject);
    procedure chkDopKorClick(Sender: TObject);
    procedure neTvnChange(Sender: TObject);
    procedure neBTvnChange(Sender: TObject);
    procedure chkDopBKorClick(Sender: TObject);
    procedure deEndChange(Sender: TObject);
    procedure deEnd1Change(Sender: TObject);
    procedure deBEndChange(Sender: TObject);
    procedure deBEnd1Change(Sender: TObject);
    procedure BtnCancelClick(Sender: TObject);
    procedure BtnOkClick(Sender: TObject);
  private
    DaysOt:integer;
    SrtOt:double;
    procedure GetSrTemp(Filt:string);
  public
    { Public declarations }
  end;

var
  FrmKorrectObkOt: TFrmKorrectObkOt;

implementation

uses DataModule, MainForm;

{$R *.dfm}

procedure TFrmKorrectObkOt.FormShow(Sender: TObject);
begin
  // Находим нагрузку по отоплению
  If FrmMain.CurRec1 = 0 then
  begin
    Caption:='Корректировка объекта '+dm.qryRezCalcObk['nzv_obk'];
    with dm.qryOrg do
    begin
      if Active then Close;
      Open;
      Locate('kodorg',dm.qryRezCalcObk['kodorg'],[]);
    end;
    with dm.qryObekt do
    begin
      if Active then Close;
      try
        Open;
        Locate('kodobk',dm.qryRezCalcObk['kodobk'],[]);
        neQot.Value:=dm.qryObektq.Value;
        neBTvn.Value:=dm.qryObektt.Value;
      except
        ShowMessage('Не удалось получить нагрузку по объекту...');
        FrmKorrectObkOt.Close;
      end;
    end;
    deStart.Date:=dm.qryCalcKotdatas.Value;
    deEnd.Date:=EndOfMonth(dm.qryCalcKotdatas.Value);
    neKco.Value:=dm.qryCalcKotKCO.Value;
    neBKco.Value:=dm.qryCalcKotKCO.Value;
  end
  else
  begin
    Caption:='Корректировка объекта '+dm.qryRezCalcObkOt['nzv_obk'];
    with dm.qryOrg do
    begin
      if Active then Close;
      Open;
      Locate('kodorg',dm.qryRezCalcObkOt['kodorg'],[]);
    end;
    with dm.qryObekt do
    begin
      if Active then Close;
      try
        Open;
        Locate('kodobk',dm.qryRezCalcObkOt['kodobk'],[]);
        neQot.Value:=dm.qryObektq.Value;
        neBTvn.Value:=dm.qryObektt.Value;
      except
        ShowMessage('Не удалось получить нагрузку по объекту...');
        FrmKorrectObkOt.Close;
      end;
    end;
    {deStart.Date:=dm.qryCalcKotdatas.Value;
    deEnd.Date:=EndOfMonth(dm.qryCalcKotdatas.Value);
    neKco.Value:=dm.qryCalcKotKCO.Value;
    neBKco.Value:=dm.qryCalcKotKCO.Value; }
  end;
end;

procedure TFrmKorrectObkOt.GetSrTemp(Filt: string);
begin
  with qryTemper do
  begin
    FilterSQL:=Filt;
    Open;
    DaysOt:=qryTemper['d'];
    SrtOt:=qryTemper['t'];
  end;
end;

procedure TFrmKorrectObkOt.chkDopKorClick(Sender: TObject);
begin
  deStart1.Enabled:=chkDopKor.Checked;
  deEnd1.Enabled:=chkDopKor.Checked;
end;

procedure TFrmKorrectObkOt.neTvnChange(Sender: TObject);
begin
  {Ситаем Гкал по корректировке}
  neCalc.Value:=RoundTo((neQot.Value/dm.qryObektt.Value*neTvn.Value)*neKdo.Value*
  neKco.Value*(neTvn.Value-neSrT.Value)/(neTvn.Value+27)/1000000,-2);
  neItog.Value:=neCalc.Value+neBCalc.Value;
end;

procedure TFrmKorrectObkOt.neBTvnChange(Sender: TObject);
begin
  neBCalc.Value:=RoundTo(neQot.Value*neBKdo.Value*neBKco.Value*
  (neBTvn.Value-neBSrt.Value)/(neBTvn.Value+27)/1000000,-2);
  neItog.Value:=neCalc.Value+neBCalc.Value;
end;

procedure TFrmKorrectObkOt.chkDopBKorClick(Sender: TObject);
begin
  deBStart1.Enabled:=chkDopBKor.Checked;
  deBEnd1.Enabled:=chkDopBKor.Checked;
end;

procedure TFrmKorrectObkOt.deEndChange(Sender: TObject);
begin
  GetSrTemp('data between '''+DateToStr(deStart.Date)+
  ''' and '''+DateToStr(deEnd.Date)+'''');
  neKdo.Value:=DaysOt;
  neSrT.Value:=SrtOt;
end;

procedure TFrmKorrectObkOt.deEnd1Change(Sender: TObject);
begin
  GetSrTemp('data between '''+DateToStr(deStart.Date)+
  ''' and '''+DateToStr(deEnd.Date)+''''+' or data between '''+DateToStr(deStart1.Date)+
  ''' and '''+DateToStr(deEnd1.Date)+'''');
  neKdo.Value:=DaysOt;
  neSrT.Value:=SrtOt;
end;

procedure TFrmKorrectObkOt.deBEndChange(Sender: TObject);
begin
  GetSrTemp('data between '''+DateToStr(deBStart.Date)+
  ''' and '''+DateToStr(deBEnd.Date)+'''');
  neBKdo.Value:=DaysOt;
  neBSrT.Value:=SrtOt;
end;

procedure TFrmKorrectObkOt.deBEnd1Change(Sender: TObject);
begin
  GetSrTemp('data between '''+DateToStr(deBStart.Date)+
  ''' and '''+DateToStr(deBEnd.Date)+''''+' or data between '''+DateToStr(deBStart1.Date)+
  ''' and '''+DateToStr(deBEnd1.Date)+'''');
  neBKdo.Value:=DaysOt;
  neBSrT.Value:=SrtOt;
end;

procedure TFrmKorrectObkOt.BtnCancelClick(Sender: TObject);
begin
  FrmMain.MR:=2;
  Close
end;

procedure TFrmKorrectObkOt.BtnOkClick(Sender: TObject);
begin
  with MQuery do
  begin
    SQL.Clear;
    SQL.Add('update dataobekt set kdo=:kdo,kco=:kco,tvn=:tvn,ts=:ts,st=:st,'+
    'gkt=:gkt where kodobk=:kodobk and datan=:data');
    ParamByName('kdo').AsFloat:=neKdo.Value;
    ParamByName('kco').AsFloat:=neKco.Value;
    ParamByName('tvn').AsFloat:=neTvn.Value;
    ParamByName('ts').AsFloat:=neSrt.Value;
    ParamByName('st').AsFloat:=1;
    ParamByName('gkt').AsFloat:=neItog.Value;
    if FrmMain.CurRec1 = 0 then
      ParamByName('kodobk').AsInteger:=dm.qryRezCalcObk['kodobk']
    else
      ParamByName('kodobk').AsInteger:=dm.qryRezCalcObkOt['kodobk'];
    ParamByName('data').AsDate:=StrToDate(FrmMain.WorkDate);
    try
      Execute;
      FrmMain.MR:=1;
    except
      ShowMessage('Ошибка обновления данных...');
    end;
  end;
  Close;
end;

end.

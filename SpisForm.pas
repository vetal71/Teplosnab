unit SpisForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DBCtrls, RzDBCmbo, RzEdit, RzPanel, StdCtrls, Mask, RzDBEdit,
  RzLabel, RzButton, ExtCtrls, DBAccess, MSAccess, DB, MemDS, Math,
  ComCtrls, Grids, DBGridEh, GridsEh, DBGridEhGrouping;

type
  TFrmSpis = class(TForm)
    RzPanel2: TRzPanel;
    BtnOk: TRzBitBtn;
    BtnCancel: TRzBitBtn;
    pnlMain: TRzPanel;
    RzLabel1: TRzLabel;
    edtKoteln: TRzDBEdit;
    RzGroupBox1: TRzGroupBox;
    RzLabel2: TRzLabel;
    neRot: TRzNumericEdit;
    RzLabel4: TRzLabel;
    neRgv: TRzNumericEdit;
    RzLabel3: TRzLabel;
    nePs: TRzNumericEdit;
    RzLabel5: TRzLabel;
    neVyr: TRzNumericEdit;
    lcbVidTop: TRzDBLookupComboBox;
    RzLabel6: TRzLabel;
    RzLabel7: TRzLabel;
    RzLabel8: TRzLabel;
    neKper: TRzNumericEdit;
    neNTop: TRzNumericEdit;
    RzLabel9: TRzLabel;
    RzLabel10: TRzLabel;
    neKolTop: TRzNumericEdit;
    neTut: TRzNumericEdit;
    qryRealiz: TMSQuery;
    MQuery: TMSSQL;
    qryTop: TMSQuery;
    dsTop: TDataSource;
    RzPanel1: TRzPanel;
    dbgTop: TDBGridEh;
    RzLabel11: TRzLabel;
    neOst: TRzNumericEdit;
    RzLabel12: TRzLabel;
    neSp: TRzNumericEdit;
    BtnProv: TRzBitBtn;
    BtnFakt: TRzBitBtn;
    BtnOst: TRzBitBtn;
    qryCalc: TMSQuery;
    reHelp: TRzRichEdit;
    BtnAdd: TRzBitBtn;
    BtnDel: TRzBitBtn;
    BtnRef: TRzBitBtn;
    neTek: TRzNumericEdit;
    procedure FormShow(Sender: TObject);
    procedure nePsChange(Sender: TObject);
    procedure BtnCancelClick(Sender: TObject);
    procedure BtnOkClick(Sender: TObject);
    procedure BtnProvClick(Sender: TObject);
    procedure lcbVidTopCloseUp(Sender: TObject);
    procedure BtnFaktClick(Sender: TObject);
    procedure BtnOstClick(Sender: TObject);
    procedure BtnAddClick(Sender: TObject);
    procedure BtnDelClick(Sender: TObject);
    procedure BtnRefClick(Sender: TObject);
  private
    TipKn:integer;
    procedure VerifyVid(vid:integer);
    procedure ReCalc;
  public
    { Public declarations }
  end;

var
  FrmSpis: TFrmSpis;

implementation

uses DataModule, DataPrint, MainForm;

{$R *.dfm}

procedure TFrmSpis.FormShow(Sender: TObject);
begin
  with dm.qryVidTop do
  begin
    if Active then Close;
    try
      Open;
    except
      ShowMessage('Не удалось выбрать виды топлива...');
      exit;
    end;
  end;
  with qryRealiz do
  begin
    if Active then Close;
    try
      FilterSQL:='b.kodkot='+dm.qryKotelnkodkot.AsString+
      ' and datan ='''+FrmMain.WorkDate+'''';
      Open;
      neRot.Value:=qryRealiz['r_ot'];
      neRgv.Value:=qryRealiz['r_gv'];
      if Not VarIsNull(dm.qryCalcKotps.Value) then
      nePs.Value:=dm.qryCalcKotps.Value;
    except
      ShowMessage('Не удалось выбрать реализацию...');
      exit;
    end;
  end;
  with qryTop do
  begin
    if Active then Close;
    FilterSQL:='kodkot = '+dm.qryKotelnkodkot.AsString+' and datan = '''+
    FrmMain.WorkDate+'''';
    Open;
  end;
  reHelp.Lines.LoadFromFile(FrmMain.RPath+'Списание топлива.rtf');
end;

procedure TFrmSpis.nePsChange(Sender: TObject);
begin
  neVyr.Value:=neRot.Value+neRgv.Value+nePs.Value;
end;

procedure TFrmSpis.BtnCancelClick(Sender: TObject);
begin
  with qryCalc do
  begin
    if Active then Close;
    SQL.Clear;
    SQL.Add('delete from datatop where kodkot = :kodkot and datan = :data');
    ParamByName('kodkot').AsInteger:=dm.qryKotelnkodkot.AsInteger;
    ParamByName('data').AsDate:=StrToDate(FrmMain.WorkDate);
    if Application.MessageBox('Вы хотите удалить результаты списания ?','Предупреждение',
    mb_YesNo or mb_TaskModal or mb_IconQuestion)=idYes then Execute;
  end;
  close
end;

procedure TFrmSpis.BtnOkClick(Sender: TObject);
begin
  ReCalc;
  with MQuery do
  begin
    SQL.Clear;
    SQL.Add('UPDATE datakoteln set r_ot=:r_ot,r_gv=:r_gv,');
    SQL.Add('ps=:ps,vyr=:vyr');
    SQL.Add('where kodkot=:kod and datan=:data');
    ParamByName('r_ot').AsFloat:=qryCalc['rt'];
    ParamByName('r_gv').AsFloat:=qryCalc['rv'];
    ParamByName('ps').AsFloat:=qryCalc['p'];
    ParamByName('vyr').AsFloat:=qryCalc['v'];
    ParamByName('kod').AsInteger:=dm.qryKotelnkodkot.Value;
    ParamByName('data').AsDate:=StrToDate(FrmMain.WorkDate);
    Execute;
  end;     
  Close;
end;

procedure TFrmSpis.BtnProvClick(Sender: TObject);
begin
  {Проверка списания}
  // 1. Проверяем вид топлива
  VerifyVid(lcbVidTop.KeyValue);
  // 2. Расчитываем максимум
  neTut.Value:=RoundTo(neVyr.Value*neNTop.Value,-1);
  neKolTop.Value:=RoundTo(neTut.Value/neKper.Value,-1);
  TipKn:=4;
end;

procedure TFrmSpis.VerifyVid(vid:integer);
begin
  if VarIsNull(vid) then
    ShowMessage('Необходимо выбрать вид топлива...')
  else
  begin
    case vid of
    1:begin // природный газ
      neKper.Min:=1.0; neKper.Max:=1.15; neKper.CheckRange:=True;
      neKper.Value:=1.14;
      end;
    2:begin
      neKper.Min:=1.0; neKper.Max:=1.4; neKper.CheckRange:=True;
      neKper.Value:=1.39;
      end;
    3:begin
      neKper.Min:=0.2; neKper.Max:=0.3; neKper.CheckRange:=True;
      neKper.Value:=0.266;
      end;
    4..8:begin
      neKper.Min:=0.0; neKper.Max:=1.0; neKper.CheckRange:=True;
      neKper.Value:=0.0;
      end;
    end;
  end;

end;

procedure TFrmSpis.lcbVidTopCloseUp(Sender: TObject);
begin
  VerifyVid(lcbVidTop.KeyValue);
  neTut.Value:=0; neKolTop.Value:=0;
end;

procedure TFrmSpis.BtnFaktClick(Sender: TObject);
var
  vyr:double;
begin
  {Списание по факту}
  ReCalc;
  if VarIsNull(qryCalc['v']) then vyr:=0 else vyr:=qryCalc['v'];
  neTut.Value:=RoundTo(neKolTop.Value*neKper.Value,-1);
  neTek.Value:=RoundTo(neTut.Value/neNTop.Value,-1);
  neSp.Value:=neTek.Value+vyr;
  neOst.Value:=neVyr.Value-neSp.Value;
  if neOst.Value<0 then ShowMessage('Вы списали слишком много');
  TipKn:=1;
end;

procedure TFrmSpis.ReCalc;
begin
  with qryCalc do
  begin
    if Active then Close;
    SQL.Clear;
    SQL.Add('select sum(r_ot) as rt, sum(r_gv) as rv, sum(ps) as p, sum(v_tep) as v from datatop');
    if TipKn<>3 then
    FilterSQL:='kodkot = '+dm.qryKotelnkodkot.AsString+' and datan = '''+
    FrmMain.WorkDate+'''' else
    FilterSQL:='kodkot = '+dm.qryKotelnkodkot.AsString+' and datan = '''+
    FrmMain.WorkDate+''' and kodtop <> '+IntToStr(lcbVidTop.KeyValue);
    Open;
  end;
end;

procedure TFrmSpis.BtnOstClick(Sender: TObject);
begin
  {Списание по остатку}
  neTut.Value:=RoundTo(neOst.Value*neNTop.Value,-1);
  neKolTop.Value:=RoundTo(neTut.Value/neKper.Value,-1);
  TipKn:=2;
end;

procedure TFrmSpis.BtnAddClick(Sender: TObject);
Var
  rot,rgv,ps,vyr,prc:double;
begin
  rot:=0;rgv:=0;ps:=0;vyr:=0;
  case TipKn of
  1:begin
    prc:=neTek.Value/neVyr.Value;
    rot:=neRot.Value*prc;
    rgv:=neRgv.Value*prc;
    ps:=nePs.Value*prc;
    vyr:=neVyr.Value*prc;
    end;
  2:begin
    ReCalc;
    rot:=neRot.Value-qryCalc['rt'];
    rgv:=neRgv.Value-qryCalc['rv'];
    ps:=nePs.Value-qryCalc['p'];
    vyr:=neVyr.Value-qryCalc['v'];
    end;
  4:begin
    rot:=neRot.Value;
    rgv:=neRgv.Value;
    ps:=nePs.Value;
    vyr:=neVyr.Value;
    end;
  end;  
  {Добавить списание}
  with MQuery do
  begin
    SQL.Clear;
    SQL.Add('EXEC sp_up_top :kodkot,:kodtop,');
    SQL.Add(':r_ot,:r_gv,:ps,:v_tep,:k_per,:n_top,:kol_n,:kol_t,:datan');
    ParamByName('kodkot').AsInteger:=dm.qryKotelnkodkot.AsInteger;
    ParamByName('kodtop').AsInteger:=lcbVidtop.KeyValue;
    ParamByName('r_ot').AsFloat:=rot;
    ParamByName('r_gv').AsFloat:=rgv;
    ParamByName('ps').AsFloat:=ps;
    ParamByName('v_tep').AsFloat:=vyr;
    ParamByName('k_per').AsFloat:=neKper.Value;
    ParamByName('n_top').AsFloat:=neNTop.Value;
    ParamByName('kol_n').AsFloat:=neKolTop.Value;
    ParamByName('kol_t').AsFloat:=neTut.Value;
    ParamByName('datan').AsDate:=StrToDate(FrmMain.WorkDate);
    try
      Execute;
      qryTop.Refresh;
    except
      ShowMessage('Не удалось добавить списание...');
    end;    
  end;    
end;

procedure TFrmSpis.BtnDelClick(Sender: TObject);
begin
  with qryCalc do
  begin
    if Active then Close;
    SQL.Clear;
    SQL.Add('delete from datatop where kodkot = :kodkot and datan = :data and kodtop = :kodtop');
    ParamByName('kodkot').AsInteger:=dm.qryKotelnkodkot.AsInteger;
    ParamByName('data').AsDate:=StrToDate(FrmMain.WorkDate);
    ParamByName('kodtop').AsInteger:=qryTop['kodtop'];
    if Application.MessageBox('Вы хотите удалить текущее списание ?','Предупреждение',
    mb_YesNo or mb_TaskModal or mb_IconQuestion)=idYes then Execute;
  end;
  qryTop.Refresh;
end;

procedure TFrmSpis.BtnRefClick(Sender: TObject);
begin
  {Пересписание}
  ReCalc;
  if qryCalc['v']=neVyr.Value then
  begin
    ShowMessage('Сперва удалите какое-нибудь списание и повторите операцию...');
    exit;
  end
  else
  begin
    lcbVidTop.KeyValue:=qryTop['kodtop'];
    neKper.Value:=qryTop['k_per'];
    neNtop.Value:=qryTop['n_top'];
  end;
  TipKn:=3;
end;

end.

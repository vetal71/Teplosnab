unit KorrectNasOtForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, RzDBGrid, RzButton, RzRadChk, RzEdit, RzPanel,
  StdCtrls, Mask, RzLabel, DBCtrls, RzDBCmbo, RzRadGrp, ExtCtrls, Math,
  DBAccess, MSAccess;

type
  TFrmKorrectNasOt = class(TForm)
    RzPanel2: TRzPanel;
    RzLabel8: TRzLabel;
    RzLabel7: TRzLabel;
    rgKor: TRzGroupBox;
    RzLabel10: TRzLabel;
    RzLabel14: TRzLabel;
    neSrT: TRzNumericEdit;
    neTvn: TRzNumericEdit;
    neItog: TRzNumericEdit;
    neQot: TRzNumericEdit;
    RzPanel3: TRzPanel;
    BtnOk: TRzBitBtn;
    BtnCancel: TRzBitBtn;
    MQuery: TMSSQL;
    procedure FormShow(Sender: TObject);
    procedure neTvnChange(Sender: TObject);
    procedure BtnOkClick(Sender: TObject);
    procedure BtnCancelClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmKorrectNasOt: TFrmKorrectNasOt;

implementation

uses DataModule, MainForm;

{$R *.dfm}

procedure TFrmKorrectNasOt.FormShow(Sender: TObject);
begin
  neSrt.Value:=dm.qryCalcKotNORMATIV_OT.Value;
end;

procedure TFrmKorrectNasOt.neTvnChange(Sender: TObject);
begin
  neItog.Value:=RoundTo(neSrT.Value/18*neTvn.Value*neQot.Value,-2);
end;

procedure TFrmKorrectNasOt.BtnOkClick(Sender: TObject);
Var
  Tabname, SQLWhere:string;
begin
  if FrmMain.CurRec1 = 1 then
  begin
    tabname:= 'doma';
    SQLWhere:= 'koddom';
  end
  else
  begin
    tabname:= 'kvart';
    SQLWhere:= 'kodkv';
  end;
  with MQuery do
  begin
    SQL.Clear;
    SQL.Add('update data'+tabname+
    ' set normativ = :normativ,st=1,'+
    'gkt=:gkt where '+SQLWhere+'=:kod and datan=:data');
    ParamByName('normativ').AsFloat:=neSrT.Value/18*neTvn.Value;
    ParamByName('gkt').AsFloat:=neItog.Value;
    if FrmMain.CurRec1 = 1 then
    ParamByName('kod').AsInteger:=dm.qryRezCalcNas['koddom']
    else
    ParamByName('kod').AsInteger:=dm.qryRezCalcKvart['kodkv'];
    ParamByName('data').AsDate:=StrToDate(FrmMain.WorkDate);
    try
      Execute;
    except
      ShowMessage('Ошибка обновления данных...');
    end;
  end;
  Close;
end;

procedure TFrmKorrectNasOt.BtnCancelClick(Sender: TObject);
begin
  Close
end;

end.

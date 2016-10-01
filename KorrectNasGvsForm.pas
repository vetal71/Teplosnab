unit KorrectNasGvsForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RzDBEdit, RzButton, StdCtrls, Mask, RzEdit, RzPanel, RzLabel,
  ExtCtrls, Math, DBAccess, MSAccess;

type
  TFrmKorrectNasGvs = class(TForm)
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
    RzLabel1: TRzLabel;
    neKdg: TRzDBNumericEdit;
    RzLabel2: TRzLabel;
    neNgv: TRzDBNumericEdit;
    MQuery: TMSSQL;
    procedure FormShow(Sender: TObject);
    procedure neTvnChange(Sender: TObject);
    procedure BtnCancelClick(Sender: TObject);
    procedure BtnOkClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmKorrectNasGvs: TFrmKorrectNasGvs;

implementation

uses DataModule, MainForm;

{$R *.dfm}

procedure TFrmKorrectNasGvs.FormShow(Sender: TObject);
begin
  neSrt.Value:=dm.qryCalcKotNORMATIV_GV.Value;
  neKdg.Value:=dm.qryCalcKotKDG.Value;
  neNgv.Value:=dm.qryCalcKotN_GV.Value;
end;

procedure TFrmKorrectNasGvs.neTvnChange(Sender: TObject);
begin
  neItog.Value:=RoundTo(neSrT.Value/50*neTvn.Value*neQot.Value/1000*neKdg.Value*
  neNgv.Value,-2);
end;

procedure TFrmKorrectNasGvs.BtnCancelClick(Sender: TObject);
begin
  Close
end;

procedure TFrmKorrectNasGvs.BtnOkClick(Sender: TObject);
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
    ' set normativgv = :normativ,sv=1,'+
    'gkv=:gkt where '+SQLWhere+'=:kod and datan=:data');
    ParamByName('normativ').AsFloat:=neSrT.Value/50*neTvn.Value;
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

end.

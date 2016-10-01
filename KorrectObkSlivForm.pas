unit KorrectObkSlivForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DBAccess, MSAccess, RzButton, RzRadChk, RzEdit, StdCtrls, Mask,
  RzPanel, RzLabel, ExtCtrls, RzDBLbl, Math;

type
  TFrmKorrectObkSliv = class(TForm)
    RzPanel1: TRzPanel;
    RzLabel8: TRzLabel;
    RzLabel7: TRzLabel;
    rgKor: TRzGroupBox;
    RzLabel6: TRzLabel;
    RzLabel10: TRzLabel;
    neNormativ: TRzNumericEdit;
    neKtop: TRzNumericEdit;
    neItog: TRzNumericEdit;
    RzPanel2: TRzPanel;
    BtnOk: TRzBitBtn;
    BtnCancel: TRzBitBtn;
    MQuery: TMSSQL;
    RzDBLabel1: TRzDBLabel;
    RzLabel1: TRzLabel;
    neKStop: TRzNumericEdit;
    procedure FormShow(Sender: TObject);
    procedure neNormativChange(Sender: TObject);
    procedure BtnCancelClick(Sender: TObject);
    procedure BtnOkClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmKorrectObkSliv: TFrmKorrectObkSliv;

implementation

uses DataModule, MainForm, DB;

{$R *.dfm}

procedure TFrmKorrectObkSliv.FormShow(Sender: TObject);
begin
  neNormativ.Value:=0.153;
  if FrmMain.CurRec1 = 0 then
  begin
    with dm do
    begin
      if qryKolTop.Active then qryKolTop.Close;
      try
        qryKolTop.FilterSQL:='kodobk='+qryRezCalcObkkodobk.AsString+
        ' and datan='''+FrmMain.WorkDate+'''';
        qryKolTop.Open;
        if Not VarIsNull(qryKolTop['koltop']) then
        begin
          neKtop.Value:=qryKolTop['koltop'];
          neNormativ.Value:=qryKolTop['kolch'];
        end;
      except
        ShowMessage('Ошибка получения данных');
        exit;
      end;
      if qryRezCalcObkkodobk.Value=129 then
      begin
        if qrySumKolTop.Active then qrySumKolTop.Close;
        try
          qrySumKolTop.FilterSQL:='datan='''+FrmMain.WorkDate+'''';
          qrySumKolTop.Open;
          if Not VarIsNull(qrySumKolTop['s_top']) then
          neKtop.Value:=qrySumKolTop['s_top'];
          neKStop.Enabled:=True;
          neKtop.Enabled:=False;
        except
          ShowMessage('Ошибка получения данных');
          exit;
        end;
      end
      else
      begin
        neKStop.Enabled:=False;
        neKTop.Enabled:=True;
      end;
    end;
  end
  else
  begin
    with dm do
    begin
      if qryKolTop.Active then qryKolTop.Close;
      try
        qryKolTop.FilterSQL:='kodobk='+qryRezCalcObkOtkodobk.AsString+
        ' and datan='''+FrmMain.WorkDate+'''';
        qryKolTop.Open;
        if Not VarIsNull(qryKolTop['koltop']) then
        begin
          neKtop.Value:=qryKolTop['koltop'];
          neNormativ.Value:=qryKolTop['kolch'];
        end;
      except
        ShowMessage('Ошибка получения данных');
        exit;
      end;
      if qryRezCalcObkOtkodobk.Value=129 then
      begin
        if qrySumKolTop.Active then qrySumKolTop.Close;
        try
          qrySumKolTop.FilterSQL:='datan='''+FrmMain.WorkDate+'''';
          qrySumKolTop.Open;
          if Not VarIsNull(qrySumKolTop['s_top']) then
          neKtop.Value:=qrySumKolTop['s_top'];
          neKStop.Enabled:=True;
          neKtop.Enabled:=False;
        except
          ShowMessage('Ошибка получения данных');
          exit;
        end;
      end
      else
      begin
        neKStop.Enabled:=False;
        neKTop.Enabled:=True;
      end;
    end;
  end;
end;

procedure TFrmKorrectObkSliv.neNormativChange(Sender: TObject);
begin
  if neKStop.Enabled then
  neItog.Value:=RoundTo(neKStop.Value*neNormativ.Value,-2) else
  neItog.Value:=RoundTo(neKtop.Value*neNormativ.Value,-2);
end;

procedure TFrmKorrectObkSliv.BtnCancelClick(Sender: TObject);
begin
  FrmMain.MR:= 2;
  Close
end;

procedure TFrmKorrectObkSliv.BtnOkClick(Sender: TObject);
begin
  with MQuery do
  begin
    SQL.Clear;
    SQL.Add('EXECUTE sp_nac_sliv :kodobk,:koltop,:kolch,:gkt,:data');
    try
      if FrmMain.CurRec1 = 0 then
        ParamByName('kodobk').AsInteger:=dm.qryRezCalcObkkodobk.Value
      else
        ParamByName('kodobk').AsInteger:=dm.qryRezCalcObkOtkodobk.Value;
      if dm.qryRezCalcObkkodobk.Value = 129 then
      ParamByName('koltop').AsFloat:=neKtop.Value+neKStop.Value else
      ParamByName('koltop').AsFloat:=neKtop.Value;
      ParamByName('kolch').AsFloat:=neNormativ.Value;
      ParamByName('gkt').AsFloat:=neItog.Value;
      ParamByName('data').AsDate:=StrToDate(FrmMain.WorkDate);
      Execute;
      FrmMain.MR:= 1;
    except
      ShowMessage('Не удалось сохранить данные...');
    end;
  end;
  Close;
end;

end.

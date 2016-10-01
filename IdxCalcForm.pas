unit IdxCalcForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DBAccess, MSAccess, RzDBLbl, RzButton, StdCtrls, Mask, RzEdit,
  RzLabel, ExtCtrls, RzPanel;
  
type
  TfrmCalcIdx = class(TForm)
    pnlMain: TRzPanel;
    RzLabel1: TRzLabel;
    RzPanel2: TRzPanel;
    BtnOk: TRzBitBtn;
    BtnCancel: TRzBitBtn;
    RzDBLabel1: TRzDBLabel;
    lblTeplo: TRzLabel;
    neIdx: TRzNumericEdit;
    lblVoda: TRzLabel;
    neIdxk: TRzNumericEdit;
    UpPokPrib: TMSSQL;
    RzLabel2: TRzLabel;
    neIdxv: TRzNumericEdit;
    procedure FormShow(Sender: TObject);
    procedure BtnCancelClick(Sender: TObject);
    procedure BtnOkClick(Sender: TObject);
  private
    { Private declarations }
  public
    IsTeplo: Boolean;
  end;

var
  frmCalcIdx: TfrmCalcIdx;

implementation

uses DataModule, MainForm;

{$R *.dfm}

procedure TfrmCalcIdx.FormShow(Sender: TObject);
begin
  neIdxv.Enabled  := not IsTeplo;
  neIdxk.Enabled  := not IsTeplo;
  neIdx.Enabled   := IsTeplo;

  neIdx.Value   := DM.qryCalcIdxOrgs_symidx.Value;
  neIdxv.Value  := DM.qryCalcIdxOrgs_symidxv.Value;
  neIdxk.Value  := DM.qryCalcIdxOrgs_symidxk.Value;

end;

procedure TfrmCalcIdx.BtnCancelClick(Sender: TObject);
begin
  FrmMain.MR:=2;
end;

procedure TfrmCalcIdx.BtnOkClick(Sender: TObject);
begin
  with UpPokPrib do
  begin
    SQL.Clear;
    SQL.Add('update dataorg set symidx = :p1, symidxv = :p2, symidxk = :p3 '+
    'where kodorg = :kod and datan = :data');
    ParamByName('kod').AsInteger:= dm.qryCalcIdxOrgkodorg.Value;
    ParamByName('data').AsDate  := StrToDate(FrmMain.WorkDate);
    ParamByName('p1').AsFloat   := neIdx.Value;
    ParamByName('p2').AsFloat   := neIdxv.Value;
    ParamByName('p3').AsFloat   := neIdxk.Value;
    try
      Execute;
      FrmMain.MR:=1;
    except
      ShowMessage('Не удалось обновить начисление...');
    end;
  end;
end;

end.

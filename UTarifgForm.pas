unit UTarifgForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RzEdit, RzDBEdit, StdCtrls, Mask, RzButton, RzLabel, ExtCtrls,
  RzPanel, DB, MemDS, DBAccess, MSAccess;

type
  TFrmUTarif_g = class(TForm)
    pnlMain: TRzPanel;
    RzLabel1: TRzLabel;
    RzLabel2: TRzLabel;
    RzPanel2: TRzPanel;
    BtnOk: TRzBitBtn;
    BtnCancel: TRzBitBtn;
    edtNazv: TRzDBEdit;
    RzLabel3: TRzLabel;
    deDataTarif: TRzDateTimeEdit;
    spUpTarif: TMSStoredProc;
    neCena: TRzNumericEdit;
    procedure FormShow(Sender: TObject);
    procedure BtnCancelClick(Sender: TObject);
    procedure BtnOkClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmUTarif_g: TFrmUTarif_g;

implementation

uses DataModule, MainForm;

{$R *.dfm}

procedure TFrmUTarif_g.FormShow(Sender: TObject);
begin   
  if dm.qryTarif_g.State = dsInsert then
  begin
    Caption:='Новый тариф';
    neCena.Value:=0;
    deDataTarif.Date:=StrToDate(FrmMain.WorkDate);
    deDataTarif.Enabled:=True;
  end;
  if dm.qryTarif_g.State = dsEdit then
  begin
    FrmMain.CurRec:=dm.qryTarif_gkodtg.Value;
    Caption:='Тариф:'+dm.qryTarif_g['nazt'];
    neCena.Value:=dm.qryTarif_gCENAG.Value;
    deDataTarif.Date:=dm.qryTarif_gdatan.Value;
    deDataTarif.Enabled:=False;
  end;
end;

procedure TFrmUTarif_g.BtnCancelClick(Sender: TObject);
begin
  dm.qryTarif_g.Cancel;
  Close;
end;

procedure TFrmUTarif_g.BtnOkClick(Sender: TObject);
begin
  try
    with dm do
    begin
      if Application.MessageBox('Сохранить изменения ?',
      'Предупреждение',mb_YesNo or mb_TaskModal or mb_IconQuestion)=idYes then
      begin
        {Блок новой цены}
        if qryTarif_g.State = dsEdit then
        begin
          qryTarif_g.Post;
          with spUpTarif do
          begin
            ParamByName('kod').AsInteger:=dm.qryTarif_gkodtg.Value;
            ParamByName('cena1').AsFloat:=neCena.Value;
            ParamByName('cena2').AsFloat:=0;
            ParamByName('data').AsDate:=deDataTarif.Date;
            ParamByName('oper').AsInteger:=3;
            try
              ExecProc;
              dm.qryTarif_g.Locate('kodtg',FrmMain.CurRec,[]);
            except
              ShowMessage('Не удалось установить цену...');
            end;
          end;
        end;
        if qryTarif_g.State = dsInsert then
        begin
          qryTarif_g.Post;
          with spUpTarif do
          begin
            ParamByName('kod').AsInteger:=dm.qryTarif_gkodtg.Value;
            ParamByName('cena1').AsFloat:=neCena.Value;
            ParamByName('cena2').AsFloat:=0;
            ParamByName('data').AsDate:=deDataTarif.Date;
            ParamByName('oper').AsInteger:=31;
            try
              ExecProc;
            except
              ShowMessage('Не удалось добавить запись...');
            end;
          end;
        end;
        qryTarif_g.Refresh;
      end;
    end;
  except
    ShowMessage('Невозможно выполнить изменения. Повторите...');
  end;
  Close;
end;

end.

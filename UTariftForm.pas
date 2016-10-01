unit UTariftForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RzEdit, RzDBEdit, StdCtrls, Mask, RzButton, RzLabel, ExtCtrls,
  RzPanel, DB, MemDS, DBAccess, MSAccess;

type
  TFrmUTarif_t = class(TForm)
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
  FrmUTarif_t: TFrmUTarif_t;

implementation

uses DataModule, MainForm;

{$R *.dfm}

procedure TFrmUTarif_t.FormShow(Sender: TObject);
begin   
  if dm.qryTarif_t.State = dsInsert then
  begin
    Caption:='Новый тариф';
    neCena.Value:=0;
    deDataTarif.Date:=StrToDate(FrmMain.WorkDate);
    deDataTarif.Enabled:=True;
  end;
  if dm.qryTarif_t.State = dsEdit then
  begin
    FrmMain.CurRec:=dm.qryTarif_tkodtt.Value;
    Caption:='Тариф:'+dm.qryTarif_t['nazt'];
    neCena.Value:=dm.qryTarif_tCENA.Value;
    deDataTarif.Date:=dm.qryTarif_tdatan.Value;
    deDataTarif.Enabled:=False;
  end;
end;

procedure TFrmUTarif_t.BtnCancelClick(Sender: TObject);
begin
  dm.qryTarif_t.Cancel;
  Close;
end;

procedure TFrmUTarif_t.BtnOkClick(Sender: TObject);
begin
  try
    with dm do
    begin
      if Application.MessageBox('Сохранить изменения ?',
      'Предупреждение',mb_YesNo or mb_TaskModal or mb_IconQuestion)=idYes then
      begin
        {Блок новой цены}
        if qryTarif_t.State = dsEdit then
        begin
          qryTarif_t.Post;
          with spUpTarif do
          begin
            ParamByName('kod').AsInteger:=dm.qryTarif_tkodtt.Value;
            ParamByName('cena1').AsFloat:=neCena.Value;
            ParamByName('cena2').AsFloat:=0;
            ParamByName('data').AsDate:=deDataTarif.Date;
            ParamByName('oper').AsInteger:=1;
            try
              ExecProc;
              dm.qryTarif_t.Locate('kodtt',FrmMain.CurRec,[]);
            except
              ShowMessage('Не удалось установить цену...');
            end;
          end;
        end;
        if qryTarif_t.State = dsInsert then
        begin
          qryTarif_t.Post;
          with spUpTarif do
          begin
            ParamByName('kod').AsInteger:=dm.qryTarif_tkodtt.Value;
            ParamByName('cena1').AsFloat:=neCena.Value;
            ParamByName('cena2').AsFloat:=0;
            ParamByName('data').AsDate:=deDataTarif.Date;
            ParamByName('oper').AsInteger:=11;
            try
              ExecProc;
            except
              ShowMessage('Не удалось добавить запись...');
            end;
          end;
        end;
        qryTarif_t.Refresh;
      end;
    end;
  except
    ShowMessage('Невозможно выполнить изменения. Повторите...');
  end;
  Close;
end;

end.

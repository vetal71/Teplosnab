unit UTarifvForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RzButton, RzEdit, RzDBEdit, StdCtrls, Mask, RzLabel, ExtCtrls,
  RzPanel, DB, MemDS, DBAccess, MSAccess;

type
  TFrmUTarif_v = class(TForm)
    pnlMain: TRzPanel;
    RzLabel1: TRzLabel;
    RzLabel2: TRzLabel;
    RzLabel3: TRzLabel;
    edtNazv: TRzDBEdit;
    deDataTarif: TRzDateTimeEdit;
    RzPanel2: TRzPanel;
    BtnOk: TRzBitBtn;
    BtnCancel: TRzBitBtn;
    RzLabel4: TRzLabel;
    neCenav: TRzNumericEdit;
    neCenak: TRzNumericEdit;
    spUpTarif: TMSStoredProc;
    procedure FormShow(Sender: TObject);
    procedure BtnCancelClick(Sender: TObject);
    procedure BtnOkClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmUTarif_v: TFrmUTarif_v;

implementation

uses DataModule, MainForm;

{$R *.dfm}

procedure TFrmUTarif_v.FormShow(Sender: TObject);
begin
  if dm.qryTarif_v.State = dsInsert then
  begin
    Caption:='Новый тариф';
    neCenav.Value:=0;
    neCenak.Value:=0;
    deDataTarif.Date:=StrToDate(FrmMain.WorkDate);
    deDataTarif.Enabled:=True;
  end;
  if dm.qryTarif_v.State = dsEdit then
  begin
    FrmMain.CurRec:=dm.qryTarif_vkodtv.Value;
    Caption:='Тариф:'+dm.qryTarif_v['nazt'];
    neCenav.Value:=dm.qryTarif_vCENAV.Value;
    neCenak.Value:=dm.qryTarif_vCENAK.Value;
    deDataTarif.Date:=dm.qryTarif_tdatan.Value;
    deDataTarif.Enabled:=False;
  end;
end;

procedure TFrmUTarif_v.BtnCancelClick(Sender: TObject);
begin
  dm.qryTarif_v.Cancel;
  Close;
end;

procedure TFrmUTarif_v.BtnOkClick(Sender: TObject);
begin
  //try
    with dm do
    begin
      if Application.MessageBox('Сохранить изменения ?',
      'Предупреждение',mb_YesNo or mb_TaskModal or mb_IconQuestion)=idYes then
      begin
        {Блок новой цены}
        if qryTarif_v.State = dsEdit then
        begin
          qryTarif_v.Post;
          with spUpTarif do
          begin
            ParamByName('kod').AsInteger:=dm.qryTarif_vkodtv.Value;
            ParamByName('cena1').AsFloat:=neCenav.Value;
            ParamByName('cena2').AsFloat:=neCenak.Value;
            ParamByName('data').AsDate:=deDataTarif.Date;
            ParamByName('oper').AsInteger:=2;
            //try
              ExecProc;
              dm.qryTarif_v.Locate('kodtv',FrmMain.CurRec,[]);
            //except
            //  ShowMessage('Не удалось установить цену...');
            //end;
          end;
        end;
        if qryTarif_v.State = dsInsert then
        begin
          qryTarif_v.Post;
          with spUpTarif do
          begin
            ParamByName('kod').AsInteger:=dm.qryTarif_vkodtv.Value;
            ParamByName('cena1').AsFloat:=neCenav.Value;
            ParamByName('cena2').AsFloat:=neCenak.Value;
            ParamByName('data').AsDate:=deDataTarif.Date;
            ParamByName('oper').AsInteger:=22;
            try
              ExecProc;
            except
              ShowMessage('Не удалось добавить запись...');
            end;
          end;
        end;
        qryTarif_v.Refresh;
      end;
    end;
  //except
  //  ShowMessage('Невозможно выполнить изменения. Повторите...');
  //end;
  Close;
end;

end.

unit ChangeOrgForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RzButton, DBCtrls, RzDBCmbo, StdCtrls, RzLabel, ExtCtrls,
  RzPanel, DB, MemDS, DBAccess, MSAccess;
  
type
  TfrmChangeOrg = class(TForm)
    RzPanel1: TRzPanel;
    RzPanel2: TRzPanel;
    RzLabel11: TRzLabel;
    lcbOldOrg: TRzDBLookupComboBox;
    RzLabel1: TRzLabel;
    lcbNewOrg: TRzDBLookupComboBox;
    RzBitBtn1: TRzBitBtn;
    RzBitBtn2: TRzBitBtn;
    SpUpObekt: TMSStoredProc;
    qryOrg: TMSQuery;
    dsOrg: TDataSource;
    procedure RzBitBtn2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure RzBitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmChangeOrg: TfrmChangeOrg;

implementation

uses DataModule;

{$R *.dfm}

procedure TfrmChangeOrg.RzBitBtn2Click(Sender: TObject);
begin
  close;
end;

procedure TfrmChangeOrg.FormShow(Sender: TObject);
begin
  Caption:='Передача объекта '+dm.qryObekt['nazv'];
  if Not qryOrg.Active then qryOrg.Open;
  qryOrg.Locate('kodorg',dm.qryOrgkodorg.Value, []);
  lcbOldOrg.KeyValue:=qryOrg['kodorg'];
  lcbNewOrg.KeyValue:=-1;
end;

procedure TfrmChangeOrg.RzBitBtn1Click(Sender: TObject);
Var
   s:string;
   p:PChar;
begin
  with SpUpObekt do
  begin
    Params.ParamByName('kodorg').AsInteger:=lcbNewOrg.KeyValue;
    Params.ParamByName('kodobk').AsInteger:=dm.qryObektkodobk.Value;
    p:=StrAlloc(250*SizeOf(Char));
    s:='Вы действительно хотите передать '+dm.qryObekt['nazv']+' с баланса '+#10#13+
       lcbOldOrg.Text+' на баланс '+lcbNewOrg.Text;
    StrPCopy(p,s);
    if Application.MessageBox(p,
    'Предупреждение',mb_YesNo or mb_TaskModal or mb_IconQuestion)=idYes then
    try
      ExecProc;
      dm.qryObekt.Refresh;
    except
      ShowMessage('Не удалось выполнить передачу...');
    end;
  end;
  Close;      
end;

end.

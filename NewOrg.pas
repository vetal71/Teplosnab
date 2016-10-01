unit OrganizationFrame;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, ExtCtrls, RzPanel, StdCtrls, RzLabel, Grids, DBGridEh, RzButton,
  ImgList,UOrganizationForm, RzCmboBx, Menus, PoiskForm, DB, frxClass,
  frxDBSet, UObektFrom, DBCtrls, RzDBNav, GridsEh, DBGridEhGrouping;

type
  TFmeOrganization = class(TFrame)
    RzLabel9: TRzLabel;
    RzPanel1: TRzPanel;
    RzPanel2: TRzPanel;
    Splitter1: TSplitter;
    RzPanel3: TRzPanel;
    ImageList1: TImageList;
    dbgOrg: TDBGridEh;
    dbgObekt: TDBGridEh;
    tbrOrg: TRzToolbar;
    tbrObekt: TRzToolbar;
    BtnInsertOrg: TRzToolButton;
    BtnEditOrg: TRzToolButton;
    BtnDeleteOrg: TRzToolButton;
    BtnInsertObk: TRzToolButton;
    BtnEditObk: TRzToolButton;
    BtnDeleteObk: TRzToolButton;
    RzSpacer1: TRzSpacer;
    RzSpacer2: TRzSpacer;
    BtnFilterOrg: TRzToolButton;
    pmPrint: TPopupMenu;
    N1: TMenuItem;
    RzSpacer3: TRzSpacer;
    cboTipOrg: TRzComboBox;
    RzSpacer4: TRzSpacer;
    BtnDelFilterOrg: TRzToolButton;
    RzSpacer5: TRzSpacer;
    BtnFind: TRzToolButton;
    RzSpacer6: TRzSpacer;
    BtnPrint: TRzToolButton;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    OrgSet: TfrxDBDataset;
    ObektSet: TfrxDBDataset;
    Report: TfrxReport;
    RzDBNavigator1: TRzDBNavigator;
    procedure BtnInsertOrgClick(Sender: TObject);
    procedure BtnEditOrgClick(Sender: TObject);
    procedure BtnDeleteOrgClick(Sender: TObject);
    procedure ActivateSumList;
    procedure dbgOrgCellClick(Column: TColumnEh);
    procedure dbgOrgKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BtnFilterOrgClick(Sender: TObject);
    procedure cboTipOrgChange(Sender: TObject);
    procedure BtnDelFilterOrgClick(Sender: TObject);
    procedure BtnFindClick(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure BtnInsertObkClick(Sender: TObject);
    procedure BtnEditObkClick(Sender: TObject);
    procedure BtnDeleteObkClick(Sender: TObject);
    procedure RzDBNavigator1Click(Sender: TObject; Button: TRzNavigatorButton);
  private
    F:TFrmUOrganization;
    FO:TFrmUObekt;
    FP:TFrmPoisk;
    RPath:String;
  public
    procedure Init;
  end;

implementation

uses DataModule, MainForm, ADODB;

{$R *.dfm}

{ TFmeOrganization }

procedure TFmeOrganization.Init;
begin
  RPath:=ExtractFilePath(Application.ExeName)+'Template\';
  with dm do begin
    if Not qryOrg.Active then
    try
      qryOrg.Open;
    except
      ShowMessage('Не удалось открыть таблицу "Организации"');
    end;
    if Not qryObekt.Active then
    try
      qryObekt.Open;
      ActivateSumList;
    except
      ShowMessage('Не удалось открыть таблицу "Объекты"');
    end;
  end;
end;        

procedure TFmeOrganization.BtnInsertOrgClick(Sender: TObject);
begin
  // Добавляем организацию
  dm.qryOrg.Insert;
  F := TFrmUOrganization.Create( Application );
  try
    F.ShowModal;
  finally
    F.Free;
  end;
end;

procedure TFmeOrganization.BtnEditOrgClick(Sender: TObject);
begin
  // Редактируем организацию
  dm.qryOrg.Edit;
  F := TFrmUOrganization.Create( Application );
  try
    F.ShowModal;
  finally
    F.Free;
  end;
end;

procedure TFmeOrganization.BtnDeleteOrgClick(Sender: TObject);
Var
  s:string;
  p:PChar;
begin
  p:=StrAlloc(250*SizeOf(Char));
  s:='Вы действительно хотите удалить '+dm.qryOrg['nazv']+' ?'+#10#13+
     'Вместе с организацией будут удалены все объекты и начисления...';
  StrPCopy(p,s);
  if Application.MessageBox(p,
   'Предупреждение',mb_YesNo or mb_TaskModal or mb_IconQuestion)=idYes then
  begin
    with dm.Del_Object do
    begin
      try
        Params.ParamValues['@tab_name']:='org';
        Params.ParamValues['@col_name']:='kodorg';
        Params.ParamValues['@init_vol']:=dm.qryOrg['kodorg'];
        ExecProc;
        dm.qryOrg.Close;
        dm.qryOrg.Open;
        ActivateSumList;
      except
        ShowMessage('Не удалось удалить. Повторите...');
      end;
    end;
  end;
end;

procedure TFmeOrganization.ActivateSumList;
begin
  with dbgObekt do
  begin
    SumList.Active:=False;
    SumList.Active:=True;
  end;
end;

procedure TFmeOrganization.dbgOrgCellClick(Column: TColumnEh);
begin
  ActivateSumList;
end;

procedure TFmeOrganization.dbgOrgKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  ActivateSumList;
end;

procedure TFmeOrganization.BtnFilterOrgClick(Sender: TObject);
begin
  cboTipOrg.Enabled:=True;
end;

procedure TFmeOrganization.cboTipOrgChange(Sender: TObject);
begin
  with dm.qryOrg do
  begin
    Filtered:=False;
    Filter:='tiporg='+IntToStr(cboTipOrg.ItemIndex);
    Filtered:=True;
  end;
end;

procedure TFmeOrganization.BtnDelFilterOrgClick(Sender: TObject);
begin
  with dm.qryOrg do
  begin
    Filtered:=False;
    Filter:='';
    Filtered:=True;
  end;
  cboTipOrg.ItemIndex:=-1;
  cboTipOrg.Enabled:=False;
end;

procedure TFmeOrganization.BtnFindClick(Sender: TObject);
begin
  {Поиск по параметрам}
  FP := TFrmPoisk.Create( Application );
  try
    FP.ShowModal;
    case FP.rgPoisk.ItemIndex of
    0:if Not dm.qryOrg.Locate('kodorg',Trim(FP.edtPoisk.Text),[]) then
      ShowMessage('Организация с кодом '+Trim(FP.edtPoisk.Text)+
      ' не найдена...');
    1:if Not dm.qryOrg.Locate('nazv',Trim(FP.edtPoisk.Text),[loCaseInsensitive, loPartialKey]) then
      ShowMessage('Организация с названием '+Trim(FP.edtPoisk.Text)+
      ' не найдена...');
    end;
  finally
    FP.Free;
  end;
  dbgOrg.SetFocus;
  ActivateSumList;
end;

procedure TFmeOrganization.N1Click(Sender: TObject);
begin
  Report.LoadFromFile(RPath+'Организации.fr3');
  Report.ShowReport;
end;

procedure TFmeOrganization.N2Click(Sender: TObject);
begin
  Report.LoadFromFile(RPath+'Объекты.fr3');
  Report.ShowReport;
end;

procedure TFmeOrganization.BtnInsertObkClick(Sender: TObject);
begin
  // Добавляем объект
  FrmMain.DBState:=1;
  FO := TFrmUObekt.Create( Application );
  try
    FO.ShowModal;
  finally
    FO.Free;
  end;
end;

procedure TFmeOrganization.BtnEditObkClick(Sender: TObject);
begin
  // Редактируем объект
  FrmMain.DBState:=2;
  FO := TFrmUObekt.Create( Application );
  try
    FO.ShowModal;
  finally
    FO.Free;
  end;
end;

procedure TFmeOrganization.BtnDeleteObkClick(Sender: TObject);
Var
  s:string;
  p:PChar;
begin
  p:=StrAlloc(250*SizeOf(Char));
  s:='Вы действительно хотите удалить '+dm.qryObekt['nazv']+' ?'+#10#13+
     'Вместе с объектом будут удалены все начисления...';
  StrPCopy(p,s);
  if Application.MessageBox(p,
   'Предупреждение',mb_YesNo or mb_TaskModal or mb_IconQuestion)=idYes then
  begin
    with dm.Del_Object do
    begin
      try
        Params.ParamValues['@tab_name']:='obekt';
        Params.ParamValues['@col_name']:='kodobk';
        Params.ParamValues['@init_vol']:=dm.qryObekt['kodobk'];
        ExecProc;
        dm.qryObekt.Close;
        dm.qryObekt.Open;
        ActivateSumList;
      except
        ShowMessage('Не удалось удалить. Повторите...');
      end;
    end;
  end;
end;

procedure TFmeOrganization.RzDBNavigator1Click(Sender: TObject;
  Button: TRzNavigatorButton);
begin
  if (Button in [nbInsert,nbEdit]) then
  begin
    F := TFrmUOrganization.Create( Application );
    try
      F.ShowModal;
    finally
      F.Free;
    end;
  end;  
end;

end.

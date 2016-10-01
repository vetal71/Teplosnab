unit UsersFrame;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, TB2Item, TBX, TB2Dock, TB2Toolbar, ExtCtrls, RzPanel, StdCtrls,
  RzLabel, DB, DBAccess, MSAccess, MemDS, Grids, DBGridEh, UpUsersForm,
  RzLstBox, RzChkLst, GridsEh, DBGridEhGrouping;

type
  TFmeUsers = class(TFrame)
    RzLabel9: TRzLabel;
    RzPanel1: TRzPanel;
    TBXDock1: TTBXDock;
    TBXToolbar2: TTBXToolbar;
    Filter: TTBXItem;
    DelFilter: TTBXItem;
    TBXItem1: TTBXItem;
    TBXItem2: TTBXItem;
    MQuery: TMSSQL;
    RzPanel2: TRzPanel;
    dbgError: TDBGridEh;
    RzPanel3: TRzPanel;
    chkListRoleAll: TRzCheckList;
    RzPanel4: TRzPanel;
    chkListRole: TRzCheckList;
    TBXItem3: TTBXItem;
    TBXSeparatorItem1: TTBXSeparatorItem;
    TBXSeparatorItem2: TTBXSeparatorItem;
    procedure FilterClick(Sender: TObject);
    procedure TBXItem2Click(Sender: TObject);
    procedure DelFilterClick(Sender: TObject);
    procedure TBXItem1Click(Sender: TObject);
    procedure dbgErrorCellClick(Column: TColumnEh);
    procedure dbgErrorKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure TBXItem3Click(Sender: TObject);
  private
    FU:TFrmUpUsers;
  public
    procedure Init;
    procedure GetRole(uid:Integer; List: TStrings);
    procedure CheckAll(List:TRzCheckList);
  end;

implementation

uses DataModule, MainForm;

{$R *.dfm}

{ TFmeUsers }

procedure TFmeUsers.Init;
begin
  with dm.qryUsers do
  begin
    if Active then Close;
    try
      Open;
      GetRole(dm.qryUsers['uid'], chkListRole.Items);
      CheckAll(chkListRole);
      GetRole(-1, chkListRoleAll.Items);
    except
      ShowMessage('Извините, не удалось получить информацию о пользователях');
    end;
  end;
end;

procedure TFmeUsers.FilterClick(Sender: TObject);
begin
  FU:=TFrmUpUsers.Create(Application);
  try
    FrmMain.CurRec:=0;
    FU.ShowModal;
    if FrmMain.CurRec1 = 1 then
    begin
      with MQuery do
      begin
        SQL.Clear;
        SQL.Add('EXEC sp_addlogin :login, :pass, :db');
        ParamByName('login').AsString:=FU.edtUsers.Text;
        ParamByName('pass').AsString:=FU.edtPassword.Text;
        ParamByName('db').AsString:='Teplosnab';
        Execute;
        SQL.Clear;
        SQL.Add('EXEC sp_grantdbaccess :login');
        ParamByName('login').AsString:=FU.edtUsers.Text;
        Execute;
        dm.qryUsers.Refresh;
      end;
    end;
  finally
    FU.Free
  end;
end;

procedure TFmeUsers.TBXItem2Click(Sender: TObject);
begin
  FU:=TFrmUpUsers.Create(Application);
  try
    FrmMain.CurRec:=1;
    FU.ShowModal;
    if FrmMain.CurRec1 = 1 then
    begin
      with MQuery do
      begin
        SQL.Clear;
        SQL.Add('EXEC sp_password  :pass, :newpass, :login');
        ParamByName('login').AsString:=FU.edtUsers.Text;
        ParamByName('pass').AsString:=FU.edtPassword.Text;
        ParamByName('newpass').AsString:=FU.edtConfirm.Text;
        Execute;
      end;
    end;
  finally
    FU.Free
  end;
end;

procedure TFmeUsers.DelFilterClick(Sender: TObject);
begin
  if Application.MessageBox(
  PChar('Вы хотите удалить пользователя '+dm.qryUsers.FieldByName('name').AsString+'?'),
  'Предупреждение',mb_YesNo or mb_TaskModal or mb_IconQuestion)=idYes  then
  begin
    with MQuery do
    begin
      SQL.Clear;
      SQL.Add('EXEC sp_dropuser :login');
      ParamByName('login').AsString:=dm.qryUsers.FieldByName('name').AsString;
      Execute;
      SQL.Clear;
      SQL.Add('EXEC sp_droplogin :login');
      ParamByName('login').AsString:=dm.qryUsers.FieldByName('name').AsString;
      Execute;
      dm.qryUsers.Refresh;
    end;
  end;
end;

procedure TFmeUsers.TBXItem1Click(Sender: TObject);
begin
  {Выход}
  FrmMain.pgcWork.ActivePage:=FrmMain.TabWelcome;
end;

procedure TFmeUsers.GetRole(uid: Integer; List: TStrings);
begin
  {Роли}
  List.Clear;
  with dm.qryRole do
  begin
    if Active then Close;
    try
      if uid <> -1 then
      FilterSQL:='u.uid='+IntToStr(uid);
      Open;
      while Not Eof do
      begin
        List.Add(dm.qryRole.FieldByName('DbRole').AsString);
        Next;
      end;
    except
      ShowMessage('Нет доступа к данным...');
    end;
  end;
end;

procedure TFmeUsers.CheckAll(List: TRzCheckList);
begin
  with List do
    List.CheckAll;
end;

procedure TFmeUsers.dbgErrorCellClick(Column: TColumnEh);
begin
  GetRole(dm.qryUsers['uid'], chkListRole.Items);
  CheckAll(chkListRole);
end;

procedure TFmeUsers.dbgErrorKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  GetRole(dm.qryUsers['uid'], chkListRole.Items);
  CheckAll(chkListRole);
end;

procedure TFmeUsers.TBXItem3Click(Sender: TObject);
Var i:integer;
begin
  with chkListRoleAll do
  begin
    for i:=0 to Count-1 do
    begin
      if ItemChecked[i] = True then
      begin
        with MQuery do
        begin
          SQL.clear;
          SQL.Add('EXEC sp_addrolemember :role,:login');
          ParamByName('role').AsString:=ItemCaption(i);
          ParamByName('login').AsString:=dm.qryUsers['name'];
          Execute;
        end;
      end;
    end;      
  end;
  Init;
end;

end.

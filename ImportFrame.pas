unit ImportFrame;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, StdCtrls, RzCmboBx, DB, DBTables, RzButton, RzLabel, ExtCtrls,
  RzPanel, Registry, RzLstBox, RzChkLst, Mask, RzEdit, RzRadGrp, MemDS,
  DBAccess, MSAccess, RzPrgres, RzDBProg, PDJ_XPCS, PDJ_XPPB, ComCtrls,
  RzShellDialogs, RzBtnEdt, SaDb, ImgList, RzRadChk;

type
  TFmeImport = class(TFrame)
    pnlMain: TRzPanel;
    RzLabel9: TRzLabel;
    pnlBtn: TRzPanel;
    BtnOk: TRzBitBtn;
    BtnCancel: TRzBitBtn;
    dbSource: TDatabase;
    tblSource: TTable;
    tblDest: TMSTable;
    qryBatch: TMSQuery;
    RzPanel1: TRzPanel;
    BtnPodkl: TRzBitBtn;
    RzPanel2: TRzPanel;
    RzLabel1: TRzLabel;
    lstTables: TRzCheckList;
    lstField: TRzListBox;
    RzPanel3: TRzPanel;
    dsSource: TDataSource;
    dbProgress: TProgressBar;
    qryCount: TQuery;
    RzLabel2: TRzLabel;
    cboSorce: TRzComboBox;
    RzLabel3: TRzLabel;
    edtUser: TRzEdit;
    RzLabel4: TRzLabel;
    edtPass: TRzEdit;
    edtFileName: TRzButtonEdit;
    DlgOpen: TRzOpenDialog;
    RzLabel5: TRzLabel;
    dbSource1: TSaDb;
    rgVariant: TRzRadioGroup;
    tblTable: TSaDs;
    DataSource1: TDataSource;
    tblColumn: TSaDs;
    DataSource2: TDataSource;
    tblSaDbSource: TSaDs;
    DataSource3: TDataSource;
    SaQuery: TSaDs;
    BtnSelectAll: TRzBitBtn;
    ImageList1: TImageList;
    BtnDeSelectAll: TRzBitBtn;
    chkIdent: TRzCheckBox;
    procedure cboSorceChange(Sender: TObject);
    procedure BtnPodklClick(Sender: TObject);
    procedure BtnOkClick(Sender: TObject);
    procedure BtnCancelClick(Sender: TObject);
    procedure edtFileNameButtonClick(Sender: TObject);
    procedure BtnSelectAllClick(Sender: TObject);
    procedure BtnDeSelectAllClick(Sender: TObject);
    procedure rgVariantClick(Sender: TObject);
  private
    procedure GetDataSourceNames(System: Boolean);
    function VerifyChecked:Boolean;
    function SQLGenName(tblName:string):string;
    function SQLGenDelete(tblName:string):string;
    procedure GetTableNameSaDb(List:TStrings);
    procedure GetFieldNameSaDb(const TableName:String;List:TStrings);
  public
    procedure Init;
  end;

implementation

uses DataModule, MainForm, SaDbBase;

{$R *.dfm}

{ TFmeImport }

procedure TFmeImport.GetDataSourceNames(System: Boolean);
var
  reg: TRegistry;
begin
  cboSorce.Items.Clear;
  reg := TRegistry.Create;
  try
    if System then
      reg.RootKey := HKEY_LOCAL_MACHINE
    else
      reg.RootKey := HKEY_CURRENT_USER;

    if reg.OpenKey('\Software\ODBC\ODBC.INI\ODBC Data Sources', False) then
    begin
      reg.GetValueNames(cboSorce.Items);
    end;
  finally  
    reg.CloseKey;
    FreeAndNil(reg);
  end;  
end;

procedure TFmeImport.Init;
begin
  if FrmMain.User = 'admin' then
  begin
    GetDataSourceNames(False);
    with lstTables do
      Height:=Height+(pnlBtn.Top-440);
    with lstField do
      Height:=lstTables.Height;
  end
  else
  begin
    FrmMain.Chars.Speak('У Вас отсутствуют права на выполнение данной операции...','');
    FrmMain.pgcWork.ActivePage:=FrmMain.TabWelcome;
  end;  
end;

procedure TFmeImport.cboSorceChange(Sender: TObject);
begin
  with dbSource do
  begin
    AliasName:=cboSorce.Text;
    DatabaseName:=cboSorce.Text;
    Params.Add('username');
    Params.Values['username']:=edtUser.Text;
    Params.Add('password');
    Params.Values['password']:=edtPass.Text;
    LoginPrompt:=False;
  end;      
end;

procedure TFmeImport.BtnPodklClick(Sender: TObject);
begin
  case rgVariant.ItemIndex of
  0:// через BDE
  begin
    with dbSource do
    begin
      try
        Connected:=True;
        // Заполняем List
        GetTableNames(lstTables.Items);
      except
        FrmMain.Chars.Speak('Не удалось подключиться к источнику данных '+cboSorce.Text,'');
      end;
    end;
  end;
  1:// через SaVCL
  begin
    with dbSource1 do
    begin
      with ConnectParams do
      begin
        DatabaseFile:=edtFileName.Text;
        DatabaseName:='ttt';
        LoginUid:=edtUser.Text;
        LoginPwd:=edtPass.Text;
        ServerName:='ttt';
      end;
      try
        Active:=True;
        GetTableNameSAdb(lstTables.Items);
      except
        FrmMain.Chars.Speak('Не удалось подключиться к источнику данных '+edtFileName.Text,'');
      end;
    end;  
  end;
  end;
end;

procedure TFmeImport.BtnOkClick(Sender: TObject);
Var
  i,j,CntRec:integer;
  str:string;
  Imp:Boolean;
begin
  Imp:=False;
  if Not VerifyChecked then
    ShowMessage('Не выбраны исходные таблицы')
  else
  begin
    {Импортируем данные}
    for i:=0 to lstTables.Items.Count-1 do
    begin
      if lstTables.ItemChecked[i] then
      begin
        str:='Выбрана таблица '+lstTables.ItemCaption(i)+'. Импортировать данные ?';
        if Application.MessageBox(PChar(str),'Импорт',
        mb_YesNo or mb_TaskModal or mb_IconQuestion)=idYes then
        begin
          lstField.Items.Clear;
          if rgVariant.ItemIndex = 0 then
          begin
            dbSource.GetFieldNames(lstTables.ItemCaption(i),lstField.Items);
            {Выбираем записи исходной таблицы}
            with tblSource do
            begin
              DatabaseName:=dbSource.DatabaseName;
              TableName:=lstTables.ItemCaption(i);
              try
                Open;
                dbProgress.Position:=0;
                Imp:=True;
              except
                ShowMessage('Не удалось получить данные из таблицы '+
                lstTables.ItemCaption(i));
              end;
            end;
            with qryCount do
            begin
              DatabaseName:=dbSource.DatabaseName;
              SQL.Clear;
              SQL.Add('select count(*) as cnt from '+lstTables.ItemCaption(i));
              try
                Open;
                dbProgress.Max:=qryCount['cnt'];
              except
                dbProgress.Max:=0;
              end;
            end;
          end
          else
          begin
            GetFieldNameSaDb(lstTables.ItemCaption(i),lstField.Items);
            {Выбираем записи исходной таблицы}
            with tblSaDbSource do
            begin
              TblNames:=lstTables.ItemCaption(i);
              try
                Open;
                dbProgress.Position:=0;
                Imp:=True;
              except
                ShowMessage('Не удалось получить данные из таблицы '+
                lstTables.ItemCaption(i));
              end;
            end;
            with SaQuery do
            begin
              QuerySql:='select count(*) as cnt from '+lstTables.ItemCaption(i);
              try
                Open;
                dbProgress.Max:=SaQuery['cnt'];
              except
                dbProgress.Max:=0;
              end;
            end;
          end;
          if Imp then
          begin
            with qryBatch do
            begin
              SQL.Clear;
              SQL.Add(SQLGenDelete(lstTables.ItemCaption(i)));
              try
                Execute;
              except
                ShowMessage('Не удалось очистить таблицу '+lstTables.ItemCaption(i));
              end;
            end;
            if chkIdent.Checked then
            begin
            with qryBatch do
            begin
              SQL.Clear;
              SQL.Add('SET IDENTITY_INSERT '+SQLGenName(lstTables.ItemCaption(i))+' ON ');
              try
                Execute;
              except
                ShowMessage('Не удалось установить свойство');
              end;
            end;
            end;
            with tblDest do
            begin
              TableName:=SQLGenName(lstTables.ItemCaption(i));
              Open;
              if rgVariant.ItemIndex = 0 then
              begin
                tblSource.First;
                CntRec:=1;
                while Not tblSource.Eof do
                begin
                  dbProgress.Position:=CntRec;
                  Insert;
                  for j:=0 to lstField.Items.Count-1 do
                  begin
                    tblDest.FieldByName(lstField.ItemCaption(j)).Value:=
                    tblSource.FieldByName(lstField.ItemCaption(j)).Value;
                  end;
                  try
                    Post;
                  except
                    ShowMessage('Не удалось перенести данные по '+lstField.ItemCaption(0));
                  end;
                  tblSource.Next;
                  Inc(CntRec);
                end;
              end
              else
              begin
                tblSaDbSource.First;
                CntRec:=1;
                while Not tblSaDbSource.Eof do
                begin
                  dbProgress.Position:=CntRec;
                  Insert;
                  for j:=0 to lstField.Items.Count-1 do
                  begin
                    tblDest.FieldByName(lstField.ItemCaption(j)).Value:=
                    tblSaDbSource.FieldByName(lstField.ItemCaption(j)).Value;
                  end;
                  try
                    Post;
                  except
                    ShowMessage('Не удалось перенести данные по '+lstTables.ItemCaption(i));
                  end;
                  tblSaDbSource.Next;
                  Inc(CntRec);
                end;
              end;
              dbProgress.Position:=0;
              FrmMain.Chars.Speak('Импорт данных таблицы '+lstTables.ItemCaption(i)+
              ' завершен...','');
              if chkIdent.Checked then
              begin
              with qryBatch do
              begin
                SQL.Clear;
                SQL.Add('SET IDENTITY_INSERT '+SQLGenName(lstTables.ItemCaption(i))+' OFF ');
                try
                  Execute;
                except
                  ShowMessage('Не удалось установить свойство');
                end;
              end;
              end;
              lstTables.ItemChecked[i]:=False;
            end;  
          end;
        end;
      end;
    end;
  end;
end;

function TFmeImport.VerifyChecked:Boolean;
Var
  i:integer;
begin
  result:=False;
  for i:=0 to lstTables.Items.Count-1 do
    if lstTables.ItemChecked[i] then
      result:=True;
end;

procedure TFmeImport.BtnCancelClick(Sender: TObject);
begin
  dbSource.Connected:=False;
  dbSource1.Active:=False;
  FrmMain.pgcWork.ActivePage:=FrmMain.TabWelcome;
end;

function TFmeImport.SQLGenName(tblName:string): string;
begin
  if rgVariant.ItemIndex = 0 then
  result:=Copy(tblName,Length(Trim(edtUser.Text))+2,
  Length(Trim(tblName))-Length(Trim(edtUser.Text))-1)
  else result:=tblName;
end;

function TFmeImport.SQLGenDelete(tblName: string): string;
begin
  if rgVariant.ItemIndex = 0 then
    result:='DELETE FROM '+Copy(tblName,Length(Trim(edtUser.Text))+2,
    Length(Trim(tblName))-Length(Trim(edtUser.Text))-1)
  else
    result:='DELETE FROM '+tblName;
end;

procedure TFmeImport.edtFileNameButtonClick(Sender: TObject);
begin
  if DlgOpen.Execute then
  begin
    EdtFileName.Text := DlgOpen.FileName;
  end;
end;

procedure TFmeImport.GetTableNameSaDb(List: TStrings);
begin
  with tblTable do
  begin
    Open;
    First;
    List.Clear;
    while Not Eof do
    begin
      List.Add(tblTable['table_name']);
      Next;
    end;
  end;
end;

procedure TFmeImport.GetFieldNameSaDb(const TableName: String;
  List: TStrings);
begin
  with tblColumn do
  begin
    tblWhere:='table_id in '+
    '(select table_id from systable where table_name='''+TableName+''')';
    Open;
    First;
    while Not Eof do
    begin
      List.Add(tblColumn['column_name']);
      Next;
    end;
  end;
end;

procedure TFmeImport.BtnSelectAllClick(Sender: TObject);
Var i:integer;
begin
  for i:=0 to lstTables.Items.Count-1 do
    lstTables.ItemChecked[i]:=True;
end;

procedure TFmeImport.BtnDeSelectAllClick(Sender: TObject);
Var i:integer;
begin
  for i:=0 to lstTables.Items.Count-1 do
    lstTables.ItemChecked[i]:=False;
end;

procedure TFmeImport.rgVariantClick(Sender: TObject);
begin
  if rgVariant.ItemIndex = 0 then
    edtFileName.Enabled:=False
  else
    cboSorce.Enabled:=False;  
end;

end.

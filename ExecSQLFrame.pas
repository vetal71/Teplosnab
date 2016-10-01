unit ExecSQLFrame;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, RzStatus, RzPanel, ExtCtrls, StdCtrls, RzButton, ImgList,
  DBAccess, MSAccess, RzLabel, DB, MemDS, Grids, DBGridEh, RzTabs, Mask,
  RzEdit, GridsEh, DBGridEhGrouping;
  
type
  TFmeExecSQL = class(TFrame)
    lblCaption: TRzLabel;
    MySQL: TMSSQL;
    RzToolbar1: TRzToolbar;
    ImageList1: TImageList;
    BtnExecute: TRzToolButton;
    RzPanel1: TRzPanel;
    meSQL: TMemo;
    Splitter1: TSplitter;
    RzPanel2: TRzPanel;
    RzStatusBar1: TRzStatusBar;
    Status: TRzStatusPane;
    RzPageControl1: TRzPageControl;
    TabSheet1: TRzTabSheet;
    meResult: TMemo;
    TabSheet2: TRzTabSheet;
    DBGridEh1: TDBGridEh;
    MyQuery: TMSQuery;
    MySource: TDataSource;
    dlgOpenFile: TOpenDialog;
    RzSpacer1: TRzSpacer;
    BtnOpenFile: TRzToolButton;
    BtnCheck: TRzToolButton;
    RzSpacer2: TRzSpacer;
    BtnClear: TRzToolButton;
    RzSpacer3: TRzSpacer;
    RzToolButton1: TRzToolButton;
    TabSheet3: TRzTabSheet;
    MD: TMSMetadata;
    dsMetaData: TDataSource;
    DBGridEh2: TDBGridEh;
    edtName: TRzEdit;
    procedure BtnExecuteClick(Sender: TObject);
    procedure meSQLExit(Sender: TObject);
    procedure MySQLAfterExecute(Sender: TObject; Result: Boolean);
    procedure BtnOpenFileClick(Sender: TObject);
    procedure BtnCheckClick(Sender: TObject);
    procedure BtnClearClick(Sender: TObject);
    procedure RzToolButton1Click(Sender: TObject);
    procedure edtNameChange(Sender: TObject);
  private
    { Private declarations }
  public
    procedure Init;
  end;

implementation

uses DataModule, MainForm;

{$R *.dfm}

{ TFrame1 }

procedure TFmeExecSQL.Init;
begin
  //meSQL.Clear;
  RzPageControl1.ActivePage:=TabSheet1;
end;

procedure TFmeExecSQL.BtnExecuteClick(Sender: TObject);
begin
  MySQL.SQL := meSQL.Lines;
  Status.Caption := 'Выполнение...';
  MySQL.Execute;
  MyQuery.SQL := meSQL.Lines;
  try
    MyQuery.Open;
  except

  end;  
end;

procedure TFmeExecSQL.meSQLExit(Sender: TObject);
begin
  MySQL.SQL := meSQL.Lines;
end;

procedure TFmeExecSQL.MySQLAfterExecute(Sender: TObject; Result: Boolean);
var
  i:integer;
begin
  if Result then begin
    Status.Caption := 'Успешно' + '  (' + IntToStr(MySQL.RowsAffected) +
      ' строк обработано)';
    meResult.Lines.Clear;
    for i := 0 to MySQL.Params.Count-1 do begin
      meResult.Lines.Add(MySQL.Params[i].Name + ' = ' +
       MySQL.Params[i].AsString);
    end;
  end
  else
    Status.Caption := 'Ошибка';
  MessageBeep(MB_OK);
end;

procedure TFmeExecSQL.BtnOpenFileClick(Sender: TObject);
begin
  dlgOpenFile.Execute;
  meSQL.Lines.LoadFromFile(dlgOpenFile.FileName);
end;

procedure TFmeExecSQL.BtnCheckClick(Sender: TObject);
Var
 i:integer;
begin
  for i:=0 to meSQl.Lines.Count-1 do
    if CompareText('Go',meSQl.Lines.Strings[i])=0 then
      meSQl.Lines.Strings[i]:='  ';
end;

procedure TFmeExecSQL.BtnClearClick(Sender: TObject);
begin
  meSQl.Clear;
end;

procedure TFmeExecSQL.RzToolButton1Click(Sender: TObject);
begin
  FrmMain.pgcWork.ActivePage:=FrmMain.TabWelcome;
end;

procedure TFmeExecSQL.edtNameChange(Sender: TObject);
begin
  MD.TableName:=edtName.Text;
  MD.Active:=True;
end;

end.

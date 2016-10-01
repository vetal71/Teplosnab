unit CalcOrgIdxFrame;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, StdCtrls, RzLabel, RzTabs, Grids, DBGridEh, ExtCtrls, RzPanel,
  TB2Item, TBX, TB2Dock, TB2Toolbar, TBXStatusBars, RzCmboBx, Str_fun, DB,
  LookObektForm, EditNacOrgForm, EditNacOrgVkForm, DBAccess, MSAccess,
  EditNacOrgGForm, PerCalcGForm, ShellAPI,
  PerCalcOtForm, PerCalcVkForm, KorrectObkOtForm, KorrectObkSlivForm,
  KorrectObkGvs, CalcBanForm, CalcBolForm, ChangePeriodForm, GridsEh,
  DBGridEhGrouping, UObektFrom;
  
type
  TFmeCalcIdxOrg = class(TFrame)
    lblCaption: TRzLabel;
    TBXDock1: TTBXDock;
    RzPanel1: TRzPanel;
    TBXToolbar2: TTBXToolbar;
    Filter: TTBXItem;
    TBXSeparatorItem6: TTBXSeparatorItem;
    TBXSeparatorItem4: TTBXSeparatorItem;
    DelFilter: TTBXItem;
    TBControlItem1: TTBControlItem;
    cboTipOrg: TRzComboBox;
    MQuery: TMSSQL;
    TBXItem1: TTBXItem;
    pgcMain: TRzPageControl;
    TabOt: TRzTabSheet;
    TabVk: TRzTabSheet;
    dbgOrg: TDBGridEh;
    DBGridEh1: TDBGridEh;
    IdxOrg: TTBXItem;
    TBXSeparatorItem1: TTBXSeparatorItem;
    TBXSeparatorItem2: TTBXSeparatorItem;
    Load: TTBXItem;
    TBXSeparatorItem3: TTBXSeparatorItem;
    Clear: TTBXItem;
    ReceiveMail: TTBXItem;
    TBXSeparatorItem5: TTBXSeparatorItem;
    procedure IdxOrgClick(Sender: TObject);
    procedure FilterClick(Sender: TObject);
    procedure cboTipOrgChange(Sender: TObject);
    procedure DelFilterClick(Sender: TObject);
    procedure TBXItem1Click(Sender: TObject);
    procedure FrameEnter(Sender: TObject);
    procedure LoadClick(Sender: TObject);
    procedure ClearClick(Sender: TObject);
    procedure ReceiveMailClick(Sender: TObject);
  private
    BeginDate, EndDate: TDateTime;
    MarkOrg:TBookmark;
  public
    procedure Init;
  end;

implementation

uses MainForm, DataModule, uWaitForm, IdxCalcForm, DateUtils, SelectUsl;

{$R *.dfm}

{ TFmeCalcOrg }

procedure TFmeCalcIdxOrg.Init;
begin
  {Инициализация}
  BeginDate := StartOfTheMonth(StrToDate(FrmMain.WorkDate));
  EndDate   := EndOfTheMonth(StrToDate(FrmMain.WorkDate));
  lblCaption.Caption:='Индексация по организациям за ' +
  FormatDateTime('mmmm, yyyy "г."', BeginDate);
  with dm.qryCalcIdxOrg do
  begin
    if Active then Close;
    try
      FilterSQL:='b.datan between :d1 and :d2';
      ParamByName('d1').AsDateTime := BeginDate;
      ParamByName('d2').AsDateTime := EndDate;
      Open;
    except
      ShowMessage('Не удалось открыть таблицу "Организации"');
    end;
  end;
  pgcMain.ActivePageIndex := 0;
end;

procedure TFmeCalcIdxOrg.IdxOrgClick(Sender: TObject);
begin
  {Индексация}
    {Ввод начисления}
  MarkOrg := dm.qryCalcIdxOrg.GetBookMark;
  dm.qryCalcIdxOrg.DisableControls;

  frmCalcIdx := TfrmCalcIdx.Create(Owner);
  if pgcMain.ActivePage = TabOt then
    frmCalcIdx.IsTeplo := True;
  if pgcMain.ActivePage = TabVk then
    frmCalcIdx.IsTeplo := False;
  try
    if frmCalcIdx.ShowModal <> mrOK then Exit;
  finally
    frmCalcIdx.Free;
  end;

  with MQuery do begin
    ParamByName('kod').AsFloat := dm.qryCalcIdxOrgkodorg.Value;
    ParamByName('data').AsDate := StrToDate(FrmMain.WorkDate);
    try
      try
        ShowWait(clGreen);
        Execute;
      finally
        HideWait;
      end;
    except
      ShowMessage('Расчет не удался...');
    end;
  end;

  dm.qryCalcIdxOrg.Refresh;
  dm.qryCalcIdxOrg.GotoBookmark(MarkOrg);
  dm.qryCalcIdxOrg.FreeBookmark(MarkOrg);
  dm.qryCalcIdxOrg.EnableControls;
end;

procedure TFmeCalcIdxOrg.FilterClick(Sender: TObject);
begin
  {Фильтр}
  with cboTipOrg do
    Enabled:=True;
end;

procedure TFmeCalcIdxOrg.cboTipOrgChange(Sender: TObject);
begin
  FrmMain.FilterData := 'b.datan between ''' + DateToStr(BeginDate) + ''' and ''' +
    DateToStr(EndDate) + '''';
  with dm.qryCalcOrg do
    FilterSQL := FrmMain.FilterData + ' and a.tiporg = ' + IntToStr(cboTipOrg.ItemIndex);
end;

procedure TFmeCalcIdxOrg.DelFilterClick(Sender: TObject);
begin
  with cboTipOrg do
    Enabled:=False;
  with dm.qryCalcOrg do
    FilterSQL := frmMain.FilterData;
end;

procedure TFmeCalcIdxOrg.TBXItem1Click(Sender: TObject);
begin
  FrmMain.pgcWork.ActivePage:=FrmMain.TabWelcome;
end;

procedure TFmeCalcIdxOrg.FrameEnter(Sender: TObject);
begin
  Init;
end;

procedure TFmeCalcIdxOrg.LoadClick(Sender: TObject);
var
  qryReport: TMSQuery;
  qryExec  : TMSSQL;
  Provider, DataSrc, FName, FField: string;
begin
  // Загрузка с екселя
  if MessageDlg('Вы хотите загрузить данные в таблицу ? Существующие данные будут обнулены.', mtConfirmation,
    [mbYes, mbNo],0) <> mrYes then Exit;

  with TOpenDialog.Create(Owner) do begin
    Filter := 'Excel|*.xls';
    if Execute then FName := FileName else Exit;
  end;
  qryReport := TMSQuery.Create(nil);
  qryReport.Connection := DM.Conect;

  qryExec := TMSSQL.Create(nil);
  qryExec.Connection := DM.Conect;

  try
    frmUsluga := TfrmUsluga.Create(Owner);
    try
      if frmUsluga.ShowModal <> mrOK then Exit;
      case frmUsluga.RzRadioGroup1.ItemIndex of
      0: FField := 'symidx';
      1: FField := 'symidxv';
      2: FField := 'symidxk';
      end;
    finally
      frmUsluga.Free;
    end;
    // Импорт
    try
      ShowWait(clGreen);
      qryReport.Close;
      Provider := 'Microsoft.Jet.OleDB.4.0';
      DataSrc  := 'Data Source=' + FName + ';Extended Properties=EXCEL 5.0';
      qryReport.SQL.Text := 'select kod,nazv,sum_idx from opendatasource(''' + Provider + ''',' +
        '''' + DataSrc + ''')...[TDSheet$]';
      qryReport.Open;
      qryExec.SQL.Text := 'update dataorg set ' + FField + ' = :p ' +
        'where kodorg = :kod and datan = :data';
      while not qryReport.Eof do begin
        qryExec.ParamByName('kod').AsInteger:= qryReport.FieldByName('kod').asInteger;
        qryExec.ParamByName('data').AsDate  := StrToDate(FrmMain.WorkDate);
        qryExec.ParamByName('p').AsFloat    := qryReport.FieldByName('sum_idx').asInteger;
        qryExec.Execute;
        // symidx = :p1, symidxv = :p2, symidxk = :p3 '+

        with MQuery do begin
          ParamByName('kod').AsFloat := qryReport.FieldByName('kod').asInteger;
          ParamByName('data').AsDate := StrToDate(FrmMain.WorkDate);
          try
            try
              Execute;
            finally
              HideWait;
            end;
          except
            ShowMessage('Расчет не удался...');
          end;
        end;

        qryReport.Next;
      end;
    finally
      HideWait;
    end;
  finally
    qryExec.Free;
    qryReport.Free;
  end;
  dm.qryCalcIdxOrg.Refresh;
  ShowMessage('Готово!');
end;

procedure TFmeCalcIdxOrg.ClearClick(Sender: TObject);
var
  qryExec  : TMSSQL;
  FField: string;
begin
  // чистим
  if MessageDlg('Вы хотите обнулить таблицу ?', mtConfirmation,
    [mbYes, mbNo],0) <> mrYes then Exit;

  qryExec := TMSSQL.Create(nil);
  qryExec.Connection := DM.Conect;
  case pgcMain.ActivePageIndex of
    0: FField := 'symidx = 0, ndsidx = 0';
    1: FField := 'symidxv = 0, ndsidxv = 0, symidxk = 0, ndsidxk = 0';
  end;
  try
    qryExec.SQL.Text := 'update dataorg set ' + FField +
      ' where datan = :data';
    qryExec.ParamByName('data').AsDate := StrToDate(FrmMain.WorkDate);
    qryExec.Execute;
  finally
    qryExec.Free;
  end;
  dm.qryCalcIdxOrg.Refresh;
  ShowMessage('Готово!');
end;

procedure TFmeCalcIdxOrg.ReceiveMailClick(Sender: TObject);
var
  MailClient: string;
begin
  // Получение почты
  MailClient := FrmMain.ProgPath + 'gmail\gmail.exe';
  ShellExecute(Handle, nil, PChar(MailClient), '-r', nil, SW_SHOWNORMAL);
end;

end.

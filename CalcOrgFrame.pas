unit CalcOrgFrame;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, StdCtrls, RzLabel, RzTabs, Grids, DBGridEh, ExtCtrls, RzPanel,
  TB2Item, TBX, TB2Dock, TB2Toolbar, TBXStatusBars, RzCmboBx, Str_fun, DB,
  LookObektForm, EditNacOrgForm, EditNacOrgVkForm, DBAccess, MSAccess,
  EditNacOrgGForm, PerCalcGForm,
  PerCalcOtForm, PerCalcVkForm, KorrectObkOtForm, KorrectObkSlivForm,
  KorrectObkGvs, CalcBanForm, CalcBolForm, ChangePeriodForm, GridsEh,
  DBGridEhGrouping, UObektFrom;
  
type
  TFmeCalcOrg = class(TFrame)
    lblCaption: TRzLabel;
    TBXDock1: TTBXDock;
    RzPanel1: TRzPanel;
    Splitter1: TSplitter;
    RzPanel2: TRzPanel;
    dbgOrg: TDBGridEh;
    RzPanel3: TRzPanel;
    pgcMain: TRzPageControl;
    TabOt: TRzTabSheet;
    TabVk: TRzTabSheet;
    dbgObekt: TDBGridEh;
    TBXToolbar2: TTBXToolbar;
    DanObk: TTBXItem;
    CalcObk: TTBXSubmenuItem;
    EditNacobk: TTBXItem;
    TBXSeparatorItem2: TTBXSeparatorItem;
    KorOtObk: TTBXItem;
    KorGvsObk: TTBXItem;
    TBXSeparatorItem3: TTBXSeparatorItem;
    EditPerObk: TTBXItem;
    TBXSeparatorItem5: TTBXSeparatorItem;
    Filter: TTBXItem;
    TBXSeparatorItem6: TTBXSeparatorItem;
    TBXSeparatorItem4: TTBXSeparatorItem;
    DelFilter: TTBXItem;
    Print: TTBXSubmenuItem;
    PrintSchet: TTBXItem;
    PrintRash: TTBXItem;
    ChangePeriod: TTBXItem;
    ReturnPeriod: TTBXItem;
    TBControlItem1: TTBControlItem;
    cboTipOrg: TRzComboBox;
    dbgObektVk: TDBGridEh;
    MQuery: TMSSQL;
    MQuery1: TMSSQL;
    MQuery2: TMSSQL;
    TBXItem1: TTBXItem;
    TabG: TRzTabSheet;
    dbgObektG: TDBGridEh;
    MQuery3: TMSSQL;
    procedure DanObkClick(Sender: TObject);
    procedure EditNacobkClick(Sender: TObject);
    procedure KorOtObkClick(Sender: TObject);
    procedure KorGvsObkClick(Sender: TObject);
    procedure EditPerObkClick(Sender: TObject);
    procedure FilterClick(Sender: TObject);
    procedure cboTipOrgChange(Sender: TObject);
    procedure DelFilterClick(Sender: TObject);
    procedure ChangePeriodClick(Sender: TObject);
    procedure ReturnPeriodClick(Sender: TObject);
    procedure PrintSchetClick(Sender: TObject);
    procedure PrintRashClick(Sender: TObject);
    procedure TBXItem1Click(Sender: TObject);
    procedure FrameEnter(Sender: TObject);
  private
    FO:TFrmUObekt;
    FE:TFrmEditNacOrg;
    FE1:TFrmEditNacOrgVk;
    FE2:TFrmEditNacOrgG;
    FP:TFrmPerCalcOt;
    FP1:TFrmPerCalcVk;
    FP2:TFrmPerCalcG;
    FK:TFrmKorrectObkOt;
    FKS:TFrmKorrectObkSliv;
    FKG:TFrmKorrectObkGvs;
    FB:TFrmCalcBan;
    FBl:TFrmCalcBol;
    CP:TFrmChangePeriod;
    FlagEdt, FlagCalc:Boolean;
    function GetTypeOrg(ID: Integer): Integer;
  public
    procedure Init;
  end;

implementation

uses MainForm, DataModule, DataPrint, uWaitForm, EditNacOrgGSKVkForm;

{$R *.dfm}

{ TFmeCalcOrg }

function TFmeCalcOrg.GetTypeOrg(ID: Integer): Integer;
begin
  Result := -1;
  with TMSQuery.Create(nil) do begin
    Connection := DM.Conect;
    SQL.Text := 'select tiporg from org where kodorg = :kod';
    try
      ParamByName('kod').asInteger := ID;
      Open;
      Result := FieldByName('tiporg').AsInteger;
    except

    end;
  end;
end;

procedure TFmeCalcOrg.Init;
begin
  {Инициализация}
  lblCaption.Caption:='Начисление по организациям за '+
  FormatDateTime('mmmm, yyyy "г."',StrToDate(FrmMain.WorkDate));
  FrmMain.Data1:=StrToDate(FrmMain.WorkDate);
  FrmMain.Data2:=EndOfMonth(StrToDate(FrmMain.WorkDate));
  with dm.qryCalcOrg do
  begin
    if Active then Close;
    try
      FilterSQL:='b.datan between '''+DateToStr(FrmMain.Data1)+''' and '''+
                 DateToStr(EndOfMonth(FrmMain.Data2))+'''';
      Open;
    except
      ShowMessage('Не удалось открыть таблицу "Организации"');
    end;
  end;
  with dm.qryRezCalcObkOt do
  begin
    if Active then Close;
    try
      FilterSQL:='a.datan between '''+DateToStr(FrmMain.Data1)+''' and '''+
                 DateToStr(EndOfMonth(FrmMain.Data2))+'''';
      Open;
    except
      ShowMessage('Не удалось открыть таблицу "Начисление за тепло"');
    end;
  end;
  with dm.qryRezCalcObkVk do
  begin
    if Active then Close;
    try
      FilterSQL:='a.datan between '''+DateToStr(FrmMain.Data1)+''' and '''+
                 DateToStr(EndOfMonth(FrmMain.Data2))+'''';
      Open;
    except
      ShowMessage('Не удалось открыть таблицу "Начисление за воду"');
    end;
  end;
  with dm.qryRezCalcObkG do
  begin
    if Active then Close;
    try
      FilterSQL:='a.datan between '''+DateToStr(FrmMain.Data1)+''' and '''+
                 DateToStr(EndOfMonth(FrmMain.Data2))+'''';
      Open;
    except
      ShowMessage('Не удалось открыть таблицу "Начисление за мусор"');
    end;
  end;
  pgcMain.ActivePageIndex := 0;
end;

procedure TFmeCalcOrg.DanObkClick(Sender: TObject);
begin
  {Данные по объекту}
  with dm.qryOrg do
  begin
    if Active then Close;
    Open;
    if pgcMain.ActivePage = TabOt then
    Locate('kodorg',dm.qryRezCalcObkOt['kodorg'],[]);
    if pgcMain.ActivePage = TabVk then
    Locate('kodorg',dm.qryRezCalcObkVk['kodorg'],[]);
    if pgcMain.ActivePage = TabG then
    Locate('kodorg',dm.qryRezCalcObkG['kodorg'],[]);
  end;
  with dm.qryObekt do
  begin
    if Active then Close;
    try
      Open;
      if pgcMain.ActivePage = TabOt then
      Locate('kodobk',dm.qryRezCalcObkOt['kodobk'],[]);
      if pgcMain.ActivePage = TabVk then
      Locate('kodobk',dm.qryRezCalcObkVk['kodobk'],[]);
      if pgcMain.ActivePage = TabG then
      Locate('kodobk',dm.qryRezCalcObkG['kodobk'],[]);

//      FO:=TFrmLookObekt.Create(Application);
//      try
//        FO.ShowModal;
//      finally
//        FO.Free;
//      end;

      dm.qryObekt.Edit;

      FO := TFrmUObekt.Create( Application );
      try
        FO.ShowModal;
      finally
        FO.Free;
      end;

    except
      ShowMessage('Не удалось получить данные по объекту...');
    end;
  end;
end;

procedure TFmeCalcOrg.EditNacobkClick(Sender: TObject);
var
  MarkOrg:TBookmark;
  MarkObk:TBookmark;
begin
  {Ввод начисления}
  MarkOrg := dm.qryCalcOrg.GetBookMark;
  dm.qryCalcOrg.DisableControls;
  if pgcMain.ActivePage = TabOt then
  begin
    MarkObk := dm.qryRezCalcObkOt.GetBookmark;
    dm.qryRezCalcObkOt.DisableControls;
    FE:=TFrmEditNacOrg.Create(Application);
    try
      if FE.ShowModal = mrOk then begin
        {Расчет начисления}
        with MQuery do
        begin
          ParamByName('data').AsDate:=StrToDate(FrmMain.WorkDate);
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
      end;
    finally
      FE.Free;
    end;

    dm.qryRezCalcObkOt.Refresh; dbgObekt.SumList.RecalcAll;
    dm.qryRezCalcObkOt.GotoBookmark(MarkObk);
    dm.qryRezCalcObkOt.FreeBookmark(MarkObk);
    dm.qryRezCalcObkOt.EnableControls;
  end;
  if pgcMain.ActivePage = TabVk then
  begin
    MarkObk := dm.qryRezCalcObkVk.GetBookmark;
    dm.qryRezCalcObkVk.DisableControls;
    if GetTypeOrg(DM.qryCalcOrg.fieldByName('kodorg').AsInteger) < 2 then begin
      FE1:=TFrmEditNacOrgVk.Create(Application);
      try
        if FE1.ShowModal <> mrOk then Exit;
      finally
        FE1.Free;
      end;
    end else begin
      FrmEditNacOrgGSKVk := TFrmEditNacOrgGSKVk.Create(Application);
      try
        if FrmEditNacOrgGSKVk.ShowModal <> mrOk then Exit;
      finally
        FrmEditNacOrgGSKVk.Free;
      end;
    end;
    {Расчет начисления}
    with MQuery1 do
    begin
      ParamByName('data').AsDate:=StrToDate(FrmMain.WorkDate);
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

    dm.qryRezCalcObkVk.Refresh; dbgObekt.SumList.RecalcAll;
    dm.qryRezCalcObkVk.GotoBookmark(MarkObk);
    dm.qryRezCalcObkVk.FreeBookmark(MarkObk);
    dm.qryRezCalcObkVk.EnableControls;
  end;
  if pgcMain.ActivePage = TabG then
  begin
    MarkObk := dm.qryRezCalcObkG.GetBookmark;
    dm.qryRezCalcObkG.DisableControls;
    FE2:=TFrmEditNacOrgG.Create(Application);
    try
      if FE2.ShowModal = mrOk then begin
        {Расчет начисления за мусор}
        with MQuery3 do
        begin
          ParamByName('data').AsDate:=StrToDate(FrmMain.WorkDate);
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
      end;
    finally
      FE2.Free;
    end;

    dm.qryRezCalcObkG.Refresh; dbgObekt.SumList.RecalcAll;
    dm.qryRezCalcObkG.GotoBookmark(MarkObk);
    dm.qryRezCalcObkG.FreeBookmark(MarkObk);
    dm.qryRezCalcObkG.EnableControls;
  end;
  dm.qryCalcOrg.Refresh;
  dm.qryCalcOrg.GotoBookmark(MarkOrg);
  dm.qryCalcOrg.FreeBookmark(MarkOrg);
  dm.qryCalcOrg.EnableControls;
end;

procedure TFmeCalcOrg.KorOtObkClick(Sender: TObject);
var
  Mark:TBookmark;
begin
  {Корректировка отопления}
  // Проверяем котельную
  if pgcMain.ActivePage = TabOt then
  begin
    dm.qryRezCalcObkOt.DisableControls;
    Mark := dm.qryRezCalcObkOt.GetBookmark;
    with dm.qryOrg do
    begin
      if Active then Close;
      Open;
      Locate('kodorg',dm.qryRezCalcObkOt['kodorg'],[]);
    end;
    with dm.qryObekt do
    begin
      if Active then Close;
      Open;
      Locate('kodobk',dm.qryRezCalcObkOt['kodobk'],[]);
    end;
    if (dm.qryObektkodkot.Value<8) or (dm.qryObektkodkot.Value>10) then
    begin
      if dm.qryRezCalcObkOtKodpr.Value>1 then
        if Application.MessageBox('По объекту ведется приборный учет. Продолжить?',
        'Предупреждение',mb_YesNo or mb_TaskModal or mb_IconQuestion)=idYes then
          FlagEdt:=True else FlagEdt:=False
        else FlagEdt:=True;
      if FlagEdt = True then
      begin
        FrmMain.CurRec1:=1;
        FK:=TFrmKorrectObkOt.Create(Application);
        try
          FK.ShowModal;
          if FrmMain.MR = 1 then FlagCalc:=True else FlagCalc:=False;
        finally
          FK.Free;
        end;
      end;
    end;
    if (dm.qryKotelnkodkot.Value=10) then
    begin
      // Слив
      FrmMain.CurRec1:=1;
      FKS:=TFrmKorrectObkSliv.Create(Application);
      try
        FKS.ShowModal;
        if FrmMain.MR = 1 then FlagCalc:=True else FlagCalc:=False;
      finally
        FKS.Free;
      end;
    end;
    {Расчет начисления}
    with MQuery do
    begin
      ParamByName('data').AsDate:=StrToDate(FrmMain.WorkDate);
      try
        if FlagCalc then Execute;
      except
        ShowMessage('Расчет не удался...');
      end;
    end;
    dm.qryRezCalcObkOt.Refresh; dbgObekt.SumList.RecalcAll;
    dm.qryRezCalcObkOt.GotoBookmark(Mark);
    dm.qryRezCalcObkOt.FreeBookmark(Mark);
    dm.qryRezCalcObkOt.EnableControls;
  end else ShowMessage('Перейдите на вкладку "Теплоснабжение"...');
end;

procedure TFmeCalcOrg.KorGvsObkClick(Sender: TObject);
var
  Mark:TBookmark;
begin
  {Корректировка ГВС}
  if pgcMain.ActivePage = TabOt then
  begin
    dm.qryRezCalcObkOt.DisableControls;
    Mark := dm.qryRezCalcObkOt.GetBookmark;
    with dm.qryOrg do
    begin
      if Active then Close;
      Open;
      Locate('kodorg',dm.qryRezCalcObkOt['kodorg'],[]);
    end;
    with dm.qryObekt do
    begin
      if Active then Close;
      Open;
      Locate('kodobk',dm.qryRezCalcObkOt['kodobk'],[]);
    end;
    if (dm.qryKotelnkodkot.Value<>8) and (dm.qryKotelnkodkot.Value<>9) then
    begin
      // Остальные
      //1. Проверяем, а есть ли вода горячая
      if dm.qryObektpodklgv.Value = 0 then
      begin
        FrmMain.CurRec1:=1;
        FKG:=TFrmKorrectObkGvs.Create(Application);
        try
          FKG.ShowModal;
          if FrmMain.MR = 1 then FlagCalc:=True else FlagCalc:=False;
        finally
          FKG.Free;
        end;
      end else ShowMessage('Объект не подключен к ГВС...');
    end;
    if (dm.qryKotelnkodkot.Value=8) then
    begin
      // Баня
      FrmMain.CurRec1:=1;
      FB:=TFrmCalcBan.Create(Application);
      try
        FB.ShowModal;
        if FrmMain.MR = 1 then FlagCalc:=True else FlagCalc:=False;
      finally
        FB.Free;
      end;
    end;
    if (dm.qryKotelnkodkot.Value=9) then
    begin
      // Больница
      FrmMain.CurRec1:=1;
      FBl:=TFrmCalcBol.Create(Application);
      try
        FBl.ShowModal;
        if FrmMain.MR = 1 then FlagCalc:=True else FlagCalc:=False;
      finally
        FBl.Free;
      end;
    end;
    {Расчет начисления}
    with MQuery do
    begin
      ParamByName('data').AsDate:=StrToDate(FrmMain.WorkDate);
      try
        if FlagCalc then Execute;
      except
        ShowMessage('Расчет не удался...');
      end;
    end;
    dm.qryRezCalcObkOt.Refresh; dbgObekt.SumList.RecalcAll;
    dm.qryRezCalcObkOt.GotoBookmark(Mark);
    dm.qryRezCalcObkOt.FreeBookmark(Mark);
    dm.qryRezCalcObkOt.EnableControls;
  end else ShowMessage('Перейдите на вкладку "Теплоснабжение"...');
end;

procedure TFmeCalcOrg.EditPerObkClick(Sender: TObject);
var
  Mark:TBookmark;
begin
  {Перерасчеты}
  if pgcMain.ActivePage = TabOt then
  begin
    dm.qryRezCalcObkOt.DisableControls;
    Mark := dm.qryRezCalcObkOt.GetBookmark;
    FP:=TFrmPerCalcOt.Create(Application);
    try
      FP.ShowModal;
      if FrmMain.MR = 1 then FlagCalc:=True else FlagCalc:=False;
    finally
      FP.Free;
    end;
    {Расчет начисления}
    with MQuery do
    begin
      ParamByName('data').AsDate:=StrToDate(FrmMain.WorkDate);
      try
        if FlagCalc then Execute;
      except
        ShowMessage('Расчет не удался...');
      end;
    end;
    dm.qryRezCalcObkOt.Refresh; dbgObekt.SumList.RecalcAll;
    dm.qryRezCalcObkOt.GotoBookmark(Mark);
    dm.qryRezCalcObkOt.FreeBookmark(Mark);
    dm.qryRezCalcObkOt.EnableControls;
  end;
  if pgcMain.ActivePage = TabVk then
  begin
    dm.qryRezCalcObkVk.DisableControls;
    Mark := dm.qryRezCalcObkVk.GetBookmark;
    FP1:=TFrmPerCalcVk.Create(Application);
    try
      FP1.ShowModal;
      if FrmMain.MR = 1 then FlagCalc:=True else FlagCalc:=False;
    finally
      FP1.Free;
    end;
    {Расчет начисления}
    with MQuery1 do
    begin
      ParamByName('data').AsDate:=StrToDate(FrmMain.WorkDate);
      try
        if FlagCalc then Execute;
      except
        ShowMessage('Расчет не удался...');
      end;
    end;
    dm.qryRezCalcObkVk.Refresh; dbgObekt.SumList.RecalcAll;
    dm.qryRezCalcObkVk.GotoBookmark(Mark);
    dm.qryRezCalcObkVk.FreeBookmark(Mark);
    dm.qryRezCalcObkVk.EnableControls;
  end;
  if pgcMain.ActivePage = TabG then
  begin
    dm.qryRezCalcObkG.DisableControls;
    Mark := dm.qryRezCalcObkG.GetBookmark;
    FP2:=TFrmPerCalcG.Create(Application);
    try
      FP2.ShowModal;
      if FrmMain.MR = 1 then FlagCalc:=True else FlagCalc:=False;
    finally
      FP2.Free;
    end;
    {Расчет начисления}
    with MQuery3 do
    begin
      ParamByName('data').AsDate:=StrToDate(FrmMain.WorkDate);
      try
        if FlagCalc then Execute;
      except
        ShowMessage('Расчет не удался...');
      end;
    end;
    dm.qryRezCalcObkG.Refresh; dbgObekt.SumList.RecalcAll;
    dm.qryRezCalcObkG.GotoBookmark(Mark);
    dm.qryRezCalcObkG.FreeBookmark(Mark);
    dm.qryRezCalcObkG.EnableControls;
  end;
end;

procedure TFmeCalcOrg.FilterClick(Sender: TObject);
begin
  {Фильтр}
  with cboTipOrg do
    Enabled:=True;
end;

procedure TFmeCalcOrg.cboTipOrgChange(Sender: TObject);
begin
  FrmMain.FilterData:='b.datan between '''+DateToStr(FrmMain.Data1)+''' and '''+
               DateToStr(EndOfMonth(FrmMain.Data2))+'''';
  with dm.qryCalcOrg do
    FilterSQL:=FrmMain.FilterData+' and a.tiporg='+IntToStr(cboTipOrg.ItemIndex);
end;

procedure TFmeCalcOrg.DelFilterClick(Sender: TObject);
begin
  with cboTipOrg do
    Enabled:=False;
  with dm.qryCalcOrg do
    FilterSQL:='b.datan between '''+DateToStr(FrmMain.Data1)+''' and '''+
               DateToStr(EndOfMonth(FrmMain.Data2))+'''';
end;

procedure TFmeCalcOrg.ChangePeriodClick(Sender: TObject);
begin
  {Смена периода}
  CP:=TFrmChangePeriod.Create(Application);
  try
    CP.ShowModal;
    FrmMain.FilterData:='b.datan between '''+DateToStr(FrmMain.Data1)+''' and '''+
          DateToStr(EndOfMonth(FrmMain.Data2))+'''';
    with dm.qryCalcOrg do
      FilterSQL:=FrmMain.FilterData;
    with dm.qryRezCalcObkOt do
      FilterSQL:='a.datan between '''+DateToStr(FrmMain.Data1)+''' and '''+
                 DateToStr(EndOfMonth(FrmMain.Data2))+'''';
    with dm.qryRezCalcObkVk do
      FilterSQL:='a.datan between '''+DateToStr(FrmMain.Data1)+''' and '''+
                 DateToStr(EndOfMonth(FrmMain.Data2))+'''';
    if FrmMain.Data1 = FrmMain.Data2 then
    lblCaption.Caption:='Результаты по объектам за '+
    PeriodStr(FrmMain.Data1,Null) else
    lblCaption.Caption:='Результаты по объектам за '+
    PeriodStr(FrmMain.Data1,FrmMain.Data2);
    CalcObk.Enabled:=False;
  finally
    CP.Free;
  end;
end;

procedure TFmeCalcOrg.ReturnPeriodClick(Sender: TObject);
begin
  FrmMain.Data1:=StrToDate(FrmMain.WorkDate);
  FrmMain.Data2:=StrToDate(FrmMain.WorkDate);
  FrmMain.FilterData:='b.datan between '''+DateToStr(FrmMain.Data1)+''' and '''+
          DateToStr(EndOfMonth(FrmMain.Data2))+'''';
  with dm.qryCalcOrg do
    FilterSQL:=FrmMain.FilterData;
  with dm.qryRezCalcObkOt do
    FilterSQL:='a.datan between '''+DateToStr(FrmMain.Data1)+''' and '''+
               DateToStr(EndOfMonth(FrmMain.Data2))+'''';
  with dm.qryRezCalcObkVk do
    FilterSQL:='a.datan between '''+DateToStr(FrmMain.Data1)+''' and '''+
               DateToStr(EndOfMonth(FrmMain.Data2))+'''';
  if FrmMain.Data1 = FrmMain.Data2 then
  lblCaption.Caption:='Результаты по объектам за '+
  PeriodStr(FrmMain.Data1,Null) else
  lblCaption.Caption:='Результаты по объектам за '+
  PeriodStr(FrmMain.Data1,FrmMain.Data2);
  CalcObk.Enabled:=True;
end;

procedure TFmeCalcOrg.PrintSchetClick(Sender: TObject);
begin
  {Счет-фактура}
  CP:=TFrmChangePeriod.Create(Application);
  try
    CP.cboEnd.Enabled:=False;
    CP.RzLabel1.Caption:='За';
    if CP.ShowModal = mrCancel then Exit;
    with dp.qryParam do
    begin
      if Active then Close;
      Open;
    end;
    with MQuery2 do
    begin
      ParamByName('kod').AsInteger:=dm.qryCalcOrg['kodorg'];
      ParamByName('data').AsDate:=FrmMain.Data1;
      try
        Execute;
      except
        ShowMessage('Расчет не удался...');
      end;
    end;
    with dp.qrySchet do
    begin
      Open;
    end;
    with dp.qryLicev do
    begin
      SQL.Clear;
      SQL.Add('SELECT a.kodobk, a.nazv, a.kodorg,');
      SQL.Add('sum(b.gkt+b.pgkt) AS gkal_t,sum(b.gkv+b.pgkv) AS gkal_v,');
      SQL.Add('avg(b.rastarift) AS tarif_t,');
      SQL.Add('sum(b.pert+b.perv) AS per,');
      SQL.Add('sum(b.symt+b.symv+(b.pert-b.pertnds)+(b.perv-b.pervnds)) AS symbeznds,');
      SQL.Add('sum(b.symtnds+b.symvnds+b.pertnds+b.pervnds) AS symnds,');
      SQL.Add('sum(b.symk+b.symgv+b.pert+b.perv) AS symsnds,');
      SQL.Add('sum(b.lgkt) AS lgkal_t,');
      SQL.Add('sum(b.lgkv) AS lgkal_v,');
      SQL.Add('sum(b.lsymt) AS lsumt,');
      SQL.Add('sum(b.lsymv) AS lsumgv,');
      SQL.Add('sum(b.kybv+b.pkybv) AS kyb_v,');
      SQL.Add('sum(b.kybk+b.pkybk) AS kyb_k,');
      SQL.Add('avg(b.rastarifv) AS tarif_v,');
      SQL.Add('avg(b.rastarifk) AS tarif_k,');
      SQL.Add('sum(b.perh+b.perk) AS perhv,');
      SQL.Add('sum(b.symh+b.symkk+(b.perh-b.perhnds)+(b.perk-b.perknds)) AS symbezndshv,');
      SQL.Add('sum(b.symhnds+b.symknds+b.perhnds+b.perknds) AS symndshv,');
      SQL.Add('sum(b.symhs+b.symks+b.perh+b.perk) AS symsndshv,');
      SQL.Add('sum(b.lkybv) AS lkyb_v,');
      SQL.Add('sum(b.lkybk) AS lkyb_k,');
      SQL.Add('sum(b.lsymh) AS lsumh,');
      SQL.Add('sum(b.lsymkk) AS lsumk,');

      SQL.Add('sum(b.kybg+b.pkybg) AS kyb_g,');
      SQL.Add('avg(b.rastarifg) AS tarif_g,');
      SQL.Add('sum(b.perg) AS perg,');
      SQL.Add('sum(b.symg+b.perg-b.pergnds) AS symbezndsg,');
      SQL.Add('sum(b.symgnds+b.pergnds) AS symndsg,');
      SQL.Add('sum(b.symgs+b.perg) AS symsndsg,');
      SQL.Add('sum(b.lkybg) AS lkyb_g,');
      SQL.Add('sum(b.lsymg) AS lsumg');

      SQL.Add('FROM OBEKT a, dataobekt b');
      SQL.Add('WHERE a.kodobk=b.kodobk');
      SQL.Add('GROUP BY a.kodobk, a.nazv, a.kodorg');
      SQL.Add('ORDER BY a.kodobk');
      FilterSQL:='b.datan = '''+DateToStr(FrmMain.Data1)+'''';
      Open;
    end;
    dp.Report.LoadFromFile(FrmMain.RPath+'Счет-фактура (полная).fr3');
    dp.Report.Variables['period']:=PeriodStr(FrmMain.Data1,Null);
    dp.Report.ShowReport;
  finally
    CP.Free;
  end;
end;

procedure TFmeCalcOrg.PrintRashClick(Sender: TObject);
begin
  {Расшифровка}
  CP:=TFrmChangePeriod.Create(Application);
  try
    CP.ShowModal;
    with dm.qryOrg do
    begin
      if Active then Close;
      Open;
      Locate('kodorg',dm.qryRezCalcObkOt['kodorg'],[]);
    end;
    with dp.qryLicevRas do
    begin
      FilterSQL:='b.datan between '''+DateToStr(FrmMain.Data1)+''' and '''+
               DateToStr(EndOfMonth(FrmMain.Data2))+'''';
      Open;
    end;
    dp.Report.LoadFromFile(FrmMain.RPath+'Расшифровка по объектам.fr3');
    dp.Report.ShowReport;
  finally
    CP.Free;
  end;
end;

procedure TFmeCalcOrg.TBXItem1Click(Sender: TObject);
begin
  FrmMain.pgcWork.ActivePage:=FrmMain.TabWelcome;
end;

procedure TFmeCalcOrg.FrameEnter(Sender: TObject);
begin
  Init;
end;

end.

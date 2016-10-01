unit VidtopFrame;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, Grids, DBGridEh, RzPanel, ImgList, DBCtrls, RzDBNav, RzButton,
  ExtCtrls, StdCtrls, RzLabel, frxClass, frxDBSet, DB, MemDS, DBAccess,
  MSAccess, GridsEh, DBGridEhGrouping;

type
  TFmeVidTop = class(TFrame)
    RzLabel9: TRzLabel;
    tbrTarif: TRzToolbar;
    RzSpacer7: TRzSpacer;
    RzToolButton2: TRzToolButton;
    RzSpacer2: TRzSpacer;
    NavigateTarif: TRzDBNavigator;
    ImageList1: TImageList;
    pnlMain: TRzPanel;
    dbgVidtop: TDBGridEh;
    qryVidtop: TMSQuery;
    dsVidtop: TDataSource;
    VidtopSet: TfrxDBDataset;
    Report: TfrxReport;
    RzToolButton1: TRzToolButton;
    procedure RzToolButton2Click(Sender: TObject);
    procedure RzToolButton1Click(Sender: TObject);
  private

  public
    procedure Init;
  end;

implementation

uses DataModule, MainForm;

{$R *.dfm}

{ TFmeVidTop }

procedure TFmeVidTop.Init;
begin
  with dm.qryVidTop do
  begin
    if Active then Close;
    try
      Open;
    except
      ShowMessage('Не удалось открыть таблицу "Виды топлива"');
    end;
  end;
end;

procedure TFmeVidTop.RzToolButton2Click(Sender: TObject);
begin
  Report.LoadFromFile(FrmMain.RPath+'Виды топлива.fr3');
  Report.ShowReport;
end;

procedure TFmeVidTop.RzToolButton1Click(Sender: TObject);
begin
  FrmMain.pgcWork.ActivePage:=FrmMain.TabWelcome;
end;

end.

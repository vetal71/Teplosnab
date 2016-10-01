program Teplosnab;

uses
  ExceptionLog,
  Forms,
  SysUtils,
  Dialogs,
  DataModule in 'DataModule.pas' {DM: TDataModule},
  MainForm in 'MainForm.pas' {FrmMain},
  DataPrint in 'DataPrint.pas' {DP: TDataModule},
  FunForFR in 'FunForFR.pas',
  EditPropis in 'EditPropis.pas' {fPropis};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Теплоснабжение и водоснабжение';
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TFrmMain, FrmMain);
  Application.CreateForm(TDP, DP);
  Application.Run;
end.

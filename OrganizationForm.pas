unit OrganizationForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGridEh, ExtCtrls, RzPanel, StdCtrls, RzCmboBx, DBCtrls,
  RzDBNav, RzButton, RzLabel, DB, MemDS, DBAccess, MSAccess, frxClass,
  frxDBSet, Menus, ImgList, GridsEh, DBGridEhGrouping;

type
  TFrmOrganization = class(TForm)
    ImageList1: TImageList;
    pmPrint: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    N8: TMenuItem;
    N9: TMenuItem;
    Report: TfrxReport;
    OrgSet: TfrxDBDataset;
    ObektSet: TfrxDBDataset;
    LicevSet: TfrxDBDataset;
    qryOrg: TMSQuery;
    dsOrg: TDataSource;
    qryObekt: TMSQuery;
    dsObekt: TDataSource;
    qryLicev: TMSQuery;
    dsLicev: TDataSource;
    RzLabel9: TRzLabel;
    tbrOrg: TRzToolbar;
    RzSpacer1: TRzSpacer;
    BtnFilterOrg: TRzToolButton;
    RzSpacer3: TRzSpacer;
    RzSpacer4: TRzSpacer;
    BtnDelFilterOrg: TRzToolButton;
    BtnFind: TRzToolButton;
    BtnPrint: TRzToolButton;
    RzSpacer7: TRzSpacer;
    BtnFreeFilter: TRzToolButton;
    RzSpacer8: TRzSpacer;
    BtnDeleteOrg: TRzToolButton;
    RzSpacer10: TRzSpacer;
    NavigateOrg: TRzDBNavigator;
    cboTipOrg: TRzComboBox;
    RzPanel1: TRzPanel;
    Splitter1: TSplitter;
    RzPanel2: TRzPanel;
    dbgOrg: TDBGridEh;
    RzPanel3: TRzPanel;
    dbgObekt: TDBGridEh;
    tbrObekt: TRzToolbar;
    RzSpacer2: TRzSpacer;
    btnChangeOrg: TRzToolButton;
    RzSpacer5: TRzSpacer;
    BtnHistory: TRzToolButton;
    RzSpacer6: TRzSpacer;
    BtnFreeFilterObk: TRzToolButton;
    RzSpacer9: TRzSpacer;
    BtnDeleteObk: TRzToolButton;
    RzSpacer11: TRzSpacer;
    NavigateObk: TRzDBNavigator;
  private
    { Private declarations }
  public
    procedure Init;
  end;

var
  FrmOrganization: TFrmOrganization;

implementation

uses DataModule;

{$R *.dfm}

{ TForm1 }

procedure TFrmOrganization.Init;
begin
  with dm do begin
    if qryOrg.Active then qryOrg.Close;
    try
      qryOrg.Open;
    except
      ShowMessage('Не удалось открыть таблицу "Организации"');
    end;
    if qryObekt.Active then qryObekt.Close;
    try
      qryObekt.Open;
    except
      ShowMessage('Не удалось открыть таблицу "Объекты"');
    end;
  end;
end;

end.

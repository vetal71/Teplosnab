object FrmLookHistoryNorma: TFrmLookHistoryNorma
  Left = 263
  Top = 255
  Width = 282
  Height = 244
  Caption = #1055#1088#1086#1089#1084#1086#1090#1088' '#1080#1089#1090#1086#1088#1080#1080
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object dbgNas: TDBGridEh
    Left = 0
    Top = 0
    Width = 274
    Height = 210
    Align = alClient
    DataGrouping.GroupLevels = <>
    DataSource = DM.dsHistNorma
    Flat = True
    FooterColor = clWindow
    FooterFont.Charset = DEFAULT_CHARSET
    FooterFont.Color = clWindowText
    FooterFont.Height = -11
    FooterFont.Name = 'MS Sans Serif'
    FooterFont.Style = []
    IndicatorOptions = [gioShowRowIndicatorEh]
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
    RowDetailPanel.Color = clBtnFace
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    UseMultiTitle = True
    Columns = <
      item
        EditButtons = <>
        FieldName = 'norma'
        Footers = <>
        Title.Caption = #1059#1076'.'#1085#1086#1088#1084#1072' ('#1101#1083'.'#1101#1085'.)'
        Width = 60
      end
      item
        EditButtons = <>
        FieldName = 'dataiz'
        Footers = <>
        Title.Caption = #1044#1072#1090#1072' '#1080#1079#1084'.'
        Width = 120
      end>
    object RowDetailData: TRowDetailPanelControlEh
    end
  end
end

object FrmLookHistoryObekt: TFrmLookHistoryObekt
  Left = 294
  Top = 209
  Width = 542
  Height = 263
  Caption = 'FrmLookHistoryObekt'
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
  object dbgOrg: TDBGridEh
    Left = 0
    Top = 0
    Width = 534
    Height = 229
    Align = alClient
    DataGrouping.GroupLevels = <>
    DataSource = DM.dsHistObk
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
    Columns = <
      item
        EditButtons = <>
        FieldName = 'v'
        Footers = <>
        Title.Alignment = taCenter
        Title.Caption = #1054#1073#1098#1077#1084
      end
      item
        EditButtons = <>
        FieldName = 'q'
        Footers = <>
        Title.Alignment = taCenter
        Title.Caption = 'Q '#1086#1090#1086#1087'.'
      end
      item
        EditButtons = <>
        FieldName = 'prj'
        Footers = <>
        Title.Alignment = taCenter
        Title.Caption = #1055#1088#1086#1078'.'
      end
      item
        EditButtons = <>
        FieldName = 'prjl'
        Footers = <>
        Title.Alignment = taCenter
        Title.Caption = #1055#1088#1086#1078'., '#1083#1100#1075'.'
      end
      item
        EditButtons = <>
        FieldName = 'spl'
        Footers = <>
        Title.Alignment = taCenter
        Title.Caption = #1054#1073'.'#1087#1083'.'
      end
      item
        EditButtons = <>
        FieldName = 'spll'
        Footers = <>
        Title.Alignment = taCenter
        Title.Caption = #1054#1073'.'#1087#1083'., '#1083#1100#1075'.'
      end
      item
        EditButtons = <>
        FieldName = 'dataiz'
        Footers = <>
        Title.Alignment = taCenter
        Title.Caption = #1044#1072#1090#1072' '#1080#1079#1084'.'
      end>
    object RowDetailData: TRowDetailPanelControlEh
    end
  end
end

object FrmLookHistoryNas: TFrmLookHistoryNas
  Left = 325
  Top = 238
  Width = 335
  Height = 204
  Caption = #1055#1088#1086#1089#1084#1086#1090#1088' '#1080#1089#1090#1086#1088#1080#1080
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object dbgNas: TDBGridEh
    Left = 0
    Top = 0
    Width = 327
    Height = 170
    Align = alClient
    DataGrouping.GroupLevels = <>
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
        FieldName = 'qot'
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
        FieldName = 'spl'
        Footers = <>
        Title.Alignment = taCenter
        Title.Caption = #1054#1073'.'#1087#1083'.'
      end
      item
        EditButtons = <>
        FieldName = 'dataiz'
        Footers = <>
        Title.Alignment = taCenter
        Title.Caption = #1044#1072#1090#1072' '#1080#1079#1084'.'
        Width = 100
      end>
    object RowDetailData: TRowDetailPanelControlEh
    end
  end
end

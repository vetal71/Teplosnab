object frmSelectBank: TfrmSelectBank
  Left = 112
  Top = 137
  Width = 860
  Height = 473
  Caption = #1041#1072#1085#1082#1080
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  ShowHint = True
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object dbgBank: TRzDBGrid
    Left = 4
    Top = 3
    Width = 844
    Height = 399
    Hint = #1044#1074#1086#1081#1085#1086#1081' '#1082#1083#1080#1082' - '#1074#1099#1073#1086#1088' '#1073#1072#1085#1082#1072
    DataSource = DM.dsSelBank
    FixedColor = clActiveCaption
    Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnDblClick = dbgBankDblClick
    FrameColor = 12164479
    FrameVisible = True
    FixedLineColor = 12164479
    LineColor = clInactiveCaption
    Columns = <
      item
        Expanded = False
        FieldName = 'kod_bank'
        Title.Alignment = taCenter
        Title.Caption = #1052#1060#1054
        Width = 50
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'nazv_bank'
        Title.Alignment = taCenter
        Title.Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
        Width = 450
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'adres_bank'
        Title.Alignment = taCenter
        Title.Caption = #1040#1076#1088#1077#1089
        Width = 320
        Visible = True
      end>
  end
  object ePoisk: TRzEdit
    Left = 212
    Top = 410
    Width = 637
    Height = 21
    FrameColor = 12164479
    FrameHotColor = 16776176
    FrameVisible = True
    TabOrder = 1
    OnChange = ePoiskChange
  end
  object rgPoisk: TRzRadioGroup
    Left = 4
    Top = 402
    Width = 201
    Height = 33
    Columns = 2
    ItemFrameColor = 8409372
    ItemHotTrack = True
    ItemHighlightColor = 2203937
    ItemHotTrackColor = 3983359
    ItemHotTrackColorType = htctActual
    ItemIndex = 0
    Items.Strings = (
      #1087#1086' '#1082#1086#1076#1091
      #1087#1086' '#1085#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1102)
    StartYPos = 10
    TabOrder = 2
    ThemeAware = False
    OnClick = rgPoiskClick
  end
end

object FmePlan: TFmePlan
  Left = 0
  Top = 0
  Width = 601
  Height = 438
  TabOrder = 0
  TabStop = True
  object lblCaption: TRzLabel
    Left = 0
    Top = 0
    Width = 601
    Height = 30
    Align = alTop
    Alignment = taCenter
    AutoSize = False
    Caption = #1055#1088#1077#1076#1074#1072#1088#1080#1090#1077#1083#1100#1085#1086#1077' '#1085#1072#1095#1080#1089#1083#1077#1085#1080#1077' '#1087#1086' '#1086#1088#1075#1072#1085#1080#1079#1072#1094#1080#1103#1084
    Color = 16771797
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Verdana'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
    Transparent = False
    Layout = tlCenter
    BorderOuter = fsFlat
    BorderSides = [sdBottom]
    ShadowColor = clWhite
    TextStyle = tsRaised
  end
  object TBXDock1: TTBXDock
    Left = 0
    Top = 30
    Width = 601
    Height = 26
    object TBXToolbar2: TTBXToolbar
      Left = 0
      Top = 0
      Caption = 'TBXToolbar1'
      ChevronHint = #1044#1086#1087#1086#1083#1085#1080#1090#1077#1083#1100#1085#1086'|'
      Images = FrmMain.ImageList1
      TabOrder = 0
      object TBXLabelItem1: TTBXLabelItem
        Caption = #1042#1099#1073#1086#1088' '#1084#1077#1089#1103#1094#1072':'
      end
      object TBControlItem2: TTBControlItem
        Control = cboMonth
      end
      object TBXSeparatorItem2: TTBXSeparatorItem
      end
      object TBXItem1: TTBXItem
        Caption = #1055#1077#1095#1072#1090#1100
        DisplayMode = nbdmImageAndText
        ImageIndex = 7
        Stretch = True
        OnClick = TBXItem1Click
      end
      object TBXItem3: TTBXItem
        Caption = #1042#1099#1093#1086#1076
        DisplayMode = nbdmImageAndText
        ImageIndex = 135
        Stretch = True
        OnClick = TBXItem3Click
      end
      object cboMonth: TRzComboBox
        Left = 75
        Top = 0
        Width = 133
        Height = 21
        Hint = #1042#1099#1073#1088#1072#1090#1100' '#1084#1077#1089#1103#1094
        Style = csDropDownList
        Ctl3D = False
        FlatButtons = True
        FrameColor = 12164479
        FrameVisible = True
        ItemHeight = 13
        ParentCtl3D = False
        TabOrder = 0
      end
    end
  end
  object pgcMain: TRzPageControl
    Left = 0
    Top = 56
    Width = 601
    Height = 382
    ActivePage = TabGarbage
    Align = alClient
    Color = 16119543
    FlatColor = 10263441
    HotTrackColor = 3983359
    ParentColor = False
    TabColors.HighlightBar = 3983359
    TabIndex = 3
    TabOrder = 1
    FixedDimension = 19
    object TabTeplo: TRzTabSheet
      Color = 16119543
      Caption = #1058#1077#1087#1083#1086#1089#1085#1072#1073#1078#1077#1085#1080#1077
      object RzLabel1: TRzLabel
        Left = 8
        Top = 211
        Width = 210
        Height = 13
        Caption = #1042#1074#1077#1076#1080#1090#1077' '#1087#1088#1086#1094#1077#1085#1090' '#1080#1079#1084#1077#1085#1077#1085#1080#1103' '#1085#1072#1095#1080#1089#1083#1077#1085#1080#1103':'
      end
      object rgTep: TRzRadioGroup
        Left = 8
        Top = 8
        Width = 281
        Height = 125
        Caption = #1042#1099#1073#1086#1088' '#1090#1080#1087#1072' '#1092#1080#1085#1072#1085#1089#1080#1088#1086#1074#1072#1085#1080#1103' '#1086#1088#1075#1072#1085#1080#1079#1072#1094#1080#1081
        ItemFrameColor = 8409372
        ItemHotTrack = True
        ItemHighlightColor = 2203937
        ItemHotTrackColor = 3983359
        ItemIndex = 0
        Items.Strings = (
          #1085#1077' '#1086#1090#1073#1080#1088#1072#1090#1100
          #1084#1077#1089#1090#1085#1099#1081' '#1073#1102#1076#1078#1077#1090
          #1073#1102#1076#1078#1077#1090' ('#1074#1089#1077')'
          #1093#1086#1079#1088#1072#1089#1095#1077#1090
          #1074#1089#1077)
        TabOrder = 0
        Transparent = True
      end
      object neProcent: TRzNumericEdit
        Left = 224
        Top = 208
        Width = 65
        Height = 21
        FrameColor = 12164479
        FrameVisible = True
        TabOrder = 1
        IntegersOnly = False
        DisplayFormat = ',0.00;-,0.00'
      end
      object rgTip1: TRzRadioGroup
        Left = 8
        Top = 136
        Width = 281
        Height = 65
        Caption = #1042#1099#1073#1086#1088' '#1090#1080#1087#1072' '#1087#1083#1072#1085#1080#1088#1086#1074#1072#1085#1080#1103
        ItemFrameColor = 8409372
        ItemHotTrack = True
        ItemHighlightColor = 2203937
        ItemHotTrackColor = 3983359
        ItemIndex = 0
        Items.Strings = (
          #1087#1086' '#1087#1088#1086#1094#1077#1085#1090#1091
          #1087#1086' '#1090#1072#1088#1080#1092#1091)
        TabOrder = 2
        Transparent = True
        OnClick = rgTip1Click
      end
    end
    object TabVoda: TRzTabSheet
      Color = 16119543
      Caption = #1042#1086#1076#1086#1089#1085#1072#1073#1078#1077#1085#1080#1077
      object RzLabel2: TRzLabel
        Left = 8
        Top = 211
        Width = 210
        Height = 13
        Caption = #1042#1074#1077#1076#1080#1090#1077' '#1087#1088#1086#1094#1077#1085#1090' '#1080#1079#1084#1077#1085#1077#1085#1080#1103' '#1085#1072#1095#1080#1089#1083#1077#1085#1080#1103':'
      end
      object rgVoda: TRzRadioGroup
        Left = 8
        Top = 8
        Width = 281
        Height = 125
        Caption = #1042#1099#1073#1086#1088' '#1090#1080#1087#1072' '#1092#1080#1085#1072#1085#1089#1080#1088#1086#1074#1072#1085#1080#1103' '#1086#1088#1075#1072#1085#1080#1079#1072#1094#1080#1081
        ItemFrameColor = 8409372
        ItemHotTrack = True
        ItemHighlightColor = 2203937
        ItemHotTrackColor = 3983359
        ItemIndex = 0
        Items.Strings = (
          #1085#1077' '#1086#1090#1073#1080#1088#1072#1090#1100
          #1084#1077#1089#1090#1085#1099#1081' '#1073#1102#1076#1078#1077#1090
          #1073#1102#1076#1078#1077#1090' ('#1074#1089#1077')'
          #1093#1086#1079#1088#1072#1089#1095#1077#1090
          #1074#1089#1077)
        TabOrder = 0
        Transparent = True
      end
      object neProcentV: TRzNumericEdit
        Left = 224
        Top = 208
        Width = 65
        Height = 21
        FrameColor = 12164479
        FrameVisible = True
        TabOrder = 1
        IntegersOnly = False
        DisplayFormat = ',0.00;-,0.00'
      end
      object rgTip2: TRzRadioGroup
        Left = 8
        Top = 136
        Width = 281
        Height = 65
        Caption = #1042#1099#1073#1086#1088' '#1090#1080#1087#1072' '#1087#1083#1072#1085#1080#1088#1086#1074#1072#1085#1080#1103
        ItemFrameColor = 8409372
        ItemHotTrack = True
        ItemHighlightColor = 2203937
        ItemHotTrackColor = 3983359
        ItemIndex = 0
        Items.Strings = (
          #1087#1086' '#1087#1088#1086#1094#1077#1085#1090#1091
          #1087#1086' '#1090#1072#1088#1080#1092#1091)
        TabOrder = 2
        Transparent = True
        OnClick = rgTip2Click
      end
    end
    object TabStok: TRzTabSheet
      Color = 16119543
      Caption = #1042#1086#1076#1086#1086#1090#1074#1077#1076#1077#1085#1080#1077
      object RzLabel3: TRzLabel
        Left = 8
        Top = 211
        Width = 210
        Height = 13
        Caption = #1042#1074#1077#1076#1080#1090#1077' '#1087#1088#1086#1094#1077#1085#1090' '#1080#1079#1084#1077#1085#1077#1085#1080#1103' '#1085#1072#1095#1080#1089#1083#1077#1085#1080#1103':'
      end
      object rgStok: TRzRadioGroup
        Left = 8
        Top = 8
        Width = 281
        Height = 125
        Caption = #1042#1099#1073#1086#1088' '#1090#1080#1087#1072' '#1092#1080#1085#1072#1085#1089#1080#1088#1086#1074#1072#1085#1080#1103' '#1086#1088#1075#1072#1085#1080#1079#1072#1094#1080#1081
        ItemFrameColor = 8409372
        ItemHotTrack = True
        ItemHighlightColor = 2203937
        ItemHotTrackColor = 3983359
        ItemIndex = 0
        Items.Strings = (
          #1085#1077' '#1086#1090#1073#1080#1088#1072#1090#1100
          #1084#1077#1089#1090#1085#1099#1081' '#1073#1102#1076#1078#1077#1090
          #1073#1102#1076#1078#1077#1090' ('#1074#1089#1077')'
          #1093#1086#1079#1088#1072#1089#1095#1077#1090
          #1074#1089#1077)
        TabOrder = 0
        Transparent = True
      end
      object neProcentK: TRzNumericEdit
        Left = 224
        Top = 208
        Width = 65
        Height = 21
        FrameColor = 12164479
        FrameVisible = True
        TabOrder = 1
        IntegersOnly = False
        DisplayFormat = ',0.00;-,0.00'
      end
      object rgTip3: TRzRadioGroup
        Left = 8
        Top = 136
        Width = 281
        Height = 65
        Caption = #1042#1099#1073#1086#1088' '#1090#1080#1087#1072' '#1087#1083#1072#1085#1080#1088#1086#1074#1072#1085#1080#1103
        ItemFrameColor = 8409372
        ItemHotTrack = True
        ItemHighlightColor = 2203937
        ItemHotTrackColor = 3983359
        ItemIndex = 0
        Items.Strings = (
          #1087#1086' '#1087#1088#1086#1094#1077#1085#1090#1091
          #1087#1086' '#1090#1072#1088#1080#1092#1091)
        TabOrder = 2
        Transparent = True
        OnClick = rgTip3Click
      end
    end
    object TabGarbage: TRzTabSheet
      Color = 16119543
      Caption = #1042#1099#1074#1086#1079' '#1084#1091#1089#1086#1088#1072
      object RzLabel4: TRzLabel
        Left = 8
        Top = 211
        Width = 210
        Height = 13
        Caption = #1042#1074#1077#1076#1080#1090#1077' '#1087#1088#1086#1094#1077#1085#1090' '#1080#1079#1084#1077#1085#1077#1085#1080#1103' '#1085#1072#1095#1080#1089#1083#1077#1085#1080#1103':'
      end
      object rgGarbage: TRzRadioGroup
        Left = 8
        Top = 8
        Width = 281
        Height = 125
        Caption = #1042#1099#1073#1086#1088' '#1090#1080#1087#1072' '#1092#1080#1085#1072#1085#1089#1080#1088#1086#1074#1072#1085#1080#1103' '#1086#1088#1075#1072#1085#1080#1079#1072#1094#1080#1081
        ItemFrameColor = 8409372
        ItemHotTrack = True
        ItemHighlightColor = 2203937
        ItemHotTrackColor = 3983359
        ItemIndex = 0
        Items.Strings = (
          #1085#1077' '#1086#1090#1073#1080#1088#1072#1090#1100
          #1084#1077#1089#1090#1085#1099#1081' '#1073#1102#1076#1078#1077#1090
          #1073#1102#1076#1078#1077#1090' ('#1074#1089#1077')'
          #1093#1086#1079#1088#1072#1089#1095#1077#1090
          #1074#1089#1077)
        TabOrder = 0
        Transparent = True
      end
      object neProcentG: TRzNumericEdit
        Left = 224
        Top = 208
        Width = 65
        Height = 21
        FrameColor = 12164479
        FrameVisible = True
        TabOrder = 1
        IntegersOnly = False
        DisplayFormat = ',0.00;-,0.00'
      end
      object rgTip4: TRzRadioGroup
        Left = 8
        Top = 136
        Width = 281
        Height = 65
        Caption = #1042#1099#1073#1086#1088' '#1090#1080#1087#1072' '#1087#1083#1072#1085#1080#1088#1086#1074#1072#1085#1080#1103
        ItemFrameColor = 8409372
        ItemHotTrack = True
        ItemHighlightColor = 2203937
        ItemHotTrackColor = 3983359
        ItemIndex = 0
        Items.Strings = (
          #1087#1086' '#1087#1088#1086#1094#1077#1085#1090#1091
          #1087#1086' '#1090#1072#1088#1080#1092#1091)
        TabOrder = 2
        Transparent = True
        OnClick = rgTip3Click
      end
    end
  end
  object MQuery: TMSSQL
    Connection = DM.Conect
    CommandTimeout = 0
    Left = 336
    Top = 136
  end
end

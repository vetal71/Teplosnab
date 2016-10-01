object FmeCalcIdxOrg: TFmeCalcIdxOrg
  Left = 0
  Top = 0
  Width = 876
  Height = 564
  TabOrder = 0
  TabStop = True
  OnEnter = FrameEnter
  object lblCaption: TRzLabel
    Left = 0
    Top = 0
    Width = 876
    Height = 30
    Align = alTop
    Alignment = taCenter
    AutoSize = False
    Caption = #1048#1085#1076#1077#1082#1089#1072#1094#1080#1103' '#1087#1086' '#1086#1088#1075#1072#1085#1080#1079#1072#1094#1080#1103#1084' '#1079#1072
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
    Width = 876
    Height = 26
    object TBXToolbar2: TTBXToolbar
      Left = 0
      Top = 0
      Caption = 'TBXToolbar1'
      ChevronHint = #1044#1086#1087#1086#1083#1085#1080#1090#1077#1083#1100#1085#1086'|'
      Images = FrmMain.ImageList1
      TabOrder = 0
      object IdxOrg: TTBXItem
        Caption = #1042#1074#1086#1076' '#1080#1085#1076#1077#1082#1089#1072#1094#1080#1080
        DisplayMode = nbdmImageAndText
        ImageIndex = 2
        Layout = tbxlGlyphLeft
        OnClick = IdxOrgClick
      end
      object TBXSeparatorItem1: TTBXSeparatorItem
      end
      object Filter: TTBXItem
        Caption = #1060#1080#1083#1100#1090#1088
        DisplayMode = nbdmImageAndText
        ImageIndex = 4
        Stretch = True
        OnClick = FilterClick
      end
      object TBXSeparatorItem6: TTBXSeparatorItem
      end
      object TBControlItem1: TTBControlItem
        Control = cboTipOrg
      end
      object TBXSeparatorItem4: TTBXSeparatorItem
      end
      object DelFilter: TTBXItem
        Caption = #1059#1073#1088#1072#1090#1100' '#1092#1080#1083#1100#1090#1088
        DisplayMode = nbdmImageAndText
        ImageIndex = 3
        OnClick = DelFilterClick
      end
      object TBXSeparatorItem3: TTBXSeparatorItem
      end
      object ReceiveMail: TTBXItem
        Caption = #1055#1086#1083#1091#1095#1080#1090#1100
        DisplayMode = nbdmImageAndText
        ImageIndex = 222
        Stretch = True
        OnClick = ReceiveMailClick
      end
      object TBXSeparatorItem5: TTBXSeparatorItem
      end
      object Load: TTBXItem
        Caption = #1047#1072#1075#1088#1091#1079#1080#1090#1100
        DisplayMode = nbdmImageAndText
        ImageIndex = 73
        OnClick = LoadClick
      end
      object Clear: TTBXItem
        Caption = #1054#1095#1080#1089#1090#1080#1090#1100
        DisplayMode = nbdmImageAndText
        ImageIndex = 66
        OnClick = ClearClick
      end
      object TBXSeparatorItem2: TTBXSeparatorItem
      end
      object TBXItem1: TTBXItem
        Caption = #1042#1099#1093#1086#1076
        DisplayMode = nbdmImageAndText
        ImageIndex = 135
        Stretch = True
        OnClick = TBXItem1Click
      end
      object cboTipOrg: TRzComboBox
        Left = 192
        Top = 0
        Width = 133
        Height = 21
        Hint = #1042#1099#1073#1088#1072#1090#1100' '#1091#1089#1083#1086#1074#1080#1077' '#1092#1080#1083#1100#1090#1088#1072
        Style = csDropDownList
        Ctl3D = False
        Enabled = False
        FlatButtons = True
        FrameColor = 12164479
        FrameVisible = True
        ItemHeight = 13
        ParentCtl3D = False
        TabOrder = 0
        OnChange = cboTipOrgChange
        Items.Strings = (
          #1041#1102#1076#1078#1077#1090#1085#1099#1077
          #1061#1086#1079#1088#1072#1089#1095#1077#1090#1085#1099#1077
          #1046#1057#1050
          #1046#1057#1050' ('#1040#1082#1072#1076#1077#1084#1080#1103')')
      end
    end
  end
  object RzPanel1: TRzPanel
    Left = 0
    Top = 56
    Width = 876
    Height = 508
    Align = alClient
    BorderOuter = fsFlatRounded
    TabOrder = 1
    object pgcMain: TRzPageControl
      Left = 2
      Top = 2
      Width = 872
      Height = 504
      ActivePage = TabVk
      Align = alClient
      Color = 16119543
      FlatColor = 10263441
      HotTrackColor = 3983359
      ParentColor = False
      TabColors.HighlightBar = 3983359
      TabIndex = 1
      TabOrder = 0
      FixedDimension = 19
      object TabOt: TRzTabSheet
        Color = 16119543
        Caption = #1058#1077#1087#1083#1086#1089#1085#1072#1073#1078#1077#1085#1080#1077
        object dbgOrg: TDBGridEh
          Left = 0
          Top = 0
          Width = 868
          Height = 481
          Align = alClient
          DataGrouping.GroupLevels = <>
          DataSource = DM.dsCalcIdxOrg
          Flat = True
          FooterColor = clWindow
          FooterFont.Charset = DEFAULT_CHARSET
          FooterFont.Color = clWindowText
          FooterFont.Height = -11
          FooterFont.Name = 'Tahoma'
          FooterFont.Style = []
          IndicatorOptions = [gioShowRowIndicatorEh]
          Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
          OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection, dghIncSearch, dghPreferIncSearch, dghDialogFind, dghColumnResize, dghColumnMove, dghExtendVertLines]
          TabOrder = 0
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'Tahoma'
          TitleFont.Style = []
          UseMultiTitle = True
          VTitleMargin = 5
          OnDblClick = IdxOrgClick
          Columns = <
            item
              EditButtons = <>
              FieldName = 'nazv'
              Footers = <>
              Title.Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#1086#1088#1075#1072#1085#1080#1079#1072#1094#1080#1080
              Width = 200
            end
            item
              EditButtons = <>
              FieldName = 's_symidx'
              Footers = <>
              Title.Caption = #1058#1077#1087#1083#1086#1074#1072#1103' '#1101#1085#1077#1088#1075#1080#1103'|'#1057#1091#1084#1084#1072' '#1080#1085#1076#1077#1082#1089#1072#1094#1080#1080', '#1088#1091#1073
              Width = 206
            end
            item
              EditButtons = <>
              FieldName = 's_ndsidx'
              Footers = <>
              Title.Caption = #1058#1077#1087#1083#1086#1074#1072#1103' '#1101#1085#1077#1088#1075#1080#1103'|'#1053#1044#1057' '#1080#1085#1076#1077#1082#1089#1072#1094#1080#1080', '#1088#1091#1073
              Width = 224
            end>
          object RowDetailData: TRowDetailPanelControlEh
          end
        end
      end
      object TabVk: TRzTabSheet
        Color = 16119543
        Caption = #1042#1086#1076#1086#1089#1085#1072#1073#1078#1077#1085#1080#1077' '#1080' '#1074#1086#1076#1086#1086#1090#1074#1077#1076#1077#1085#1080#1077
        object DBGridEh1: TDBGridEh
          Left = 0
          Top = 0
          Width = 868
          Height = 481
          Align = alClient
          DataGrouping.GroupLevels = <>
          DataSource = DM.dsCalcIdxOrg
          Flat = True
          FooterColor = clWindow
          FooterFont.Charset = DEFAULT_CHARSET
          FooterFont.Color = clWindowText
          FooterFont.Height = -11
          FooterFont.Name = 'Tahoma'
          FooterFont.Style = []
          IndicatorOptions = [gioShowRowIndicatorEh]
          Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
          OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection, dghIncSearch, dghPreferIncSearch, dghDialogFind, dghColumnResize, dghColumnMove, dghExtendVertLines]
          TabOrder = 0
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'Tahoma'
          TitleFont.Style = []
          UseMultiTitle = True
          VTitleMargin = 5
          OnDblClick = IdxOrgClick
          Columns = <
            item
              EditButtons = <>
              FieldName = 'nazv'
              Footers = <>
              Title.Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#1086#1088#1075#1072#1085#1080#1079#1072#1094#1080#1080
              Width = 200
            end
            item
              EditButtons = <>
              FieldName = 's_symidxv'
              Footers = <>
              Title.Caption = #1042#1086#1076#1086#1089#1085#1072#1073#1078#1077#1085#1080#1077'|'#1057#1091#1084#1084#1072' '#1080#1085#1076#1077#1082#1089#1072#1094#1080#1080', '#1088#1091#1073
              Width = 150
            end
            item
              EditButtons = <>
              FieldName = 's_ndsidxv'
              Footers = <>
              Title.Caption = #1042#1086#1076#1086#1089#1085#1072#1073#1078#1077#1085#1080#1077'|'#1053#1044#1057' '#1080#1085#1076#1077#1082#1089#1072#1094#1080#1080', '#1088#1091#1073
              Width = 150
            end
            item
              EditButtons = <>
              FieldName = 's_symidxk'
              Footers = <>
              Title.Caption = #1042#1086#1076#1086#1086#1090#1074#1077#1076#1077#1085#1080#1077'|'#1057#1091#1084#1084#1072' '#1080#1085#1076#1077#1082#1089#1072#1094#1080#1080', '#1088#1091#1073
              Width = 150
            end
            item
              EditButtons = <>
              FieldName = 's_ndsidxk'
              Footers = <>
              Title.Caption = #1042#1086#1076#1086#1086#1090#1074#1077#1076#1077#1085#1080#1077'|'#1053#1044#1057' '#1080#1085#1076#1077#1082#1089#1072#1094#1080#1080', '#1088#1091#1073
              Width = 150
            end>
          object RowDetailData: TRowDetailPanelControlEh
          end
        end
      end
    end
  end
  object MQuery: TMSSQL
    Connection = DM.Conect
    SQL.Strings = (
      'EXECUTE sp_calc_org_idx :kod,:data')
    CommandTimeout = 0
    Left = 379
    Top = 159
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'kod'
      end
      item
        DataType = ftDateTime
        Name = 'data'
        ParamType = ptInput
      end>
  end
end

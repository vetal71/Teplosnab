object FrmRezCalcObekt: TFrmRezCalcObekt
  Left = 255
  Top = 151
  Width = 814
  Height = 540
  Caption = 'FrmRezCalcObekt'
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
  object lblCaption: TRzLabel
    Left = 0
    Top = 0
    Width = 806
    Height = 30
    Align = alTop
    Alignment = taCenter
    AutoSize = False
    Caption = #1056#1077#1079#1091#1083#1100#1090#1072#1090#1099' '#1087#1086' '#1086#1073#1098#1077#1082#1090#1072#1084
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
    TextStyle = tsRaised
  end
  object RzPanel1: TRzPanel
    Left = 0
    Top = 66
    Width = 806
    Height = 418
    Align = alClient
    BorderOuter = fsFlatRounded
    TabOrder = 0
    object dbgObekt: TDBGridEh
      Left = 2
      Top = 2
      Width = 802
      Height = 414
      Align = alClient
      DataGrouping.GroupLevels = <>
      DataSource = DM.dsRezCalcObk
      Flat = True
      FooterColor = 12713213
      FooterFont.Charset = DEFAULT_CHARSET
      FooterFont.Color = clWindowText
      FooterFont.Height = -11
      FooterFont.Name = 'MS Sans Serif'
      FooterFont.Style = []
      FooterRowCount = 3
      IndicatorOptions = [gioShowRowIndicatorEh]
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
      PopupMenu = pmObekt
      RowDetailPanel.Color = clBtnFace
      SumList.Active = True
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      UseMultiTitle = True
      OnCellClick = dbgObektCellClick
      OnDblClick = BtnEditObkClick
      OnKeyDown = dbgObektKeyDown
      OnKeyUp = dbgObektKeyDown
      Columns = <
        item
          EditButtons = <>
          FieldName = 'nzv_obk'
          Footer.FieldName = 'nazv_org'
          Footer.ValueType = fvtFieldValue
          Footers = <
            item
              FieldName = 'nazv_org'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -9
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ValueType = fvtFieldValue
            end
            item
              Value = #1053#1072#1095#1080#1089#1083#1077#1085#1086' '#1089' '#1053#1044#1057
              ValueType = fvtStaticText
            end
            item
              Value = #1054#1090#1087#1091#1097#1077#1085#1086' '#1090#1077#1087#1083#1086#1074#1086#1081' '#1101#1085#1077#1088#1075#1080#1080
              ValueType = fvtStaticText
            end>
          Title.Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#1086#1073#1098#1077#1082#1090#1072
          Width = 200
        end
        item
          EditButtons = <>
          FieldName = 's_gkt'
          Footer.ValueType = fvtSum
          Footers = <
            item
            end
            item
            end
            item
              ValueType = fvtSum
            end>
          Title.Caption = #1043#1082#1072#1083', '#1086#1090#1086#1087#1083#1077#1085#1080#1077
          Width = 70
        end
        item
          EditButtons = <>
          FieldName = 's_gkv'
          Footer.ValueType = fvtSum
          Footers = <
            item
            end
            item
            end
            item
              ValueType = fvtSum
            end>
          Title.Caption = #1043#1082#1083#1072', '#1043#1042#1057
          Width = 70
        end
        item
          DisplayFormat = ',0'
          EditButtons = <>
          FieldName = 's_symt'
          Footers = <
            item
            end
            item
              DisplayFormat = ',0'
              FieldName = 's_symk'
              ValueType = fvtSum
            end
            item
            end>
          Title.Caption = #1057#1091#1084#1084#1072' '#1073#1077#1079' '#1053#1044#1057', '#1086#1090#1086#1087#1083#1077#1085#1080#1077
          Width = 72
        end
        item
          DisplayFormat = ',0'
          EditButtons = <>
          FieldName = 's_symv'
          Footers = <
            item
            end
            item
              DisplayFormat = ',0'
              FieldName = 's_symgv'
              ValueType = fvtSum
            end
            item
            end>
          Title.Caption = #1057#1091#1084#1084#1072' '#1073#1077#1079' '#1053#1044#1057', '#1043#1042#1057
          Width = 70
        end
        item
          DisplayFormat = ',0'
          EditButtons = <>
          FieldName = 's_pert'
          Footers = <
            item
            end
            item
              DisplayFormat = ',0'
              ValueType = fvtSum
            end
            item
            end>
          Title.Caption = #1057#1091#1084#1084#1072' '#1087#1077#1088#1077#1088#1072#1089#1095#1077#1090#1072' '#1089' '#1053#1044#1057', '#1086#1090#1086#1087#1083#1077#1085#1080#1077' '
          Width = 70
        end
        item
          DisplayFormat = ',0'
          EditButtons = <>
          FieldName = 's_perv'
          Footers = <
            item
            end
            item
              DisplayFormat = ',0'
              ValueType = fvtSum
            end
            item
            end>
          Title.Caption = #1057#1091#1084#1084#1072' '#1087#1077#1088#1077#1088#1072#1089#1095#1077#1090#1072' '#1089' '#1053#1044#1057', '#1043#1042#1057
          Width = 70
        end
        item
          EditButtons = <>
          FieldName = 's_pgkt'
          Footers = <
            item
            end
            item
            end
            item
              ValueType = fvtSum
            end>
          Title.Caption = #1055#1077#1088#1077#1088#1072#1089#1095#1077#1090' '#1043#1082#1072#1083', '#1086#1090#1086#1087#1083#1077#1085#1080#1077
          Width = 70
        end
        item
          EditButtons = <>
          FieldName = 's_pgkv'
          Footers = <
            item
            end
            item
            end
            item
              ValueType = fvtSum
            end>
          Title.Caption = #1055#1077#1088#1077#1088#1072#1089#1095#1077#1090' '#1043#1082#1072#1083', '#1043#1042#1057
          Width = 70
        end>
      object RowDetailData: TRowDetailPanelControlEh
      end
    end
  end
  object TBXDock1: TTBXDock
    Left = 0
    Top = 30
    Width = 806
    Height = 36
    object TBXToolbar1: TTBXToolbar
      Left = 0
      Top = 0
      Caption = 'TBXToolbar1'
      ChevronHint = #1044#1086#1087#1086#1083#1085#1080#1090#1077#1083#1100#1085#1086'|'
      Images = FrmMain.ImageList1
      TabOrder = 0
      object DanObk: TTBXItem
        Caption = #1044#1072#1085#1085#1099#1077' '#1087#1086' '#13#10#1086#1073#1098#1077#1082#1090#1091
        DisplayMode = nbdmImageAndText
        ImageIndex = 2
        Layout = tbxlGlyphLeft
        OnClick = BtnDanObkClick
      end
      object CalcObk: TTBXSubmenuItem
        Caption = #1056#1072#1089#1095#1077#1090#1099' '#13#10#1087#1086' '#1086#1073#1098#1077#1082#1090#1091
        DisplayMode = nbdmImageAndText
        DropdownCombo = True
        ImageIndex = 56
        object EditNacobk: TTBXItem
          Caption = #1074#1074#1086#1076' '#1085#1072#1095#1080#1089#1083#1077#1085#1080#1103
          ImageIndex = 0
          OnClick = BtnEditObkClick
        end
        object TBXSeparatorItem1: TTBXSeparatorItem
        end
        object KorOtObk: TTBXItem
          Caption = #1082#1086#1088#1088#1077#1082#1090#1080#1088#1086#1074#1082#1072' '#1087#1086' '#1076#1085#1103#1084' '#1086#1090#1086#1087#1083#1077#1085#1080#1103
          ImageIndex = 133
          OnClick = KorOtObkClick
        end
        object KorGvsObk: TTBXItem
          Caption = #1082#1086#1088#1088#1077#1082#1090#1080#1088#1086#1074#1082#1072' '#1087#1086' '#1076#1085#1103#1084' '#1043#1042#1057
          ImageIndex = 132
          OnClick = KorGvsObkClick
        end
        object TBXSeparatorItem2: TTBXSeparatorItem
        end
        object EditPerObk: TTBXItem
          Caption = #1074#1074#1086#1076' '#1087#1077#1088#1077#1088#1072#1089#1095#1077#1090#1086#1074
          ImageIndex = 131
          OnClick = EditPerObkClick
        end
      end
      object TBXSeparatorItem5: TTBXSeparatorItem
      end
      object Filter: TTBXItem
        Caption = #1060#1080#1083#1100#1090#1088#13#10#1086#1073#1098#1077#1082#1090#1086#1074
        DisplayMode = nbdmImageAndText
        ImageIndex = 4
        OnClick = FilterClick
      end
      object TBXSeparatorItem6: TTBXSeparatorItem
      end
      object TBControlItem1: TTBControlItem
        Control = lcbFilter
      end
      object TBXSeparatorItem4: TTBXSeparatorItem
      end
      object DelFilter: TTBXItem
        Caption = #1059#1073#1088#1072#1090#1100' '#13#10#1092#1080#1083#1100#1090#1088
        DisplayMode = nbdmImageAndText
        ImageIndex = 3
        OnClick = DelFilterClick
      end
      object Print: TTBXSubmenuItem
        Caption = #1055#1077#1095#1072#1090#1100' '#13#10#1086#1090#1095#1077#1090#1086#1074
        DisplayMode = nbdmImageAndText
        DropdownCombo = True
        ImageIndex = 7
        object PrintLic: TTBXItem
          Caption = #1051#1080#1094#1077#1074#1086#1081' '#1089#1095#1077#1090' '#1086#1073#1098#1077#1082#1090#1072
          ImageIndex = 7
          OnClick = PrintLicClick
        end
        object PrintRez: TTBXItem
          Caption = #1056#1077#1079#1091#1083#1100#1090#1072#1090#1099' '#1085#1072#1095#1080#1089#1083#1077#1085#1080#1103
          ImageIndex = 7
          OnClick = PrintRezClick
        end
      end
      object ChangePeriod: TTBXItem
        Caption = #1057#1084#1077#1085#1080#1090#1100#13#10#1087#1077#1088#1080#1086#1076
        DisplayMode = nbdmImageAndText
        ImageIndex = 16
        OnClick = ChangePeriodClick
      end
      object ReturnPeriod: TTBXItem
        Caption = #1042#1077#1088#1085#1091#1090#1100#13#10#1087#1077#1088#1080#1086#1076
        DisplayMode = nbdmImageAndText
        ImageIndex = 18
        OnClick = ReturnPeriodClick
      end
      object History: TTBXItem
        Caption = #1048#1089#1090#1086#1088#1080#1103#13#10#1086#1073#1098#1077#1082#1090#1072
        DisplayMode = nbdmImageAndText
        Hint = #1048#1089#1090#1086#1088#1080#1103' '#1086#1073#1098#1077#1082#1090#1072
        ImageIndex = 10
        OnClick = HistoryClick
      end
      object lcbFilter: TRzDBLookupComboBox
        Left = 271
        Top = 5
        Width = 200
        Height = 21
        Ctl3D = False
        DropDownRows = 15
        KeyField = 'kodorg'
        ListField = 'nazv'
        ListSource = DM.dsOrgKot
        ParentCtl3D = False
        TabOrder = 0
        OnCloseUp = lcbFilterCloseUp
        FlatButtons = True
        FrameColor = 12164479
        FrameVisible = True
      end
    end
  end
  object sb: TTBXStatusBar
    Left = 0
    Top = 484
    Width = 806
    Panels = <
      item
        Caption = #1057#1086#1089#1090#1086#1103#1085#1080#1077' '#1086#1073#1098#1077#1082#1090#1072
        MaxSize = 900
        Size = 500
        StretchPriority = 100
        Tag = 0
        TextTruncation = twEndEllipsis
      end>
    UseSystemFont = False
  end
  object MQuery: TMSSQL
    Connection = DM.Conect
    SQL.Strings = (
      'EXECUTE sp_calc_obk :data'
      'EXECUTE sp_calc_org :data')
    CommandTimeout = 0
    Left = 147
    Top = 191
    ParamData = <
      item
        DataType = ftDateTime
        Name = 'data'
        ParamType = ptInput
      end
      item
        DataType = ftDateTime
        Name = 'data'
        ParamType = ptInput
      end>
  end
  object pmObekt: TTBXPopupMenu
    Images = FrmMain.ImageList1
    LinkSubitems = CalcObk
    Left = 120
    Top = 191
  end
end

object FrmRezCalcNas: TFrmRezCalcNas
  Left = 257
  Top = 149
  Width = 728
  Height = 559
  Caption = #1059#1095#1072#1089#1090#1086#1082
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
  object lblCaption: TRzLabel
    Left = 0
    Top = 0
    Width = 720
    Height = 30
    Align = alTop
    Alignment = taCenter
    AutoSize = False
    Caption = #1056#1077#1079#1091#1083#1100#1090#1072#1090#1099' '#1087#1086' '#1085#1072#1089#1077#1083#1077#1085#1080#1102
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
  object TBXDock1: TTBXDock
    Left = 0
    Top = 30
    Width = 720
    Height = 36
    object TBXToolbar1: TTBXToolbar
      Left = 0
      Top = 0
      Caption = 'TBXToolbar1'
      ChevronHint = #1044#1086#1087#1086#1083#1085#1080#1090#1077#1083#1100#1085#1086'|'
      Images = FrmMain.ImageList1
      TabOrder = 0
      object DanNas: TTBXSubmenuItem
        Caption = #1044#1072#1085#1085#1099#1077
        DisplayMode = nbdmImageAndText
        DropdownCombo = True
        ImageIndex = 2
        Stretch = True
        OnClick = DanDomaClick
        object DanDoma: TTBXItem
          Caption = #1087#1086' '#1076#1086#1084#1091
          ImageIndex = 50
          OnClick = DanDomaClick
        end
        object DanKvart: TTBXItem
          Caption = #1087#1086' '#1082#1074#1072#1088#1090#1080#1088#1077
          ImageIndex = 51
          OnClick = DanKvartClick
        end
      end
      object CalcNas: TTBXSubmenuItem
        Caption = #1056#1072#1089#1095#1077#1090#1099' '
        DisplayMode = nbdmImageAndText
        DropdownCombo = True
        ImageIndex = 56
        Stretch = True
        object EditNac: TTBXItem
          Caption = #1074#1074#1086#1076' '#1085#1072#1095#1080#1089#1083#1077#1085#1080#1103
          ImageIndex = 0
          OnClick = EditNacClick
        end
        object TBXSeparatorItem1: TTBXSeparatorItem
        end
        object KorOtObk: TTBXItem
          Caption = #1082#1086#1088#1088#1077#1082#1090#1080#1088#1086#1074#1082#1072' '#1087#1086' '#1086#1090#1086#1087#1083#1077#1085#1080#1102
          ImageIndex = 133
          OnClick = KorOtObkClick
        end
        object KorGvsObk: TTBXItem
          Caption = #1082#1086#1088#1088#1077#1082#1090#1080#1088#1086#1074#1082#1072' '#1087#1086' '#1043#1042#1057
          ImageIndex = 132
          OnClick = KorGvsObkClick
        end
      end
      object TBXSeparatorItem5: TTBXSeparatorItem
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
          Caption = #1051#1080#1094#1077#1074#1086#1081' '#1089#1095#1077#1090' '#1076#1086#1084#1072
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
      object lcbFilter: TRzDBLookupComboBox
        Left = 243
        Top = 5
        Width = 172
        Height = 21
        Ctl3D = False
        DragKind = dkDock
        DropDownRows = 15
        KeyField = 'kodul'
        ListField = 'nazvul'
        ListSource = DM.dsUlKot
        ParentCtl3D = False
        TabOrder = 0
        OnCloseUp = lcbFilterCloseUp
        FlatButtons = True
        FrameColor = 12164479
        FrameVisible = True
      end
    end
  end
  object RzPanel1: TRzPanel
    Left = 0
    Top = 66
    Width = 720
    Height = 459
    Align = alClient
    BorderOuter = fsFlatRounded
    TabOrder = 1
    object Splitter1: TSplitter
      Left = 2
      Top = 221
      Width = 716
      Height = 3
      Cursor = crVSplit
      Align = alTop
    end
    object RzPanel2: TRzPanel
      Left = 2
      Top = 2
      Width = 716
      Height = 219
      Align = alTop
      BorderOuter = fsFlatRounded
      TabOrder = 0
      object dbgDoma: TDBGridEh
        Left = 2
        Top = 2
        Width = 712
        Height = 215
        Align = alClient
        DataGrouping.GroupLevels = <>
        DataSource = DM.dsRezCalcNas
        Flat = True
        FooterColor = 12713213
        FooterFont.Charset = DEFAULT_CHARSET
        FooterFont.Color = clWindowText
        FooterFont.Height = -11
        FooterFont.Name = 'MS Sans Serif'
        FooterFont.Style = []
        FooterRowCount = 1
        IndicatorOptions = [gioShowRowIndicatorEh]
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
        OptionsEh = [dghFixed3D, dghFooter3D, dghHighlightFocus, dghClearSelection, dghDialogFind, dghColumnResize, dghColumnMove]
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
        Columns = <
          item
            EditButtons = <>
            FieldName = 'koddom'
            Footers = <>
            Title.Caption = #1050#1086#1076
            Width = 60
          end
          item
            EditButtons = <>
            FieldName = 'adres'
            Footer.Font.Charset = DEFAULT_CHARSET
            Footer.Font.Color = clWindowText
            Footer.Font.Height = -11
            Footer.Font.Name = 'MS Sans Serif'
            Footer.Font.Style = [fsBold]
            Footer.Value = #1042#1089#1077#1075#1086' '#1085#1072#1095#1080#1089#1083#1077#1085#1086
            Footer.ValueType = fvtStaticText
            Footers = <>
            Title.Caption = #1040#1076#1088#1077#1089
            Width = 400
          end
          item
            EditButtons = <>
            FieldName = 's_gkt'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #1043#1082#1072#1083', '#1086#1090#1086#1087#1083#1077#1085#1080#1077
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 's_gkv'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #1043#1082#1072#1083', '#1043#1042#1057
            Width = 80
          end>
        object RowDetailData: TRowDetailPanelControlEh
        end
      end
    end
    object RzPanel3: TRzPanel
      Left = 2
      Top = 224
      Width = 716
      Height = 211
      Align = alClient
      BorderOuter = fsFlatRounded
      TabOrder = 1
      object dbgKvart: TDBGridEh
        Left = 2
        Top = 2
        Width = 712
        Height = 207
        Align = alClient
        DataGrouping.GroupLevels = <>
        DataSource = DM.dsRezCalcKvart
        Flat = True
        FooterColor = 12713213
        FooterFont.Charset = DEFAULT_CHARSET
        FooterFont.Color = clWindowText
        FooterFont.Height = -11
        FooterFont.Name = 'MS Sans Serif'
        FooterFont.Style = []
        FooterRowCount = 1
        IndicatorOptions = [gioShowRowIndicatorEh]
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
        OptionsEh = [dghFixed3D, dghFooter3D, dghHighlightFocus, dghClearSelection, dghDialogFind, dghColumnResize, dghColumnMove]
        RowDetailPanel.Color = clBtnFace
        SumList.Active = True
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        Columns = <
          item
            EditButtons = <>
            FieldName = 'kodkv'
            Footers = <>
            Title.Alignment = taCenter
            Title.Caption = #1050#1086#1076
            Width = 60
          end
          item
            EditButtons = <>
            FieldName = 'kv'
            Footer.Font.Charset = DEFAULT_CHARSET
            Footer.Font.Color = clWindowText
            Footer.Font.Height = -11
            Footer.Font.Name = 'MS Sans Serif'
            Footer.Font.Style = [fsBold]
            Footer.Value = #1055#1086' '#1076#1086#1084#1091
            Footer.ValueType = fvtStaticText
            Footers = <>
            Title.Alignment = taCenter
            Title.Caption = #1053#1086#1084#1077#1088' '#1082#1074#1072#1088#1090#1080#1088#1099
            Width = 100
          end
          item
            EditButtons = <>
            FieldName = 's_gkt'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Alignment = taCenter
            Title.Caption = #1043#1082#1083#1072', '#1086#1090#1086#1087#1083#1077#1085#1080#1077
            Width = 100
          end
          item
            EditButtons = <>
            FieldName = 's_gkv'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Alignment = taCenter
            Title.Caption = #1043#1082#1072#1083', '#1043#1042#1057
            Width = 100
          end>
        object RowDetailData: TRowDetailPanelControlEh
        end
      end
    end
    object sb: TTBXStatusBar
      Left = 2
      Top = 435
      Width = 716
      Panels = <
        item
          Caption = #1057#1086#1089#1090#1086#1103#1085#1080#1077' '#1086#1073#1098#1077#1082#1090#1072
          MaxSize = 800
          Size = 100
          StretchPriority = 100
          Tag = 0
          TextTruncation = twEndEllipsis
        end>
      UseSystemFont = False
    end
  end
  object pmObekt: TTBXPopupMenu
    Images = FrmMain.ImageList1
    LinkSubitems = CalcNas
    Left = 160
    Top = 239
  end
  object MQuery: TMSSQL
    Connection = DM.Conect
    SQL.Strings = (
      'EXECUTE sp_calc_kv :data'
      'EXECUTE sp_calc_kv_dom :data'
      'EXECUTE sp_calc_kv_obk :data'
      'EXECUTE sp_calc_obk :data'
      'EXECUTE sp_calc_org :data')
    CommandTimeout = 0
    Left = 188
    Top = 239
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
      end
      item
        DataType = ftDateTime
        Name = 'data'
        ParamType = ptInput
      end
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
end

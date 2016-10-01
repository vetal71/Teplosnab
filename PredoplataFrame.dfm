object FrmPredoplata: TFrmPredoplata
  Left = 0
  Top = 0
  Width = 994
  Height = 673
  TabOrder = 0
  TabStop = True
  object lblCaption: TRzLabel
    Left = 0
    Top = 0
    Width = 994
    Height = 30
    Align = alTop
    Alignment = taCenter
    AutoSize = False
    Caption = #1055#1088#1077#1076#1086#1087#1083#1072#1090#1072' '#1087#1086' '#1086#1088#1075#1072#1085#1080#1079#1072#1094#1080#1103#1084
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
    Width = 994
    Height = 36
    object TBXToolbar2: TTBXToolbar
      Left = 0
      Top = 0
      Caption = 'TBXToolbar1'
      ChevronHint = #1044#1086#1087#1086#1083#1085#1080#1090#1077#1083#1100#1085#1086'|'
      Images = FrmMain.ImageList1
      TabOrder = 0
      object TBXItem2: TTBXItem
        Caption = #1054#1073#1085#1086#1074#1080#1090#1100
        DisplayMode = nbdmImageAndText
        ImageIndex = 115
        Stretch = True
        OnClick = TBXItem2Click
      end
      object TBXSeparatorItem3: TTBXSeparatorItem
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
        Caption = #1059#1073#1088#1072#1090#1100' '#13#10#1092#1080#1083#1100#1090#1088
        DisplayMode = nbdmImageAndText
        ImageIndex = 3
        OnClick = DelFilterClick
      end
      object TBXSeparatorItem1: TTBXSeparatorItem
      end
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
      object cboTipOrg: TRzComboBox
        Left = 154
        Top = 5
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
      object cboMonth: TRzComboBox
        Left = 441
        Top = 5
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
        TabOrder = 1
        OnChange = cboMonthChange
      end
    end
  end
  object RzPanel1: TRzPanel
    Left = 0
    Top = 66
    Width = 994
    Height = 607
    Align = alClient
    BorderOuter = fsFlatRounded
    TabOrder = 1
    object RzPanel2: TRzPanel
      Left = 2
      Top = 2
      Width = 990
      Height = 311
      Align = alTop
      BorderOuter = fsFlatRounded
      BorderSides = [sdLeft, sdTop, sdRight]
      TabOrder = 0
      object DBGridEh1: TDBGridEh
        Left = 2
        Top = 2
        Width = 986
        Height = 309
        Align = alClient
        DataGrouping.GroupLevels = <>
        DataSource = dsOrg
        Flat = True
        FooterColor = clWindow
        FooterFont.Charset = DEFAULT_CHARSET
        FooterFont.Color = clWindowText
        FooterFont.Height = -11
        FooterFont.Name = 'Tahoma'
        FooterFont.Style = []
        IndicatorOptions = [gioShowRowIndicatorEh]
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
        OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection, dghIncSearch, dghPreferIncSearch, dghDialogFind, dghColumnResize, dghColumnMove, dghExtendVertLines]
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
        UseMultiTitle = True
        VTitleMargin = 5
        Columns = <
          item
            EditButtons = <>
            FieldName = 'kodorg'
            Footers = <>
            Title.Caption = #1050#1086#1076
            Width = 60
          end
          item
            EditButtons = <>
            FieldName = 'nazv'
            Footers = <>
            Title.Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
            Width = 500
          end>
        object RowDetailData: TRowDetailPanelControlEh
        end
      end
    end
    object RzPanel3: TRzPanel
      Left = 2
      Top = 313
      Width = 990
      Height = 292
      Align = alClient
      BorderOuter = fsFlatRounded
      TabOrder = 1
      object dbgOrg: TDBGridEh
        Left = 2
        Top = 2
        Width = 986
        Height = 288
        Hint = #1042#1099#1073#1077#1088#1080#1090#1077' '#1082#1086#1083#1086#1085#1082#1091' '#1080' '#1080#1079#1084#1077#1085#1080#1090#1077' '#1087#1072#1088#1072#1084#1077#1090#1088
        Align = alClient
        DataGrouping.GroupLevels = <>
        DataSource = dsPredoplata
        Flat = True
        FooterColor = clWindow
        FooterFont.Charset = DEFAULT_CHARSET
        FooterFont.Color = clWindowText
        FooterFont.Height = -11
        FooterFont.Name = 'Tahoma'
        FooterFont.Style = []
        IndicatorOptions = [gioShowRowIndicatorEh]
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
        UseMultiTitle = True
        VTitleMargin = 5
        Columns = <
          item
            EditButtons = <>
            FieldName = #1053#1072#1095#1080#1089#1083#1077#1085#1086' '#1079#1072' '#1090#1077#1087#1083#1086
            Footers = <>
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = #1053#1072#1095#1080#1089#1083#1077#1085#1086' '#1079#1072' '#1074#1086#1076#1091
            Footers = <>
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = #1053#1072#1095#1080#1089#1083#1077#1085#1086' '#1079#1072' '#1089#1090#1086#1082#1080
            Footers = <>
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = #1053#1072#1095#1080#1089#1083#1077#1085#1086' '#1079#1072' '#1084#1091#1089#1086#1088
            Footers = <>
          end
          item
            EditButtons = <>
            FieldName = #1060#1080#1082#1089#1080#1088#1086#1074#1072#1085#1085#1072#1103' '#1089#1091#1084#1084#1072' '#1079#1072' '#1090#1077#1087#1083#1086
            Footers = <>
            Width = 90
            OnUpdateData = dbgOrgColumns3UpdateData
          end
          item
            EditButtons = <>
            FieldName = #1060#1080#1082#1089#1080#1088#1086#1074#1072#1085#1085#1072#1103' '#1089#1091#1084#1084#1072' '#1079#1072' '#1074#1086#1076#1091
            Footers = <>
            Width = 90
            OnUpdateData = dbgOrgColumns3UpdateData
          end
          item
            EditButtons = <>
            FieldName = #1060#1080#1082#1089#1080#1088#1086#1074#1072#1085#1085#1072#1103' '#1089#1091#1084#1084#1072' '#1079#1072' '#1089#1090#1086#1082#1080
            Footers = <>
            Width = 90
            OnUpdateData = dbgOrgColumns3UpdateData
          end
          item
            EditButtons = <>
            FieldName = #1060#1080#1082#1089#1080#1088#1086#1074#1072#1085#1085#1072#1103' '#1089#1091#1084#1084#1072' '#1079#1072' '#1084#1091#1089#1086#1088
            Footers = <>
          end
          item
            EditButtons = <>
            FieldName = '% '#1079#1072' '#1090#1077#1087#1083#1086
            Footers = <>
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = '% '#1079#1072' '#1074#1086#1076#1091
            Footers = <>
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = '% '#1079#1072' '#1089#1090#1086#1082#1080
            Footers = <>
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = '% '#1079#1072' '#1084#1091#1089#1086#1088
            Footers = <>
          end>
        object RowDetailData: TRowDetailPanelControlEh
        end
      end
    end
  end
  object qryPredoplata: TMSQuery
    Connection = DM.Conect
    SQL.Strings = (
      'select kodorg,'
      '  sum_t as ['#1053#1072#1095#1080#1089#1083#1077#1085#1086' '#1079#1072' '#1090#1077#1087#1083#1086'],'
      '  sum_v as ['#1053#1072#1095#1080#1089#1083#1077#1085#1086' '#1079#1072' '#1074#1086#1076#1091'],'
      '  sum_k as ['#1053#1072#1095#1080#1089#1083#1077#1085#1086' '#1079#1072' '#1089#1090#1086#1082#1080'],'
      '  sum_g as ['#1053#1072#1095#1080#1089#1083#1077#1085#1086' '#1079#1072' '#1084#1091#1089#1086#1088'],'
      '  fsum_t as ['#1060#1080#1082#1089#1080#1088#1086#1074#1072#1085#1085#1072#1103' '#1089#1091#1084#1084#1072' '#1079#1072' '#1090#1077#1087#1083#1086'],'
      '  fsum_v as ['#1060#1080#1082#1089#1080#1088#1086#1074#1072#1085#1085#1072#1103' '#1089#1091#1084#1084#1072' '#1079#1072' '#1074#1086#1076#1091'],'
      '  fsum_k as ['#1060#1080#1082#1089#1080#1088#1086#1074#1072#1085#1085#1072#1103' '#1089#1091#1084#1084#1072' '#1079#1072' '#1089#1090#1086#1082#1080'],'
      '  fsum_g as ['#1060#1080#1082#1089#1080#1088#1086#1074#1072#1085#1085#1072#1103' '#1089#1091#1084#1084#1072' '#1079#1072' '#1084#1091#1089#1086#1088'],'
      '  psum_t as [% '#1079#1072' '#1090#1077#1087#1083#1086'],'
      '  psum_v as [% '#1079#1072' '#1074#1086#1076#1091'],'
      '  psum_k as [% '#1079#1072' '#1089#1090#1086#1082#1080'],'
      '  psum_g as [% '#1079#1072' '#1084#1091#1089#1086#1088']'
      'from tPredoplata')
    Left = 112
    Top = 88
  end
  object MQuery: TMSSQL
    Connection = DM.Conect
    CommandTimeout = 0
    Left = 144
    Top = 88
  end
  object dsPredoplata: TDataSource
    DataSet = qryPredoplata
    Left = 112
    Top = 120
  end
  object qryOrg: TMSQuery
    Connection = DM.Conect
    SQL.Strings = (
      'select * from org'
      'order by nazv')
    Left = 176
    Top = 88
  end
  object dsOrg: TDataSource
    DataSet = qryOrg
    Left = 176
    Top = 120
  end
end

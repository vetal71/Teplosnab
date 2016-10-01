object FmeCalcOrg: TFmeCalcOrg
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
    Caption = #1053#1072#1095#1080#1089#1083#1077#1085#1080#1077' '#1087#1086' '#1086#1088#1075#1072#1085#1080#1079#1072#1094#1080#1103#1084
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
    Height = 36
    object TBXToolbar2: TTBXToolbar
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
        OnClick = DanObkClick
      end
      object CalcObk: TTBXSubmenuItem
        Caption = #1056#1072#1089#1095#1077#1090#1099' '#13#10#1087#1086' '#1086#1073#1098#1077#1082#1090#1091
        DisplayMode = nbdmImageAndText
        DropdownCombo = True
        ImageIndex = 56
        OnClick = EditNacobkClick
        object EditNacobk: TTBXItem
          Caption = #1074#1074#1086#1076' '#1085#1072#1095#1080#1089#1083#1077#1085#1080#1103
          ImageIndex = 0
          OnClick = EditNacobkClick
        end
        object TBXSeparatorItem2: TTBXSeparatorItem
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
        object TBXSeparatorItem3: TTBXSeparatorItem
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
      object Print: TTBXSubmenuItem
        Caption = #1055#1077#1095#1072#1090#1100' '#13#10#1086#1090#1095#1077#1090#1086#1074
        DisplayMode = nbdmImageAndText
        DropdownCombo = True
        ImageIndex = 7
        OnClick = PrintSchetClick
        object PrintSchet: TTBXItem
          Caption = #1057#1095#1077#1090'-'#1092#1072#1082#1090#1091#1088#1072
          ImageIndex = 7
          OnClick = PrintSchetClick
        end
        object PrintRash: TTBXItem
          Caption = #1056#1072#1089#1096#1080#1092#1088#1086#1074#1082#1072' '#1085#1072#1095#1080#1089#1083#1077#1085#1080#1103
          ImageIndex = 7
          OnClick = PrintRashClick
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
      object TBXItem1: TTBXItem
        Caption = #1042#1099#1093#1086#1076
        DisplayMode = nbdmImageAndText
        ImageIndex = 135
        Stretch = True
        OnClick = TBXItem1Click
      end
      object cboTipOrg: TRzComboBox
        Left = 260
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
    end
  end
  object RzPanel1: TRzPanel
    Left = 0
    Top = 66
    Width = 876
    Height = 498
    Align = alClient
    BorderOuter = fsFlatRounded
    TabOrder = 1
    object Splitter1: TSplitter
      Left = 2
      Top = 169
      Width = 872
      Height = 3
      Cursor = crVSplit
      Align = alTop
    end
    object RzPanel2: TRzPanel
      Left = 2
      Top = 2
      Width = 872
      Height = 167
      Align = alTop
      BorderOuter = fsFlatRounded
      TabOrder = 0
      object dbgOrg: TDBGridEh
        Left = 2
        Top = 2
        Width = 868
        Height = 163
        Align = alClient
        DataGrouping.GroupLevels = <>
        DataSource = DM.dsCalcOrg
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
            FieldName = 's_gkt'
            Footers = <>
            Title.Caption = #1058#1077#1087#1083#1086#1074#1072#1103' '#1101#1085#1077#1088#1075#1080#1103'|'#1043#1082#1072#1083', '#1086#1090#1086#1087#1083#1077#1085#1080#1077
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 's_gkv'
            Footers = <>
            Title.Caption = #1058#1077#1087#1083#1086#1074#1072#1103' '#1101#1085#1077#1088#1075#1080#1103'|'#1043#1082#1072#1083', '#1043#1042#1057
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 's_itog'
            Footers = <>
            Title.Caption = #1058#1077#1087#1083#1086#1074#1072#1103' '#1101#1085#1077#1088#1075#1080#1103'|'#1053#1072#1095#1080#1089#1083#1077#1085#1086', '#1088#1091#1073'.'
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 's_skybv'
            Footers = <>
            Title.Caption = #1042#1086#1076#1086#1089#1085#1072#1073#1078#1077#1085#1080#1077'|'#1050#1091#1073'.'#1084'.'
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 's_itogv'
            Footers = <>
            Title.Caption = #1042#1086#1076#1086#1089#1085#1072#1073#1078#1077#1085#1080#1077'|'#1053#1072#1095#1080#1089#1083#1077#1085#1086', '#1088#1091#1073'.'
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 's_skybk'
            Footers = <>
            Title.Caption = #1042#1086#1076#1086#1086#1090#1074#1077#1076#1077#1085#1080#1077'|'#1050#1091#1073'.'#1084'.'
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 's_itogk'
            Footers = <>
            Title.Caption = #1042#1086#1076#1086#1086#1090#1074#1077#1076#1077#1085#1080#1077'|'#1053#1072#1095#1080#1089#1083#1077#1085#1086', '#1088#1091#1073'.'
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 's_skybg'
            Footers = <>
            Title.Caption = #1042#1099#1074#1086#1079' '#1084#1091#1089#1086#1088#1072'|'#1050#1091#1073'.'#1084'.'
          end
          item
            EditButtons = <>
            FieldName = 's_itogg'
            Footers = <>
            Title.Caption = #1042#1099#1074#1086#1079' '#1084#1091#1089#1086#1088#1072'|'#1053#1072#1095#1080#1089#1083#1077#1085#1086', '#1088#1091#1073'.'
          end>
        object RowDetailData: TRowDetailPanelControlEh
        end
      end
    end
    object RzPanel3: TRzPanel
      Left = 2
      Top = 172
      Width = 872
      Height = 324
      Align = alClient
      BorderOuter = fsFlatRounded
      TabOrder = 1
      object pgcMain: TRzPageControl
        Left = 2
        Top = 2
        Width = 868
        Height = 320
        ActivePage = TabG
        Align = alClient
        Color = 16119543
        FlatColor = 10263441
        HotTrackColor = 3983359
        ParentColor = False
        TabColors.HighlightBar = 3983359
        TabIndex = 2
        TabOrder = 0
        FixedDimension = 19
        object TabOt: TRzTabSheet
          Color = 16119543
          Caption = #1058#1077#1087#1083#1086#1089#1085#1072#1073#1078#1077#1085#1080#1077
          object dbgObekt: TDBGridEh
            Left = 0
            Top = 0
            Width = 864
            Height = 297
            Align = alClient
            DataGrouping.GroupLevels = <>
            DataSource = DM.dsRezCalcObkOt
            Flat = True
            FooterColor = 12713213
            FooterFont.Charset = DEFAULT_CHARSET
            FooterFont.Color = clWindowText
            FooterFont.Height = -11
            FooterFont.Name = 'Tahoma'
            FooterFont.Style = []
            FooterRowCount = 3
            IndicatorOptions = [gioShowRowIndicatorEh]
            Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
            SumList.Active = True
            TabOrder = 0
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -11
            TitleFont.Name = 'Tahoma'
            TitleFont.Style = []
            UseMultiTitle = True
            OnDblClick = EditNacobkClick
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
                Width = 180
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
                Width = 65
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
                Title.Caption = #1043#1082#1072#1083', '#1043#1042#1057
                Width = 65
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
                Width = 70
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
                Width = 65
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
                Width = 65
              end>
            object RowDetailData: TRowDetailPanelControlEh
            end
          end
        end
        object TabVk: TRzTabSheet
          Color = 16119543
          Caption = #1042#1086#1076#1086#1089#1085#1072#1073#1078#1077#1085#1080#1077' '#1080' '#1074#1086#1076#1086#1086#1090#1074#1077#1076#1077#1085#1080#1077
          object dbgObektVk: TDBGridEh
            Left = 0
            Top = 0
            Width = 864
            Height = 297
            Align = alClient
            DataGrouping.GroupLevels = <>
            DataSource = DM.dsRezCalcObkVk
            Flat = True
            FooterColor = 12713213
            FooterFont.Charset = DEFAULT_CHARSET
            FooterFont.Color = clWindowText
            FooterFont.Height = -11
            FooterFont.Name = 'Tahoma'
            FooterFont.Style = []
            FooterRowCount = 3
            IndicatorOptions = [gioShowRowIndicatorEh]
            Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
            SumList.Active = True
            TabOrder = 0
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -11
            TitleFont.Name = 'Tahoma'
            TitleFont.Style = []
            UseMultiTitle = True
            OnDblClick = EditNacobkClick
            Columns = <
              item
                EditButtons = <>
                FieldName = 'nzv_obk'
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
                    Value = #1042#1086#1076#1086#1089#1085#1072#1073#1078#1077#1085#1080#1077' '#1080' '#1074#1086#1076#1086#1086#1090#1074#1077#1076#1077#1085#1080#1077
                    ValueType = fvtStaticText
                  end>
                Title.Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#1086#1073#1098#1077#1082#1090#1072
                Width = 180
              end
              item
                EditButtons = <>
                FieldName = 's_kybv'
                Footers = <
                  item
                  end
                  item
                  end
                  item
                    ValueType = fvtSum
                  end>
                Title.Caption = #1050#1091#1073'.'#1084'., '#1074#1086#1076#1072
                Width = 65
              end
              item
                EditButtons = <>
                FieldName = 's_kybk'
                Footers = <
                  item
                  end
                  item
                  end
                  item
                    ValueType = fvtSum
                  end>
                Title.Caption = #1050#1091#1073'.'#1084'., '#1082#1072#1085#1072#1083#1080#1079'.'
                Width = 65
              end
              item
                EditButtons = <>
                FieldName = 's_symh'
                Footers = <
                  item
                  end
                  item
                    DisplayFormat = ',0 '#1088'.'
                    FieldName = 's_symhs'
                    ValueType = fvtFieldValue
                  end
                  item
                  end>
                Title.Caption = #1057#1091#1084#1084#1072' '#1073#1077#1079' '#1053#1044#1057', '#1074#1086#1076#1072
                Width = 70
              end
              item
                EditButtons = <>
                FieldName = 's_symkk'
                Footers = <
                  item
                  end
                  item
                    DisplayFormat = ',0 '#1088
                    FieldName = 's_symks'
                    ValueType = fvtFieldValue
                  end
                  item
                  end>
                Title.Caption = #1057#1091#1084#1084#1072' '#1073#1077#1079' '#1053#1044#1057', '#1082#1072#1085#1072#1083#1080#1079'.'
                Width = 70
              end
              item
                EditButtons = <>
                FieldName = 's_perh'
                Footers = <
                  item
                  end
                  item
                    DisplayFormat = ',0 '#1088
                    FieldName = 's_perh'
                    ValueType = fvtSum
                  end
                  item
                  end>
                Title.Caption = #1057#1091#1084#1084#1072' '#1087#1077#1088#1077#1088#1072#1089#1095#1077#1090#1072' '#1089' '#1053#1044#1057', '#1074#1086#1076#1072
                Width = 70
              end
              item
                EditButtons = <>
                FieldName = 's_perk'
                Footers = <
                  item
                  end
                  item
                    DisplayFormat = ',0 '#1088
                    FieldName = 's_perk'
                    ValueType = fvtSum
                  end
                  item
                  end>
                Title.Caption = #1057#1091#1084#1084#1072' '#1087#1077#1088#1077#1088#1072#1089#1095#1077#1090#1072' '#1089' '#1053#1044#1057', '#1082#1072#1085#1072#1083#1080#1079'.'
                Width = 70
              end
              item
                EditButtons = <>
                FieldName = 's_pkybv'
                Footers = <
                  item
                  end
                  item
                  end
                  item
                    ValueType = fvtSum
                  end>
                Title.Caption = #1055#1077#1088#1077#1088#1072#1089#1095#1077#1090' '#1082#1091#1073'.'#1084'., '#1074#1086#1076#1072
                Width = 65
              end
              item
                EditButtons = <>
                FieldName = 's_pkybk'
                Footers = <
                  item
                  end
                  item
                  end
                  item
                    ValueType = fvtSum
                  end>
                Title.Caption = #1055#1077#1088#1077#1088#1072#1089#1095#1077#1090' '#1082#1091#1073'.'#1084'., '#1082#1072#1085#1072#1083#1080#1079'.'
                Width = 65
              end>
            object RowDetailData: TRowDetailPanelControlEh
            end
          end
        end
        object TabG: TRzTabSheet
          Color = 16119543
          Caption = #1042#1099#1074#1086#1079' '#1084#1091#1089#1086#1088#1072
          object dbgObektG: TDBGridEh
            Left = 0
            Top = 0
            Width = 864
            Height = 297
            Align = alClient
            DataGrouping.GroupLevels = <>
            DataSource = DM.dsRezCalcObkG
            Flat = True
            FooterColor = 12713213
            FooterFont.Charset = DEFAULT_CHARSET
            FooterFont.Color = clWindowText
            FooterFont.Height = -11
            FooterFont.Name = 'Tahoma'
            FooterFont.Style = []
            FooterRowCount = 3
            IndicatorOptions = [gioShowRowIndicatorEh]
            Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
            OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection, dghIncSearch, dghPreferIncSearch, dghDialogFind, dghColumnResize, dghColumnMove, dghExtendVertLines]
            SumList.Active = True
            TabOrder = 0
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -11
            TitleFont.Name = 'Tahoma'
            TitleFont.Style = []
            UseMultiTitle = True
            OnDblClick = EditNacobkClick
            Columns = <
              item
                EditButtons = <>
                FieldName = 'nzv_obk'
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
                    Value = #1042#1099#1074#1086#1079' '#1084#1091#1089#1086#1088#1072
                    ValueType = fvtStaticText
                  end>
                Title.Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#1086#1073#1098#1077#1082#1090#1072
                Width = 180
              end
              item
                EditButtons = <>
                FieldName = 's_kybg'
                Footers = <
                  item
                  end
                  item
                  end
                  item
                    ValueType = fvtSum
                  end>
                Title.Caption = #1050#1091#1073'.'#1084'.'
                Width = 65
              end
              item
                EditButtons = <>
                FieldName = 's_symg'
                Footers = <
                  item
                  end
                  item
                    DisplayFormat = ',0 '#1088'.'
                    FieldName = 's_symgs'
                    ValueType = fvtFieldValue
                  end
                  item
                  end>
                Title.Caption = #1057#1091#1084#1084#1072' '#1073#1077#1079' '#1053#1044#1057
                Width = 70
              end
              item
                EditButtons = <>
                FieldName = 's_perg'
                Footers = <
                  item
                  end
                  item
                    DisplayFormat = ',0 '#1088
                    FieldName = 's_perg'
                    ValueType = fvtSum
                  end
                  item
                  end>
                Title.Caption = #1057#1091#1084#1084#1072' '#1087#1077#1088#1077#1088#1072#1089#1095#1077#1090#1072' '#1089' '#1053#1044#1057
                Width = 70
              end
              item
                EditButtons = <>
                FieldName = 's_pkybg'
                Footers = <
                  item
                  end
                  item
                  end
                  item
                    ValueType = fvtSum
                  end>
                Title.Caption = #1055#1077#1088#1077#1088#1072#1089#1095#1077#1090' '#1082#1091#1073'.'#1084'.'
                Width = 65
              end>
            object RowDetailData: TRowDetailPanelControlEh
            end
          end
        end
      end
    end
  end
  object MQuery: TMSSQL
    Connection = DM.Conect
    SQL.Strings = (
      'EXECUTE sp_calc_obk :data'
      'EXECUTE sp_calc_org :data')
    CommandTimeout = 0
    Left = 379
    Top = 159
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
  object MQuery1: TMSSQL
    Connection = DM.Conect
    SQL.Strings = (
      'EXECUTE sp_calc_obk_vk :data'
      'EXECUTE sp_calc_org_vk :data')
    CommandTimeout = 0
    Left = 411
    Top = 159
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
  object MQuery2: TMSSQL
    Connection = DM.Conect
    SQL.Strings = (
      'EXECUTE sp_create_sf :kod,:data'
      '')
    CommandTimeout = 0
    Left = 483
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
  object MQuery3: TMSSQL
    Connection = DM.Conect
    SQL.Strings = (
      'EXECUTE sp_calc_obk_g :data'
      'EXECUTE sp_calc_org_g :data')
    CommandTimeout = 0
    Left = 443
    Top = 159
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
end

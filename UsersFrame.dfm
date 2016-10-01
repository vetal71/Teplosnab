object FmeUsers: TFmeUsers
  Left = 0
  Top = 0
  Width = 593
  Height = 534
  TabOrder = 0
  TabStop = True
  object RzLabel9: TRzLabel
    Left = 0
    Top = 0
    Width = 593
    Height = 26
    Align = alTop
    Alignment = taCenter
    Caption = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1080' '#1073#1072#1079#1099' '#1076#1072#1085#1085#1099#1093
    Color = 16771797
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -21
    Font.Name = 'Verdana'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
    Transparent = True
    Layout = tlCenter
    BorderOuter = fsFlat
    BorderSides = [sdBottom]
    TextStyle = tsRaised
  end
  object RzPanel1: TRzPanel
    Left = 0
    Top = 52
    Width = 593
    Height = 482
    Align = alClient
    BorderOuter = fsFlatRounded
    TabOrder = 0
    object RzPanel2: TRzPanel
      Left = 2
      Top = 2
      Width = 589
      Height = 263
      Align = alTop
      BorderOuter = fsFlatRounded
      TabOrder = 0
      object dbgError: TDBGridEh
        Left = 2
        Top = 2
        Width = 585
        Height = 259
        Align = alClient
        DataGrouping.GroupLevels = <>
        DataSource = DM.dsUsers
        Flat = True
        FooterColor = clWindow
        FooterFont.Charset = DEFAULT_CHARSET
        FooterFont.Color = clWindowText
        FooterFont.Height = -11
        FooterFont.Name = 'Tahoma'
        FooterFont.Style = []
        IndicatorOptions = [gioShowRowIndicatorEh]
        RowDetailPanel.Color = clBtnFace
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
        OnCellClick = dbgErrorCellClick
        OnKeyDown = dbgErrorKeyDown
        OnKeyUp = dbgErrorKeyDown
        Columns = <
          item
            EditButtons = <>
            FieldName = 'uid'
            Footers = <>
            Title.Alignment = taCenter
            Title.Caption = 'UID'
            Width = 60
          end
          item
            EditButtons = <>
            FieldName = 'name'
            Footers = <>
            Title.Alignment = taCenter
            Title.Caption = #1048#1084#1103
            Width = 500
          end>
        object RowDetailData: TRowDetailPanelControlEh
        end
      end
    end
    object RzPanel3: TRzPanel
      Left = 306
      Top = 265
      Width = 285
      Height = 215
      Align = alClient
      BorderOuter = fsFlatRounded
      TabOrder = 1
      object chkListRoleAll: TRzCheckList
        Left = 2
        Top = 2
        Width = 281
        Height = 211
        Align = alClient
        FrameColor = 12164479
        FrameVisible = True
        ItemHeight = 17
        TabOrder = 0
      end
    end
    object RzPanel4: TRzPanel
      Left = 2
      Top = 265
      Width = 304
      Height = 215
      Align = alLeft
      BorderOuter = fsFlatRounded
      TabOrder = 2
      object chkListRole: TRzCheckList
        Left = 2
        Top = 2
        Width = 300
        Height = 211
        Align = alClient
        FrameColor = 12164479
        FrameVisible = True
        ItemHeight = 17
        TabOrder = 0
      end
    end
  end
  object TBXDock1: TTBXDock
    Left = 0
    Top = 26
    Width = 593
    Height = 26
    object TBXToolbar2: TTBXToolbar
      Left = 0
      Top = 0
      Caption = 'TBXToolbar1'
      ChevronHint = #1044#1086#1087#1086#1083#1085#1080#1090#1077#1083#1100#1085#1086'|'
      Images = FrmMain.ImageList1
      TabOrder = 0
      object Filter: TTBXItem
        Caption = #1053#1086#1074#1099#1081
        DisplayMode = nbdmImageAndText
        ImageIndex = 297
        Stretch = True
        OnClick = FilterClick
      end
      object TBXItem2: TTBXItem
        Caption = #1048#1079#1084#1077#1085#1080#1090#1100
        DisplayMode = nbdmImageAndText
        ImageIndex = 298
        OnClick = TBXItem2Click
      end
      object DelFilter: TTBXItem
        Caption = #1059#1076#1072#1083#1080#1090#1100
        DisplayMode = nbdmImageAndText
        ImageIndex = 299
        Stretch = True
        OnClick = DelFilterClick
      end
      object TBXSeparatorItem1: TTBXSeparatorItem
      end
      object TBXItem3: TTBXItem
        Caption = #1055#1088#1072#1074#1072
        DisplayMode = nbdmImageAndText
        ImageIndex = 210
        Stretch = True
        OnClick = TBXItem3Click
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
    end
  end
  object MQuery: TMSSQL
    Connection = DM.Conect
    CommandTimeout = 0
    Left = 464
    Top = 120
  end
end

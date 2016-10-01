object frmChangeOrg: TfrmChangeOrg
  Left = 381
  Top = 194
  Width = 369
  Height = 135
  Caption = 'frmChangeOrg'
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
  object RzPanel1: TRzPanel
    Left = 0
    Top = 0
    Width = 361
    Height = 60
    Align = alClient
    BorderOuter = fsFlatRounded
    BorderSides = [sdLeft, sdTop, sdRight]
    TabOrder = 0
    object RzLabel11: TRzLabel
      Left = 9
      Top = 15
      Width = 107
      Height = 13
      Caption = #1057#1090#1072#1088#1072#1103' '#1086#1088#1075#1072#1085#1080#1079#1072#1094#1080#1103':'
    end
    object RzLabel1: TRzLabel
      Left = 9
      Top = 41
      Width = 103
      Height = 13
      Caption = #1053#1086#1074#1072#1103' '#1086#1088#1075#1072#1085#1080#1079#1072#1094#1080#1103':'
    end
    object lcbOldOrg: TRzDBLookupComboBox
      Left = 121
      Top = 12
      Width = 233
      Height = 21
      Ctl3D = False
      KeyField = 'kodorg'
      ListField = 'nazv'
      ListSource = dsOrg
      ParentCtl3D = False
      TabOrder = 0
      FlatButtons = True
      FrameColor = 12164479
      FrameVisible = True
    end
    object lcbNewOrg: TRzDBLookupComboBox
      Left = 121
      Top = 38
      Width = 233
      Height = 21
      Ctl3D = False
      KeyField = 'kodorg'
      ListField = 'nazv'
      ListSource = dsOrg
      ParentCtl3D = False
      TabOrder = 1
      FlatButtons = True
      FrameColor = 12164479
      FrameVisible = True
    end
  end
  object RzPanel2: TRzPanel
    Left = 0
    Top = 60
    Width = 361
    Height = 41
    Align = alBottom
    BorderOuter = fsFlatRounded
    TabOrder = 1
    object RzBitBtn1: TRzBitBtn
      Left = 8
      Top = 8
      Width = 169
      Caption = #1055#1077#1088#1077#1076#1072#1090#1100
      Color = 15791348
      HighlightColor = 16026986
      HotTrack = True
      HotTrackColor = 3983359
      TabOrder = 0
      OnClick = RzBitBtn1Click
    end
    object RzBitBtn2: TRzBitBtn
      Left = 179
      Top = 8
      Width = 169
      Caption = #1054#1090#1082#1072#1079#1072#1090#1100#1089#1103
      Color = 15791348
      HighlightColor = 16026986
      HotTrack = True
      HotTrackColor = 3983359
      TabOrder = 1
      OnClick = RzBitBtn2Click
    end
  end
  object SpUpObekt: TMSStoredProc
    StoredProcName = 'sp_change_org;1'
    Connection = DM.Conect
    SQL.Strings = (
      '{:RETURN_VALUE = CALL sp_change_org;1(:kodorg, :kodobk)}')
    Left = 24
    Top = 8
    ParamData = <
      item
        DataType = ftInteger
        Name = 'RETURN_VALUE'
        ParamType = ptResult
        Value = 0
      end
      item
        DataType = ftInteger
        Name = 'kodorg'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'kodobk'
        ParamType = ptInput
      end>
  end
  object qryOrg: TMSQuery
    Connection = DM.Conect
    SQL.Strings = (
      'select * from org')
    Left = 56
    Top = 8
  end
  object dsOrg: TDataSource
    DataSet = qryOrg
    Left = 88
    Top = 8
  end
end

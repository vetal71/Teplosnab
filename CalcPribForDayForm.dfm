object FrmCalcPribForDay: TFrmCalcPribForDay
  Left = 459
  Top = 218
  Width = 420
  Height = 291
  Caption = #1056#1072#1089#1095#1077#1090' '#1087#1088#1080#1073#1086#1088#1072' '#1087#1086' '#1076#1085#1103#1084
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
    Width = 412
    Height = 216
    Align = alClient
    BorderOuter = fsFlatRounded
    BorderSides = [sdLeft, sdTop, sdRight]
    TabOrder = 0
    object RzLabel8: TRzLabel
      Left = 16
      Top = 198
      Width = 122
      Height = 13
      Caption = #1048#1090#1086#1075#1086' '#1087#1086' '#1087#1088#1080#1073#1086#1088#1091' '#1091#1095#1077#1090#1072':'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object RzGroupBox1: TRzGroupBox
      Left = 8
      Top = 5
      Width = 396
      Height = 182
      Caption = #1044#1072#1085#1085#1099#1077' '#1087#1086' '#1087#1088#1080#1073#1086#1088#1091' '#1091#1095#1077#1090#1072' '#1079#1072' '#1087#1077#1088#1080#1086#1076
      TabOrder = 0
      object RzLabel1: TRzLabel
        Left = 8
        Top = 22
        Width = 148
        Height = 13
        Caption = #1056#1072#1089#1095#1077#1090#1085#1099#1081' '#1087#1077#1088#1080#1086#1076' '#1087#1088#1080#1073#1086#1088#1072' '#1089
      end
      object RzLabel2: TRzLabel
        Left = 269
        Top = 22
        Width = 12
        Height = 13
        Caption = #1087#1086
      end
      object RzLabel3: TRzLabel
        Left = 8
        Top = 48
        Width = 134
        Height = 13
        Caption = #1055#1086#1082#1072#1079#1072#1085#1080#1103' '#1087#1088#1080#1073#1086#1088#1072' '#1091#1095#1077#1090#1072':'
      end
      object RzLabel4: TRzLabel
        Left = 8
        Top = 75
        Width = 145
        Height = 13
        Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1088#1072#1089#1095#1077#1090#1085#1099#1093' '#1076#1085#1077#1081':'
      end
      object RzLabel5: TRzLabel
        Left = 8
        Top = 102
        Width = 140
        Height = 13
        Caption = #1057#1088'.'#1090#1077#1084#1087#1077#1088#1072#1090#1091#1088#1072' '#1085#1072#1088'.'#1074#1086#1079'-'#1093#1072':'
      end
      object RzLabel6: TRzLabel
        Left = 8
        Top = 156
        Width = 146
        Height = 13
        Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1043#1082#1072#1083' '#1087#1086' '#1088#1072#1089#1095#1077#1090#1091':'
      end
      object RzLabel7: TRzLabel
        Left = 8
        Top = 129
        Width = 110
        Height = 13
        Caption = #1053#1072#1075#1088#1091#1079#1082#1072' '#1087#1086' '#1087#1088#1080#1073#1086#1088#1091':'
      end
      object RzLabel9: TRzLabel
        Left = 238
        Top = 75
        Width = 69
        Height = 13
        Caption = #1050#1086#1083'-'#1074#1086' '#1095#1072#1089#1086#1074':'
      end
      object deStart: TRzDateTimeEdit
        Left = 163
        Top = 18
        Width = 100
        Height = 21
        EditType = etDate
        FlatButtons = True
        FrameColor = 12164479
        FrameVisible = True
        TabOrder = 0
      end
      object deEnd: TRzDateTimeEdit
        Left = 287
        Top = 18
        Width = 100
        Height = 21
        EditType = etDate
        FlatButtons = True
        FrameColor = 12164479
        FrameVisible = True
        TabOrder = 1
        OnChange = deEndChange
      end
      object nePokPrib: TRzNumericEdit
        Left = 163
        Top = 44
        Width = 67
        Height = 21
        FrameColor = 12164479
        FrameVisible = True
        TabOrder = 2
        OnChange = nePokPribChange
        IntegersOnly = False
        DisplayFormat = ',0.00;(,0.00)'
      end
      object neKdo: TRzNumericEdit
        Left = 163
        Top = 71
        Width = 67
        Height = 21
        Enabled = False
        FrameColor = 12164479
        FrameVisible = True
        TabOrder = 3
        DisplayFormat = ',0;(,0)'
      end
      object neSrT: TRzNumericEdit
        Left = 163
        Top = 98
        Width = 67
        Height = 21
        Enabled = False
        FrameColor = 12164479
        FrameVisible = True
        TabOrder = 4
        IntegersOnly = False
        DisplayFormat = ',0.0;-,0.0'
      end
      object neCalc: TRzNumericEdit
        Left = 163
        Top = 152
        Width = 67
        Height = 21
        Enabled = False
        FrameColor = 12164479
        FrameVisible = True
        TabOrder = 6
        IntegersOnly = False
        DisplayFormat = ',0.00;(,0.00)'
      end
      object neQot: TRzNumericEdit
        Left = 163
        Top = 125
        Width = 67
        Height = 21
        Enabled = False
        FrameColor = 12164479
        FrameVisible = True
        TabOrder = 5
        IntegersOnly = False
        DisplayFormat = ',0;(,0)'
      end
      object neKco: TRzNumericEdit
        Left = 320
        Top = 71
        Width = 67
        Height = 21
        FrameColor = 12164479
        FrameVisible = True
        TabOrder = 7
        OnChange = nePokPribChange
        CheckRange = True
        Max = 24.000000000000000000
        DisplayFormat = ',0;(,0)'
      end
    end
    object neItog: TRzNumericEdit
      Left = 171
      Top = 194
      Width = 67
      Height = 21
      Enabled = False
      FrameColor = 12164479
      FrameVisible = True
      TabOrder = 1
      IntegersOnly = False
      DisplayFormat = ',0.00;(,0.00)'
    end
  end
  object RzPanel2: TRzPanel
    Left = 0
    Top = 216
    Width = 412
    Height = 41
    Align = alBottom
    BorderOuter = fsFlatRounded
    TabOrder = 1
    object BtnOk: TRzBitBtn
      Left = 8
      Top = 8
      Width = 100
      Caption = 'OK'
      Color = 15791348
      HighlightColor = 16026986
      HotTrack = True
      HotTrackColor = 3983359
      TabOrder = 0
      OnClick = BtnOkClick
      Glyph.Data = {
        36060000424D3606000000000000360400002800000020000000100000000100
        08000000000000020000630B0000630B00000001000000000000000000003300
        00006600000099000000CC000000FF0000000033000033330000663300009933
        0000CC330000FF33000000660000336600006666000099660000CC660000FF66
        000000990000339900006699000099990000CC990000FF99000000CC000033CC
        000066CC000099CC0000CCCC0000FFCC000000FF000033FF000066FF000099FF
        0000CCFF0000FFFF000000003300330033006600330099003300CC003300FF00
        330000333300333333006633330099333300CC333300FF333300006633003366
        33006666330099663300CC663300FF6633000099330033993300669933009999
        3300CC993300FF99330000CC330033CC330066CC330099CC3300CCCC3300FFCC
        330000FF330033FF330066FF330099FF3300CCFF3300FFFF3300000066003300
        66006600660099006600CC006600FF0066000033660033336600663366009933
        6600CC336600FF33660000666600336666006666660099666600CC666600FF66
        660000996600339966006699660099996600CC996600FF99660000CC660033CC
        660066CC660099CC6600CCCC6600FFCC660000FF660033FF660066FF660099FF
        6600CCFF6600FFFF660000009900330099006600990099009900CC009900FF00
        990000339900333399006633990099339900CC339900FF339900006699003366
        99006666990099669900CC669900FF6699000099990033999900669999009999
        9900CC999900FF99990000CC990033CC990066CC990099CC9900CCCC9900FFCC
        990000FF990033FF990066FF990099FF9900CCFF9900FFFF99000000CC003300
        CC006600CC009900CC00CC00CC00FF00CC000033CC003333CC006633CC009933
        CC00CC33CC00FF33CC000066CC003366CC006666CC009966CC00CC66CC00FF66
        CC000099CC003399CC006699CC009999CC00CC99CC00FF99CC0000CCCC0033CC
        CC0066CCCC0099CCCC00CCCCCC00FFCCCC0000FFCC0033FFCC0066FFCC0099FF
        CC00CCFFCC00FFFFCC000000FF003300FF006600FF009900FF00CC00FF00FF00
        FF000033FF003333FF006633FF009933FF00CC33FF00FF33FF000066FF003366
        FF006666FF009966FF00CC66FF00FF66FF000099FF003399FF006699FF009999
        FF00CC99FF00FF99FF0000CCFF0033CCFF0066CCFF0099CCFF00CCCCFF00FFCC
        FF0000FFFF0033FFFF0066FFFF0099FFFF00CCFFFF00FFFFFF00000080000080
        000000808000800000008000800080800000C0C0C00080808000191919004C4C
        4C00B2B2B200E5E5E500C8AC2800E0CC6600F2EABF00B59B2400D8E9EC009933
        6600D075A300ECC6D900646F710099A8AC00E2EFF10000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000E8E8E8E8E8E8
        E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8
        E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8180C
        E8E8E8E8E8E8E8E8E8E8E8E8E8E8E2DFE8E8E8E8E8E8E8E8E8E8E8E8E8181212
        0CE8E8E8E8E8E8E8E8E8E8E8E8E28181DFE8E8E8E8E8E8E8E8E8E8E818121212
        120CE8E8E8E8E8E8E8E8E8E8E281818181DFE8E8E8E8E8E8E8E8E81812121212
        12120CE8E8E8E8E8E8E8E8E2818181818181DFE8E8E8E8E8E8E8E81812120C18
        1212120CE8E8E8E8E8E8E8E28181DFE2818181DFE8E8E8E8E8E8E818120CE8E8
        181212120CE8E8E8E8E8E8E281DFE8E8E2818181DFE8E8E8E8E8E8180CE8E8E8
        E8181212120CE8E8E8E8E8E2DFE8E8E8E8E2818181DFE8E8E8E8E8E8E8E8E8E8
        E8E8181212120CE8E8E8E8E8E8E8E8E8E8E8E2818181DFE8E8E8E8E8E8E8E8E8
        E8E8E8181212120CE8E8E8E8E8E8E8E8E8E8E8E2818181DFE8E8E8E8E8E8E8E8
        E8E8E8E81812120CE8E8E8E8E8E8E8E8E8E8E8E8E28181DFE8E8E8E8E8E8E8E8
        E8E8E8E8E818120CE8E8E8E8E8E8E8E8E8E8E8E8E8E281DFE8E8E8E8E8E8E8E8
        E8E8E8E8E8E8180CE8E8E8E8E8E8E8E8E8E8E8E8E8E8E2DFE8E8E8E8E8E8E8E8
        E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8
        E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8}
      NumGlyphs = 2
    end
    object BtnCancel: TRzBitBtn
      Left = 112
      Top = 8
      Width = 100
      Caption = 'Cancel'
      Color = 15791348
      HighlightColor = 16026986
      HotTrack = True
      HotTrackColor = 3983359
      TabOrder = 1
      OnClick = BtnCancelClick
      Glyph.Data = {
        36060000424D3606000000000000360400002800000020000000100000000100
        08000000000000020000630B0000630B00000001000000000000000000003300
        00006600000099000000CC000000FF0000000033000033330000663300009933
        0000CC330000FF33000000660000336600006666000099660000CC660000FF66
        000000990000339900006699000099990000CC990000FF99000000CC000033CC
        000066CC000099CC0000CCCC0000FFCC000000FF000033FF000066FF000099FF
        0000CCFF0000FFFF000000003300330033006600330099003300CC003300FF00
        330000333300333333006633330099333300CC333300FF333300006633003366
        33006666330099663300CC663300FF6633000099330033993300669933009999
        3300CC993300FF99330000CC330033CC330066CC330099CC3300CCCC3300FFCC
        330000FF330033FF330066FF330099FF3300CCFF3300FFFF3300000066003300
        66006600660099006600CC006600FF0066000033660033336600663366009933
        6600CC336600FF33660000666600336666006666660099666600CC666600FF66
        660000996600339966006699660099996600CC996600FF99660000CC660033CC
        660066CC660099CC6600CCCC6600FFCC660000FF660033FF660066FF660099FF
        6600CCFF6600FFFF660000009900330099006600990099009900CC009900FF00
        990000339900333399006633990099339900CC339900FF339900006699003366
        99006666990099669900CC669900FF6699000099990033999900669999009999
        9900CC999900FF99990000CC990033CC990066CC990099CC9900CCCC9900FFCC
        990000FF990033FF990066FF990099FF9900CCFF9900FFFF99000000CC003300
        CC006600CC009900CC00CC00CC00FF00CC000033CC003333CC006633CC009933
        CC00CC33CC00FF33CC000066CC003366CC006666CC009966CC00CC66CC00FF66
        CC000099CC003399CC006699CC009999CC00CC99CC00FF99CC0000CCCC0033CC
        CC0066CCCC0099CCCC00CCCCCC00FFCCCC0000FFCC0033FFCC0066FFCC0099FF
        CC00CCFFCC00FFFFCC000000FF003300FF006600FF009900FF00CC00FF00FF00
        FF000033FF003333FF006633FF009933FF00CC33FF00FF33FF000066FF003366
        FF006666FF009966FF00CC66FF00FF66FF000099FF003399FF006699FF009999
        FF00CC99FF00FF99FF0000CCFF0033CCFF0066CCFF0099CCFF00CCCCFF00FFCC
        FF0000FFFF0033FFFF0066FFFF0099FFFF00CCFFFF00FFFFFF00000080000080
        000000808000800000008000800080800000C0C0C00080808000191919004C4C
        4C00B2B2B200E5E5E500C8AC2800E0CC6600F2EABF00B59B2400D8E9EC009933
        6600D075A300ECC6D900646F710099A8AC00E2EFF10000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000E8E8E8E8E8E8
        E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8
        E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8
        E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8B46C6C6CE8
        E8E8E8E8B46C6C6CE8E8E8E2DFDFDFE8E8E8E8E8E2DFDFDFE8E8E8B49090906C
        E8E8E8B49090906CE8E8E8E2818181DFE8E8E8E2818181DFE8E8E8E8B4909090
        6CE8B49090906CE8E8E8E8E8E2818181DFE8E2818181DFE8E8E8E8E8E8B49090
        906C9090906CE8E8E8E8E8E8E8E2818181DF818181DFE8E8E8E8E8E8E8E8B490
        909090906CE8E8E8E8E8E8E8E8E8E28181818181DFE8E8E8E8E8E8E8E8E8E8B4
        9090906CE8E8E8E8E8E8E8E8E8E8E8E2818181DFE8E8E8E8E8E8E8E8E8E8B490
        909090906CE8E8E8E8E8E8E8E8E8E28181818181DFE8E8E8E8E8E8E8E8B49090
        906C9090906CE8E8E8E8E8E8E8E2818181DF818181DFE8E8E8E8E8E8B4909090
        6CE8B49090906CE8E8E8E8E8E2818181DFE8E2818181DFE8E8E8E8B49090906C
        E8E8E8B49090906CE8E8E8E2818181DFE8E8E8E2818181DFE8E8E8B4B4B4B4E8
        E8E8E8E8B4B4B4B4E8E8E8E2E2E2E2E8E8E8E8E8E2E2E2E2E8E8E8E8E8E8E8E8
        E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8
        E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8}
      NumGlyphs = 2
    end
  end
  object spSrTemp: TMSStoredProc
    StoredProcName = 'sp_avg_temp;1'
    Connection = DM.Conect
    SQL.Strings = (
      
        '{:RETURN_VALUE = CALL sp_avg_temp;1(:data1, :data2, :c_day, :c_t' +
        'mp)}')
    FetchRows = 1
    Left = 320
    Top = 112
    ParamData = <
      item
        DataType = ftInteger
        Name = 'RETURN_VALUE'
        ParamType = ptResult
        Value = 0
      end
      item
        DataType = ftDateTime
        Name = 'data1'
        ParamType = ptInput
      end
      item
        DataType = ftDateTime
        Name = 'data2'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'c_day'
        ParamType = ptInputOutput
        Value = 0
      end
      item
        DataType = ftBCD
        Name = 'c_tmp'
        ParamType = ptInputOutput
      end>
  end
  object spQprib: TMSStoredProc
    StoredProcName = 'sp_q_pr;1'
    Connection = DM.Conect
    SQL.Strings = (
      '{:RETURN_VALUE = CALL sp_q_pr;1(:kod, :qot, :tvn)}')
    FetchRows = 1
    Left = 320
    Top = 140
    ParamData = <
      item
        DataType = ftInteger
        Name = 'RETURN_VALUE'
        ParamType = ptResult
        Value = 0
      end
      item
        DataType = ftInteger
        Name = 'kod'
        ParamType = ptInput
        Value = 2
      end
      item
        DataType = ftInteger
        Name = 'qot'
        ParamType = ptInputOutput
        Value = 310500
      end
      item
        DataType = ftInteger
        Name = 'tvn'
        ParamType = ptInputOutput
        Value = 18
      end>
  end
  object spVerifyTemper: TMSStoredProc
    StoredProcName = 'sp_VerifyTemper;1'
    Connection = DM.Conect
    SQL.Strings = (
      
        '{:RETURN_VALUE = CALL sp_VerifyTemper;1(:data1, :data2, :str, :k' +
        'ol)}')
    FetchRows = 1
    Left = 288
    Top = 112
    ParamData = <
      item
        DataType = ftInteger
        Name = 'RETURN_VALUE'
        ParamType = ptResult
        Value = 0
      end
      item
        DataType = ftDateTime
        Name = 'data1'
        ParamType = ptInput
      end
      item
        DataType = ftDateTime
        Name = 'data2'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'str'
        ParamType = ptInputOutput
        Size = 1000
      end
      item
        DataType = ftInteger
        Name = 'kol'
        ParamType = ptInputOutput
      end>
  end
  object UpPokPrib: TMSQuery
    Connection = DM.Conect
    SQL.Strings = (
      'update dataprib'
      'set gkt = :gkt, kdr = :kdr, kcr = :kcr, str = :str, gkr = :gkr'
      'where kodpr = :kod and datan = :data')
    Left = 288
    Top = 140
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'gkt'
      end
      item
        DataType = ftUnknown
        Name = 'kdr'
      end
      item
        DataType = ftUnknown
        Name = 'kcr'
      end
      item
        DataType = ftUnknown
        Name = 'str'
      end
      item
        DataType = ftUnknown
        Name = 'gkr'
      end
      item
        DataType = ftUnknown
        Name = 'kod'
      end
      item
        DataType = ftUnknown
        Name = 'data'
      end>
  end
end

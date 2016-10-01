object FrmLookObekt: TFrmLookObekt
  Left = 281
  Top = 159
  Width = 521
  Height = 465
  Caption = #1044#1072#1085#1085#1099#1077' '#1087#1086' '#1086#1073#1098#1077#1082#1090#1091
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
  object pnlMain: TRzPanel
    Left = 0
    Top = 0
    Width = 513
    Height = 390
    Align = alClient
    BorderOuter = fsFlatRounded
    BorderSides = [sdLeft, sdTop, sdRight]
    TabOrder = 0
    object RzLabel1: TRzLabel
      Left = 8
      Top = 11
      Width = 124
      Height = 13
      Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#1086#1073#1098#1077#1082#1090#1072':'
    end
    object RzLine1: TRzLine
      Left = -1
      Top = 24
      Width = 516
      Height = 20
      LineColor = clTeal
    end
    object RzLabel2: TRzLabel
      Left = 8
      Top = 44
      Width = 92
      Height = 13
      Caption = #1053#1072#1088#1091#1078#1085#1099#1081' '#1086#1073#1098#1077#1084':'
    end
    object RzLabel3: TRzLabel
      Left = 9
      Top = 97
      Width = 122
      Height = 13
      Caption = #1053#1072#1075#1088#1091#1079#1082#1072' '#1085#1072' '#1086#1090#1086#1087#1083#1077#1085#1080#1077':'
    end
    object RzLabel4: TRzLabel
      Left = 9
      Top = 70
      Width = 130
      Height = 13
      Caption = #1042#1085#1091#1090#1088#1077#1085#1085#1103#1103' '#1090#1077#1084#1087#1077#1088#1072#1090#1091#1088#1072':'
    end
    object RzLabel5: TRzLabel
      Left = 238
      Top = 97
      Width = 77
      Height = 13
      Caption = #1093#1086#1083#1086#1076#1085#1091#1102' '#1074#1086#1076#1091':'
    end
    object RzLabel6: TRzLabel
      Left = 398
      Top = 97
      Width = 32
      Height = 13
      Caption = #1089#1090#1086#1082#1080':'
    end
    object RzLabel7: TRzLabel
      Left = 9
      Top = 123
      Width = 60
      Height = 13
      Caption = #1055#1088#1086#1078#1080#1074#1072#1077#1090':'
    end
    object RzLabel8: TRzLabel
      Left = 238
      Top = 123
      Width = 61
      Height = 13
      Caption = #1083#1100#1075#1086#1090#1085#1080#1082#1086#1074':'
    end
    object RzLabel9: TRzLabel
      Left = 9
      Top = 149
      Width = 86
      Height = 13
      Caption = #1054#1073#1097#1072#1103' '#1087#1083#1086#1097#1072#1076#1100':'
    end
    object RzLabel10: TRzLabel
      Left = 238
      Top = 149
      Width = 49
      Height = 13
      Caption = #1083#1100#1075#1086#1090#1085#1072#1103':'
    end
    object RzLabel11: TRzLabel
      Left = 9
      Top = 174
      Width = 148
      Height = 13
      Caption = #1058#1072#1088#1080#1092' '#1085#1072' '#1090#1077#1087#1083#1086#1074#1091#1102' '#1101#1085#1077#1088#1075#1080#1102':'
    end
    object RzLabel12: TRzLabel
      Left = 9
      Top = 201
      Width = 138
      Height = 13
      Caption = #1058#1072#1088#1080#1092' '#1085#1072' '#1093#1086#1083'.'#1074#1086#1076#1091' '#1080' '#1089#1090#1086#1082#1080':'
    end
    object RzLabel13: TRzLabel
      Left = 10
      Top = 226
      Width = 65
      Height = 13
      Caption = #1056#1072#1089#1095#1077#1090' '#1053#1044#1057':'
    end
    object RzLabel14: TRzLabel
      Left = 9
      Top = 254
      Width = 144
      Height = 13
      Caption = #1055#1088#1086#1080#1079#1074#1086#1076#1089#1090#1074#1077#1085#1085#1099#1081' '#1091#1095#1072#1089#1090#1086#1082':'
    end
    object RzLabel15: TRzLabel
      Left = 9
      Top = 281
      Width = 103
      Height = 13
      Caption = #1055#1088#1080#1073#1086#1088' '#1091#1095#1077#1090#1072' '#1090#1077#1087#1083#1072':'
    end
    object RzLabel16: TRzLabel
      Left = 9
      Top = 366
      Width = 135
      Height = 13
      Caption = #1055#1088#1080#1085#1072#1076#1083#1077#1078#1085#1086#1089#1090#1100' '#1086#1073#1098#1077#1082#1090#1072':'
    end
    object RzLabel17: TRzLabel
      Left = 282
      Top = 227
      Width = 66
      Height = 13
      Caption = #1057#1090#1072#1074#1082#1072' '#1053#1044#1057':'
    end
    object edtName: TRzEdit
      Left = 160
      Top = 8
      Width = 345
      Height = 21
      FrameColor = 12164479
      FrameVisible = True
      TabOrder = 0
    end
    object neVolume: TRzNumericEdit
      Left = 160
      Top = 40
      Width = 73
      Height = 21
      FrameColor = 12164479
      FrameVisible = True
      TabOrder = 1
      DisplayFormat = ',0.00;(,0.00)'
    end
    object neQot: TRzNumericEdit
      Left = 160
      Top = 92
      Width = 73
      Height = 21
      FrameColor = 12164479
      FrameVisible = True
      TabOrder = 3
      DisplayFormat = ',0;(,0)'
    end
    object seTemp: TRzSpinEdit
      Left = 160
      Top = 66
      Width = 73
      Height = 21
      Max = 25.000000000000000000
      Min = 10.000000000000000000
      Value = 10.000000000000000000
      FlatButtons = True
      FrameColor = 12164479
      FrameVisible = True
      TabOrder = 2
    end
    object neQhv: TRzNumericEdit
      Left = 320
      Top = 92
      Width = 73
      Height = 21
      FrameColor = 12164479
      FrameVisible = True
      TabOrder = 4
      IntegersOnly = False
      DisplayFormat = ',0.00;(,0.00)'
    end
    object neQkan: TRzNumericEdit
      Left = 432
      Top = 92
      Width = 73
      Height = 21
      FrameColor = 12164479
      FrameVisible = True
      TabOrder = 5
      IntegersOnly = False
      DisplayFormat = ',0.00;(,0.00)'
    end
    object neProj: TRzNumericEdit
      Left = 160
      Top = 118
      Width = 73
      Height = 21
      FrameColor = 12164479
      FrameVisible = True
      TabOrder = 6
      DisplayFormat = ',0;(,0)'
    end
    object neProj_l: TRzNumericEdit
      Left = 320
      Top = 118
      Width = 73
      Height = 21
      FrameColor = 12164479
      FrameVisible = True
      TabOrder = 7
      DisplayFormat = ',0;(,0)'
    end
    object neSpl: TRzNumericEdit
      Left = 160
      Top = 144
      Width = 73
      Height = 21
      FrameColor = 12164479
      FrameVisible = True
      TabOrder = 8
      IntegersOnly = False
      DisplayFormat = ',0.00;(,0.00)'
    end
    object neSpl_l: TRzNumericEdit
      Left = 320
      Top = 144
      Width = 73
      Height = 21
      FrameColor = 12164479
      FrameVisible = True
      TabOrder = 9
      IntegersOnly = False
      DisplayFormat = ',0.00;(,0.00)'
    end
    object lcbTarifOt: TRzDBLookupComboBox
      Left = 160
      Top = 170
      Width = 233
      Height = 21
      Ctl3D = False
      KeyField = 'kodtt'
      ListField = 'nazt'
      ListSource = DM.dsTarifTeplo
      ParentCtl3D = False
      TabOrder = 10
      FlatButtons = True
      FrameColor = 12164479
      FrameVisible = True
    end
    object lcbTarifVoda: TRzDBLookupComboBox
      Left = 160
      Top = 197
      Width = 233
      Height = 21
      Ctl3D = False
      KeyField = 'kodtv'
      ListField = 'nazt'
      ListSource = DM.dsTarifVoda
      ParentCtl3D = False
      TabOrder = 11
      FlatButtons = True
      FrameColor = 12164479
      FrameVisible = True
    end
    object cboNds: TRzComboBox
      Left = 160
      Top = 223
      Width = 113
      Height = 21
      Ctl3D = False
      FlatButtons = True
      FrameColor = 12164479
      FrameVisible = True
      ItemHeight = 13
      ParentCtl3D = False
      TabOrder = 12
      Items.Strings = (
        '18%'
        #1041#1077#1079' '#1053#1044#1057
        '')
    end
    object lcbKoteln: TRzDBLookupComboBox
      Left = 160
      Top = 250
      Width = 233
      Height = 21
      Ctl3D = False
      KeyField = 'kodkot'
      ListField = 'nazk'
      ListSource = DM.dsKoteln
      ParentCtl3D = False
      TabOrder = 14
      FlatButtons = True
      FrameColor = 12164479
      FrameVisible = True
    end
    object lcbPribor: TRzDBLookupComboBox
      Left = 160
      Top = 277
      Width = 233
      Height = 21
      Ctl3D = False
      KeyField = 'kod'
      ListField = 'nazp'
      ListSource = DM.dsPribor
      ParentCtl3D = False
      TabOrder = 15
      FlatButtons = True
      FrameColor = 12164479
      FrameVisible = True
    end
    object chkUTeplo: TRzCheckBox
      Left = 8
      Top = 304
      Width = 153
      Height = 17
      Caption = #1059#1095#1077#1090' '#1090#1077#1087#1083#1072' '#1085#1072' '#1086#1090#1086#1087#1083#1077#1085#1080#1077
      FrameColor = 8409372
      HighlightColor = 2203937
      HotTrack = True
      HotTrackColor = 3983359
      HotTrackColorType = htctActual
      State = cbUnchecked
      TabOrder = 16
    end
    object chkUGvoda: TRzCheckBox
      Left = 168
      Top = 304
      Width = 225
      Height = 17
      Caption = #1059#1095#1077#1090' '#1090#1077#1087#1083#1072' '#1085#1072' '#1075#1086#1088#1103#1095#1077#1077' '#1074#1086#1076#1086#1089#1085#1072#1073#1078#1077#1085#1080#1077
      FrameColor = 8409372
      HighlightColor = 2203937
      HotTrack = True
      HotTrackColor = 3983359
      HotTrackColorType = htctActual
      State = cbUnchecked
      TabOrder = 17
    end
    object chkPodklOt: TRzCheckBox
      Left = 8
      Top = 323
      Width = 153
      Height = 17
      Caption = #1055#1086#1076#1082#1083#1102#1095#1077#1085' '#1082' '#1090#1077#1087#1083#1086#1089#1077#1090#1103#1084
      Checked = True
      FrameColor = 8409372
      HighlightColor = 2203937
      HotTrack = True
      HotTrackColor = 3983359
      HotTrackColorType = htctActual
      State = cbChecked
      TabOrder = 18
    end
    object chkPodklVoda: TRzCheckBox
      Left = 168
      Top = 323
      Width = 172
      Height = 17
      Caption = #1055#1086#1076#1082#1083#1102#1095#1077#1085' '#1082' '#1074#1086#1076#1103#1085#1099#1084' '#1089#1077#1090#1103#1084
      FrameColor = 8409372
      HighlightColor = 2203937
      HotTrack = True
      HotTrackColor = 3983359
      HotTrackColorType = htctActual
      State = cbUnchecked
      TabOrder = 19
    end
    object chkRaschEcnal: TRzCheckBox
      Left = 8
      Top = 342
      Width = 329
      Height = 17
      Caption = #1051#1100#1075#1086#1090#1072' '#1087#1086' '#1088#1072#1089#1095#1077#1090#1091' '#1101#1082#1086#1083#1086#1075#1080#1095#1077#1089#1082#1086#1075#1086' '#1085#1072#1083#1086#1075#1072
      Checked = True
      FrameColor = 8409372
      HighlightColor = 2203937
      HotTrack = True
      HotTrackColor = 3983359
      HotTrackColorType = htctActual
      State = cbChecked
      TabOrder = 21
    end
    object cbPrinObk: TRzComboBox
      Left = 160
      Top = 363
      Width = 161
      Height = 21
      Ctl3D = False
      FlatButtons = True
      FrameColor = 12164479
      FrameVisible = True
      ItemHeight = 13
      ParentCtl3D = False
      TabOrder = 22
      Items.Strings = (
        #1054#1088#1075#1072#1085#1080#1079#1072#1094#1080#1103
        #1053#1072#1089#1077#1083#1077#1085#1080#1077)
    end
    object chkGvs: TRzCheckBox
      Left = 345
      Top = 323
      Width = 88
      Height = 17
      Caption = #1055#1086#1076#1072#1095#1072' '#1043#1042#1057
      FrameColor = 8409372
      HighlightColor = 2203937
      HotTrack = True
      HotTrackColor = 3983359
      HotTrackColorType = htctActual
      State = cbUnchecked
      TabOrder = 20
    end
    object neNds: TRzNumericEdit
      Left = 352
      Top = 223
      Width = 41
      Height = 21
      FrameColor = 12164479
      FrameVisible = True
      TabOrder = 13
      DisplayFormat = ',0;(,0)'
    end
  end
  object RzPanel2: TRzPanel
    Left = 0
    Top = 390
    Width = 513
    Height = 41
    Align = alBottom
    BorderOuter = fsFlatRounded
    TabOrder = 1
    object BtnOk: TRzBitBtn
      Left = 8
      Top = 8
      Width = 100
      Caption = #1042#1099#1093#1086#1076
      Color = 15791348
      HighlightColor = 16026986
      HotTrack = True
      HotTrackColor = 3983359
      HotTrackColorType = htctActual
      TabOrder = 0
      OnClick = BtnOkClick
      Glyph.Data = {
        36060000424D3606000000000000360400002800000020000000100000000100
        08000000000000020000730B0000730B00000001000000000000000000003300
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
        EEE8E8E8E8E8E8E8E8E8E8E8E8E8E8E8EEE8E8E8E8E8E8E8E8E8E8E8E8EEE3AC
        E3EEE8E8E8E8E8E8E8E8E8E8E8EEE8ACE3EEE8E8E8E8E8E8E8E8E8EEE3E28257
        57E2ACE3EEE8E8E8E8E8E8EEE8E2818181E2ACE8EEE8E8E8E8E8E382578282D7
        578181E2E3E8E8E8E8E8E881818181D7818181E2E8E8E8E8E8E857828989ADD7
        57797979EEE8E8E8E8E88181DEDEACD781818181EEE8E8E8E8E857898989ADD7
        57AAAAA2D7ADE8E8E8E881DEDEDEACD781DEDE81D7ACE8E8E8E857898989ADD7
        57AACEA3AD10E8E8E8E881DEDEDEACD781DEAC81AC81E8E8E8E85789825EADD7
        57ABCFE21110E8E8E8E881DE8181ACD781ACACE28181E8E8E8E8578957D7ADD7
        57ABDE101010101010E881DE56D7ACD781ACDE818181818181E857898257ADD7
        57E810101010101010E881DE8156ACD781E381818181818181E857898989ADD7
        57E882101010101010E881DEDEDEACD781E381818181818181E857898989ADD7
        57ACEE821110E8E8E8E881DEDEDEACD781ACEE818181E8E8E8E857898989ADD7
        57ABE8AB8910E8E8E8E881DEDEDEACD781ACE3ACDE81E8E8E8E857828989ADD7
        57ACE8A3E889E8E8E8E88181DEDEACD781ACE381E8DEE8E8E8E8E8DE5E8288D7
        57A2A2A2E8E8E8E8E8E8E8DE8181DED781818181E8E8E8E8E8E8E8E8E8AC8257
        57E8E8E8E8E8E8E8E8E8E8E8E8AC818181E8E8E8E8E8E8E8E8E8}
      NumGlyphs = 2
    end
  end
end

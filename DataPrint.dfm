object DP: TDP
  OldCreateOrder = False
  Left = 324
  Top = 134
  Height = 649
  Width = 815
  object qryLicevPr: TMSQuery
    Connection = DM.Conect
    SQL.Strings = (
      'select a.kod,a.nazp,sum(b.gkt) as gk_t,sum(b.gkv) as gk_v'
      'from pribor a, dataprib b'
      'where a.kod=b.kodpr and b.datan between :data1 and :data2'
      'group by a.kod, a.nazp'
      'order by kod')
    Left = 9
    Top = 8
    ParamData = <
      item
        DataType = ftDateTime
        Name = 'data1'
        ParamType = ptInput
        Value = 38718d
      end
      item
        DataType = ftDateTime
        Name = 'data2'
        ParamType = ptInput
        Value = 38930d
      end>
  end
  object dsLicevPr: TDataSource
    DataSet = qryLicevPr
    Left = 38
    Top = 8
  end
  object qryLicevPrObekt: TMSQuery
    Connection = DM.Conect
    SQL.Strings = (
      
        'SELECT a.kodobk, a.nazv, c.kodkot, c.nazk, a.q, (a.spl+a.spll) a' +
        's so, (a.prj+a.prjl) as prj, a.kodpr,'
      'b.gkt AS gkal_t,'
      'b.gkv AS gkal_v'
      'FROM OBEKT a, DATAOBEKT b, KOTELN c, dataprib d'
      
        'WHERE a.kodobk=b.kodobk AND a.kodkot = c.kodkot and a.kodpr=d.ko' +
        'dpr and b.datan=d.datan'
      'and b.datan=:data1 and d.gkt>0 and (b.gkt+b.gkv)>0'
      'ORDER BY 3, 1'
      ' ')
    Left = 9
    Top = 35
    ParamData = <
      item
        DataType = ftDateTime
        Name = 'data1'
        ParamType = ptInput
        Value = 39022d
      end>
  end
  object dsLicevPrObekt: TDataSource
    DataSet = qryLicevPrObekt
    Left = 38
    Top = 35
  end
  object qryLicevPrDoma: TMSQuery
    Connection = DM.Conect
    SQL.Strings = (
      
        'select a.koddom,a.kodpr,d.kodkot,d.nazk,sum(g.prj) as prj,sum(g.' +
        'so) as so,sum(g.qot) as qot,(c.nazvul+'#39','#39'+a.ndom) as adres,'
      'sum(b.gkt) as gk_t,'
      'sum(b.gkv) as gk_v, f.nazp'
      
        'from doma a, ulica c, datakvart b, koteln d, dataprib e, pribor ' +
        'f, kvart g'
      
        'where a.kodul=c.kodul and a.koddom=g.koddom and a.kodkot=d.kodko' +
        't and g.kodkv = b.kodkv'
      
        'and a.kodpr=e.kodpr and f.kod = e.kodpr and e.datan=b.datan and ' +
        '(e.gkt+e.gkv)>0'
      'and b.datan=:data1 '
      
        'group by a.koddom,a.kodpr,d.kodkot,d.nazk,(c.nazvul+'#39','#39'+a.ndom),' +
        'f.nazp'
      'having sum(b.gkt)+sum(b.gkv)>0'
      'order by 3, 8'
      ''
      ''
      ' ')
    Left = 9
    Top = 64
    ParamData = <
      item
        DataType = ftDateTime
        Name = 'data1'
        ParamType = ptInput
        Value = 39022d
      end>
  end
  object dsLicevPrDoma: TDataSource
    DataSet = qryLicevPrDoma
    Left = 38
    Top = 64
  end
  object LicevPrObekt: TfrxDBDataset
    UserName = 'dsLicevPrObekt'
    CloseDataSource = True
    DataSource = dsLicevPrObekt
    BCDToCurrency = False
    Left = 41
    Top = 96
  end
  object LicevPrDoma: TfrxDBDataset
    UserName = 'dsLicevPrDoma'
    CloseDataSource = True
    DataSource = dsLicevPrDoma
    BCDToCurrency = False
    Left = 73
    Top = 96
  end
  object LicevPrSet: TfrxDBDataset
    UserName = 'dsLicevPr'
    CloseDataSource = True
    DataSource = dsLicevPr
    BCDToCurrency = False
    Left = 105
    Top = 96
  end
  object Report: TfrxReport
    Version = '4.12'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39064.448561724500000000
    ReportOptions.LastChange = 42581.887956157400000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'procedure MasterData3OnBeforePrint(Sender:TfrxComponent);'
      'begin'
      '  if (<dsLicevCalc."lgkal_t">+<dsLicevCalc."lgkal_v">+'
      
        '     <dsLicevCalc."lkyb_v">+<dsLicevCalc."lkyb_k">+<dsLicevCalc.' +
        '"lkyb_g">)<>0 then'
      '     MasterData3.Visible:=True else'
      '     MasterData3.Visible:=False;'
      'end;'
      ''
      'begin'
      ''
      'end.')
    OnBeforePrint = ReportBeforePrint
    OnGetValue = ReportGetValue
    OnUserFunction = ReportUserFunction
    Left = 232
    Top = 296
    Datasets = <
      item
        DataSet = LicevSet
        DataSetName = 'DSLicevCalc'
      end
      item
        DataSet = Param
        DataSetName = 'dsParam'
      end
      item
        DataSet = Propis
        DataSetName = 'dsPropis'
      end
      item
        DataSet = Schet
        DataSetName = 'dsSchet'
      end>
    Variables = <
      item
        Name = ' My'
        Value = Null
      end
      item
        Name = 'period'
        Value = #1052#1072#1088#1090' 2014 '#1075'.'
      end>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object MainPage: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      object MasterData1: TfrxMasterData
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        Height = 15.118120000000000000
        ParentFont = False
        Top = 532.913730000000000000
        Width = 718.110700000000000000
        DataSet = Schet
        DataSetName = 'dsSchet'
        RowCount = 0
        Stretched = True
        object Memo18: TfrxMemoView
          Left = 3.779530000000000000
          Width = 154.960730000000000000
          Height = 15.118120000000000000
          ShowHint = False
          DataField = 'usluga'
          DataSet = Schet
          DataSetName = 'dsSchet'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8 = (
            '[dsSchet."usluga"]')
          ParentFont = False
        end
        object Memo19: TfrxMemoView
          Left = 158.740260000000000000
          Width = 68.031540000000000000
          Height = 15.118120000000000000
          ShowHint = False
          DataField = 'ed_izm'
          DataSet = Schet
          DataSetName = 'dsSchet'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '[dsSchet."ed_izm"]')
          ParentFont = False
        end
        object Memo20: TfrxMemoView
          Left = 226.771800000000000000
          Width = 71.811070000000000000
          Height = 15.118120000000000000
          ShowHint = False
          DataField = 'kol'
          DataSet = Schet
          DataSetName = 'dsSchet'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '[dsSchet."kol"]')
          ParentFont = False
        end
        object Memo21: TfrxMemoView
          Left = 298.582870000000000000
          Width = 90.708720000000000000
          Height = 15.118120000000000000
          ShowHint = False
          DataField = 'tarif'
          DataSet = Schet
          DataSetName = 'dsSchet'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '[dsSchet."tarif"]')
          ParentFont = False
        end
        object Memo22: TfrxMemoView
          Left = 389.291590000000000000
          Width = 90.708720000000000000
          Height = 15.118120000000000000
          ShowHint = False
          DataField = 'sum_b_nds'
          DataSet = Schet
          DataSetName = 'dsSchet'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '[dsSchet."sum_b_nds"]')
          ParentFont = False
        end
        object Memo23: TfrxMemoView
          Left = 480.000310000000000000
          Width = 49.133890000000000000
          Height = 15.118120000000000000
          ShowHint = False
          DataField = 'stavka_nds'
          DataSet = Schet
          DataSetName = 'dsSchet'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '[dsSchet."stavka_nds"]')
          ParentFont = False
        end
        object Memo24: TfrxMemoView
          Left = 529.134200000000000000
          Width = 90.708720000000000000
          Height = 15.118120000000000000
          ShowHint = False
          DataField = 'nds'
          DataSet = Schet
          DataSetName = 'dsSchet'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '[dsSchet."nds"]')
          ParentFont = False
        end
        object Memo25: TfrxMemoView
          Left = 619.842920000000000000
          Width = 90.708720000000000000
          Height = 15.118120000000000000
          ShowHint = False
          DataField = 'sum_s_nds'
          DataSet = Schet
          DataSetName = 'dsSchet'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '[dsSchet."sum_s_nds"]')
          ParentFont = False
        end
      end
      object PageHeader1: TfrxPageHeader
        Height = 453.543600000000000000
        Top = 18.897650000000000000
        Width = 718.110700000000000000
        object Line19: TfrxLineView
          Left = 200.315090000000000000
          Top = 325.039580000000000000
          Width = 514.016080000000000000
          ShowHint = False
          Frame.Typ = [ftTop]
        end
        object Memo52: TfrxMemoView
          Left = 3.779530000000000000
          Top = 328.819110000000000000
          Width = 192.756030000000000000
          Height = 15.118120000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Memo.UTF8 = (
            #1056#1116#1056#176#1056#1105#1056#1112#1056#181#1056#1029#1056#1109#1056#1030#1056#176#1056#1029#1056#1105#1056#181' '#1056#177#1056#176#1056#1029#1056#1108#1056#176
            ' ')
          ParentFont = False
        end
        object Memo53: TfrxMemoView
          Left = 200.315090000000000000
          Top = 328.819110000000000000
          Width = 514.016080000000000000
          Height = 26.456710000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Memo.UTF8 = (
            '[dsSchet."bank_org"]')
          ParentFont = False
        end
        object Line20: TfrxLineView
          Left = 200.315090000000000000
          Top = 359.055350000000000000
          Width = 514.016080000000000000
          ShowHint = False
          Frame.Typ = [ftTop]
        end
        object Memo29: TfrxMemoView
          Left = 521.575140000000000000
          Top = 3.779530000000000000
          Width = 192.756030000000000000
          Height = 30.236240000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8 = (
            #1056#1038#1057#8225#1056#181#1057#8218'-'#1057#8222#1056#176#1056#1108#1057#8218#1057#1107#1057#1026#1056#176' '#1056#1111#1057#1026#1056#181#1056#1169#1057#1027#1057#8218#1056#176#1056#1030#1056#187#1057#1039#1056#181#1057#8218#1057#1027#1057#1039
            #1056#1029#1056#176' '#1056#1109#1056#1169#1056#1029#1056#1109#1056#1112' '#1056#187#1056#1105#1057#1027#1057#8218#1056#181)
          ParentFont = False
        end
        object Line12: TfrxLineView
          Left = 521.575140000000000000
          Top = 37.795300000000000000
          Width = 192.756030000000000000
          ShowHint = False
          Frame.Typ = [ftTop]
        end
        object Memo30: TfrxMemoView
          Left = 521.575140000000000000
          Top = 37.795300000000000000
          Width = 192.756030000000000000
          Height = 18.897650000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8 = (
            '('#1056#1111#1057#1026#1056#1109#1056#1111#1056#1105#1057#1027#1057#1034#1057#1035')')
          ParentFont = False
        end
        object Memo31: TfrxMemoView
          Left = 3.779530000000000000
          Top = 60.472480000000000000
          Width = 710.551640000000000000
          Height = 30.236240000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8 = (
            #1056#1038#1056#167#1056#8226#1056#1118' - '#1056#164#1056#1106#1056#1113#1056#1118#1056#1032#1056#160#1056#1106' '#1056#8211#1056#1113#1056#1168' '#1074#8222#8211' [<dsSchet."kodorg">]'
            #1056#183#1056#176' [period]')
          ParentFont = False
        end
        object Memo32: TfrxMemoView
          Left = 3.779530000000000000
          Top = 94.488250000000000000
          Width = 192.756030000000000000
          Height = 18.897650000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8 = (
            '[Date #ddd mmmm yyyy] '#1056#1110'. ')
          ParentFont = False
        end
        object Line13: TfrxLineView
          Left = 3.779530000000000000
          Top = 117.165430000000000000
          Width = 192.756030000000000000
          ShowHint = False
          Frame.Typ = [ftTop]
        end
        object Memo33: TfrxMemoView
          Left = 3.779530000000000000
          Top = 117.165430000000000000
          Width = 192.756030000000000000
          Height = 18.897650000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8 = (
            '('#1056#1169#1056#176#1057#8218#1056#176')')
          ParentFont = False
        end
        object Memo34: TfrxMemoView
          Left = 521.575140000000000000
          Top = 94.488250000000000000
          Width = 192.756030000000000000
          Height = 18.897650000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8 = (
            ' '#1056#1110'. '#1056#8220#1056#1109#1057#1026#1056#1108#1056#1105)
          ParentFont = False
        end
        object Line14: TfrxLineView
          Left = 521.575140000000000000
          Top = 117.165430000000000000
          Width = 192.756030000000000000
          ShowHint = False
          Frame.Typ = [ftTop]
        end
        object Memo35: TfrxMemoView
          Left = 521.575140000000000000
          Top = 117.165430000000000000
          Width = 192.756030000000000000
          Height = 18.897650000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8 = (
            '('#1056#1112#1056#181#1057#1027#1057#8218#1056#1109' '#1057#1027#1056#1109#1057#1027#1057#8218#1056#176#1056#1030#1056#187#1056#181#1056#1029#1056#1105#1057#1039')')
          ParentFont = False
        end
        object Memo36: TfrxMemoView
          Left = 3.779530000000000000
          Top = 143.622140000000000000
          Width = 192.756030000000000000
          Height = 15.118120000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold, fsUnderline]
          Memo.UTF8 = (
            #1056#1119#1057#1026#1056#1109#1056#1169#1056#176#1056#1030#1056#181#1057#8224':')
          ParentFont = False
        end
        object Memo37: TfrxMemoView
          Left = 3.779530000000000000
          Top = 162.519790000000000000
          Width = 192.756030000000000000
          Height = 15.118120000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Memo.UTF8 = (
            #1056#1116#1056#176#1056#1105#1056#1112#1056#181#1056#1029#1056#1109#1056#1030#1056#176#1056#1029#1056#1105#1056#181)
          ParentFont = False
        end
        object Memo38: TfrxMemoView
          Left = 200.315090000000000000
          Top = 162.519790000000000000
          Width = 514.016080000000000000
          Height = 15.118120000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Memo.UTF8 = (
            '[dsParam."nazvorg"]')
          ParentFont = False
        end
        object Line15: TfrxLineView
          Left = 200.315090000000000000
          Top = 177.637910000000000000
          Width = 514.016080000000000000
          ShowHint = False
          Frame.Typ = [ftTop]
        end
        object Memo39: TfrxMemoView
          Left = 3.779530000000000000
          Top = 181.417440000000000000
          Width = 192.756030000000000000
          Height = 15.118120000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Memo.UTF8 = (
            #1056#1106#1056#1169#1057#1026#1056#181#1057#1027)
          ParentFont = False
        end
        object Memo40: TfrxMemoView
          Left = 200.315090000000000000
          Top = 181.417440000000000000
          Width = 514.016080000000000000
          Height = 15.118120000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Memo.UTF8 = (
            '[dsParam."adresorg"]')
          ParentFont = False
        end
        object Line16: TfrxLineView
          Left = 200.315090000000000000
          Top = 196.535560000000000000
          Width = 514.016080000000000000
          ShowHint = False
          Frame.Typ = [ftTop]
        end
        object Memo41: TfrxMemoView
          Left = 3.779530000000000000
          Top = 200.315090000000000000
          Width = 34.015770000000000000
          Height = 15.118120000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Memo.UTF8 = (
            #1056#1032#1056#1116#1056#1119)
          ParentFont = False
        end
        object Memo42: TfrxMemoView
          Left = 200.315090000000000000
          Top = 200.315090000000000000
          Width = 514.016080000000000000
          Height = 15.118120000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Memo.UTF8 = (
            
              #1056#160#1056#176#1057#1027#1057#8225#1056#181#1057#8218#1056#1029#1057#8249#1056#8470' '#1057#1027#1057#8225#1056#181#1057#8218' [dsParam."rshetorg"] '#1056#1113#1056#1109#1056#1169' '#1056#177#1056#176#1056#1029#1056#1108 +
              #1056#176' [dsParam."kodbank"]')
          ParentFont = False
        end
        object Line17: TfrxLineView
          Left = 200.315090000000000000
          Top = 215.433210000000000000
          Width = 514.016080000000000000
          ShowHint = False
          Frame.Typ = [ftTop]
        end
        object Memo43: TfrxMemoView
          Left = 41.574830000000000000
          Top = 200.315090000000000000
          Width = 154.960730000000000000
          Height = 15.118120000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Memo.UTF8 = (
            '[dsParam."unnorg"]')
          ParentFont = False
        end
        object Memo44: TfrxMemoView
          Left = 3.779530000000000000
          Top = 219.212740000000000000
          Width = 192.756030000000000000
          Height = 15.118120000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Memo.UTF8 = (
            #1056#1116#1056#176#1056#1105#1056#1112#1056#181#1056#1029#1056#1109#1056#1030#1056#176#1056#1029#1056#1105#1056#181' '#1056#177#1056#176#1056#1029#1056#1108#1056#176
            ' ')
          ParentFont = False
        end
        object Memo45: TfrxMemoView
          Left = 200.315090000000000000
          Top = 219.212740000000000000
          Width = 514.016080000000000000
          Height = 15.118120000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Memo.UTF8 = (
            '[dsParam."nazv_bank"], [dsParam."adres_bank"]')
          ParentFont = False
        end
        object Line18: TfrxLineView
          Left = 200.315090000000000000
          Top = 234.330860000000000000
          Width = 514.016080000000000000
          ShowHint = False
          Frame.Typ = [ftTop]
        end
        object BarCode2: TfrxBarCodeView
          Left = 5.972480000000000000
          Top = 7.559060000000000000
          Width = 109.000000000000000000
          Height = 45.354330710000000000
          ShowHint = False
          BarType = bcCode93Extended
          CalcCheckSum = True
          DataSet = Param
          DataSetName = 'dsParam'
          Expression = 
            'IntToStr(Dayof(<Date>))+'#39' '#39'+IntToStr(MonthOf(<Date>))+'#39' '#39'+IntToS' +
            'tr(YearOf(<Date>))+'#39'   '#39'+<dsParam."nazvorg">'
          Rotation = 0
          Text = '12345678'
          WideBarRatio = 2.000000000000000000
          Zoom = 1.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
        end
        object Memo46: TfrxMemoView
          Left = 3.779530000000000000
          Top = 249.448980000000000000
          Width = 192.756030000000000000
          Height = 15.118120000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold, fsUnderline]
          Memo.UTF8 = (
            #1056#1119#1056#1109#1056#1108#1057#1107#1056#1111#1056#176#1057#8218#1056#181#1056#187#1057#1034':')
          ParentFont = False
        end
        object Memo47: TfrxMemoView
          Left = 3.779530000000000000
          Top = 268.346630000000000000
          Width = 192.756030000000000000
          Height = 15.118120000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Memo.UTF8 = (
            #1056#1116#1056#176#1056#1105#1056#1112#1056#181#1056#1029#1056#1109#1056#1030#1056#176#1056#1029#1056#1105#1056#181)
          ParentFont = False
        end
        object Memo48: TfrxMemoView
          Left = 200.315090000000000000
          Top = 268.346630000000000000
          Width = 514.016080000000000000
          Height = 15.118120000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Memo.UTF8 = (
            '[dsSchet."nazv_org"]')
          ParentFont = False
        end
        object Memo49: TfrxMemoView
          Left = 3.779530000000000000
          Top = 287.244280000000000000
          Width = 192.756030000000000000
          Height = 15.118120000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Memo.UTF8 = (
            #1056#1106#1056#1169#1057#1026#1056#181#1057#1027)
          ParentFont = False
        end
        object Memo50: TfrxMemoView
          Left = 200.315090000000000000
          Top = 287.244280000000000000
          Width = 514.016080000000000000
          Height = 15.118120000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Memo.UTF8 = (
            '[dsSchet."adres_org"]')
          ParentFont = False
        end
        object Memo51: TfrxMemoView
          Left = 41.574830000000000000
          Top = 306.141930000000000000
          Width = 154.960730000000000000
          Height = 15.118120000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Memo.UTF8 = (
            '[dsSchet."unn_org"]')
          ParentFont = False
        end
        object Memo54: TfrxMemoView
          Left = 3.779530000000000000
          Top = 306.141930000000000000
          Width = 34.015770000000000000
          Height = 15.118120000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Memo.UTF8 = (
            #1056#1032#1056#1116#1056#1119)
          ParentFont = False
        end
        object Memo55: TfrxMemoView
          Left = 200.315090000000000000
          Top = 306.141930000000000000
          Width = 514.016080000000000000
          Height = 15.118120000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Memo.UTF8 = (
            #1056#160#1056#176#1057#1027#1057#8225#1056#181#1057#8218#1056#1029#1057#8249#1056#8470' '#1057#1027#1057#8225#1056#181#1057#8218' [dsSchet."rs_org"]')
          ParentFont = False
        end
        object Line21: TfrxLineView
          Left = 204.094620000000000000
          Top = 283.464750000000000000
          Width = 514.016080000000000000
          ShowHint = False
          Frame.Typ = [ftTop]
        end
        object Line22: TfrxLineView
          Left = 204.094620000000000000
          Top = 302.362400000000000000
          Width = 514.016080000000000000
          ShowHint = False
          Frame.Typ = [ftTop]
        end
        object Memo2: TfrxMemoView
          Left = 3.779530000000000000
          Top = 396.850650000000000000
          Width = 154.960730000000000000
          Height = 41.574830000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            #1056#1116#1056#176#1056#1105#1056#1112#1056#181#1056#1029#1056#1109#1056#1030#1056#176#1056#1029#1056#1105#1056#181' '#1057#1107#1057#1027#1056#187#1057#1107#1056#1110#1056#1105)
          ParentFont = False
        end
        object Memo3: TfrxMemoView
          Left = 158.740260000000000000
          Top = 396.850650000000000000
          Width = 68.031540000000000000
          Height = 41.574830000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            #1056#8226#1056#1169#1056#1105#1056#1029#1056#1105#1057#8224#1056#176' '#1056#1105#1056#183#1056#1112#1056#181#1057#1026#1056#181#1056#1029#1056#1105#1057#1039)
          ParentFont = False
        end
        object Memo4: TfrxMemoView
          Left = 226.771800000000000000
          Top = 396.850650000000000000
          Width = 71.811070000000000000
          Height = 41.574830000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            #1056#1113#1056#1109#1056#187#1056#1105#1057#8225#1056#181#1057#1027#1057#8218#1056#1030#1056#1109)
          ParentFont = False
        end
        object Memo5: TfrxMemoView
          Left = 298.582870000000000000
          Top = 396.850650000000000000
          Width = 90.708720000000000000
          Height = 41.574830000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            #1056#166#1056#181#1056#1029#1056#176' ('#1057#8218#1056#176#1057#1026#1056#1105#1057#8222') '#1056#183#1056#176' '#1056#181#1056#1169#1056#1105#1056#1029#1056#1105#1057#8224#1057#1107', '#1057#1026#1057#1107#1056#177'.')
          ParentFont = False
        end
        object Memo6: TfrxMemoView
          Left = 389.291590000000000000
          Top = 396.850650000000000000
          Width = 90.708720000000000000
          Height = 41.574830000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            #1056#1038#1057#1107#1056#1112#1056#1112#1056#176' '#1056#177#1056#181#1056#183' '#1056#1116#1056#8221#1056#1038', '#1057#1026#1057#1107#1056#177'.')
          ParentFont = False
        end
        object Memo7: TfrxMemoView
          Left = 480.000310000000000000
          Top = 396.850650000000000000
          Width = 49.133890000000000000
          Height = 41.574830000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            #1056#1038#1057#8218#1056#176#1056#1030#1056#1108#1056#176' '#1056#1116#1056#8221#1056#1038', %.')
          ParentFont = False
        end
        object Memo8: TfrxMemoView
          Left = 529.134200000000000000
          Top = 396.850650000000000000
          Width = 90.708720000000000000
          Height = 41.574830000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            #1056#1038#1057#1107#1056#1112#1056#1112#1056#176' '#1056#1116#1056#8221#1056#1038', '#1057#1026#1057#1107#1056#177'.')
          ParentFont = False
        end
        object Memo9: TfrxMemoView
          Left = 619.842920000000000000
          Top = 396.850650000000000000
          Width = 90.708720000000000000
          Height = 41.574830000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            #1056#1038#1057#1107#1056#1112#1056#1112#1056#176' '#1057#1027' '#1056#1116#1056#8221#1056#1038', '#1057#1026#1057#1107#1056#177'.')
          ParentFont = False
        end
        object Memo10: TfrxMemoView
          Left = 3.779530000000000000
          Top = 438.425480000000000000
          Width = 154.960730000000000000
          Height = 15.118120000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '1')
          ParentFont = False
        end
        object Memo11: TfrxMemoView
          Left = 158.740260000000000000
          Top = 438.425480000000000000
          Width = 68.031540000000000000
          Height = 15.118120000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '2')
          ParentFont = False
        end
        object Memo12: TfrxMemoView
          Left = 226.771800000000000000
          Top = 438.425480000000000000
          Width = 71.811070000000000000
          Height = 15.118120000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '3')
          ParentFont = False
        end
        object Memo13: TfrxMemoView
          Left = 298.582870000000000000
          Top = 438.425480000000000000
          Width = 90.708720000000000000
          Height = 15.118120000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '4')
          ParentFont = False
        end
        object Memo14: TfrxMemoView
          Left = 389.291590000000000000
          Top = 438.425480000000000000
          Width = 90.708720000000000000
          Height = 15.118120000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '5')
          ParentFont = False
        end
        object Memo15: TfrxMemoView
          Left = 480.000310000000000000
          Top = 438.425480000000000000
          Width = 49.133890000000000000
          Height = 15.118120000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '6')
          ParentFont = False
        end
        object Memo16: TfrxMemoView
          Left = 529.134200000000000000
          Top = 438.425480000000000000
          Width = 90.708720000000000000
          Height = 15.118120000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '7')
          ParentFont = False
        end
        object Memo17: TfrxMemoView
          Left = 619.842920000000000000
          Top = 438.425480000000000000
          Width = 90.708720000000000000
          Height = 15.118120000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '8')
          ParentFont = False
        end
      end
      object Footer1: TfrxFooter
        Height = 411.968770000000000000
        Top = 570.709030000000000000
        Width = 718.110700000000000000
        object Memo1: TfrxMemoView
          Left = 3.779530000000000000
          Width = 154.960730000000000000
          Height = 15.118120000000000000
          ShowHint = False
          DataSet = Schet
          DataSetName = 'dsSchet'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8 = (
            #1056#152#1056#1118#1056#1115#1056#8220#1056#1115':')
          ParentFont = False
        end
        object Memo26: TfrxMemoView
          Left = 158.740260000000000000
          Width = 68.031540000000000000
          Height = 15.118120000000000000
          ShowHint = False
          DataSet = Schet
          DataSetName = 'dsSchet'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            'x')
          ParentFont = False
        end
        object Memo27: TfrxMemoView
          Left = 226.771800000000000000
          Width = 71.811070000000000000
          Height = 15.118120000000000000
          ShowHint = False
          DataSet = Schet
          DataSetName = 'dsSchet'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            'x')
          ParentFont = False
        end
        object Memo28: TfrxMemoView
          Left = 298.582870000000000000
          Width = 90.708720000000000000
          Height = 15.118120000000000000
          ShowHint = False
          DataSet = Schet
          DataSetName = 'dsSchet'
          DisplayFormat.FormatStr = '%2.2m'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            'x')
          ParentFont = False
        end
        object Memo56: TfrxMemoView
          Left = 389.291590000000000000
          Width = 90.708720000000000000
          Height = 15.118120000000000000
          ShowHint = False
          DataSet = Schet
          DataSetName = 'dsSchet'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '[sum(<dsSchet."sum_b_nds">)]')
          ParentFont = False
        end
        object Memo57: TfrxMemoView
          Left = 480.000310000000000000
          Width = 49.133890000000000000
          Height = 15.118120000000000000
          ShowHint = False
          DataSet = Schet
          DataSetName = 'dsSchet'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            'x')
          ParentFont = False
        end
        object Memo58: TfrxMemoView
          Left = 529.134200000000000000
          Width = 90.708720000000000000
          Height = 15.118120000000000000
          ShowHint = False
          DataSet = Schet
          DataSetName = 'dsSchet'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '[sum(<dsSchet."nds">)]')
          ParentFont = False
        end
        object Memo59: TfrxMemoView
          Left = 619.842920000000000000
          Width = 90.708720000000000000
          Height = 15.118120000000000000
          ShowHint = False
          DataSet = Schet
          DataSetName = 'dsSchet'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '[sum(<dsSchet."sum_s_nds">)]')
          ParentFont = False
        end
        object Memo60: TfrxMemoView
          Left = 3.779530000000000000
          Top = 34.015770000000000000
          Width = 147.401670000000000000
          Height = 15.118120000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Memo.UTF8 = (
            #1056#1038#1057#1107#1056#1112#1056#1112#1056#176' '#1056#1116#1056#8221#1056#1038)
          ParentFont = False
        end
        object Memo61: TfrxMemoView
          Left = 154.960730000000000000
          Top = 34.015770000000000000
          Width = 559.370440000000000000
          Height = 15.118120000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Memo.UTF8 = (
            
              '[Money(sum(<dsSchet."nds">,MasterData1),<dsPropis."ruble_prop">,' +
              '<dsPropis."kopeika_prop">,<dsPropis."print_kop">]')
          ParentFont = False
        end
        object Line1: TfrxLineView
          Left = 158.740260000000000000
          Top = 49.133889999999900000
          Width = 555.590910000000000000
          ShowHint = False
          Frame.Typ = [ftTop]
        end
        object Memo62: TfrxMemoView
          Left = 321.260050000000000000
          Top = 45.354360000000000000
          Width = 192.756030000000000000
          Height = 18.897650000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8 = (
            '('#1056#1111#1057#1026#1056#1109#1056#1111#1056#1105#1057#1027#1057#1034#1057#1035')')
          ParentFont = False
        end
        object Memo63: TfrxMemoView
          Left = 3.779530000000000000
          Top = 64.252010000000000000
          Width = 147.401670000000000000
          Height = 15.118120000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Memo.UTF8 = (
            #1056#152#1057#8218#1056#1109#1056#1110#1056#1109' '#1056#1029#1056#176' '#1057#1027#1057#1107#1056#1112#1056#1112#1057#1107' '#1057#1027' '#1056#1116#1056#8221#1056#1038)
          ParentFont = False
        end
        object Memo64: TfrxMemoView
          Left = 154.960730000000000000
          Top = 64.252010000000000000
          Width = 559.370440000000000000
          Height = 15.118120000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Memo.UTF8 = (
            
              '[Money(sum(<dsSchet."sum_s_nds">,MasterData1),<dsPropis."ruble_p' +
              'rop">,<dsPropis."kopeika_prop">,<dsPropis."print_kop">)]')
          ParentFont = False
        end
        object Memo65: TfrxMemoView
          Left = 321.260050000000000000
          Top = 75.590600000000000000
          Width = 192.756030000000000000
          Height = 18.897650000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8 = (
            '('#1056#1111#1057#1026#1056#1109#1056#1111#1056#1105#1057#1027#1057#1034#1057#1035')')
          ParentFont = False
        end
        object Line2: TfrxLineView
          Left = 154.960730000000000000
          Top = 79.370130000000000000
          Width = 555.590910000000000000
          ShowHint = False
          Frame.Typ = [ftTop]
        end
        object Memo66: TfrxMemoView
          Left = 3.779530000000000000
          Top = 94.488250000000000000
          Width = 147.401670000000000000
          Height = 15.118120000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Memo.UTF8 = (
            #1056#1115#1056#177#1056#1109#1057#1027#1056#1029#1056#1109#1056#1030#1056#176#1056#1029#1056#1105#1056#181' '#1057#8224#1056#181#1056#1029#1057#8249' ('#1057#8218#1056#176#1057#1026#1056#1105#1057#8222#1056#176')')
          ParentFont = False
        end
        object Memo67: TfrxMemoView
          Left = 154.960730000000000000
          Top = 94.488250000000000000
          Width = 559.370440000000000000
          Height = 15.118120000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Line3: TfrxLineView
          Left = 154.960730000000000000
          Top = 109.606370000000000000
          Width = 555.590910000000000000
          ShowHint = False
          Frame.Typ = [ftTop]
        end
        object Line4: TfrxLineView
          Left = 3.779530000000000000
          Top = 132.283550000000000000
          Width = 710.551640000001000000
          ShowHint = False
          Frame.Typ = [ftTop]
        end
        object Memo68: TfrxMemoView
          Left = 3.779530000000000000
          Top = 147.401670000000000000
          Width = 147.401670000000000000
          Height = 15.118120000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Memo.UTF8 = (
            #1056#1119#1057#1026#1056#1109#1056#1169#1056#176#1056#1030#1056#181#1057#8224':')
          ParentFont = False
        end
        object Memo69: TfrxMemoView
          Left = 3.779530000000000000
          Top = 170.078850000000000000
          Width = 147.401670000000000000
          Height = 15.118120000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Memo.UTF8 = (
            '[<dsParam."dolgn_chif">]')
          ParentFont = False
        end
        object Line5: TfrxLineView
          Left = 3.779530000000000000
          Top = 185.196970000000000000
          Width = 147.401670000000000000
          ShowHint = False
          Frame.Typ = [ftTop]
        end
        object Memo70: TfrxMemoView
          Left = 3.779530000000000000
          Top = 185.196970000000000000
          Width = 147.401670000000000000
          Height = 18.897650000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8 = (
            '('#1056#1169#1056#1109#1056#187#1056#182#1056#1029#1056#1109#1057#1027#1057#8218#1057#1034')')
          ParentFont = False
        end
        object Memo71: TfrxMemoView
          Left = 162.519790000000000000
          Top = 170.078850000000000000
          Width = 147.401670000000000000
          Height = 15.118120000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Line6: TfrxLineView
          Left = 162.519790000000000000
          Top = 185.196970000000000000
          Width = 147.401670000000000000
          ShowHint = False
          Frame.Typ = [ftTop]
        end
        object Memo72: TfrxMemoView
          Left = 162.519790000000000000
          Top = 185.196970000000000000
          Width = 147.401670000000000000
          Height = 18.897650000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8 = (
            '('#1056#1111#1056#1109#1056#1169#1056#1111#1056#1105#1057#1027#1057#1034')')
          ParentFont = False
        end
        object Memo73: TfrxMemoView
          Left = 321.260050000000000000
          Top = 170.078850000000000000
          Width = 249.448980000000000000
          Height = 15.118120000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8 = (
            '[<dsParam."fio_chif">]')
          ParentFont = False
        end
        object Line7: TfrxLineView
          Left = 321.260050000000000000
          Top = 185.196970000000000000
          Width = 249.448980000000000000
          ShowHint = False
          Frame.Typ = [ftTop]
        end
        object Memo74: TfrxMemoView
          Left = 321.260050000000000000
          Top = 185.196970000000000000
          Width = 249.448980000000000000
          Height = 18.897650000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8 = (
            '('#1057#8222#1056#176#1056#1112#1056#1105#1056#187#1056#1105#1057#1039', '#1056#1105#1056#1029#1056#1105#1057#8224#1056#1105#1056#176#1056#187#1057#8249')')
          ParentFont = False
        end
        object Memo75: TfrxMemoView
          Left = 3.779530000000000000
          Top = 222.992270000000000000
          Width = 147.401670000000000000
          Height = 15.118120000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Memo.UTF8 = (
            #1056#1114'.'#1056#1119'.')
          ParentFont = False
        end
        object Memo76: TfrxMemoView
          Left = 7.559060000000000000
          Top = 260.787570000000000000
          Width = 71.811070000000000000
          Height = 15.118120000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Memo.UTF8 = (
            #1056#8217#1057#8249#1056#1169#1056#176#1056#187':')
          ParentFont = False
        end
        object Memo77: TfrxMemoView
          Left = 79.370130000000000000
          Top = 272.126160000000000000
          Width = 109.606370000000000000
          Height = 15.118120000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Memo78: TfrxMemoView
          Left = 79.370130000000000000
          Top = 287.244280000000000000
          Width = 109.606370000000000000
          Height = 18.897650000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8 = (
            '('#1056#1111#1056#1109#1056#1169#1056#1111#1056#1105#1057#1027#1057#1034')')
          ParentFont = False
        end
        object Memo79: TfrxMemoView
          Left = 196.535560000000000000
          Top = 272.126160000000000000
          Width = 166.299320000000000000
          Height = 15.118120000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          HAlign = haCenter
          ParentFont = False
        end
        object Line8: TfrxLineView
          Left = 196.535560000000000000
          Top = 287.244280000000000000
          Width = 166.299320000000000000
          ShowHint = False
          Frame.Typ = [ftTop]
        end
        object Memo80: TfrxMemoView
          Left = 196.535560000000000000
          Top = 287.244280000000000000
          Width = 166.299320000000000000
          Height = 18.897650000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8 = (
            '('#1057#8222#1056#176#1056#1112#1056#1105#1056#187#1056#1105#1057#1039', '#1056#1105#1056#1029#1056#1105#1057#8224#1056#1105#1056#176#1056#187#1057#8249')')
          ParentFont = False
        end
        object Line9: TfrxLineView
          Left = 79.370130000000000000
          Top = 287.244280000000000000
          Width = 109.606370000000000000
          ShowHint = False
          Frame.Typ = [ftTop]
        end
        object Memo81: TfrxMemoView
          Left = 362.834880000000000000
          Top = 260.787570000000000000
          Width = 71.811070000000000000
          Height = 15.118120000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Memo.UTF8 = (
            #1056#1119#1056#1109#1056#187#1057#1107#1057#8225#1056#1105#1056#187':')
          ParentFont = False
        end
        object Memo82: TfrxMemoView
          Left = 430.866420000000000000
          Top = 272.126160000000000000
          Width = 109.606370000000000000
          Height = 15.118120000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Memo83: TfrxMemoView
          Left = 430.866420000000000000
          Top = 287.244280000000000000
          Width = 109.606370000000000000
          Height = 18.897650000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8 = (
            '('#1056#1111#1056#1109#1056#1169#1056#1111#1056#1105#1057#1027#1057#1034')')
          ParentFont = False
        end
        object Memo84: TfrxMemoView
          Left = 548.031850000000000000
          Top = 272.126160000000000000
          Width = 166.299320000000000000
          Height = 15.118120000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          HAlign = haCenter
          ParentFont = False
        end
        object Memo85: TfrxMemoView
          Left = 548.031850000000000000
          Top = 287.244280000000000000
          Width = 166.299320000000000000
          Height = 18.897650000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8 = (
            '('#1057#8222#1056#176#1056#1112#1056#1105#1056#187#1056#1105#1057#1039', '#1056#1105#1056#1029#1056#1105#1057#8224#1056#1105#1056#176#1056#187#1057#8249')')
          ParentFont = False
        end
        object Line10: TfrxLineView
          Left = 548.031850000000000000
          Top = 287.244280000000000000
          Width = 166.299320000000000000
          ShowHint = False
          Frame.Typ = [ftTop]
        end
        object Line11: TfrxLineView
          Left = 430.866420000000000000
          Top = 287.244280000000000000
          Width = 109.606370000000000000
          ShowHint = False
          Frame.Typ = [ftTop]
        end
        object Memo86: TfrxMemoView
          Left = 41.574830000000000000
          Top = 321.260050000000000000
          Width = 109.606370000000000000
          Height = 15.118120000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Memo87: TfrxMemoView
          Left = 41.574830000000000000
          Top = 336.378170000000000000
          Width = 109.606370000000000000
          Height = 18.897650000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8 = (
            '('#1056#1169#1056#176#1057#8218#1056#176' '#1056#1030#1057#8249#1056#1169#1056#176#1057#8225#1056#1105')')
          ParentFont = False
        end
        object Line23: TfrxLineView
          Left = 41.574830000000000000
          Top = 336.378170000000000000
          Width = 109.606370000000000000
          ShowHint = False
          Frame.Typ = [ftTop]
        end
        object Memo88: TfrxMemoView
          Left = 415.748300000000000000
          Top = 321.260050000000000000
          Width = 109.606370000000000000
          Height = 15.118120000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Memo89: TfrxMemoView
          Left = 415.748300000000000000
          Top = 336.378170000000000000
          Width = 109.606370000000000000
          Height = 18.897650000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8 = (
            '('#1056#1169#1056#176#1057#8218#1056#176' '#1056#1111#1056#1109#1056#187#1057#1107#1057#8225#1056#181#1056#1029#1056#1105#1057#1039')')
          ParentFont = False
        end
        object Line24: TfrxLineView
          Left = 415.748300000000000000
          Top = 336.378170000000000000
          Width = 109.606370000000000000
          ShowHint = False
          Frame.Typ = [ftTop]
        end
        object Memo90: TfrxMemoView
          Left = 3.779530000000000000
          Top = 377.953000000000000000
          Width = 710.551640000000000000
          Height = 34.015770000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Memo.UTF8 = (
            #1056#1119#1057#1026#1056#1105#1056#1112#1056#181#1057#8225#1056#176#1056#1029#1056#1105#1056#181'.'
            
              #1056#1038#1057#8225#1056#181#1057#8218'-'#1057#8222#1056#176#1056#1108#1057#8218#1057#1107#1057#1026#1056#176' ('#1056#8211#1056#1113#1056#1168') '#1057#1039#1056#1030#1056#187#1057#1039#1056#181#1057#8218#1057#1027#1057#1039' '#1056#176#1056#1108#1057#8218#1056#1109#1056#1112' '#1056#1109#1056 +
              #1108#1056#176#1056#183#1056#176#1056#1029#1056#1029#1057#8249#1057#8230' '#1057#1107#1057#1027#1056#187#1057#1107#1056#1110' ('#1056#1030#1057#8249#1056#1111#1056#1109#1056#187#1056#1029#1056#181#1056#1029#1056#1029#1057#8249#1057#8230' '#1057#1026#1056#176#1056#177#1056#1109#1057#8218').')
          ParentFont = False
        end
      end
    end
    object TranscriptPage: TfrxReportPage
      Orientation = poLandscape
      PaperWidth = 297.000000000000000000
      PaperHeight = 210.000000000000000000
      PaperSize = 9
      LeftMargin = 5.000000000000000000
      RightMargin = 5.000000000000000000
      TopMargin = 5.000000000000000000
      BottomMargin = 5.000000000000000000
      object MasterData2: TfrxMasterData
        Height = 37.795300000000000000
        Top = 238.110390000000000000
        Width = 1084.725110000000000000
        DataSet = LicevSet
        DataSetName = 'DSLicevCalc'
        RowCount = 0
        Stretched = True
        object Memo110: TfrxMemoView
          Left = 7.559060000000000000
          Width = 147.401670000000000000
          Height = 37.795300000000000000
          ShowHint = False
          StretchMode = smActualHeight
          DataField = 'nazv'
          DataSet = LicevSet
          DataSetName = 'DSLicevCalc'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8 = (
            '[DSLicevCalc."nazv"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo111: TfrxMemoView
          ShiftMode = smDontShift
          Left = 154.960730000000000000
          Width = 52.913420000000000000
          Height = 18.897650000000000000
          ShowHint = False
          DataField = 'gkal_t'
          DataSet = LicevSet
          DataSetName = 'DSLicevCalc'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '[DSLicevCalc."gkal_t"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo112: TfrxMemoView
          Left = 154.960730000000000000
          Top = 18.897650000000000000
          Width = 52.913420000000000000
          Height = 18.897650000000000000
          ShowHint = False
          StretchMode = smMaxHeight
          DataField = 'gkal_v'
          DataSet = LicevSet
          DataSetName = 'DSLicevCalc'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '[DSLicevCalc."gkal_v"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo113: TfrxMemoView
          Left = 207.874150000000000000
          Width = 52.913420000000000000
          Height = 37.795300000000000000
          ShowHint = False
          StretchMode = smMaxHeight
          DataField = 'tarif_t'
          DataSet = LicevSet
          DataSetName = 'DSLicevCalc'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '[DSLicevCalc."tarif_t"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo114: TfrxMemoView
          Left = 260.787570000000000000
          Width = 68.031540000000000000
          Height = 18.897650000000000000
          ShowHint = False
          DataField = 'symbeznds'
          DataSet = LicevSet
          DataSetName = 'DSLicevCalc'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '[DSLicevCalc."symbeznds"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo115: TfrxMemoView
          Left = 328.819110000000000000
          Width = 68.031540000000000000
          Height = 37.795300000000000000
          ShowHint = False
          StretchMode = smMaxHeight
          DataField = 'per'
          DataSet = LicevSet
          DataSetName = 'DSLicevCalc'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '[DSLicevCalc."per"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo116: TfrxMemoView
          Left = 260.787570000000000000
          Top = 18.897650000000000000
          Width = 68.031540000000000000
          Height = 18.897650000000000000
          ShowHint = False
          StretchMode = smMaxHeight
          DataField = 'symnds'
          DataSet = LicevSet
          DataSetName = 'DSLicevCalc'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '[DSLicevCalc."symnds"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo117: TfrxMemoView
          Left = 396.850650000000000000
          Width = 68.031540000000000000
          Height = 37.795300000000000000
          ShowHint = False
          StretchMode = smMaxHeight
          DataField = 'symsnds'
          DataSet = LicevSet
          DataSetName = 'DSLicevCalc'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '[DSLicevCalc."symsnds"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo118: TfrxMemoView
          Left = 464.882190000000000000
          Width = 52.913420000000000000
          Height = 18.897650000000000000
          ShowHint = False
          DataField = 'kyb_v'
          DataSet = LicevSet
          DataSetName = 'DSLicevCalc'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '[DSLicevCalc."kyb_v"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo119: TfrxMemoView
          Left = 464.882190000000000000
          Top = 18.897650000000000000
          Width = 52.913420000000000000
          Height = 18.897650000000000000
          ShowHint = False
          StretchMode = smMaxHeight
          DataField = 'kyb_k'
          DataSet = LicevSet
          DataSetName = 'DSLicevCalc'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '[DSLicevCalc."kyb_k"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo120: TfrxMemoView
          Left = 517.795610000000000000
          Width = 52.913420000000000000
          Height = 18.897650000000000000
          ShowHint = False
          DataField = 'tarif_v'
          DataSet = LicevSet
          DataSetName = 'DSLicevCalc'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '[DSLicevCalc."tarif_v"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo121: TfrxMemoView
          Left = 570.709030000000000000
          Width = 68.031540000000000000
          Height = 18.897650000000000000
          ShowHint = False
          DataField = 'symbezndshv'
          DataSet = LicevSet
          DataSetName = 'DSLicevCalc'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '[DSLicevCalc."symbezndshv"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo122: TfrxMemoView
          Left = 638.740570000000000000
          Width = 68.031540000000000000
          Height = 37.795300000000000000
          ShowHint = False
          StretchMode = smMaxHeight
          DataField = 'perhv'
          DataSet = LicevSet
          DataSetName = 'DSLicevCalc'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '[DSLicevCalc."perhv"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo123: TfrxMemoView
          Left = 570.709030000000000000
          Top = 18.897650000000000000
          Width = 68.031540000000000000
          Height = 18.897650000000000000
          ShowHint = False
          StretchMode = smMaxHeight
          DataField = 'symndshv'
          DataSet = LicevSet
          DataSetName = 'DSLicevCalc'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '[DSLicevCalc."symndshv"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo124: TfrxMemoView
          Left = 706.772110000000000000
          Width = 68.031540000000000000
          Height = 37.795300000000000000
          ShowHint = False
          StretchMode = smMaxHeight
          DataField = 'symsndshv'
          DataSet = LicevSet
          DataSetName = 'DSLicevCalc'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '[DSLicevCalc."symsndshv"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo125: TfrxMemoView
          Left = 517.795610000000000000
          Top = 18.897650000000000000
          Width = 52.913420000000000000
          Height = 18.897650000000000000
          ShowHint = False
          StretchMode = smMaxHeight
          DataField = 'tarif_k'
          DataSet = LicevSet
          DataSetName = 'DSLicevCalc'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '[DSLicevCalc."tarif_k"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo94: TfrxMemoView
          Left = 774.803650000000000000
          Width = 52.913420000000000000
          Height = 37.795300000000000000
          ShowHint = False
          StretchMode = smMaxHeight
          DataSet = LicevSet
          DataSetName = 'DSLicevCalc'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '[DSLicevCalc."kyb_g"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo200: TfrxMemoView
          Left = 827.717070000000000000
          Width = 52.913420000000000000
          Height = 37.795300000000000000
          ShowHint = False
          StretchMode = smMaxHeight
          DataSet = LicevSet
          DataSetName = 'DSLicevCalc'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '[DSLicevCalc."tarif_g"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo201: TfrxMemoView
          Left = 880.630490000000000000
          Width = 68.031540000000000000
          Height = 18.897650000000000000
          ShowHint = False
          DataSet = LicevSet
          DataSetName = 'DSLicevCalc'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '[DSLicevCalc."symbezndsg"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo202: TfrxMemoView
          Left = 948.662030000000000000
          Width = 68.031540000000000000
          Height = 37.795300000000000000
          ShowHint = False
          StretchMode = smMaxHeight
          DataSet = LicevSet
          DataSetName = 'DSLicevCalc'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '[DSLicevCalc."perg"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo203: TfrxMemoView
          Left = 880.630490000000000000
          Top = 18.897650000000000000
          Width = 68.031540000000000000
          Height = 18.897650000000000000
          ShowHint = False
          StretchMode = smMaxHeight
          DataSet = LicevSet
          DataSetName = 'DSLicevCalc'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '[DSLicevCalc."symndsg"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo204: TfrxMemoView
          Left = 1016.693570000000000000
          Width = 68.031540000000000000
          Height = 37.795300000000000000
          ShowHint = False
          StretchMode = smMaxHeight
          DataSet = LicevSet
          DataSetName = 'DSLicevCalc'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '[DSLicevCalc."symsndsg"]')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object PageHeader2: TfrxPageHeader
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        Height = 158.740260000000000000
        ParentFont = False
        Top = 18.897650000000000000
        Width = 1084.725110000000000000
        object Memo91: TfrxMemoView
          Top = 52.913420000000000000
          Width = 1084.725110000000000000
          Height = 18.897650000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8 = (
            
              #1056#160#1056#176#1057#1027#1057#8364#1056#1105#1057#8222#1057#1026#1056#1109#1056#1030#1056#1108#1056#176' '#1056#1029#1056#176#1057#8225#1056#1105#1057#1027#1056#187#1056#181#1056#1029#1056#1105#1057#1039' '#1056#1111#1056#1109' '#1056#1109#1056#177#1057#1033#1056#181#1056#1108#1057#8218#1056#176#1056 +
              #1112' '#1056#183#1056#176' [period]')
          ParentFont = False
        end
        object Memo92: TfrxMemoView
          Left = 7.559060000000000000
          Top = 83.149660000000000000
          Width = 147.401670000000000000
          Height = 75.590600000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            #1056#1116#1056#176#1056#1105#1056#1112#1056#181#1056#1029#1056#1109#1056#1030#1056#176#1056#1029#1056#1105#1056#181' '#1056#1109#1056#177#1057#1033#1056#181#1056#1108#1057#8218#1056#176)
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo93: TfrxMemoView
          Left = 154.960730000000000000
          Top = 83.149660000000000000
          Width = 309.921460000000000000
          Height = 15.118120000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            #1056#1118#1056#181#1056#1111#1056#187#1056#1109#1056#1030#1056#176#1057#1039' '#1057#1036#1056#1029#1056#181#1057#1026#1056#1110#1056#1105#1057#1039)
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo95: TfrxMemoView
          Left = 154.960730000000000000
          Top = 128.504020000000000000
          Width = 52.913420000000000000
          Height = 30.236240000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            #1056#8220#1056#8217#1056#1038','
            #1056#8220#1056#1108#1056#176#1056#187)
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo96: TfrxMemoView
          Left = 207.874150000000000000
          Top = 98.267780000000000000
          Width = 52.913420000000000000
          Height = 60.472480000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            #1056#1118#1056#176#1057#1026#1056#1105#1057#8222', '#1057#1026#1057#1107#1056#177'.')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo97: TfrxMemoView
          Left = 260.787570000000000000
          Top = 98.267780000000000000
          Width = 68.031540000000000000
          Height = 30.236240000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            #1056#1038#1057#1107#1056#1112#1056#1112#1056#176' '#1056#177#1056#181#1056#183' '#1056#1116#1056#8221#1056#1038', '#1057#1026#1057#1107#1056#177'.')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo98: TfrxMemoView
          Left = 260.787570000000000000
          Top = 128.504020000000000000
          Width = 68.031540000000000000
          Height = 30.236240000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            #1056#1038#1057#1107#1056#1112#1056#1112#1056#176' '#1056#1116#1056#8221#1056#1038', '#1057#1026#1057#1107#1056#177'.')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo99: TfrxMemoView
          Left = 328.819110000000000000
          Top = 98.267780000000000000
          Width = 68.031496060000000000
          Height = 60.472480000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            #1056#1119#1056#181#1057#1026#1056#181#1057#1026#1056#176#1057#1027#1057#8225#1056#181#1057#8218', '#1057#1026#1057#1107#1056#177'.')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo100: TfrxMemoView
          Left = 396.850650000000000000
          Top = 98.267780000000000000
          Width = 68.031496060000000000
          Height = 60.472480000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            #1056#1038#1057#1107#1056#1112#1056#1112#1056#176' '#1057#1027' '#1056#1116#1056#8221#1056#1038', '#1057#1026#1057#1107#1056#177'.')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo101: TfrxMemoView
          Left = 464.882190000000000000
          Top = 83.149660000000000000
          Width = 309.921460000000000000
          Height = 15.118120000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            #1056#1168#1056#1109#1056#187#1056#1109#1056#1169#1056#1029#1056#176#1057#1039' '#1056#1030#1056#1109#1056#1169#1056#176' '#1056#1105' '#1056#1108#1056#176#1056#1029#1056#176#1056#187#1056#1105#1056#183#1056#176#1057#8224#1056#1105#1057#1039)
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo102: TfrxMemoView
          Left = 464.882190000000000000
          Top = 98.267780000000000000
          Width = 52.913420000000000000
          Height = 30.236240000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            #1056#1168'. '#1056#1030#1056#1109#1056#1169#1056#176', '#1056#1108#1057#1107#1056#177'.')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo103: TfrxMemoView
          Left = 464.882190000000000000
          Top = 128.504020000000000000
          Width = 52.913420000000000000
          Height = 30.236240000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            #1056#1113#1056#176#1056#1029#1056#176#1056#187'., '#1056#1108#1057#1107#1056#177'.')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo104: TfrxMemoView
          Left = 517.795610000000000000
          Top = 98.267780000000000000
          Width = 52.913420000000000000
          Height = 30.236240000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            #1056#1118#1056#176#1057#1026#1056#1105#1057#8222' '#1057#8230'.'#1056#1030'., '#1057#1026#1057#1107#1056#177'.')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo105: TfrxMemoView
          Left = 570.709030000000000000
          Top = 98.267780000000000000
          Width = 68.031540000000000000
          Height = 30.236240000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            #1056#1038#1057#1107#1056#1112#1056#1112#1056#176' '#1056#177#1056#181#1056#183' '#1056#1116#1056#8221#1056#1038', '#1057#1026#1057#1107#1056#177'.')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo106: TfrxMemoView
          Left = 638.740570000000000000
          Top = 98.267780000000000000
          Width = 68.031540000000000000
          Height = 60.472480000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            #1056#1119#1056#181#1057#1026#1056#181#1057#1026#1056#176#1057#1027#1057#8225#1056#181#1057#8218', '#1057#1026#1057#1107#1056#177'.')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo107: TfrxMemoView
          Left = 570.709030000000000000
          Top = 128.504020000000000000
          Width = 68.031496060000000000
          Height = 30.236240000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            #1056#1038#1057#1107#1056#1112#1056#1112#1056#176' '#1056#1116#1056#8221#1056#1038', '#1057#1026#1057#1107#1056#177'.')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo108: TfrxMemoView
          Left = 706.772110000000000000
          Top = 98.267780000000000000
          Width = 68.031496060000000000
          Height = 60.472480000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            #1056#1038#1057#1107#1056#1112#1056#1112#1056#176' '#1057#1027' '#1056#1116#1056#8221#1056#1038', '#1057#1026#1057#1107#1056#177'.')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo109: TfrxMemoView
          Left = 517.795610000000000000
          Top = 128.504020000000000000
          Width = 52.913420000000000000
          Height = 30.236240000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            #1056#1118#1056#176#1057#1026#1056#1105#1057#8222' '#1056#1108#1056#176#1056#1029'., '#1057#1026#1057#1107#1056#177'.')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo127: TfrxMemoView
          Left = 827.717070000000000000
          Top = 7.559059999999990000
          Width = 245.669450000000000000
          Height = 34.015770000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Memo.UTF8 = (
            #1056#1119#1057#1026#1056#1105#1056#187#1056#1109#1056#182#1056#181#1056#1029#1056#1105#1056#181
            #1056#1108' '#1057#1027#1057#8225#1056#181#1057#8218'-'#1057#8222#1056#176#1056#1108#1057#8218#1057#1107#1057#1026#1056#181' '#1056#8211#1056#1113#1056#1168' '#1074#8222#8211'[<dsSchet."kodorg">]')
          ParentFont = False
        end
        object Memo182: TfrxMemoView
          Left = 154.960730000000000000
          Top = 98.267780000000000000
          Width = 52.913420000000000000
          Height = 30.236240000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            #1056#1109#1057#8218#1056#1109#1056#1111'.'
            #1056#8220#1056#1108#1056#176#1056#187)
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo183: TfrxMemoView
          Left = 774.803650000000000000
          Top = 83.149660000000000000
          Width = 309.921460000000000000
          Height = 15.118120000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            #1056#8217#1057#8249#1056#1030#1056#1109#1056#183' '#1056#1112#1057#1107#1057#1027#1056#1109#1057#1026#1056#176)
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo184: TfrxMemoView
          Left = 774.803650000000000000
          Top = 98.267780000000000000
          Width = 52.913420000000000000
          Height = 60.472480000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            #1056#1114#1057#1107#1057#1027#1056#1109#1057#1026', '#1056#1108#1057#1107#1056#177'.')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo186: TfrxMemoView
          Left = 827.717070000000000000
          Top = 98.267780000000000000
          Width = 52.913420000000000000
          Height = 60.472480000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            #1056#1118#1056#176#1057#1026#1056#1105#1057#8222', '#1057#1026#1057#1107#1056#177'.')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo187: TfrxMemoView
          Left = 880.630490000000000000
          Top = 98.267780000000000000
          Width = 68.031540000000000000
          Height = 30.236240000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            #1056#1038#1057#1107#1056#1112#1056#1112#1056#176' '#1056#177#1056#181#1056#183' '#1056#1116#1056#8221#1056#1038', '#1057#1026#1057#1107#1056#177'.')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo188: TfrxMemoView
          Left = 948.662030000000000000
          Top = 98.267780000000000000
          Width = 68.031540000000000000
          Height = 60.472480000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            #1056#1119#1056#181#1057#1026#1056#181#1057#1026#1056#176#1057#1027#1057#8225#1056#181#1057#8218', '#1057#1026#1057#1107#1056#177'.')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo189: TfrxMemoView
          Left = 880.630490000000000000
          Top = 128.504020000000000000
          Width = 68.031496060000000000
          Height = 30.236240000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            #1056#1038#1057#1107#1056#1112#1056#1112#1056#176' '#1056#1116#1056#8221#1056#1038', '#1057#1026#1057#1107#1056#177'.')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo190: TfrxMemoView
          Left = 1016.693570000000000000
          Top = 98.267780000000000000
          Width = 68.031496060000000000
          Height = 60.472480000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            #1056#1038#1057#1107#1056#1112#1056#1112#1056#176' '#1057#1027' '#1056#1116#1056#8221#1056#1038', '#1057#1026#1057#1107#1056#177'.')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object Footer2: TfrxFooter
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        Height = 37.795300000000000000
        ParentFont = False
        Top = 359.055350000000000000
        Width = 1084.725110000000000000
        KeepChild = True
        object Memo128: TfrxMemoView
          Left = 7.559060000000000000
          Width = 147.401670000000000000
          Height = 37.795300000000000000
          ShowHint = False
          DataSet = LicevSet
          DataSetName = 'DSLicevCalc'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            #1056#152#1056#1118#1056#1115#1056#8220#1056#1115':')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo129: TfrxMemoView
          Left = 154.960730000000000000
          Width = 52.913420000000000000
          Height = 18.897650000000000000
          ShowHint = False
          DataSet = LicevSet
          DataSetName = 'DSLicevCalc'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '[sum(<DSLicevCalc."gkal_t">,MasterData2)]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo130: TfrxMemoView
          Left = 154.960730000000000000
          Top = 18.897650000000000000
          Width = 52.913420000000000000
          Height = 18.897650000000000000
          ShowHint = False
          DataSet = LicevSet
          DataSetName = 'DSLicevCalc'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '[sum(<DSLicevCalc."gkal_v">,MasterData2)]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo131: TfrxMemoView
          Left = 207.874150000000000000
          Width = 52.913420000000000000
          Height = 37.795300000000000000
          ShowHint = False
          DataSet = LicevSet
          DataSetName = 'DSLicevCalc'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%0.0f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            'x')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo132: TfrxMemoView
          Left = 260.787570000000000000
          Width = 68.031540000000000000
          Height = 18.897650000000000000
          ShowHint = False
          DataSet = LicevSet
          DataSetName = 'DSLicevCalc'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '[sum(<DSLicevCalc."symbeznds">,MasterData2)]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo133: TfrxMemoView
          Left = 328.819110000000000000
          Width = 68.031540000000000000
          Height = 37.795300000000000000
          ShowHint = False
          DataSet = LicevSet
          DataSetName = 'DSLicevCalc'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '[sum(<DSLicevCalc."per">,MasterData2)]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo134: TfrxMemoView
          Left = 260.787570000000000000
          Top = 18.897650000000000000
          Width = 68.031540000000000000
          Height = 18.897650000000000000
          ShowHint = False
          DataSet = LicevSet
          DataSetName = 'DSLicevCalc'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '[sum(<DSLicevCalc."symnds">,MasterData2)]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo135: TfrxMemoView
          Left = 396.850650000000000000
          Width = 68.031540000000000000
          Height = 37.795300000000000000
          ShowHint = False
          DataSet = LicevSet
          DataSetName = 'DSLicevCalc'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '[sum(<DSLicevCalc."symsnds">,MasterData2)]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo136: TfrxMemoView
          Left = 464.882190000000000000
          Width = 52.913420000000000000
          Height = 18.897650000000000000
          ShowHint = False
          DataSet = LicevSet
          DataSetName = 'DSLicevCalc'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '[sum(<DSLicevCalc."kyb_v">,MasterData2)]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo137: TfrxMemoView
          Left = 464.882190000000000000
          Top = 18.897650000000000000
          Width = 52.913420000000000000
          Height = 18.897650000000000000
          ShowHint = False
          DataSet = LicevSet
          DataSetName = 'DSLicevCalc'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '[sum(<DSLicevCalc."kyb_k">,MasterData2)]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo138: TfrxMemoView
          Left = 517.795610000000000000
          Width = 52.913420000000000000
          Height = 18.897650000000000000
          ShowHint = False
          DataSet = LicevSet
          DataSetName = 'DSLicevCalc'
          DisplayFormat.FormatStr = '%0.0f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            'x')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo139: TfrxMemoView
          Left = 570.709030000000000000
          Width = 68.031540000000000000
          Height = 18.897650000000000000
          ShowHint = False
          DataSet = LicevSet
          DataSetName = 'DSLicevCalc'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '[sum(<DSLicevCalc."symbezndshv">,MasterData2)]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo140: TfrxMemoView
          Left = 638.740570000000000000
          Width = 68.031540000000000000
          Height = 37.795300000000000000
          ShowHint = False
          DataSet = LicevSet
          DataSetName = 'DSLicevCalc'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '[sum(<DSLicevCalc."perhv">,MasterData2)]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo141: TfrxMemoView
          Left = 570.709030000000000000
          Top = 18.897650000000000000
          Width = 68.031540000000000000
          Height = 18.897650000000000000
          ShowHint = False
          DataSet = LicevSet
          DataSetName = 'DSLicevCalc'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '[sum(<DSLicevCalc."symndshv">,MasterData2)]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo142: TfrxMemoView
          Left = 706.772110000000000000
          Width = 68.031540000000000000
          Height = 37.795300000000000000
          ShowHint = False
          DataSet = LicevSet
          DataSetName = 'DSLicevCalc'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '[sum(<DSLicevCalc."symsndshv">,MasterData2)]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo143: TfrxMemoView
          Left = 517.795610000000000000
          Top = 18.897650000000000000
          Width = 52.913420000000000000
          Height = 18.897650000000000000
          ShowHint = False
          DataSet = LicevSet
          DataSetName = 'DSLicevCalc'
          DisplayFormat.FormatStr = '%0.0f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            'x')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo218: TfrxMemoView
          Left = 774.803650000000000000
          Width = 52.913420000000000000
          Height = 37.795300000000000000
          ShowHint = False
          DataSet = LicevSet
          DataSetName = 'DSLicevCalc'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '[sum(<DSLicevCalc."kyb_g">,MasterData2)]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo219: TfrxMemoView
          Left = 827.717070000000000000
          Width = 52.913420000000000000
          Height = 37.795300000000000000
          ShowHint = False
          DataSet = LicevSet
          DataSetName = 'DSLicevCalc'
          DisplayFormat.FormatStr = '%0.0f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            'x')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo220: TfrxMemoView
          Left = 880.630490000000000000
          Width = 68.031540000000000000
          Height = 18.897650000000000000
          ShowHint = False
          DataSet = LicevSet
          DataSetName = 'DSLicevCalc'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '[sum(<DSLicevCalc."symbezndsg">,MasterData2)]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo221: TfrxMemoView
          Left = 948.662030000000000000
          Width = 68.031540000000000000
          Height = 37.795300000000000000
          ShowHint = False
          DataSet = LicevSet
          DataSetName = 'DSLicevCalc'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '[sum(<DSLicevCalc."perg">,MasterData2)]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo222: TfrxMemoView
          Left = 880.630490000000000000
          Top = 18.897650000000000000
          Width = 68.031540000000000000
          Height = 18.897650000000000000
          ShowHint = False
          DataSet = LicevSet
          DataSetName = 'DSLicevCalc'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '[sum(<DSLicevCalc."symndsg">,MasterData2)]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo223: TfrxMemoView
          Left = 1016.693570000000000000
          Width = 68.031540000000000000
          Height = 37.795300000000000000
          ShowHint = False
          DataSet = LicevSet
          DataSetName = 'DSLicevCalc'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '[sum(<DSLicevCalc."symsndsg">,MasterData2)]')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object MasterData3: TfrxMasterData
        Height = 37.795300000000000000
        Top = 298.582870000000000000
        Width = 1084.725110000000000000
        OnBeforePrint = 'MasterData3OnBeforePrint'
        DataSet = LicevSet
        DataSetName = 'DSLicevCalc'
        RowCount = 0
        object Memo152: TfrxMemoView
          Left = 7.559060000000000000
          Width = 147.401670000000000000
          Height = 37.795300000000000000
          ShowHint = False
          DataSet = LicevSet
          DataSetName = 'DSLicevCalc'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8 = (
            #1056#1030' '#1057#8218#1056#1109#1056#1112' '#1057#8225#1056#1105#1057#1027#1056#187#1056#181' '#1056#1111#1056#1109' '#1056#187#1057#1034#1056#1110#1056#1109#1057#8218#1056#181':')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo153: TfrxMemoView
          Left = 154.960730000000000000
          Width = 52.913420000000000000
          Height = 18.897650000000000000
          ShowHint = False
          DataField = 'lgkal_t'
          DataSet = LicevSet
          DataSetName = 'DSLicevCalc'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '[DSLicevCalc."lgkal_t"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo154: TfrxMemoView
          Left = 154.960730000000000000
          Top = 18.897650000000000000
          Width = 52.913420000000000000
          Height = 18.897650000000000000
          ShowHint = False
          DataField = 'lgkal_v'
          DataSet = LicevSet
          DataSetName = 'DSLicevCalc'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '[DSLicevCalc."lgkal_v"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo155: TfrxMemoView
          Left = 207.874150000000000000
          Width = 52.913420000000000000
          Height = 37.795300000000000000
          ShowHint = False
          DataSet = LicevSet
          DataSetName = 'DSLicevCalc'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '[(<DSLicevCalc."tarif_t">)/2]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo156: TfrxMemoView
          ShiftMode = smWhenOverlapped
          Left = 260.787570000000000000
          Width = 68.031540000000000000
          Height = 18.897650000000000000
          ShowHint = False
          DataSet = LicevSet
          DataSetName = 'DSLicevCalc'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '[<DSLicevCalc."lsumt">+<DSLicevCalc."lsumgv">]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo157: TfrxMemoView
          Left = 328.819110000000000000
          Width = 68.031540000000000000
          Height = 37.795300000000000000
          ShowHint = False
          DataSet = LicevSet
          DataSetName = 'DSLicevCalc'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo158: TfrxMemoView
          Left = 260.787570000000000000
          Top = 18.897650000000000000
          Width = 68.031540000000000000
          Height = 18.897650000000000000
          ShowHint = False
          DataSet = LicevSet
          DataSetName = 'DSLicevCalc'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            'x')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo159: TfrxMemoView
          Left = 396.850650000000000000
          Width = 68.031540000000000000
          Height = 37.795300000000000000
          ShowHint = False
          DataSet = LicevSet
          DataSetName = 'DSLicevCalc'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '[<DSLicevCalc."lsumt">+<DSLicevCalc."lsumgv">]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo160: TfrxMemoView
          Left = 464.882190000000000000
          Width = 52.913420000000000000
          Height = 18.897650000000000000
          ShowHint = False
          DataField = 'lkyb_v'
          DataSet = LicevSet
          DataSetName = 'DSLicevCalc'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '[DSLicevCalc."lkyb_v"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo161: TfrxMemoView
          Left = 464.882190000000000000
          Top = 18.897650000000000000
          Width = 52.913420000000000000
          Height = 18.897650000000000000
          ShowHint = False
          DataField = 'lkyb_k'
          DataSet = LicevSet
          DataSetName = 'DSLicevCalc'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '[DSLicevCalc."lkyb_k"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo162: TfrxMemoView
          Left = 517.795610000000000000
          Width = 52.913420000000000000
          Height = 18.897650000000000000
          ShowHint = False
          DataSet = LicevSet
          DataSetName = 'DSLicevCalc'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '[(<DSLicevCalc."tarif_v">)/2]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo163: TfrxMemoView
          Left = 570.709030000000000000
          Width = 68.031540000000000000
          Height = 18.897650000000000000
          ShowHint = False
          DataSet = LicevSet
          DataSetName = 'DSLicevCalc'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '[<DSLicevCalc."lsumh">+<DSLicevCalc."lsumk">]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo164: TfrxMemoView
          Left = 638.740570000000000000
          Width = 68.031540000000000000
          Height = 37.795300000000000000
          ShowHint = False
          DataSet = LicevSet
          DataSetName = 'DSLicevCalc'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo165: TfrxMemoView
          Left = 570.709030000000000000
          Top = 18.897650000000000000
          Width = 68.031540000000000000
          Height = 18.897650000000000000
          ShowHint = False
          DataSet = LicevSet
          DataSetName = 'DSLicevCalc'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            'x')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo166: TfrxMemoView
          Left = 706.772110000000000000
          Width = 68.031540000000000000
          Height = 37.795300000000000000
          ShowHint = False
          DataSet = LicevSet
          DataSetName = 'DSLicevCalc'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '[<DSLicevCalc."lsumh">+<DSLicevCalc."lsumk">]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo167: TfrxMemoView
          Left = 517.795610000000000000
          Top = 18.897650000000000000
          Width = 52.913420000000000000
          Height = 18.897650000000000000
          ShowHint = False
          DataSet = LicevSet
          DataSetName = 'DSLicevCalc'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '[(<DSLicevCalc."tarif_k">)/2]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo185: TfrxMemoView
          Left = 774.803650000000000000
          Width = 52.913420000000000000
          Height = 37.795300000000000000
          ShowHint = False
          DataSet = LicevSet
          DataSetName = 'DSLicevCalc'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '[DSLicevCalc."lkyb_g"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo205: TfrxMemoView
          Left = 827.717070000000000000
          Width = 52.913420000000000000
          Height = 37.795300000000000000
          ShowHint = False
          DataSet = LicevSet
          DataSetName = 'DSLicevCalc'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '[(<DSLicevCalc."tarif_g">)/2]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo206: TfrxMemoView
          Left = 880.630490000000000000
          Width = 68.031540000000000000
          Height = 18.897650000000000000
          ShowHint = False
          DataSet = LicevSet
          DataSetName = 'DSLicevCalc'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '[<DSLicevCalc."lsumg">]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo207: TfrxMemoView
          Left = 948.662030000000000000
          Width = 68.031540000000000000
          Height = 37.795300000000000000
          ShowHint = False
          DataSet = LicevSet
          DataSetName = 'DSLicevCalc'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo216: TfrxMemoView
          Left = 880.630490000000000000
          Top = 18.897650000000000000
          Width = 68.031540000000000000
          Height = 18.897650000000000000
          ShowHint = False
          DataSet = LicevSet
          DataSetName = 'DSLicevCalc'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            'x')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo217: TfrxMemoView
          Left = 1016.693570000000000000
          Width = 68.031540000000000000
          Height = 37.795300000000000000
          ShowHint = False
          DataSet = LicevSet
          DataSetName = 'DSLicevCalc'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '[<DSLicevCalc."lsumg">]')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object ReportSummary1: TfrxReportSummary
        Height = 253.228510000000000000
        Top = 457.323130000000000000
        Width = 1084.725110000000000000
        object Memo126: TfrxMemoView
          Left = 18.897650000000000000
          Top = 3.779530000000020000
          Width = 147.401670000000000000
          Height = 15.118120000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Memo.UTF8 = (
            #1056#8217#1057#1027#1056#181#1056#1110#1056#1109' '#1057#1027#1057#1107#1056#1112#1056#1112#1056#176' '#1056#177#1056#181#1056#183' '#1056#1116#1056#8221#1056#1038':')
          ParentFont = False
        end
        object Memo144: TfrxMemoView
          Left = 170.078850000000000000
          Top = 3.779530000000000000
          Width = 559.370440000000000000
          Height = 26.456710000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = [ftBottom]
          Memo.UTF8 = (
            
              '[Money(sum(<dsLicevCalc."symbeznds">+<dsLicevCalc."symbezndshv">' +
              '+<dsLicevCalc."symbezndsg">,MasterData2),<dsPropis."ruble_prop">' +
              ',<dsPropis."kopeika_prop">,<dsPropis."print_kop">)]')
          ParentFont = False
        end
        object Memo145: TfrxMemoView
          Left = 336.378170000000000000
          Top = 33.118120000000000000
          Width = 192.756030000000000000
          Height = 15.118120000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8 = (
            '('#1056#1111#1057#1026#1056#1109#1056#1111#1056#1105#1057#1027#1057#1034#1057#1035')')
          ParentFont = False
        end
        object Memo146: TfrxMemoView
          Left = 18.897650000000000000
          Top = 56.015770000000000000
          Width = 147.401670000000000000
          Height = 15.118120000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Memo.UTF8 = (
            #1056#8217#1057#1027#1056#181#1056#1110#1056#1109' '#1057#1027#1057#1107#1056#1112#1056#1112#1056#176' '#1056#1116#1056#8221#1056#1038)
          ParentFont = False
        end
        object Memo148: TfrxMemoView
          Left = 336.378170000000000000
          Top = 85.559060000000100000
          Width = 192.756030000000000000
          Height = 15.118120000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8 = (
            '('#1056#1111#1057#1026#1056#1109#1056#1111#1056#1105#1057#1027#1057#1034#1057#1035')')
          ParentFont = False
        end
        object Memo149: TfrxMemoView
          Left = 18.897650000000000000
          Top = 103.472480000000000000
          Width = 147.401670000000000000
          Height = 15.118120000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Memo.UTF8 = (
            #1056#8217#1057#1027#1056#181#1056#1110#1056#1109' '#1057#1027#1057#1107#1056#1112#1056#1112#1056#176' '#1057#1027' '#1056#1116#1056#8221#1056#1038)
          ParentFont = False
        end
        object Memo151: TfrxMemoView
          Left = 336.378170000000000000
          Top = 136.811070000000000000
          Width = 192.756030000000000000
          Height = 15.118120000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8 = (
            '('#1056#1111#1057#1026#1056#1109#1056#1111#1056#1105#1057#1027#1057#1034#1057#1035')')
          ParentFont = False
        end
        object Memo147: TfrxMemoView
          Left = 170.078850000000000000
          Top = 56.015770000000000000
          Width = 559.370440000000000000
          Height = 26.456710000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = [ftBottom]
          Memo.UTF8 = (
            
              '[Money((sum(<dsLicevCalc."symnds">,MasterData2)+sum(<dsLicevCalc' +
              '."symndshv">,MasterData2)+sum(<dsLicevCalc."symndsg">,MasterData' +
              '2)),<dsPropis."ruble_prop">,<dsPropis."kopeika_prop">,<dsPropis.' +
              '"print_kop">)]')
          ParentFont = False
        end
        object Memo150: TfrxMemoView
          Left = 170.078850000000000000
          Top = 103.472480000000000000
          Width = 559.370440000000000000
          Height = 30.236240000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = [ftBottom]
          Memo.UTF8 = (
            
              '[Money((sum(<dsLicevCalc."symsnds">,MasterData2)+sum(<dsLicevCal' +
              'c."symsndshv">,MasterData2)+sum(<dsLicevCalc."symsndsg">,MasterD' +
              'ata2)),<dsPropis."ruble_prop">,<dsPropis."kopeika_prop">,<dsProp' +
              'is."print_kop">)]')
          ParentFont = False
        end
        object Memo168: TfrxMemoView
          Left = 18.897650000000000000
          Top = 170.078850000000000000
          Width = 147.401670000000000000
          Height = 15.118120000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Memo.UTF8 = (
            #1056#152#1057#1027#1056#1111#1056#1109#1056#187#1056#1029#1056#1105#1057#8218#1056#181#1056#187#1056#1105':')
          ParentFont = False
        end
        object Memo169: TfrxMemoView
          Left = 18.897650000000000000
          Top = 192.756030000000000000
          Width = 291.023810000000000000
          Height = 15.118120000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Memo.UTF8 = (
            '[dsParam."dolgn_isp1"] [dsParam."fio_isp1"]')
          ParentFont = False
        end
        object Memo171: TfrxMemoView
          Left = 18.897650000000000000
          Top = 215.433210000000000000
          Width = 291.023810000000000000
          Height = 15.118120000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Memo.UTF8 = (
            '[dsParam."dolgnisp2"] [dsParam."fio_isp2"]')
          ParentFont = False
        end
        object Memo173: TfrxMemoView
          Left = 18.897650000000000000
          Top = 238.110390000000000000
          Width = 147.401670000000000000
          Height = 15.118120000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Memo.UTF8 = (
            #1056#1118#1056#181#1056#187#1056#181#1057#8222#1056#1109#1056#1029':[dsParam."tel_isp"]')
          ParentFont = False
        end
      end
    end
  end
  object qryLicObekt: TMSQuery
    Connection = DM.Conect
    SQL.Strings = (
      'SELECT sum(gkt) as s_gkt,sum(gkv) as s_gkv,sum(symt) as s_symt,'
      'sum(symv) as s_symv,sum(pert) as s_pert,sum(perv) as s_perv,'
      'sum(pgkt) as s_pgkt,sum(pgkv) as s_pgkv,sum(symk) as s_symk,'
      
        'sum(symgv) as s_symgv,avg(tvn) as a_tvn,avg(kdo) as a_kdo,avg(ts' +
        ') as a_ts,'
      
        'avg(dgv) as a_dvg,sum(symtnds) as s_symtnds,sum(symvnds) as s_sy' +
        'mvnds,'
      
        'sum(lgkt) as s_lgkt,sum(lgkv) as s_lgkv,sum(lsymt) as s_lsymt,su' +
        'm(lsymv) as s_lsymv,'
      'avg(rastarift) as a_rastarift,avg(kco) as a_kco, kodobk'
      'from dataobekt '
      'group by kodobk'
      'order by kodobk')
    MasterSource = dsObk
    MasterFields = 'kodobk'
    DetailFields = 'kodobk'
    Left = 9
    Top = 152
    ParamData = <
      item
        DataType = ftInteger
        Name = 'kodobk'
        ParamType = ptInput
        Value = 0
      end>
  end
  object dsLicObekt: TDataSource
    DataSet = qryLicObekt
    Left = 38
    Top = 152
  end
  object qryObk: TMSQuery
    Connection = DM.Conect
    SQL.Strings = (
      'SELECT a.kodobk,a.nazv as nazv_obk,a.prj,a.prjl,'
      'a.q,a.t,a.spl,a.spll,b.nazv as nazv_org'
      'FROM obekt a,org b'
      'WHERE a.kodorg = b.kodorg')
    MasterSource = DM.dsRezCalcObk
    MasterFields = 'kodobk'
    DetailFields = 'kodobk'
    Left = 9
    Top = 181
    ParamData = <
      item
        DataType = ftInteger
        Name = 'kodobk'
        ParamType = ptInput
        Value = 0
      end>
  end
  object dsObk: TDataSource
    DataSet = qryObk
    Left = 38
    Top = 181
  end
  object LicObk: TfrxDBDataset
    UserName = 'dsLicObk'
    CloseDataSource = True
    DataSource = dsLicObekt
    BCDToCurrency = False
    Left = 7
    Top = 210
  end
  object Obk: TfrxDBDataset
    UserName = 'dsObk'
    CloseDataSource = True
    DataSource = dsObk
    BCDToCurrency = False
    Left = 39
    Top = 210
  end
  object qryRezKot: TMSQuery
    Connection = DM.Conect
    SQL.Strings = (
      'SELECT sum(gkt) as s_gkt,sum(gkv) as s_gkv,sum(symt) as s_symt,'
      'sum(symv) as s_symv,sum(pert) as s_pert,sum(perv) as s_perv,'
      'sum(pgkt) as s_pgkt,sum(pgkv) as s_pgkv,sum(symk) as s_symk,'
      
        'sum(symgv) as s_symgv,avg(tvn) as a_tvn,avg(kdo) as a_kdo,avg(ts' +
        ') as a_ts,'
      
        'avg(dgv) as a_dvg,sum(symtnds) as s_symtnds,sum(symvnds) as s_sy' +
        'mvnds,'
      
        'sum(lgkt) as s_lgkt,sum(lgkv) as s_lgkv,sum(lsymt) as s_lsymt,su' +
        'm(lsymv) as s_lsymv,'
      
        'avg(rastarift) as a_rastarift,avg(kco) as a_kco, b.kodkot, b.q, ' +
        'b.t, b.nazv as obk, c.nazv as org'
      'from dataobekt a, obekt b, org c'
      'where a.kodobk = b.kodobk and b.kodorg = c.kodorg and b.podkl=0'
      'group by b.kodkot, b.q, b.t, b.nazv, c.nazv'
      'order by obk'
      '')
    MasterSource = dsKoteln
    MasterFields = 'kodkot'
    DetailFields = 'kodkot'
    Left = 89
    Top = 152
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'kodkot'
      end>
  end
  object dsRezKot: TDataSource
    DataSet = qryRezKot
    Left = 118
    Top = 152
  end
  object RezKot: TfrxDBDataset
    UserName = 'dsRezKot'
    CloseDataSource = True
    DataSource = dsRezKot
    BCDToCurrency = False
    Left = 89
    Top = 181
  end
  object Koteln: TfrxDBDataset
    UserName = 'dsKoteln'
    CloseDataSource = True
    DataSource = dsKoteln
    BCDToCurrency = False
    Left = 118
    Top = 181
  end
  object qryLicDoma: TMSQuery
    Connection = DM.Conect
    SQL.Strings = (
      'SELECT sum(gkt) as s_gkt, sum(gkv) as s_gkv,'
      
        'avg(normativ) as normativot, avg(normativgv) as normativgvs, b.k' +
        'oddom, b.so, b.prj,'
      '(c.nazvul+'#39','#39'+b.ndom) as adres'
      'from datadoma a, doma b, ulica c'
      'where a.koddom = b.koddom and c.kodul = b.kodul'
      'group by b.koddom, b.so, b.prj,(c.nazvul+'#39','#39'+b.ndom)'
      'order by adres')
    MasterSource = DM.dsRezCalcNas
    MasterFields = 'koddom'
    DetailFields = 'b.koddom'
    Left = 9
    Top = 256
    ParamData = <
      item
        DataType = ftInteger
        Name = 'koddom'
        ParamType = ptInput
        Value = 1
      end>
  end
  object dsLicDoma: TDataSource
    DataSet = qryLicDoma
    Left = 38
    Top = 256
  end
  object qryLicKvart: TMSQuery
    Connection = DM.Conect
    SQL.Strings = (
      'select sum(gkt) as s_gkt,sum(gkv) as s_gkv,'
      'avg(normativ) as normativot, avg(normativgv) as normativgvs,'
      'b.kodkv, b.koddom, b.kv, b.so, b.prj'
      'from datakvart a, kvart b'
      'where a.kodkv = b.kodkv'
      'group by b.kodkv, b.koddom, b.kv, b.so, b.prj'
      'order by b.kv')
    MasterSource = dsLicDoma
    MasterFields = 'koddom'
    DetailFields = 'koddom'
    Left = 9
    Top = 285
    ParamData = <
      item
        DataType = ftInteger
        Name = 'koddom'
        ParamType = ptInput
        Value = 1
      end>
  end
  object dsLicKvart: TDataSource
    DataSet = qryLicKvart
    Left = 38
    Top = 285
  end
  object LicDom: TfrxDBDataset
    UserName = 'dsLicDom'
    CloseDataSource = True
    DataSource = dsLicDoma
    BCDToCurrency = False
    Left = 9
    Top = 314
  end
  object LicKv: TfrxDBDataset
    UserName = 'dsLicKv'
    CloseDataSource = True
    DataSource = dsLicKvart
    BCDToCurrency = False
    Left = 38
    Top = 314
  end
  object qryRezKotDoma: TMSQuery
    Connection = DM.Conect
    SQL.Strings = (
      'SELECT sum(gkt) as s_gkt, sum(gkv) as s_gkv,'
      
        'avg(normativ) as normativot, avg(normativgv) as normativgvs, b.k' +
        'oddom, b.so, b.prj, b.kodkot,'
      '(c.nazvul+'#39','#39'+b.ndom) as adres'
      'from datadoma a, doma b, ulica c'
      'where a.koddom = b.koddom and c.kodul = b.kodul'
      'group by b.koddom, b.so, b.prj,b.kodkot,(c.nazvul+'#39','#39'+b.ndom)'
      'order by adres'
      '')
    MasterSource = DM.dsKoteln
    MasterFields = 'kodkot'
    DetailFields = 'b.kodkot'
    Left = 89
    Top = 257
    ParamData = <
      item
        DataType = ftInteger
        Name = 'kodkot'
        ParamType = ptInput
        Value = 1
      end>
  end
  object dsRezKotDom: TDataSource
    DataSet = qryRezKotDoma
    Left = 118
    Top = 257
  end
  object RezKotDom: TfrxDBDataset
    UserName = 'dsRezKotDom'
    CloseDataSource = True
    DataSource = dsRezKotDom
    BCDToCurrency = False
    Left = 89
    Top = 286
  end
  object qryKoteln: TMSQuery
    Connection = DM.Conect
    SQL.Strings = (
      
        'select *,teplosnab.dbo.sf_select_mesto(mesto) as rasp from kotel' +
        'n'
      'order by kodkot'
      ''
      '')
    Left = 153
    Top = 152
  end
  object dsKoteln: TDataSource
    DataSet = qryKoteln
    Left = 182
    Top = 152
  end
  object qryObSvodOt: TMSQuery
    Connection = DM.Conect
    SQL.Strings = (
      'SELECT * FROM gen_report_ot'
      '')
    Left = 225
    Top = 8
  end
  object dsObSvodOt: TDataSource
    DataSet = qryObSvodOt
    Left = 254
    Top = 8
  end
  object ObSvodOt: TfrxDBDataset
    UserName = 'dsObSvodOt'
    CloseDataSource = True
    DataSource = dsObSvodOt
    BCDToCurrency = False
    Left = 225
    Top = 53
  end
  object qrySchet: TMSQuery
    Connection = DM.Conect
    SQL.Strings = (
      'SELECT a.*, b.adres_bank, c.kodbank '
      'FROM schet a,bank b,org c'
      'WHERE a.kodorg=c.kodorg and c.kodbank=b.kod_bank'
      'ORDER BY a.kodusl')
    Left = 305
    Top = 8
  end
  object dsSchet: TDataSource
    DataSet = qrySchet
    Left = 334
    Top = 8
  end
  object Schet: TfrxDBDataset
    UserName = 'dsSchet'
    CloseDataSource = True
    DataSource = dsSchet
    BCDToCurrency = False
    Left = 305
    Top = 96
  end
  object qryParam: TMSQuery
    Connection = DM.Conect
    SQL.Strings = (
      'SELECT a.*,b.nazv_bank,b.adres_bank FROM paramorg a, bank b'
      'where a.kodbank = b.kod_bank'
      '')
    Left = 305
    Top = 49
  end
  object dsParam: TDataSource
    DataSet = qryParam
    Left = 334
    Top = 49
  end
  object Param: TfrxDBDataset
    UserName = 'dsParam'
    CloseDataSource = True
    DataSource = dsParam
    BCDToCurrency = False
    Left = 337
    Top = 96
  end
  object frxXLSExport1: TfrxXLSExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
    ExportEMF = True
    AsText = False
    Background = True
    FastExport = True
    PageBreaks = True
    EmptyLines = True
    SuppressPageHeadersFooters = False
    Left = 352
    Top = 336
  end
  object frxBarCodeObject1: TfrxBarCodeObject
    Left = 320
    Top = 336
  end
  object frxDesigner1: TfrxDesigner
    DefaultScriptLanguage = 'PascalScript'
    DefaultFont.Charset = DEFAULT_CHARSET
    DefaultFont.Color = clWindowText
    DefaultFont.Height = -13
    DefaultFont.Name = 'Arial'
    DefaultFont.Style = []
    DefaultLeftMargin = 10.000000000000000000
    DefaultRightMargin = 10.000000000000000000
    DefaultTopMargin = 10.000000000000000000
    DefaultBottomMargin = 10.000000000000000000
    DefaultPaperSize = 9
    DefaultOrientation = poPortrait
    TemplatesExt = 'fr3'
    Restrictions = []
    RTLLanguage = False
    MemoParentFont = False
    Left = 320
    Top = 384
  end
  object qryLicev: TMSQuery
    Connection = DM.Conect
    SQL.Strings = (
      'SELECT a.kodobk, a.nazv, a.kodorg,'
      'sum(b.gkt+b.pgkt) AS gkal_t,'
      'sum(b.gkv+b.pgkv) AS gkal_v,'
      'avg(b.rastarift) AS tarif_t,'
      'sum(b.pert+b.perv) AS per,'
      'sum(b.symt+b.symv) AS symbeznds,'
      'sum(b.symtnds+b.symvnds) AS symnds, '
      'sum(b.symk+b.symgv+b.pert+b.perv) AS symsnds,'
      'sum(b.lgkt) AS lgkal_t,'
      'sum(b.lgkv) AS lgkal_v,'
      'sum(b.lsymt) AS lsumt,'
      'sum(b.lsymv) AS lsumgv,'
      'sum(b.kybv+b.pkybv) AS kyb_v,'
      'sum(b.kybk+b.pkybk) AS kyb_k,'
      'avg(b.rastarifv) AS tarif_v,'
      'avg(b.rastarifk) AS tarif_k,'
      'sum(b.perh+b.perk) AS perhv,'
      'sum(b.symh+b.symkk) AS symbezndshv,'
      'sum(b.symhnds+b.symknds) AS symndshv, '
      'sum(b.symhs+b.symks+b.perh+b.perk) AS symsndshv,'
      'sum(b.lkybv) AS lkyb_v,'
      'sum(b.lkybk) AS lkyb_k,'
      'sum(b.lsymh) AS lsumh,'
      'sum(b.lsymkk) AS lsumk'
      'FROM OBEKT a,DATAOBEKT b '
      'WHERE a.kodobk=b.kodobk'
      'GROUP BY a.kodobk, a.nazv, a.kodorg'
      'ORDER BY a.kodobk'
      ' ')
    MasterSource = dsSchet
    MasterFields = 'kodorg'
    DetailFields = 'kodorg'
    Left = 306
    Top = 139
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'kodorg'
      end>
  end
  object dsLicev: TDataSource
    DataSet = qryLicev
    Left = 335
    Top = 139
  end
  object LicevSet: TfrxDBDataset
    UserName = 'DSLicevCalc'
    CloseDataSource = True
    DataSource = dsLicev
    BCDToCurrency = False
    Left = 369
    Top = 96
  end
  object qryLicevRas: TMSQuery
    Connection = DM.Conect
    SQL.Strings = (
      'SELECT a.kodobk, a.nazv, a.kodorg,'
      'sum(b.gkt+b.pgkt) AS gkal_t,'
      'sum(b.gkv+b.pgkv) AS gkal_v,'
      'avg(b.rastarift) AS tarif_t,'
      'sum(b.pert+b.perv) AS per,'
      
        'sum(b.symt+b.symv+(b.pert-b.pertnds)+(b.perv-b.pervnds)) AS symb' +
        'eznds,'
      'sum(b.symtnds+b.symvnds+b.pertnds+b.pervnds) AS symnds, '
      'sum(b.symk+b.symgv+b.pert+b.perv) AS symsnds,'
      'sum(b.lgkt) AS lgkal_t,'
      'sum(b.lgkv) AS lgkal_v,'
      'sum(b.lsymt) AS lsumt,'
      'sum(b.lsymv) AS lsumgv,'
      'sum(b.kybv+b.pkybv) AS kyb_v,'
      'sum(b.kybk+b.pkybk) AS kyb_k,'
      'avg(b.rastarifv) AS tarif_v,'
      'avg(b.rastarifk) AS tarif_k,'
      'sum(b.perh+b.perk) AS perhv,'
      
        'sum(b.symh+b.symkk+(b.perh-b.perhnds)+(b.perk-b.perknds)) AS sym' +
        'bezndshv,'
      'sum(b.symhnds+b.symknds+b.perhnds+b.perknds) AS symndshv, '
      'sum(b.symhs+b.symks+b.perh+b.perk) AS symsndshv,'
      'sum(b.lkybv) AS lkyb_v,'
      'sum(b.lkybk) AS lkyb_k,'
      'sum(b.lsymh) AS lsumh,'
      'sum(b.lsymkk) AS lsumk,'
      'sum(b.kybg+b.pkybg) AS kyb_g,'
      'avg(b.rastarifg) AS tarif_g,'
      'sum(b.perg) AS perg,'
      'sum(b.symg+b.perg-b.pergnds) AS symbezndsg,'
      'sum(b.symgnds+b.pergnds) AS symndsg,'
      'sum(b.symgs+b.perg) AS symsndsg,'
      'sum(b.lkybg) AS lkyb_g,'
      'sum(b.lsymg) AS lsumg'
      'FROM OBEKT a,DATAOBEKT b '
      'WHERE a.kodobk=b.kodobk'
      'GROUP BY a.kodobk, a.nazv, a.kodorg'
      'ORDER BY a.kodobk')
    MasterSource = DM.dsOrg
    MasterFields = 'kodorg'
    DetailFields = 'kodorg'
    Left = 306
    Top = 187
    ParamData = <
      item
        DataType = ftInteger
        Name = 'kodorg'
        ParamType = ptInput
        Value = 32
      end>
  end
  object dsLicevRas: TDataSource
    DataSet = qryLicevRas
    Left = 335
    Top = 187
  end
  object LicevRasSet: TfrxDBDataset
    UserName = 'DSLicevRas'
    CloseDataSource = True
    DataSource = dsLicevRas
    BCDToCurrency = False
    Left = 369
    Top = 186
  end
  object OrgSet: TfrxDBDataset
    UserName = 'dsOrg'
    CloseDataSource = True
    DataSource = DM.dsOrg
    BCDToCurrency = False
    Left = 409
    Top = 186
  end
  object qryObSvodVk: TMSQuery
    Connection = DM.Conect
    SQL.Strings = (
      'SELECT * FROM gen_report_vk'
      '')
    Left = 225
    Top = 96
  end
  object dsObSvodVk: TDataSource
    DataSet = qryObSvodVk
    Left = 254
    Top = 96
  end
  object ObSvodVk: TfrxDBDataset
    UserName = 'dsObSvodVk'
    CloseDataSource = True
    DataSource = dsObSvodVk
    BCDToCurrency = False
    Left = 225
    Top = 141
  end
  object qryRasNacOt: TMSQuery
    Connection = DM.Conect
    SQL.Strings = (
      'SELECT * FROM ras_nac_ot'
      ' ')
    Left = 306
    Top = 235
  end
  object dsRasNacOt: TDataSource
    DataSet = qryRasNacOt
    Left = 335
    Top = 235
  end
  object qryRasNacVk: TMSQuery
    Connection = DM.Conect
    SQL.Strings = (
      'SELECT * FROM ras_nac_vk')
    Left = 306
    Top = 283
  end
  object dsRasNacVk: TDataSource
    DataSet = qryRasNacVk
    Left = 335
    Top = 283
  end
  object RasNacOt: TfrxDBDataset
    UserName = 'DSRasNac'
    CloseDataSource = True
    DataSource = dsRasNacOt
    BCDToCurrency = False
    Left = 369
    Top = 234
  end
  object RasNacVk: TfrxDBDataset
    UserName = 'dsRasNacVk'
    CloseDataSource = True
    DataSource = dsRasNacVk
    BCDToCurrency = False
    Left = 369
    Top = 282
  end
  object qryRasKotOt: TMSQuery
    Connection = DM.Conect
    SQL.Strings = (
      'SELECT * FROM ras_kot_ot'
      ' ')
    Left = 418
    Top = 234
  end
  object dsRasKotOt: TDataSource
    DataSet = qryRasKotOt
    Left = 447
    Top = 234
  end
  object qryRasKotVk: TMSQuery
    Connection = DM.Conect
    SQL.Strings = (
      'SELECT * FROM ras_kot_vk')
    Left = 418
    Top = 282
  end
  object dsRasKotVk: TDataSource
    DataSet = qryRasKotVk
    Left = 447
    Top = 282
  end
  object RasKotOt: TfrxDBDataset
    UserName = 'DSRasKotOt'
    CloseDataSource = True
    DataSource = dsRasKotOt
    BCDToCurrency = False
    Left = 481
    Top = 233
  end
  object RasKotVk: TfrxDBDataset
    UserName = 'dsRasKotVk'
    CloseDataSource = True
    DataSource = dsRasKotVk
    BCDToCurrency = False
    Left = 481
    Top = 281
  end
  object frxCrossObject1: TfrxCrossObject
    Left = 384
    Top = 336
  end
  object qryRasOt: TMSQuery
    Connection = DM.Conect
    SQL.Strings = (
      'SELECT * FROM ras_ot')
    Left = 418
    Top = 11
  end
  object dsRasOt: TDataSource
    DataSet = qryRasOt
    Left = 447
    Top = 11
  end
  object qryRasVk: TMSQuery
    Connection = DM.Conect
    SQL.Strings = (
      'SELECT * FROM ras_vk')
    Left = 418
    Top = 51
  end
  object dsRasVk: TDataSource
    DataSet = qryRasVk
    Left = 447
    Top = 51
  end
  object CrossOt: TfrxDBDataset
    UserName = 'DSCrossOt'
    CloseDataSource = True
    DataSource = dsRasOt
    BCDToCurrency = False
    Left = 489
    Top = 10
  end
  object CrossVk: TfrxDBDataset
    UserName = 'dsCrossVk'
    CloseDataSource = True
    DataSource = dsRasVk
    BCDToCurrency = False
    Left = 489
    Top = 50
  end
  object qryRasKotOtMesto: TMSQuery
    Connection = DM.Conect
    SQL.Strings = (
      'SELECT * FROM ras_kot_ot_m')
    Left = 418
    Top = 99
  end
  object dsRasKotOtMesto: TDataSource
    DataSet = qryRasKotOtMesto
    Left = 447
    Top = 99
  end
  object qryRasKotVkMesto: TMSQuery
    Connection = DM.Conect
    SQL.Strings = (
      'SELECT * FROM ras_kot_vk_m')
    Left = 418
    Top = 139
  end
  object dsRasKotVkMesto: TDataSource
    DataSet = qryRasKotVkMesto
    Left = 447
    Top = 139
  end
  object RasKotOtMesto: TfrxDBDataset
    UserName = 'dsRasKototMesto'
    CloseDataSource = True
    DataSource = dsRasKotOtMesto
    BCDToCurrency = False
    Left = 489
    Top = 98
  end
  object RasKotVkMesto: TfrxDBDataset
    UserName = 'dsRasKotVkMesto'
    CloseDataSource = True
    DataSource = dsRasKotVkMesto
    BCDToCurrency = False
    Left = 489
    Top = 138
  end
  object qryEcnal: TMSQuery
    Connection = DM.Conect
    SQL.Strings = (
      'SELECT * FROM ras_kot_e')
    Left = 450
    Top = 187
  end
  object dsEcnal: TDataSource
    DataSet = qryEcnal
    Left = 479
    Top = 187
  end
  object Ecnal: TfrxDBDataset
    UserName = 'DSEcnal'
    CloseDataSource = True
    DataSource = dsEcnal
    BCDToCurrency = False
    Left = 521
    Top = 186
  end
  object qryAnalizPrib: TMSQuery
    Connection = DM.Conect
    SQL.Strings = (
      'SELECT * FROM tAnalisPrib'
      ' ')
    Left = 98
    Top = 354
  end
  object dsAnalizPrib: TDataSource
    DataSet = qryAnalizPrib
    Left = 127
    Top = 354
  end
  object AnalizPrib: TfrxDBDataset
    UserName = 'DSAnalizPrib'
    CloseDataSource = True
    DataSource = dsAnalizPrib
    BCDToCurrency = False
    Left = 161
    Top = 353
  end
  object qryAnalizKot: TMSQuery
    Connection = DM.Conect
    SQL.Strings = (
      'SELECT a.*,b.* FROM tAnalisKot1 a,tAnalisKot2 b'
      'where a.kod = b.kod'
      ' ')
    Left = 98
    Top = 402
  end
  object dsAnalizKot: TDataSource
    DataSet = qryAnalizKot
    Left = 127
    Top = 402
  end
  object AnalizKot: TfrxDBDataset
    UserName = 'DSAnalizKot'
    CloseDataSource = True
    DataSource = dsAnalizKot
    BCDToCurrency = False
    Left = 161
    Top = 401
  end
  object qryAnalizOrg: TMSQuery
    Connection = DM.Conect
    SQL.Strings = (
      'SELECT a.*,b.* FROM tAnalisOrg1 a,tAnalisOrg2 b'
      'where a.kod = b.kod'
      ' ')
    Left = 98
    Top = 450
  end
  object dsAnalizOrg: TDataSource
    DataSet = qryAnalizOrg
    Left = 127
    Top = 450
  end
  object AnalizOrg: TfrxDBDataset
    UserName = 'DSAnalizOrg'
    CloseDataSource = True
    DataSource = dsAnalizOrg
    BCDToCurrency = False
    Left = 161
    Top = 449
  end
  object qryNormativ: TMSQuery
    Connection = DM.Conect
    SQL.Strings = (
      'SELECT * FROM tFactNormativ'
      ' ')
    Left = 98
    Top = 498
  end
  object dsNormativ: TDataSource
    DataSet = qryNormativ
    Left = 127
    Top = 498
  end
  object Normativ: TfrxDBDataset
    UserName = 'DSNormativ'
    CloseDataSource = True
    DataSource = dsNormativ
    BCDToCurrency = False
    Left = 161
    Top = 497
  end
  object qryLicevRasArh: TMSQuery
    Connection = DM.Conect
    SQL.Strings = (
      'SELECT a.kodobk, a.nazv, a.kodorg,'
      'sum(b.gkt+b.pgkt) AS gkal_t,'
      'sum(b.gkv+b.pgkv) AS gkal_v,'
      'avg(b.rastarift) AS tarif_t,'
      'sum(b.pert+b.perv) AS per,'
      
        'sum(b.symt+b.symv+(b.pert-b.pertnds)+(b.perv-b.pervnds)) AS symb' +
        'eznds,'
      'sum(b.symtnds+b.symvnds+b.pertnds+b.pervnds) AS symnds, '
      'sum(b.symk+b.symgv+b.pert+b.perv) AS symsnds,'
      'sum(b.lgkt) AS lgkal_t,'
      'sum(b.lgkv) AS lgkal_v,'
      'sum(b.lsymt) AS lsumt,'
      'sum(b.lsymv) AS lsumgv,'
      'sum(b.kybv+b.pkybv) AS kyb_v,'
      'sum(b.kybk+b.pkybk) AS kyb_k,'
      'avg(b.rastarifv) AS tarif_v,'
      'avg(b.rastarifk) AS tarif_k,'
      'sum(b.perh+b.perk) AS perhv,'
      
        'sum(b.symh+b.symkk+(b.perh-b.perhnds)+(b.perk-b.perknds)) AS sym' +
        'bezndshv,'
      'sum(b.symhnds+b.symknds+b.perhnds+b.perknds) AS symndshv, '
      'sum(b.symhs+b.symks+b.perh+b.perk) AS symsndshv,'
      'sum(b.lkybv) AS lkyb_v,'
      'sum(b.lkybk) AS lkyb_k,'
      'sum(b.lsymh) AS lsumh,'
      'sum(b.lsymkk) AS lsumk,'
      'sum(b.kybg+b.pkybg) AS kyb_g,'
      'avg(b.rastarifg) AS tarif_g,'
      'sum(b.perg) AS perg,'
      'sum(b.symg+b.perg-b.pergnds) AS symbezndsg,'
      'sum(b.symgnds+b.pergnds) AS symndsg,'
      'sum(b.symgs+b.perg) AS symsndsg,'
      'sum(b.lkybg) AS lkyb_g,'
      'sum(b.lsymg) AS lsumg'
      'FROM OBEKT a,ARH_DATAOBEKT b '
      'WHERE a.kodobk=b.kodobk'
      'GROUP BY a.kodobk, a.nazv, a.kodorg'
      'ORDER BY a.kodobk')
    MasterSource = DM.dsOrg
    MasterFields = 'kodorg'
    DetailFields = 'kodorg'
    Left = 234
    Top = 187
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'kodorg'
      end>
  end
  object dsLicevRasArh: TDataSource
    DataSet = qryLicevRasArh
    Left = 263
    Top = 187
  end
  object qryPlanTeplo: TMSQuery
    Connection = DM.Conect
    SQL.Strings = (
      'SELECT * FROM tPlanTeplo')
    Left = 442
    Top = 347
  end
  object dsPlanTeplo: TDataSource
    DataSet = qryPlanTeplo
    Left = 471
    Top = 347
  end
  object PlanTeplo: TfrxDBDataset
    UserName = 'DSPlanTeplo'
    CloseDataSource = True
    DataSource = dsPlanTeplo
    BCDToCurrency = False
    Left = 505
    Top = 346
  end
  object qryPlanVoda: TMSQuery
    Connection = DM.Conect
    SQL.Strings = (
      'SELECT * FROM tPlanVoda'
      ' ')
    Left = 442
    Top = 395
  end
  object dsPlanVoda: TDataSource
    DataSet = qryPlanVoda
    Left = 471
    Top = 395
  end
  object qryPlanStok: TMSQuery
    Connection = DM.Conect
    SQL.Strings = (
      'SELECT * FROM tPlanStok')
    Left = 442
    Top = 443
  end
  object dsPlanStok: TDataSource
    DataSet = qryPlanStok
    Left = 471
    Top = 443
  end
  object PlanVoda: TfrxDBDataset
    UserName = 'DSPlanVoda'
    CloseDataSource = True
    DataSource = dsPlanVoda
    BCDToCurrency = False
    Left = 505
    Top = 394
  end
  object PlanStok: TfrxDBDataset
    UserName = 'dsPlanStok'
    CloseDataSource = True
    DataSource = dsPlanStok
    BCDToCurrency = False
    Left = 505
    Top = 442
  end
  object qryKot: TMSQuery
    Connection = DM.Conect
    SQL.Strings = (
      'SELECT b.nazk,c.naztop, a.*'
      'FROM datatop a, koteln b, vidtop c'
      'WHERE a.kodkot=b.kodkot and c.kodtop=a.kodtop'
      'order by b.kodkot'
      ' ')
    Left = 234
    Top = 427
  end
  object dsKot: TDataSource
    DataSet = qryKot
    Left = 263
    Top = 427
  end
  object Kot: TfrxDBDataset
    UserName = 'dsKot'
    CloseDataSource = True
    FieldAliases.Strings = (
      'nazk=nazk'
      'naztop=naztop'
      'kodkot=KODKOT'
      'kodtop=kodtop'
      'r_ot=r_ot'
      'r_gv=r_gv'
      'ps=ps'
      'v_tep=v_tep'
      'k_per=k_per'
      'n_top=n_top'
      'kol_n=kol_n'
      'kol_t=kol_t'
      'datan=DATAN'
      'kodkot_1=kodkot_1'
      'kodtop_1=kodtop_1')
    DataSource = dsKot
    BCDToCurrency = False
    Left = 233
    Top = 469
  end
  object qryVed: TMSQuery
    Connection = DM.Conect
    SQL.Strings = (
      
        'SELECT a.gkt, a.gkv, e.nazk, b.prj, cena = (select cena from dat' +
        'atarif where kodtt=10 and datan = :data),'
      'normativ, normativgv, b.so,'
      '(c.nazvul+'#39','#39'+b.ndom+'#39'-'#39'+d.kv) as adres'
      'from datakvart a, doma b, ulica c, kvart d, koteln e'
      
        'where a.kodkv = d.kodkv and c.kodul = b.kodul and b.koddom = d.k' +
        'oddom and e.kodkot = b.kodkot'
      'and b.kodkot=:kod and a.datan = :data'
      'order by adres')
    Left = 313
    Top = 432
    ParamData = <
      item
        DataType = ftDateTime
        Name = 'data'
        Value = 39022d
      end
      item
        DataType = ftInteger
        Name = 'kod'
        Value = 2
      end
      item
        DataType = ftDateTime
        Name = 'data'
        Value = 39022d
      end>
  end
  object dsVed: TDataSource
    DataSet = qryVed
    Left = 342
    Top = 432
  end
  object Ved: TfrxDBDataset
    UserName = 'dsVed'
    CloseDataSource = True
    DataSource = dsVed
    BCDToCurrency = False
    Left = 313
    Top = 474
  end
  object qryVyr: TMSQuery
    Connection = DM.Conect
    SQL.Strings = (
      'SELECT * from tVyr'
      ''
      ' ')
    Left = 602
    Top = 291
  end
  object dsVyr: TDataSource
    DataSet = qryVyr
    Left = 631
    Top = 291
  end
  object Vyr: TfrxDBDataset
    UserName = 'dsVyr'
    CloseDataSource = True
    FieldAliases.Strings = (
      'vr=vr'
      'rt=rt'
      'ps=ps'
      'nas=nas'
      'org=org'
      'sv_org=sv_org'
      'sn=sn'
      'sl=sl'
      'dr=dr')
    DataSource = dsVyr
    BCDToCurrency = False
    Left = 601
    Top = 333
  end
  object qryTop: TMSQuery
    Connection = DM.Conect
    SQL.Strings = (
      'SELECT * from tTop')
    Left = 602
    Top = 379
  end
  object dsTop: TDataSource
    DataSet = qryTop
    Left = 631
    Top = 379
  end
  object Top: TfrxDBDataset
    UserName = 'dsTop'
    CloseDataSource = True
    FieldAliases.Strings = (
      'kt=kt'
      'vid=vid'
      'kol=kol'
      'tut=tut'
      'kper=kper')
    DataSource = dsTop
    BCDToCurrency = False
    Left = 601
    Top = 421
  end
  object qryEcLgot: TMSQuery
    Connection = DM.Conect
    SQL.Strings = (
      'SELECT * FROM ras_kot_el'
      'ORDER BY 3,2')
    Left = 232
    Top = 235
  end
  object dsEcLgot: TDataSource
    DataSet = qryEcLgot
    Left = 261
    Top = 235
  end
  object EcLgot: TfrxDBDataset
    UserName = 'DSEcnal'
    CloseDataSource = True
    DataSource = dsEcLgot
    BCDToCurrency = False
    Left = 195
    Top = 238
  end
  object qryPlanG: TMSQuery
    Connection = DM.Conect
    SQL.Strings = (
      'SELECT * FROM tPlanG')
    Left = 442
    Top = 499
  end
  object dsPlanG: TDataSource
    DataSet = qryPlanG
    Left = 471
    Top = 499
  end
  object frxDBDataset1: TfrxDBDataset
    UserName = 'dsPlanG'
    CloseDataSource = True
    DataSource = dsPlanG
    BCDToCurrency = False
    Left = 505
    Top = 499
  end
  object qryObSvodG: TMSQuery
    Connection = DM.Conect
    SQL.Strings = (
      'SELECT * FROM gen_report_g')
    Left = 585
    Top = 96
  end
  object dsObSvodG: TDataSource
    DataSet = qryObSvodG
    Left = 614
    Top = 96
  end
  object ObSvodG: TfrxDBDataset
    UserName = 'dsObSvodG'
    CloseDataSource = True
    DataSource = dsObSvodG
    BCDToCurrency = False
    Left = 657
    Top = 97
  end
  object qryRasKotG: TMSQuery
    Connection = DM.Conect
    SQL.Strings = (
      'SELECT * FROM ras_kot_g')
    Left = 586
    Top = 162
  end
  object dsRasKotG: TDataSource
    DataSet = qryRasKotG
    Left = 615
    Top = 162
  end
  object RasKotG: TfrxDBDataset
    UserName = 'dsRasKotG'
    CloseDataSource = True
    DataSource = dsRasKotG
    BCDToCurrency = False
    Left = 649
    Top = 161
  end
  object qryRasNacG: TMSQuery
    Connection = DM.Conect
    SQL.Strings = (
      'SELECT * FROM ras_nac_g')
    Left = 586
    Top = 211
  end
  object dsRasNacG: TDataSource
    DataSet = qryRasNacG
    Left = 615
    Top = 211
  end
  object RasNacG: TfrxDBDataset
    UserName = 'dsRasNacG'
    CloseDataSource = True
    DataSource = dsRasNacG
    BCDToCurrency = False
    Left = 649
    Top = 210
  end
  object exReport: TscExcelExport
    DataPipe = dpDataSet
    StyleColumnWidth = cwDefault
    ColumnWidth = 0
    FontHeader.Charset = DEFAULT_CHARSET
    FontHeader.Color = clWindowText
    FontHeader.Height = 1
    FontHeader.Name = 'Tahoma'
    FontHeader.Style = []
    FontHeader.Alignment = haGeneral
    FontHeader.WrapText = False
    FontHeader.Orientation = 0
    BorderHeader.BackAlternateColor = clBlack
    MergeHeaderCells = True
    FontTitles.Charset = DEFAULT_CHARSET
    FontTitles.Color = clWindowText
    FontTitles.Height = 1
    FontTitles.Name = 'Tahoma'
    FontTitles.Style = []
    FontTitles.Alignment = haGeneral
    FontTitles.WrapText = False
    FontTitles.Orientation = 0
    BorderTitles.BackAlternateColor = clBlack
    AutoFilter = False
    FontData.Charset = DEFAULT_CHARSET
    FontData.Color = clWindowText
    FontData.Height = 1
    FontData.Name = 'Tahoma'
    FontData.Style = []
    FontData.Alignment = haGeneral
    FontData.WrapText = False
    FontData.Orientation = 0
    FontSummary.Charset = DEFAULT_CHARSET
    FontSummary.Color = clWindowText
    FontSummary.Height = 1
    FontSummary.Name = 'Tahoma'
    FontSummary.Style = []
    FontSummary.Alignment = haGeneral
    FontSummary.WrapText = False
    FontSummary.Orientation = 0
    BorderSummary.BackAlternateColor = clBlack
    SummarySelection = ssNone
    SummaryCalculation = scSUM
    FontFooter.Charset = DEFAULT_CHARSET
    FontFooter.Color = clWindowText
    FontFooter.Height = 1
    FontFooter.Name = 'Tahoma'
    FontFooter.Style = []
    FontFooter.Alignment = haGeneral
    FontFooter.WrapText = False
    FontFooter.Orientation = 0
    BorderFooter.BackAlternateColor = clBlack
    MergeFooterCells = True
    FontGroup.Charset = DEFAULT_CHARSET
    FontGroup.Color = clWindowText
    FontGroup.Height = 1
    FontGroup.Name = 'Tahoma'
    FontGroup.Style = []
    FontGroup.Alignment = haGeneral
    FontGroup.WrapText = False
    FontGroup.Orientation = 0
    BorderGroup.BackAlternateColor = clBlack
    GroupOptions.ClearContents = True
    GroupOptions.BorderRange = bsRow
    GroupOptions.IntervalFontSize = 2
    Left = 272
    Top = 520
  end
  object qryPropis: TMSQuery
    Connection = DM.Conect
    SQL.Strings = (
      'SELECT * from tPropis')
    Left = 626
    Top = 475
  end
  object dsPropis: TDataSource
    DataSet = qryPropis
    Left = 655
    Top = 475
  end
  object Propis: TfrxDBDataset
    UserName = 'dsPropis'
    CloseDataSource = True
    FieldAliases.Strings = (
      'ruble_prop=ruble_prop'
      'kopeika_prop=kopeika_prop'
      'print_kop=print_kop')
    DataSource = dsPropis
    BCDToCurrency = False
    Left = 625
    Top = 517
  end
end

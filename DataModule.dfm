object DM: TDM
  OldCreateOrder = False
  Left = 393
  Top = 156
  Height = 712
  Width = 732
  object Conect: TMSConnection
    Database = 'Teplosnab'
    Options.Provider = prSQL
    Username = 'sa'
    Password = '1'
    Server = 'DELPHI7'
    Connected = True
    ConnectDialog = ConectDlg
    Left = 8
    Top = 11
  end
  object qryOrg: TMSQuery
    Connection = Conect
    SQL.Strings = (
      'select * from org'
      'order by nazv')
    Left = 56
    Top = 11
    object qryOrgkodorg: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'kodorg'
      Origin = 'org.kodorg'
      ReadOnly = True
    end
    object qryOrgnazv: TStringField
      FieldName = 'nazv'
      Origin = 'org.nazv'
      Size = 100
    end
    object qryOrgadres: TStringField
      FieldName = 'adres'
      Origin = 'org.adres'
      Size = 100
    end
    object qryOrgbank: TStringField
      FieldName = 'bank'
      Origin = 'org.bank'
      Size = 100
    end
    object qryOrgrschet: TStringField
      FieldName = 'rschet'
      Origin = 'org.rschet'
      Size = 13
    end
    object qryOrgunn: TStringField
      FieldName = 'unn'
      Origin = 'org.unn'
      Size = 10
    end
    object qryOrgtiporg: TFloatField
      FieldName = 'tiporg'
      Origin = 'org.tiporg'
    end
    object qryOrgdatadog: TDateTimeField
      FieldName = 'datadog'
      Origin = 'org.datadog'
    end
    object qryOrgndog: TFloatField
      FieldName = 'ndog'
      Origin = 'org.ndog'
    end
    object qryOrgmi_: TStringField
      FieldName = '_min'
      Origin = 'org._min'
      Size = 40
    end
    object qryOrgtipbud: TIntegerField
      FieldName = 'tipbud'
      Origin = 'org.tipbud'
    end
    object qryOrgkodbank: TIntegerField
      FieldName = 'kodbank'
      Origin = 'org.kodbank'
    end
  end
  object dsOrg: TDataSource
    DataSet = qryOrg
    Left = 96
    Top = 11
  end
  object qryObekt: TMSQuery
    Connection = Conect
    SQL.Strings = (
      'select * from obekt'
      'order by kodobk')
    MasterSource = dsOrg
    MasterFields = 'kodorg'
    DetailFields = 'kodorg'
    Left = 56
    Top = 57
    ParamData = <
      item
        DataType = ftInteger
        Name = 'kodorg'
        ParamType = ptInput
        Value = 1
      end>
    object qryObektkodorg: TIntegerField
      FieldName = 'kodorg'
      Origin = 'obekt.kodorg'
    end
    object qryObektkodobk: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'kodobk'
      Origin = 'obekt.kodobk'
      ReadOnly = True
    end
    object qryObektnazv: TStringField
      FieldName = 'nazv'
      Origin = 'obekt.nazv'
      Size = 100
    end
    object qryObektngvs: TFloatField
      FieldName = 'ngvs'
      Origin = 'obekt.ngvs'
    end
    object qryObektkodkot: TIntegerField
      FieldName = 'kodkot'
      Origin = 'obekt.kodkot'
    end
    object qryObektkodtt: TIntegerField
      FieldName = 'kodtt'
      Origin = 'obekt.kodtt'
    end
    object qryObektnds: TIntegerField
      FieldName = 'nds'
      Origin = 'obekt.nds'
    end
    object qryObektecnal: TIntegerField
      FieldName = 'ecnal'
      Origin = 'obekt.ecnal'
    end
    object qryObektnalprib: TIntegerField
      FieldName = 'nalprib'
      Origin = 'obekt.nalprib'
    end
    object qryObektnalpribgv: TIntegerField
      FieldName = 'nalpribgv'
      Origin = 'obekt.nalpribgv'
    end
    object qryObektkodpr: TIntegerField
      FieldName = 'kodpr'
      Origin = 'obekt.kodpr'
    end
    object qryObektprin: TIntegerField
      FieldName = 'prin'
      Origin = 'obekt.prin'
    end
    object qryObektq: TFloatField
      FieldName = 'q'
      Origin = 'obekt.q'
    end
    object qryObektt: TFloatField
      FieldName = 't'
      Origin = 'obekt.t'
    end
    object qryObektprj: TFloatField
      FieldName = 'prj'
      Origin = 'obekt.prj'
    end
    object qryObektprjl: TFloatField
      FieldName = 'prjl'
      Origin = 'obekt.prjl'
    end
    object qryObektspl: TFloatField
      FieldName = 'spl'
      Origin = 'obekt.spl'
    end
    object qryObektspll: TFloatField
      FieldName = 'spll'
      Origin = 'obekt.spll'
    end
    object qryObektpodkl: TIntegerField
      FieldName = 'podkl'
      Origin = 'obekt.podkl'
    end
    object qryObektv: TFloatField
      FieldName = 'v'
      Origin = 'obekt.v'
    end
    object qryObektrasch: TIntegerField
      FieldName = 'rasch'
      Origin = 'obekt.rasch'
    end
    object qryObektkodtv: TIntegerField
      FieldName = 'kodtv'
      Origin = 'obekt.kodtv'
    end
    object qryObektpodklv: TIntegerField
      FieldName = 'podklv'
      Origin = 'obekt.podklv'
    end
    object qryObektqv: TFloatField
      FieldName = 'qv'
      Origin = 'obekt.qv'
    end
    object qryObektqk: TFloatField
      FieldName = 'qk'
      Origin = 'obekt.qk'
    end
    object qryObektpodklgv: TIntegerField
      FieldName = 'podklgv'
    end
    object qryObektkodtg: TIntegerField
      FieldName = 'kodtg'
    end
    object qryObektpodklg: TIntegerField
      FieldName = 'podklg'
    end
    object qryObektdata_per: TDateTimeField
      FieldName = 'data_per'
    end
    object qryObektqg: TFloatField
      FieldName = 'qg'
    end
  end
  object dsObekt: TDataSource
    DataSet = qryObekt
    Left = 96
    Top = 57
  end
  object dsBank: TDataSource
    DataSet = qryBank
    Left = 96
    Top = 106
  end
  object qryBank: TMSQuery
    Connection = Conect
    SQL.Strings = (
      'select * from bank'
      'order by kod_bank')
    Left = 56
    Top = 106
  end
  object dsTarifTeplo: TDataSource
    DataSet = qryTarifTeplo
    Left = 96
    Top = 152
  end
  object qryTarifTeplo: TMSQuery
    Connection = Conect
    SQL.Strings = (
      'select * from tarift'
      'order by kodtt')
    Left = 56
    Top = 152
  end
  object dsTarifVoda: TDataSource
    DataSet = qryTarifVoda
    Left = 96
    Top = 199
  end
  object qryTarifVoda: TMSQuery
    Connection = Conect
    SQL.Strings = (
      'select * from tarifv'
      'order by kodtv')
    Left = 56
    Top = 199
  end
  object dsKoteln: TDataSource
    DataSet = qryKoteln
    Left = 96
    Top = 247
  end
  object qryKoteln: TMSQuery
    Connection = Conect
    SQL.Strings = (
      
        'select *,teplosnab.dbo.sf_select_mesto(mesto) as rasp from kotel' +
        'n'
      'order by kodkot')
    UpdateObject = UpKot
    Left = 56
    Top = 247
    object qryKotelnkodkot: TIntegerField
      AutoGenerateValue = arAutoInc
      DisplayWidth = 12
      FieldName = 'kodkot'
      Origin = 'koteln.kodkot'
      ReadOnly = True
    end
    object qryKotelnnazk: TStringField
      DisplayWidth = 36
      FieldName = 'nazk'
      Origin = 'koteln.nazk'
      Size = 30
    end
    object qryKotelnntop: TFloatField
      DisplayWidth = 12
      FieldName = 'ntop'
      Origin = 'koteln.ntop'
    end
    object qryKotelnnel: TFloatField
      DisplayWidth = 12
      FieldName = 'nel'
      Origin = 'koteln.nel'
    end
    object qryKotelnps: TFloatField
      DisplayWidth = 12
      FieldName = 'ps'
      Origin = 'koteln.ps'
    end
    object qryKotelnmesto: TFloatField
      DisplayWidth = 12
      FieldName = 'mesto'
      Origin = 'koteln.mesto'
    end
    object qryKotelnrasp: TStringField
      DisplayWidth = 18
      FieldName = 'rasp'
      Origin = '.'
      ReadOnly = True
      FixedChar = True
      Size = 5
    end
    object qryKotelnmaster: TStringField
      FieldName = 'master'
      Origin = 'koteln.master'
      FixedChar = True
      Size = 50
    end
    object qryKotelnkodpr: TIntegerField
      FieldName = 'kodpr'
      Origin = 'koteln.kodpr'
    end
  end
  object dsPribor: TDataSource
    DataSet = qryPribor
    Left = 96
    Top = 296
  end
  object qryPribor: TMSQuery
    Connection = Conect
    SQL.Strings = (
      
        'select *, teplosnab.dbo.yes_no(tep) as u_t, teplosnab.dbo.yes_no' +
        '(tgv) as u_tgv'
      'from pribor'
      'order by kod')
    UpdateObject = UpPribor
    Left = 56
    Top = 296
    object qryPriborkod: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'kod'
      Origin = 'pribor.kod'
      ReadOnly = True
    end
    object qryPribornazp: TStringField
      FieldName = 'nazp'
      Origin = 'pribor.nazp'
      Size = 50
    end
    object qryPriborkodorg: TIntegerField
      FieldName = 'kodorg'
      Origin = 'pribor.kodorg'
    end
    object qryPriborkodkot: TIntegerField
      FieldName = 'kodkot'
      Origin = 'pribor.kodkot'
    end
    object qryPribortep: TSmallintField
      FieldName = 'tep'
      Origin = 'pribor.tep'
    end
    object qryPribortgv: TSmallintField
      FieldName = 'tgv'
      Origin = 'pribor.tgv'
    end
    object qryPriboru_t: TStringField
      FieldName = 'u_t'
      Origin = '.'
      ReadOnly = True
      FixedChar = True
      Size = 3
    end
    object qryPriboru_tgv: TStringField
      FieldName = 'u_tgv'
      Origin = '.'
      ReadOnly = True
      FixedChar = True
      Size = 3
    end
  end
  object SQLMon: TMSSQLMonitor
    Options = [moDialog, moSQLMonitor, moDBMonitor, moCustom, moHandled]
    Left = 432
    Top = 11
  end
  object UpOrg: TMSUpdateSQL
    InsertSQL.Strings = (
      'INSERT INTO org'
      
        '  (nazv, adres, bank, rschet, unn, tiporg, datadog, ndog, mi_, t' +
        'ipbud, kodbank)'
      'VALUES'
      
        '  (:nazv, :adres, :bank, :rschet, :unn, :tiporg, :datadog, :ndog' +
        ', :mi_, :tipbud, :kodbank)'
      'SET :kodorg = SCOPE_IDENTITY()')
    DeleteSQL.Strings = (
      'DELETE FROM org'
      'WHERE'
      '  kodorg = :Old_kodorg')
    ModifySQL.Strings = (
      'UPDATE org'
      'SET'
      
        '  nazv = :nazv, adres = :adres, bank = :bank, rschet = :rschet, ' +
        'unn = :unn, tiporg = :tiporg, datadog = :datadog, ndog = :ndog, ' +
        'mi_ = :mi_, tipbud = :tipbud, kodbank = :kodbank'
      'WHERE'
      '  kodorg = :Old_kodorg')
    RefreshSQL.Strings = (
      
        'SELECT org.nazv, org.adres, org.bank, org.rschet, org.unn, org.t' +
        'iporg, org.datadog, org.ndog, org.mi_, org.tipbud, org.kodbank F' +
        'ROM org'
      'WHERE org.kodorg = :kodorg ')
    Left = 136
    Top = 11
  end
  object UpObk: TMSUpdateSQL
    InsertSQL.Strings = (
      'INSERT INTO obekt'
      
        '  (kodorg, nazv, ngvs, kodkot, kodtt, nds, ecnal, nalprib, nalpr' +
        'ibgv, kodpr, prin, q, t, prj, prjl, spl, spll, podkl, v, rasch, ' +
        'kodtv, podklv, qv, qk, podklgv)'
      'VALUES'
      
        '  (:kodorg, :nazv, :ngvs, :kodkot, :kodtt, :nds, :ecnal, :nalpri' +
        'b, :nalpribgv, :kodpr, :prin, :q, :t, :prj, :prjl, :spl, :spll, ' +
        ':podkl, :v, :rasch, :kodtv, :podklv, :qv, :qk, :podklgv)'
      'SET :kodobk = SCOPE_IDENTITY()')
    DeleteSQL.Strings = (
      'DELETE FROM obekt'
      'WHERE'
      '  kodobk = :Old_kodobk')
    ModifySQL.Strings = (
      'UPDATE obekt'
      'SET'
      
        '  kodorg = :kodorg, nazv = :nazv, ngvs = :ngvs, kodkot = :kodkot' +
        ', kodtt = :kodtt, nds = :nds, ecnal = :ecnal, nalprib = :nalprib' +
        ', nalpribgv = :nalpribgv, kodpr = :kodpr, prin = :prin, q = :q, ' +
        't = :t, prj = :prj, prjl = :prjl, spl = :spl, spll = :spll, podk' +
        'l = :podkl, v = :v, rasch = :rasch, kodtv = :kodtv, podklv = :po' +
        'dklv, qv = :qv, qk = :qk, podklgv = :podklgv'
      'WHERE'
      '  kodobk = :Old_kodobk')
    RefreshSQL.Strings = (
      
        'SELECT obekt.kodorg, obekt.nazv, obekt.ngvs, obekt.kodkot, obekt' +
        '.kodtt, obekt.nds, obekt.ecnal, obekt.nalprib, obekt.nalpribgv, ' +
        'obekt.kodpr, obekt.prin, obekt.q, obekt.t, obekt.prj, obekt.prjl' +
        ', obekt.spl, obekt.spll, obekt.podkl, obekt.v, obekt.rasch, obek' +
        't.kodtv, obekt.podklv, obekt.qv, obekt.qk, obekt.podklgv FROM ob' +
        'ekt'
      'WHERE obekt.kodobk = :kodobk ')
    Left = 136
    Top = 57
  end
  object qryOtChar: TMSQuery
    Connection = Conect
    SQL.Strings = (
      'select * from OtChar')
    Left = 288
    Top = 11
  end
  object qryHistObk: TMSQuery
    Connection = Conect
    SQL.Strings = (
      'select * from danobk'
      '')
    MasterSource = dsObekt
    MasterFields = 'kodobk'
    DetailFields = 'kodobk'
    CursorType = ctStatic
    Left = 192
    Top = 58
    ParamData = <
      item
        DataType = ftInteger
        Name = 'kodobk'
        ParamType = ptInput
        Value = 1
      end>
  end
  object dsHistObk: TDataSource
    DataSet = qryHistObk
    Left = 232
    Top = 58
  end
  object qryError: TMSQuery
    Connection = Conect
    SQL.Strings = (
      'select * from temp_err')
    Left = 336
    Top = 55
  end
  object dsError: TDataSource
    DataSet = qryError
    Left = 376
    Top = 55
  end
  object qryObk: TMSQuery
    Connection = Conect
    SQL.Strings = (
      'select * from obekt'
      'order by kodobk')
    Left = 193
    Top = 105
  end
  object qryDoma: TMSQuery
    Connection = Conect
    SQL.Strings = (
      'select a.*,(b.nazvul+'#39','#39'+a.ndom) as adres '
      'from doma a,ulica b'
      'where a.kodul=b.kodul'
      'order by adres')
    Left = 56
    Top = 339
    object qryDomakoddom: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'koddom'
      Origin = 'doma.koddom'
    end
    object qryDomakodkot: TIntegerField
      FieldName = 'kodkot'
      Origin = 'doma.kodkot'
    end
    object qryDomakodul: TIntegerField
      FieldName = 'kodul'
      Origin = 'doma.kodul'
    end
    object qryDomandom: TStringField
      FieldName = 'ndom'
      Origin = 'doma.ndom'
      Size = 4
    end
    object qryDomaso: TFloatField
      FieldName = 'so'
      Origin = 'doma.so'
    end
    object qryDomaprj: TFloatField
      FieldName = 'prj'
      Origin = 'doma.prj'
    end
    object qryDomaqot: TFloatField
      FieldName = 'qot'
      Origin = 'doma.qot'
    end
    object qryDomaqgv: TFloatField
      FieldName = 'qgv'
      Origin = 'doma.qgv'
    end
    object qryDomalot: TIntegerField
      FieldName = 'lot'
      Origin = 'doma.lot'
    end
    object qryDomalgv: TIntegerField
      FieldName = 'lgv'
      Origin = 'doma.lgv'
    end
    object qryDomakodpr: TIntegerField
      FieldName = 'kodpr'
      Origin = 'doma.kodpr'
    end
    object qryDomangv: TFloatField
      FieldName = 'ngv'
      Origin = 'doma.ngv'
    end
    object qryDomavd: TFloatField
      FieldName = 'vd'
      Origin = 'doma.vd'
    end
    object qryDomapodkl: TIntegerField
      FieldName = 'podkl'
      Origin = 'doma.podkl'
    end
    object qryDomaadres: TStringField
      FieldName = 'adres'
      Origin = '.'
      ReadOnly = True
      Size = 23
    end
    object qryDomapodklgv: TIntegerField
      FieldName = 'podklgv'
      Origin = 'doma.podklgv'
    end
  end
  object dsDoma: TDataSource
    DataSet = qryDoma
    Left = 96
    Top = 339
  end
  object UpDoma: TMSUpdateSQL
    InsertSQL.Strings = (
      'INSERT INTO doma'
      
        '  (kodkot, kodul, ndom, so, prj, qot, qgv, lot, lgv, kodpr, ngv,' +
        ' vd, podkl, podklgv)'
      'VALUES'
      
        '  (:kodkot, :kodul, :ndom, :so, :prj, :qot, :qgv, :lot, :lgv, :k' +
        'odpr, :ngv, :vd, :podkl, :podklgv)'
      'SET :koddom = SCOPE_IDENTITY()')
    DeleteSQL.Strings = (
      'DELETE FROM doma'
      'WHERE'
      '  koddom = :Old_koddom')
    ModifySQL.Strings = (
      'UPDATE doma'
      'SET'
      
        '  kodkot = :kodkot, kodul = :kodul, ndom = :ndom, so = :so, prj ' +
        '= :prj, qot = :qot, qgv = :qgv, lot = :lot, lgv = :lgv, kodpr = ' +
        ':kodpr, ngv = :ngv, vd = :vd, podkl = :podkl, podklgv = :podklgv'
      'WHERE'
      '  koddom = :Old_koddom')
    RefreshSQL.Strings = (
      
        'SELECT a.kodkot, a.kodul, a.ndom, a.so, a.prj, a.qot, a.qgv, a.l' +
        'ot, a.lgv, a.kodpr, a.ngv, a.vd, a.podkl, a.podklgv FROM doma a'
      'WHERE a.koddom = :koddom ')
    Left = 136
    Top = 339
  end
  object qryKvart: TMSQuery
    Connection = Conect
    SQL.Strings = (
      'select * from kvart'
      'order by kv')
    MasterSource = dsDoma
    MasterFields = 'koddom'
    DetailFields = 'koddom'
    Left = 56
    Top = 385
    ParamData = <
      item
        DataType = ftInteger
        Name = 'koddom'
        Value = 1
      end>
    object qryKvartschet: TFloatField
      FieldName = 'schet'
    end
    object qryKvartkodkv: TIntegerField
      FieldName = 'kodkv'
    end
    object qryKvartkoddom: TIntegerField
      FieldName = 'koddom'
    end
    object qryKvartkv: TStringField
      FieldName = 'kv'
      Size = 4
    end
    object qryKvartso: TFloatField
      FieldName = 'so'
    end
    object qryKvartprj: TFloatField
      FieldName = 'prj'
    end
    object qryKvartqot: TFloatField
      FieldName = 'qot'
    end
    object qryKvartqgv: TFloatField
      FieldName = 'qgv'
    end
    object qryKvartprin: TIntegerField
      FieldName = 'prin'
    end
    object qryKvartngv: TFloatField
      FieldName = 'ngv'
    end
    object qryKvartpriv: TIntegerField
      FieldName = 'priv'
    end
    object qryKvartkodobk: TIntegerField
      FieldName = 'kodobk'
    end
    object qryKvartpodkl: TIntegerField
      FieldName = 'podkl'
    end
    object qryKvartpodklgv: TIntegerField
      FieldName = 'podklgv'
    end
  end
  object dsKvart: TDataSource
    DataSet = qryKvart
    Left = 96
    Top = 385
  end
  object UpKvart: TMSUpdateSQL
    InsertSQL.Strings = (
      'INSERT INTO kvart'
      
        '  (schet, koddom, kv, so, prj, qot, qgv, prin, ngv, priv, kodobk' +
        ', podkl, podklgv)'
      'VALUES'
      
        '  (:schet, :koddom, :kv, :so, :prj, :qot, :qgv, :prin, :ngv, :pr' +
        'iv, :kodobk, :podkl, :podklgv)'
      'SET :kodkv = SCOPE_IDENTITY()')
    DeleteSQL.Strings = (
      'DELETE FROM kvart'
      'WHERE'
      '  kodkv = :Old_kodkv')
    ModifySQL.Strings = (
      'UPDATE kvart'
      'SET'
      
        '  schet = :schet, koddom = :koddom, kv = :kv, so = :so, prj = :p' +
        'rj, qot = :qot, qgv = :qgv, prin = :prin, ngv = :ngv, priv = :pr' +
        'iv, kodobk = :kodobk, podkl = :podkl, podklgv = :podklgv'
      'WHERE'
      '  kodkv = :Old_kodkv')
    RefreshSQL.Strings = (
      
        'SELECT kvart.schet, kvart.koddom, kvart.kv, kvart.so, kvart.prj,' +
        ' kvart.qot, kvart.qgv, kvart.prin, kvart.ngv, kvart.priv, kvart.' +
        'kodobk, kvart.podkl, kvart.podklgv FROM kvart'
      'WHERE kvart.kodkv = :kodkv ')
    Left = 136
    Top = 385
  end
  object qryUlica: TMSQuery
    Connection = Conect
    SQL.Strings = (
      'select * from ulica'
      'order by nazvul')
    Left = 56
    Top = 431
  end
  object dsUlica: TDataSource
    DataSet = qryUlica
    Left = 96
    Top = 431
  end
  object dsObk: TDataSource
    DataSet = qryObk
    Left = 232
    Top = 106
  end
  object qryHistoryDom: TMSQuery
    Connection = Conect
    SQL.Strings = (
      'select * from dandoma'
      '')
    MasterSource = dsDoma
    MasterFields = 'koddom'
    DetailFields = 'koddom'
    Left = 192
    Top = 338
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'koddom'
      end>
  end
  object dsHistoryDom: TDataSource
    DataSet = qryHistoryDom
    Left = 232
    Top = 338
  end
  object qryHistoryKv: TMSQuery
    Connection = Conect
    SQL.Strings = (
      'select * from dankvart'
      '')
    MasterSource = dsKvart
    MasterFields = 'kodkv'
    DetailFields = 'kodkv'
    Left = 192
    Top = 386
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'kodkv'
      end>
  end
  object dsHistoryKv: TDataSource
    DataSet = qryHistoryKv
    Left = 232
    Top = 386
  end
  object qryKv: TMSQuery
    Connection = Conect
    SQL.Strings = (
      'select * from kvart'
      'order by kv')
    UpdateObject = UpKvart
    Left = 280
    Top = 385
  end
  object dsKv: TDataSource
    DataSet = qryKv
    Left = 312
    Top = 385
  end
  object UpKot: TMSUpdateSQL
    InsertSQL.Strings = (
      'INSERT INTO koteln'
      '  (nazk, ntop, nel, ps, mesto, master, kodpr)'
      'VALUES'
      '  (:nazk, :ntop, :nel, :ps, :mesto, :master, :kodpr)'
      'SET :kodkot = SCOPE_IDENTITY()')
    DeleteSQL.Strings = (
      'DELETE FROM koteln'
      'WHERE'
      '  kodkot = :Old_kodkot')
    ModifySQL.Strings = (
      'UPDATE koteln'
      'SET'
      
        '  nazk = :nazk, ntop = :ntop, nel = :nel, ps = :ps, mesto = :mes' +
        'to, master = :master, kodpr = :kodpr'
      'WHERE'
      '  kodkot = :Old_kodkot')
    RefreshSQL.Strings = (
      
        'SELECT koteln.nazk, koteln.ntop, koteln.nel, koteln.ps, koteln.m' +
        'esto, koteln.master, koteln.kodpr FROM koteln'
      'WHERE koteln.kodkot = :kodkot ')
    Left = 136
    Top = 247
  end
  object DsNorma: TDataSource
    DataSet = qryNorma
    Left = 216
    Top = 247
  end
  object qryNorma: TMSQuery
    Connection = Conect
    SQL.Strings = (
      'select a.*,b.* from NormaTop a, VidTop b'
      'where a.kodtop=b.kodtop'
      'order by a.kodtop')
    UpdateObject = UpNorma
    MasterSource = dsKoteln
    MasterFields = 'kodkot'
    DetailFields = 'kodkot'
    Left = 176
    Top = 247
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'kodkot'
      end>
    object qryNormakodkot: TIntegerField
      FieldName = 'kodkot'
      Origin = 'NormaTop.kodkot'
    end
    object qryNormakodtop: TIntegerField
      FieldName = 'kodtop'
      Origin = 'NormaTop.kodtop'
    end
    object qryNormanorma: TFloatField
      FieldName = 'norma'
      Origin = 'NormaTop.norma'
    end
    object qryNormaid_norma: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'id_norma'
      Origin = 'NormaTop.id_norma'
      ReadOnly = True
    end
    object qryNormakodtop_1: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'kodtop_1'
      Origin = 'VidTop.kodtop'
      ReadOnly = True
    end
    object qryNormanaztop: TStringField
      FieldName = 'naztop'
      Origin = 'VidTop.naztop'
      FixedChar = True
      Size = 30
    end
    object qryNormak_per: TFloatField
      FieldName = 'k_per'
      Origin = 'VidTop.k_per'
    end
  end
  object UpNorma: TMSUpdateSQL
    InsertSQL.Strings = (
      'INSERT INTO NormaTop'
      '  (kodkot, kodtop, norma)'
      'VALUES'
      '  (:kodkot, :kodtop, :norma)'
      'SET :id_norma = SCOPE_IDENTITY()')
    DeleteSQL.Strings = (
      'DELETE FROM NormaTop'
      'WHERE'
      '  id_norma = :Old_id_norma')
    ModifySQL.Strings = (
      'UPDATE NormaTop'
      'SET'
      '  kodkot = :kodkot, kodtop = :kodtop, norma = :norma'
      'WHERE'
      '  id_norma = :Old_id_norma')
    RefreshSQL.Strings = (
      'SELECT a.kodkot, a.kodtop, a.norma FROM NormaTop a'
      'WHERE a.id_norma = :id_norma ')
    Left = 256
    Top = 247
  end
  object qryHistKot: TMSQuery
    Connection = Conect
    SQL.Strings = (
      'select * from dankot'
      '')
    MasterSource = dsKoteln
    MasterFields = 'kodkot'
    DetailFields = 'kodkot'
    CursorType = ctStatic
    Left = 312
    Top = 247
    ParamData = <
      item
        DataType = ftInteger
        Name = 'kodkot'
        ParamType = ptInput
        Value = 1
      end>
  end
  object dsHistKot: TDataSource
    DataSet = qryHistKot
    Left = 352
    Top = 247
  end
  object qryHistNorma: TMSQuery
    Connection = Conect
    SQL.Strings = (
      'select a.*,b.naztop from dannorma a, vidtop b'
      'where a.kodtop = b.kodtop'
      '')
    MasterSource = dsKoteln
    MasterFields = 'kodkot'
    DetailFields = 'kodkot'
    CursorType = ctStatic
    Left = 392
    Top = 247
    ParamData = <
      item
        DataType = ftInteger
        Name = 'kodkot'
        ParamType = ptInput
        Value = 1
      end>
  end
  object dsHistNorma: TDataSource
    DataSet = qryHistNorma
    Left = 432
    Top = 247
  end
  object qryVidTop: TMSQuery
    Connection = Conect
    SQL.Strings = (
      'select * from vidtop'
      'order by kodtop')
    UpdateObject = UpVidTop
    Left = 56
    Top = 477
    object qryVidTopkodtop: TIntegerField
      FieldName = 'kodtop'
      ReadOnly = True
    end
    object qryVidTopnaztop: TStringField
      FieldName = 'naztop'
      FixedChar = True
      Size = 30
    end
    object qryVidTopk_per: TFloatField
      FieldName = 'k_per'
    end
  end
  object dsVidTop: TDataSource
    DataSet = qryVidTop
    Left = 96
    Top = 477
  end
  object UpPribor: TMSUpdateSQL
    InsertSQL.Strings = (
      'INSERT INTO pribor'
      '  (nazp, kodorg, kodkot, tep, tgv)'
      'VALUES'
      '  (:nazp, :kodorg, :kodkot, :tep, :tgv)'
      'SET :kod = SCOPE_IDENTITY()')
    Left = 136
    Top = 296
  end
  object qryObektPr: TMSQuery
    Connection = Conect
    SQL.Strings = (
      'select *, (prj+prjl) as proj, (spl+spll) as so from obekt'
      'order by kodobk')
    MasterSource = dsPribor
    MasterFields = 'kod'
    DetailFields = 'kodpr'
    Left = 176
    Top = 296
    ParamData = <
      item
        DataType = ftInteger
        Name = 'kod'
        ParamType = ptInput
        Value = 1
      end>
    object IntegerField1: TIntegerField
      DisplayWidth = 12
      FieldName = 'kodorg'
      Origin = 'obekt.kodorg'
    end
    object IntegerField2: TIntegerField
      AutoGenerateValue = arAutoInc
      DisplayWidth = 12
      FieldName = 'kodobk'
      Origin = 'obekt.kodobk'
      ReadOnly = True
    end
    object StringField1: TStringField
      DisplayWidth = 34
      FieldName = 'nazv'
      Origin = 'obekt.nazv'
      Size = 100
    end
    object FloatField1: TFloatField
      DisplayWidth = 12
      FieldName = 'ngvs'
      Origin = 'obekt.ngvs'
    end
    object IntegerField3: TIntegerField
      DisplayWidth = 12
      FieldName = 'kodkot'
      Origin = 'obekt.kodkot'
    end
    object IntegerField4: TIntegerField
      DisplayWidth = 12
      FieldName = 'kodtt'
      Origin = 'obekt.kodtt'
    end
    object IntegerField5: TIntegerField
      DisplayWidth = 12
      FieldName = 'nds'
      Origin = 'obekt.nds'
    end
    object IntegerField6: TIntegerField
      DisplayWidth = 12
      FieldName = 'ecnal'
      Origin = 'obekt.ecnal'
    end
    object IntegerField7: TIntegerField
      DisplayWidth = 12
      FieldName = 'nalprib'
      Origin = 'obekt.nalprib'
    end
    object IntegerField8: TIntegerField
      DisplayWidth = 12
      FieldName = 'nalpribgv'
      Origin = 'obekt.nalpribgv'
    end
    object IntegerField9: TIntegerField
      DisplayWidth = 12
      FieldName = 'kodpr'
      Origin = 'obekt.kodpr'
    end
    object IntegerField10: TIntegerField
      DisplayWidth = 12
      FieldName = 'prin'
      Origin = 'obekt.prin'
    end
    object FloatField2: TFloatField
      DisplayWidth = 12
      FieldName = 'q'
      Origin = 'obekt.q'
    end
    object FloatField3: TFloatField
      DisplayWidth = 12
      FieldName = 't'
      Origin = 'obekt.t'
    end
    object FloatField4: TFloatField
      DisplayWidth = 12
      FieldName = 'prj'
      Origin = 'obekt.prj'
    end
    object FloatField5: TFloatField
      DisplayWidth = 12
      FieldName = 'prjl'
      Origin = 'obekt.prjl'
    end
    object FloatField6: TFloatField
      DisplayWidth = 12
      FieldName = 'spl'
      Origin = 'obekt.spl'
    end
    object FloatField7: TFloatField
      DisplayWidth = 12
      FieldName = 'spll'
      Origin = 'obekt.spll'
    end
    object IntegerField11: TIntegerField
      DisplayWidth = 12
      FieldName = 'podkl'
      Origin = 'obekt.podkl'
    end
    object FloatField8: TFloatField
      DisplayWidth = 12
      FieldName = 'v'
      Origin = 'obekt.v'
    end
    object IntegerField12: TIntegerField
      DisplayWidth = 12
      FieldName = 'rasch'
      Origin = 'obekt.rasch'
    end
    object IntegerField13: TIntegerField
      DisplayWidth = 12
      FieldName = 'kodtv'
      Origin = 'obekt.kodtv'
    end
    object IntegerField14: TIntegerField
      DisplayWidth = 12
      FieldName = 'podklv'
      Origin = 'obekt.podklv'
    end
    object FloatField9: TFloatField
      DisplayWidth = 12
      FieldName = 'qv'
      Origin = 'obekt.qv'
    end
    object FloatField10: TFloatField
      DisplayWidth = 12
      FieldName = 'qk'
      Origin = 'obekt.qk'
    end
    object IntegerField15: TIntegerField
      DisplayWidth = 12
      FieldName = 'podklgv'
      Origin = 'obekt.podklgv'
    end
    object qryObektPrproj: TFloatField
      FieldName = 'proj'
      Origin = '.'
      ReadOnly = True
    end
    object qryObektPrso: TFloatField
      FieldName = 'so'
      Origin = '.'
      ReadOnly = True
    end
  end
  object dsObektPr: TDataSource
    DataSet = qryObektPr
    Left = 216
    Top = 296
  end
  object qryDomaPr: TMSQuery
    Connection = Conect
    SQL.Strings = (
      'select a.*,(b.nazvul+'#39','#39'+a.ndom) as adres '
      'from doma a,ulica b'
      'where a.kodul=b.kodul'
      'order by adres')
    MasterSource = dsPribor
    MasterFields = 'kod'
    DetailFields = 'kodpr'
    Left = 258
    Top = 296
    ParamData = <
      item
        DataType = ftInteger
        Name = 'kod'
        ParamType = ptInput
        Value = 1
      end>
    object IntegerField16: TIntegerField
      FieldName = 'koddom'
    end
    object IntegerField17: TIntegerField
      FieldName = 'kodkot'
    end
    object IntegerField18: TIntegerField
      FieldName = 'kodul'
    end
    object StringField2: TStringField
      FieldName = 'ndom'
      Size = 4
    end
    object FloatField11: TFloatField
      FieldName = 'so'
    end
    object FloatField12: TFloatField
      FieldName = 'prj'
    end
    object FloatField13: TFloatField
      FieldName = 'qot'
    end
    object FloatField14: TFloatField
      FieldName = 'qgv'
    end
    object IntegerField19: TIntegerField
      FieldName = 'lot'
    end
    object IntegerField20: TIntegerField
      FieldName = 'lgv'
    end
    object IntegerField21: TIntegerField
      FieldName = 'kodpr'
    end
    object FloatField15: TFloatField
      FieldName = 'ngv'
    end
    object FloatField16: TFloatField
      FieldName = 'vd'
    end
    object IntegerField22: TIntegerField
      FieldName = 'podkl'
    end
    object StringField3: TStringField
      FieldName = 'adres'
      ReadOnly = True
      Size = 23
    end
    object IntegerField23: TIntegerField
      FieldName = 'podklgv'
    end
  end
  object dsDomaPr: TDataSource
    DataSet = qryDomaPr
    Left = 298
    Top = 296
  end
  object qryTarif_t: TMSQuery
    Connection = Conect
    SQL.Strings = (
      'select a.*, b.* from tarift a, datatarif b'
      'where a.kodtt=b.kodtt and b.datan = :data1'
      'order by a.kodtt')
    Left = 136
    Top = 152
    ParamData = <
      item
        DataType = ftDateTime
        Name = 'data1'
        ParamType = ptInput
        Value = 38930d
      end>
    object qryTarif_tkodtt: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'kodtt'
      Origin = 'tarift.kodtt'
      ReadOnly = True
    end
    object qryTarif_tnazt: TStringField
      FieldName = 'nazt'
      Origin = 'tarift.nazt'
      Size = 15
    end
    object qryTarif_tKODTT_1: TIntegerField
      FieldName = 'KODTT_1'
      Origin = 'datatarif.KODTT'
    end
    object qryTarif_tCENA: TFloatField
      FieldName = 'CENA'
      Origin = 'datatarif.CENA'
    end
    object qryTarif_tDATAN: TDateTimeField
      FieldName = 'DATAN'
      Origin = 'datatarif.DATAN'
    end
    object qryTarif_tDATAK: TDateTimeField
      FieldName = 'DATAK'
      Origin = 'datatarif.DATAK'
    end
  end
  object dsTarif_t: TDataSource
    DataSet = qryTarif_t
    Left = 176
    Top = 152
  end
  object UpTarif_t: TMSUpdateSQL
    InsertSQL.Strings = (
      'INSERT INTO tarift'
      '  (nazt)'
      'VALUES'
      '  (:nazt)'
      'SET :kodtt = SCOPE_IDENTITY()')
    DeleteSQL.Strings = (
      'DELETE FROM tarift'
      'WHERE'
      '  kodtt = :Old_kodtt')
    ModifySQL.Strings = (
      'UPDATE tarift'
      'SET'
      '  nazt = :nazt'
      'WHERE'
      '  kodtt = :Old_kodtt')
    RefreshSQL.Strings = (
      'SELECT a.nazt FROM tarift a'
      'WHERE a.kodtt = :kodtt ')
    Left = 216
    Top = 152
  end
  object qryTarif_v: TMSQuery
    Connection = Conect
    SQL.Strings = (
      'select a.*, b.* from tarifv a, datatarifv b'
      'where a.kodtv=b.kodtv and b.datan = :data1'
      'order by a.kodtv')
    UpdateObject = UpTarif_v
    Left = 136
    Top = 199
    ParamData = <
      item
        DataType = ftDateTime
        Name = 'data1'
        ParamType = ptInput
        Value = 38930d
      end>
    object qryTarif_vkodtv: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'kodtv'
      Origin = 'tarifv.kodtv'
    end
    object qryTarif_vnazt: TStringField
      FieldName = 'nazt'
      Origin = 'tarifv.nazt'
      Size = 15
    end
    object qryTarif_vKODTV_1: TIntegerField
      FieldName = 'KODTV_1'
      Origin = 'datatarifv.KODTV'
    end
    object qryTarif_vCENAV: TFloatField
      FieldName = 'CENAV'
      Origin = 'datatarifv.CENAV'
    end
    object qryTarif_vDATAN: TDateTimeField
      FieldName = 'DATAN'
      Origin = 'datatarifv.DATAN'
    end
    object qryTarif_vDATAK: TDateTimeField
      FieldName = 'DATAK'
      Origin = 'datatarifv.DATAK'
    end
    object qryTarif_vCENAK: TFloatField
      FieldName = 'CENAK'
      Origin = 'datatarifv.CENAK'
    end
  end
  object dsTarif_v: TDataSource
    DataSet = qryTarif_v
    Left = 176
    Top = 199
  end
  object UpTarif_v: TMSUpdateSQL
    InsertSQL.Strings = (
      'INSERT INTO tarifv'
      '  (nazt)'
      'VALUES'
      '  (:nazt)'
      'SET :kodtv = SCOPE_IDENTITY()')
    DeleteSQL.Strings = (
      'DELETE FROM tarifv'
      'WHERE'
      '  kodtv = :Old_kodtv')
    ModifySQL.Strings = (
      'UPDATE tarifv'
      'SET'
      '  nazt = :nazt'
      'WHERE'
      '  kodtv = :Old_kodtv')
    RefreshSQL.Strings = (
      'SELECT a.nazt FROM tarifv a'
      'WHERE a.kodtv = :kodtv ')
    Left = 216
    Top = 199
  end
  object UpVidTop: TMSUpdateSQL
    InsertSQL.Strings = (
      'INSERT INTO vidtop'
      '  (naztop, k_per)'
      'VALUES'
      '  (:naztop, :k_per)'
      'SET :kodtop = SCOPE_IDENTITY()')
    DeleteSQL.Strings = (
      'DELETE FROM vidtop'
      'WHERE'
      '  kodtop = :Old_kodtop')
    ModifySQL.Strings = (
      'UPDATE vidtop'
      'SET'
      '  naztop = :naztop, k_per = :k_per'
      'WHERE'
      '  kodtop = :Old_kodtop')
    RefreshSQL.Strings = (
      'SELECT vidtop.naztop, vidtop.k_per FROM vidtop'
      'WHERE vidtop.kodtop = :kodtop ')
    Left = 136
    Top = 476
  end
  object UpUlica: TMSUpdateSQL
    InsertSQL.Strings = (
      'INSERT INTO ulica'
      '  (nazvul, kodkot)'
      'VALUES'
      '  (:nazvul, :kodkot)'
      'SET :kodul = SCOPE_IDENTITY()')
    DeleteSQL.Strings = (
      'DELETE FROM ulica'
      'WHERE'
      '  kodul = :Old_kodul')
    ModifySQL.Strings = (
      'UPDATE ulica'
      'SET'
      '  nazvul = :nazvul, kodkot = :kodkot'
      'WHERE'
      '  kodul = :Old_kodul')
    RefreshSQL.Strings = (
      'SELECT a.nazvul, a.kodkot FROM ulica a'
      'WHERE a.kodul = :kodul ')
    Left = 216
    Top = 431
  end
  object qryUlic: TMSQuery
    Connection = Conect
    SQL.Strings = (
      'select a.*,b.nazk from ulica a, koteln b'
      'where a.kodkot=b.kodkot'
      'order by nazvul')
    UpdateObject = UpUlica
    Left = 138
    Top = 431
  end
  object dsUlic: TDataSource
    DataSet = qryUlic
    Left = 178
    Top = 431
  end
  object qryParamOrg: TMSQuery
    Connection = Conect
    SQL.Strings = (
      'select * from paramorg')
    UpdateObject = UpParamOrg
    Left = 336
    Top = 100
  end
  object dsParamOrg: TDataSource
    DataSet = qryParamOrg
    Left = 376
    Top = 100
  end
  object UpParamOrg: TMSUpdateSQL
    InsertSQL.Strings = (
      'INSERT INTO paramorg'
      
        '  (nazvorg, kodbank, adresorg, rshetorg, unnorg, dolgn_chif, fio' +
        '_chif, tel_org, dolgn_bux, fio_bux, dolgn_isp1, dolgnisp2, fio_i' +
        'sp1, fio_isp2, tel_isp)'
      'VALUES'
      
        '  (:nazvorg, :kodbank, :adresorg, :rshetorg, :unnorg, :dolgn_chi' +
        'f, :fio_chif, :tel_org, :dolgn_bux, :fio_bux, :dolgn_isp1, :dolg' +
        'nisp2, :fio_isp1, :fio_isp2, :tel_isp)'
      'SET :id_par = SCOPE_IDENTITY()')
    DeleteSQL.Strings = (
      'DELETE FROM paramorg'
      'WHERE'
      '  id_par = :Old_id_par')
    ModifySQL.Strings = (
      'UPDATE paramorg'
      'SET'
      
        '  nazvorg = :nazvorg, kodbank = :kodbank, adresorg = :adresorg, ' +
        'rshetorg = :rshetorg, unnorg = :unnorg, dolgn_chif = :dolgn_chif' +
        ', fio_chif = :fio_chif, tel_org = :tel_org, dolgn_bux = :dolgn_b' +
        'ux, fio_bux = :fio_bux, dolgn_isp1 = :dolgn_isp1, dolgnisp2 = :d' +
        'olgnisp2, fio_isp1 = :fio_isp1, fio_isp2 = :fio_isp2, tel_isp = ' +
        ':tel_isp, rasch_period = :rasch_period, zak_mes = :zak_mes, new_' +
        'mes = :new_mes, period_name = :period_name, arh_data = :arh_data'
      'WHERE'
      '  id_par = :Old_id_par')
    RefreshSQL.Strings = (
      
        'SELECT paramorg.nazvorg, paramorg.kodbank, paramorg.adresorg, pa' +
        'ramorg.rshetorg, paramorg.unnorg, paramorg.dolgn_chif, paramorg.' +
        'fio_chif, paramorg.tel_org, paramorg.dolgn_bux, paramorg.fio_bux' +
        ', paramorg.dolgn_isp1, paramorg.dolgnisp2, paramorg.fio_isp1, pa' +
        'ramorg.fio_isp2, paramorg.tel_isp FROM paramorg'
      'WHERE paramorg.id_par = :id_par ')
    Left = 417
    Top = 100
  end
  object qrySrTemp: TMSQuery
    Connection = Conect
    SQL.Strings = (
      'select * from temper'
      'order by data')
    FetchRows = 1
    UpdateObject = UpSrTemp
    Left = 56
    Top = 525
    object qrySrTempdata: TDateTimeField
      FieldName = 'data'
      Origin = 'temper.data'
    end
    object qrySrTempsrt: TFloatField
      FieldName = 'srt'
      Origin = 'temper.srt'
    end
    object qrySrTempkod_rec: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'kod_rec'
      Origin = 'temper.kod_rec'
      ReadOnly = True
    end
  end
  object dsSrTemp: TDataSource
    DataSet = qrySrTemp
    Left = 96
    Top = 525
  end
  object UpSrTemp: TMSUpdateSQL
    InsertSQL.Strings = (
      'INSERT INTO temper'
      '  (data, srt)'
      'VALUES'
      '  (:data, :srt)'
      'SET :kod_rec = SCOPE_IDENTITY()')
    DeleteSQL.Strings = (
      'DELETE FROM temper'
      'WHERE'
      '  data = :Old_data')
    ModifySQL.Strings = (
      'UPDATE temper'
      'SET'
      '  data = :data, srt = :srt'
      'WHERE'
      '  data = :Old_data')
    RefreshSQL.Strings = (
      'SELECT temper.data, temper.srt FROM temper'
      'WHERE temper.data = :data ')
    Left = 136
    Top = 524
  end
  object qryPokPrib: TMSQuery
    SQLRefresh.Strings = (
      '')
    Connection = Conect
    SQL.Strings = (
      
        'SELECT a.kod, a.nazp, a.kodorg, sum(b.gkt) as gk_t, sum(b.gkv) a' +
        's gk_v'
      'FROM pribor a JOIN dataprib b on a.kod=b.kodpr'
      'GROUP BY a.kod, a.nazp, a.kodorg'
      'ORDER BY a.kod')
    FetchRows = 1
    Left = 56
    Top = 573
    object qryPokPribkod: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'kod'
      Origin = '.kod'
      ReadOnly = True
    end
    object qryPokPribnazp: TStringField
      FieldName = 'nazp'
      Origin = '.nazp'
      Size = 50
    end
    object qryPokPribkodorg: TIntegerField
      FieldName = 'kodorg'
      Origin = '.kodorg'
    end
    object qryPokPribgk_t: TFloatField
      FieldName = 'gk_t'
      Origin = '.'
      ReadOnly = True
    end
    object qryPokPribgk_v: TFloatField
      FieldName = 'gk_v'
      Origin = '.'
      ReadOnly = True
    end
  end
  object dsPokPrib: TDataSource
    DataSet = qryPokPrib
    Left = 96
    Top = 573
  end
  object qryPokObk: TMSQuery
    Connection = Conect
    SQL.Strings = (
      'SELECT a.nazv, a.kodpr, sum(b.gkt) as gk_t, sum(b.gkv) as gk_v'
      'FROM obekt a INNER JOIN dataobekt b on a.kodobk = b.kodobk'
      'where a.podkl = 0'
      'GROUP BY a.nazv, a.kodpr')
    MasterSource = dsPokPrib
    MasterFields = 'kod'
    DetailFields = 'kodpr'
    Left = 136
    Top = 572
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'kod'
      end>
  end
  object dsPokObk: TDataSource
    DataSet = qryPokObk
    Left = 176
    Top = 572
  end
  object qryPokDoma: TMSQuery
    Connection = Conect
    SQL.Strings = (
      
        'SELECT (b.nazvul+'#39','#39'+a.ndom) as adres, a.kodpr, sum(c.gkt) as gk' +
        '_t, sum(c.gkv) as gk_v'
      'FROM doma a,ulica b,datadoma c '
      'where a.koddom=c.koddom and a.kodul = b.kodul and a.podkl = 0'
      'GROUP BY (b.nazvul+'#39','#39'+a.ndom), a.kodpr')
    UpdateObject = UpDoma
    MasterSource = dsPokPrib
    MasterFields = 'kod'
    DetailFields = 'kodpr'
    Left = 218
    Top = 572
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'kod'
      end>
  end
  object dsPokDoma: TDataSource
    DataSet = qryPokDoma
    Left = 258
    Top = 572
  end
  object ConectDlg: TMSConnectDialog
    SavePassword = True
    Caption = #1057#1086#1077#1076#1080#1085#1077#1085#1080#1077' '#1089' '#1041#1044
    UsernameLabel = #1048#1084#1103
    PasswordLabel = #1055#1072#1088#1086#1083#1100
    ServerLabel = #1057#1077#1088#1074#1077#1088
    DatabaseLabel = 'Database'
    ConnectButton = #1057#1086#1077#1076#1080#1085#1080#1090#1100
    CancelButton = #1054#1090#1084#1077#1085#1072
    LabelSet = lsCustom
    Left = 10
    Top = 59
  end
  object qryHistPok: TMSQuery
    SQLRefresh.Strings = (
      '')
    Connection = Conect
    SQL.Strings = (
      'SELECT *'
      'FROM dataprib '
      'order by datan'
      '')
    FetchRows = 1
    ReadOnly = True
    MasterSource = dsPokPrib
    MasterFields = 'kod'
    DetailFields = 'KODPR'
    Left = 304
    Top = 573
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'kod'
      end>
  end
  object dsHistPok: TDataSource
    DataSet = qryHistPok
    Left = 344
    Top = 573
  end
  object qryCalcKot: TMSQuery
    Connection = Conect
    SQL.Strings = (
      'select * from datakoteln'
      '')
    FetchRows = 1
    Left = 304
    Top = 437
    object qryCalcKotKODKOT: TIntegerField
      FieldName = 'KODKOT'
    end
    object qryCalcKotKDO: TFloatField
      FieldName = 'KDO'
    end
    object qryCalcKotKCO: TFloatField
      FieldName = 'KCO'
    end
    object qryCalcKotSRT: TFloatField
      FieldName = 'SRT'
    end
    object qryCalcKotKDG: TFloatField
      FieldName = 'KDG'
    end
    object qryCalcKotKCG: TFloatField
      FieldName = 'KCG'
    end
    object qryCalcKotDATAN: TDateTimeField
      FieldName = 'DATAN'
    end
    object qryCalcKotDATAK: TDateTimeField
      FieldName = 'DATAK'
    end
    object qryCalcKotNORMATIV_OT: TFloatField
      FieldName = 'NORMATIV_OT'
    end
    object qryCalcKotNORMATIV_GV: TFloatField
      FieldName = 'NORMATIV_GV'
    end
    object qryCalcKotN_GV: TIntegerField
      FieldName = 'N_GV'
    end
    object qryCalcKotdatas: TDateTimeField
      FieldName = 'datas'
    end
    object qryCalcKotdatapo: TDateTimeField
      FieldName = 'datapo'
    end
    object qryCalcKotps: TFloatField
      FieldName = 'ps'
    end
  end
  object dsCalcKot: TDataSource
    DataSet = qryCalcKot
    Left = 344
    Top = 437
  end
  object UpCalcKot: TMSUpdateSQL
    ModifySQL.Strings = (
      'UPDATE datakoteln'
      'SET'
      
        '  KODKOT = :KODKOT, KDO = :KDO, KCO = :KCO, SRT = :SRT, KDG = :K' +
        'DG, KCG = :KCG, DATAN = :DATAN, DATAK = :DATAK, NORMATIV_OT = :N' +
        'ORMATIV_OT, NORMATIV_GV = :NORMATIV_GV, N_GV = :N_GV, datas = :d' +
        'atas, datapo = :datapo'
      'WHERE'
      '  KODKOT = :Old_KODKOT AND DATAN = :Old_DATAN')
    RefreshSQL.Strings = (
      
        'SELECT datakoteln.KODKOT, datakoteln.KDO, datakoteln.KCO, datako' +
        'teln.SRT, datakoteln.KDG, datakoteln.KCG, datakoteln.DATAN, data' +
        'koteln.DATAK, datakoteln.NORMATIV_OT, datakoteln.NORMATIV_GV, da' +
        'takoteln.N_GV, datakoteln.datas, datakoteln.datapo FROM datakote' +
        'ln'
      'WHERE datakoteln.KODKOT = :KODKOT AND datakoteln.DATAN = :DATAN ')
    Left = 384
    Top = 436
  end
  object qryRezCalcObk: TMSQuery
    Connection = Conect
    SQL.Strings = (
      'select sum(gkt) as s_gkt,sum(gkv) as s_gkv,sum(symt) as s_symt,'
      'sum(symv) as s_symv,sum(pert) as s_pert,sum(perv) as s_perv,'
      'sum(pgkt) as s_pgkt,sum(pgkv) as s_pgkv,sum(symk) as s_symk,'
      
        'sum(symgv) as s_symgv,avg(tvn) as a_tvn,avg(kdo) as a_kdo,avg(ts' +
        ') as a_ts,'
      
        'avg(dgv) as a_dvg,sum(symtnds) as s_symtnds,sum(symvnds) as s_sy' +
        'mvnds,'
      
        'avg(rastarift) as a_rastarift,avg(kco) as a_kco, b.kodobk,b.kodo' +
        'rg,b.kodpr,'
      'b.nazv as nzv_obk, c.nazv as nazv_org'
      'from dataobekt a, obekt b, org c'
      'where a.kodobk = b.kodobk and b.kodorg = c.kodorg and b.podkl=0'
      'group by b.nazv, c.nazv, b.kodobk,b.kodorg,b.kodpr'
      'order by b.nazv'
      '')
    FetchRows = 1
    Left = 304
    Top = 485
    object qryRezCalcObks_gkt: TFloatField
      FieldName = 's_gkt'
      Origin = '.'
      ReadOnly = True
    end
    object qryRezCalcObks_gkv: TFloatField
      FieldName = 's_gkv'
      Origin = '.'
      ReadOnly = True
    end
    object qryRezCalcObks_symt: TFloatField
      FieldName = 's_symt'
      Origin = '.'
      ReadOnly = True
    end
    object qryRezCalcObks_symv: TFloatField
      FieldName = 's_symv'
      Origin = '.'
      ReadOnly = True
    end
    object qryRezCalcObks_pert: TFloatField
      FieldName = 's_pert'
      Origin = '.'
      ReadOnly = True
    end
    object qryRezCalcObks_perv: TFloatField
      FieldName = 's_perv'
      Origin = '.'
      ReadOnly = True
    end
    object qryRezCalcObks_pgkt: TFloatField
      FieldName = 's_pgkt'
      Origin = '.'
      ReadOnly = True
    end
    object qryRezCalcObks_pgkv: TFloatField
      FieldName = 's_pgkv'
      Origin = '.'
      ReadOnly = True
    end
    object qryRezCalcObks_symk: TFloatField
      FieldName = 's_symk'
      Origin = '.'
      ReadOnly = True
    end
    object qryRezCalcObks_symgv: TFloatField
      FieldName = 's_symgv'
      Origin = '.'
      ReadOnly = True
    end
    object qryRezCalcObka_tvn: TFloatField
      FieldName = 'a_tvn'
      Origin = '.'
      ReadOnly = True
    end
    object qryRezCalcObka_kdo: TFloatField
      FieldName = 'a_kdo'
      Origin = '.'
      ReadOnly = True
    end
    object qryRezCalcObka_ts: TFloatField
      FieldName = 'a_ts'
      Origin = '.'
      ReadOnly = True
    end
    object qryRezCalcObka_dvg: TFloatField
      FieldName = 'a_dvg'
      Origin = '.'
      ReadOnly = True
    end
    object qryRezCalcObks_symtnds: TFloatField
      FieldName = 's_symtnds'
      Origin = '.'
      ReadOnly = True
    end
    object qryRezCalcObks_symvnds: TFloatField
      FieldName = 's_symvnds'
      Origin = '.'
      ReadOnly = True
    end
    object qryRezCalcObka_rastarift: TFloatField
      FieldName = 'a_rastarift'
      Origin = '.'
      ReadOnly = True
    end
    object qryRezCalcObka_kco: TFloatField
      FieldName = 'a_kco'
      Origin = '.'
      ReadOnly = True
    end
    object qryRezCalcObkkodobk: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'kodobk'
      Origin = '.kodobk'
      ReadOnly = True
    end
    object qryRezCalcObkkodorg: TIntegerField
      FieldName = 'kodorg'
      Origin = '.kodorg'
    end
    object qryRezCalcObknzv_obk: TStringField
      FieldName = 'nzv_obk'
      Origin = '.'
      ReadOnly = True
      Size = 100
    end
    object qryRezCalcObknazv_org: TStringField
      FieldName = 'nazv_org'
      Origin = '.'
      ReadOnly = True
      Size = 100
    end
    object qryRezCalcObkkodpr: TIntegerField
      FieldName = 'kodpr'
      Origin = '.kodpr'
    end
  end
  object dsRezCalcObk: TDataSource
    DataSet = qryRezCalcObk
    Left = 344
    Top = 485
  end
  object qrySys: TMSQuery
    Connection = Conect
    SQL.Strings = (
      'select * from datasys')
    Left = 336
    Top = 147
    object qrySysusername: TStringField
      FieldName = 'username'
      Origin = 'datasys.username'
      Size = 10
    end
    object qrySysndata: TDateTimeField
      FieldName = 'ndata'
      Origin = 'datasys.ndata'
    end
    object qrySyskdata: TDateTimeField
      FieldName = 'kdata'
      Origin = 'datasys.kdata'
    end
    object qrySysid_period: TIntegerField
      FieldName = 'id_period'
    end
  end
  object UpSys: TMSQuery
    Connection = Conect
    SQL.Strings = (
      '')
    Left = 376
    Top = 147
  end
  object qryOrgKot: TMSQuery
    Connection = Conect
    SQL.Strings = (
      'select a.kodorg,a.nazv from org a,obekt b'
      'where a.kodorg = b.kodorg'
      'group by a.kodorg,a.nazv'
      'order by a.nazv')
    Left = 400
    Top = 323
  end
  object dsOrgKot: TDataSource
    DataSet = qryOrgKot
    Left = 432
    Top = 323
  end
  object qryKolTop: TMSQuery
    Connection = Conect
    SQL.Strings = (
      'select * from koltop')
    Left = 400
    Top = 371
  end
  object qrySumKolTop: TMSQuery
    Connection = Conect
    SQL.Strings = (
      'select sum(koltop) as s_top from koltop'
      'where kodobk<>129')
    UpdateObject = UpOrg
    Left = 440
    Top = 371
  end
  object qryHistObekt: TMSQuery
    SQLRefresh.Strings = (
      '')
    Connection = Conect
    SQL.Strings = (
      'SELECT *'
      'FROM dataobekt '
      'order by datan'
      '')
    FetchRows = 1
    ReadOnly = True
    MasterSource = dsRezCalcObk
    MasterFields = 'kodobk'
    DetailFields = 'kodobk'
    Left = 512
    Top = 437
    ParamData = <
      item
        DataType = ftInteger
        Name = 'kodobk'
        ParamType = ptInput
        Value = 0
      end>
  end
  object dsHistObekt: TDataSource
    DataSet = qryHistObekt
    Left = 552
    Top = 437
  end
  object qryRezCalcNas: TMSQuery
    Connection = Conect
    SQL.Strings = (
      
        'select sum(gkt) as s_gkt,sum(gkv) as s_gkv, (c.nazvul+'#39','#39'+b.ndom' +
        ') as adres, b.koddom, b.kodpr '
      'from datadoma a, doma b,ulica c'
      'where b.kodul=c.kodul and a.koddom = b.koddom and b.podkl=0'
      'group by (c.nazvul+'#39','#39'+b.ndom), b.koddom, b.kodpr'
      'order by adres'
      '')
    FetchRows = 1
    Left = 304
    Top = 529
    object qryRezCalcNass_gkt: TFloatField
      FieldName = 's_gkt'
      ReadOnly = True
    end
    object qryRezCalcNass_gkv: TFloatField
      FieldName = 's_gkv'
      ReadOnly = True
    end
    object qryRezCalcNasadres: TStringField
      FieldName = 'adres'
      Size = 23
    end
    object qryRezCalcNaskoddom: TIntegerField
      FieldName = 'koddom'
      ReadOnly = True
    end
    object qryRezCalcNaskodpr: TIntegerField
      FieldName = 'kodpr'
    end
  end
  object dsRezCalcNas: TDataSource
    DataSet = qryRezCalcNas
    Left = 344
    Top = 529
  end
  object qryRezCalcKvart: TMSQuery
    Connection = Conect
    SQL.Strings = (
      
        'select sum(gkt) as s_gkt,sum(gkv) as s_gkv, b.kodkv, b.koddom, b' +
        '.kv'
      'from datakvart a, kvart b'
      'where a.kodkv = b.kodkv and b.podkl=0'
      'group by b.kodkv, b.koddom, b.kv'
      'order by b.kv'
      '')
    FetchRows = 1
    MasterSource = dsRezCalcNas
    MasterFields = 'koddom'
    DetailFields = 'koddom'
    Left = 384
    Top = 529
    ParamData = <
      item
        DataType = ftInteger
        Name = 'koddom'
        ParamType = ptInput
      end>
  end
  object dsRezCalcKvart: TDataSource
    DataSet = qryRezCalcKvart
    Left = 424
    Top = 529
  end
  object qryUlKot: TMSQuery
    Connection = Conect
    SQL.Strings = (
      'select *'
      'from ulica'
      'order by nazvul')
    Left = 472
    Top = 323
    object qryUlKotkodul: TIntegerField
      FieldName = 'kodul'
      ReadOnly = True
    end
    object qryUlKotnazvul: TStringField
      FieldName = 'nazvul'
      Size = 18
    end
    object qryUlKotkodkot: TIntegerField
      FieldName = 'kodkot'
    end
  end
  object dsUlKot: TDataSource
    DataSet = qryUlKot
    Left = 504
    Top = 323
  end
  object qryCalcOrg: TMSQuery
    Connection = Conect
    SQL.Strings = (
      'SELECT a.kodorg,a.nazv,'
      'sum(gkot) as s_gkt,sum(gkgv) as s_gkv,'
      'sum(sym) as s_sym,sum(symtv) as s_symtv,'
      'sum(perto) as s_perto,sum(perho) as s_perho,'
      'sum(pgkto) as s_pgkto,sum(pertonds) as s_pertonds,'
      
        'sum(itog) as s_itog,sum(perhonds) as s_perhonds,sum(symnds) as s' +
        '_symnds,'
      'sum(sumv) as s_sumv,sum(sumk) as s_sumk,'
      'sum(sumvnds) as s_sumvnds,sum(sumknds) as s_sumknds,'
      'sum(sumvv) as s_sumvv,sum(sumkk) as s_sumkk,'
      'sum(perko) as s_perko,sum(perkonds) as s_perkonds,'
      'sum(pkybvo) as s_pkybvo,sum(pkybko) as s_pkybko,'
      'sum(itogv) as s_itogv,sum(itogk) as s_itogk,'
      'sum(sumgv) as s_sumgv,sum(symgvnds) as s_symgvnds,'
      
        'sum(symgvs) as s_symgvs,sum(pergv) as s_pergv,sum(pergvnds) as s' +
        '_pergvnds,'
      
        'sum(pgkvo) as s_pgkvo,sum(lsymot) as s_lsymot,sum(lsymgv) as s_l' +
        'symgv,'
      
        'sum(lgkot) as s_lgkot,sum(lgkgv) as s_lgkgv,sum(skybv) as s_skyb' +
        'v,'
      'sum(skybk) as s_skybk,sum(lsumv) as s_lsumv,'
      
        'sum(lskybv) as s_lskybv,sum(lsumk) as s_lsumk,sum(lskybk) as s_l' +
        'skybk,'
      'sum(sumg) as s_sumg,'
      'sum(sumgnds) as s_sumgnds,'
      'sum(sumgg) as s_sumgg,'
      'sum(pergo) as s_pergo,sum(pergonds) as s_pergonds,'
      'sum(pkybgo) as s_pkybgo,'
      'sum(itogg) as s_itogg,'
      'sum(skybg) as s_skybg,sum(lsumg) as s_lsumg,'
      'sum(lskybg) as s_lskybg'
      'FROM org a,dataorg b'
      'WHERE a.kodorg = b.kodorg'
      'GROUP BY a.kodorg,a.nazv'
      'ORDER BY a.nazv')
    RefreshOptions = [roAfterInsert, roAfterUpdate]
    Left = 488
    Top = 11
  end
  object dsCalcOrg: TDataSource
    DataSet = qryCalcOrg
    Left = 520
    Top = 11
  end
  object qryRezCalcObkVk: TMSQuery
    Connection = Conect
    SQL.Strings = (
      'SELECT sum(kybv) AS s_kybv,sum(kybk) AS s_kybk,'
      'sum(symh) AS s_symh,sum(symkk) AS s_symkk,'
      'sum(symhnds) AS s_symhnds,sum(symknds) AS s_symknds,'
      'sum(symhs) AS s_symhs,sum(symks) AS s_symks,sum(perh) AS s_perh,'
      
        'sum(perk) AS s_perk,avg(rastarifk) AS a_rastarifk,avg(rastarifv)' +
        ' AS a_rastarifv,'
      'sum(pkybv) AS s_pkybv,sum(pkybk) AS s_pkybk,'
      'sum(perhnds) as s_perhnds,sum(perknds) as s_perknds,'
      'sum(lkybv) as s_lkybv, sum(lsymh) as s_lsymh,'
      'sum(lkybk) as s_lkybk, sum(lsymkk) as s_lsymkk,'
      'b.kodobk,b.kodorg,b.kodpr,'
      'b.nazv AS nzv_obk, c.nazv AS nazv_org'
      'FROM dataobekt a, obekt b, org c'
      'WHERE a.kodobk = b.kodobk AND b.kodorg = c.kodorg AND b.podklv=0'
      'GROUP BY b.nazv, c.nazv, b.kodobk,b.kodorg,b.kodpr'
      'ORDER BY b.nazv')
    FetchRows = 1
    MasterSource = dsCalcOrg
    MasterFields = 'kodorg'
    DetailFields = 'b.kodorg'
    Left = 488
    Top = 61
    ParamData = <
      item
        DataType = ftInteger
        Name = 'kodorg'
        ParamType = ptInput
        Value = 37
      end>
    object qryRezCalcObkVks_kybv: TFloatField
      FieldName = 's_kybv'
      ReadOnly = True
    end
    object qryRezCalcObkVks_kybk: TFloatField
      FieldName = 's_kybk'
      ReadOnly = True
    end
    object qryRezCalcObkVks_symh: TFloatField
      FieldName = 's_symh'
      ReadOnly = True
    end
    object qryRezCalcObkVks_symkk: TFloatField
      FieldName = 's_symkk'
      ReadOnly = True
    end
    object qryRezCalcObkVks_symhnds: TFloatField
      FieldName = 's_symhnds'
      ReadOnly = True
    end
    object qryRezCalcObkVks_symknds: TFloatField
      FieldName = 's_symknds'
      ReadOnly = True
    end
    object qryRezCalcObkVks_symhs: TFloatField
      FieldName = 's_symhs'
      ReadOnly = True
    end
    object qryRezCalcObkVks_symks: TFloatField
      FieldName = 's_symks'
      ReadOnly = True
    end
    object qryRezCalcObkVks_perh: TFloatField
      FieldName = 's_perh'
      ReadOnly = True
    end
    object qryRezCalcObkVks_perk: TFloatField
      FieldName = 's_perk'
      ReadOnly = True
    end
    object qryRezCalcObkVka_rastarifk: TFloatField
      FieldName = 'a_rastarifk'
      ReadOnly = True
    end
    object qryRezCalcObkVka_rastarifv: TFloatField
      FieldName = 'a_rastarifv'
      ReadOnly = True
    end
    object qryRezCalcObkVks_pkybv: TFloatField
      FieldName = 's_pkybv'
      ReadOnly = True
    end
    object qryRezCalcObkVks_pkybk: TFloatField
      FieldName = 's_pkybk'
      ReadOnly = True
    end
    object qryRezCalcObkVks_perhnds: TFloatField
      FieldName = 's_perhnds'
      ReadOnly = True
    end
    object qryRezCalcObkVks_perknds: TFloatField
      FieldName = 's_perknds'
      ReadOnly = True
    end
    object qryRezCalcObkVkkodobk: TIntegerField
      FieldName = 'kodobk'
      ReadOnly = True
    end
    object qryRezCalcObkVkkodorg: TIntegerField
      FieldName = 'kodorg'
    end
    object qryRezCalcObkVkkodpr: TIntegerField
      FieldName = 'kodpr'
    end
    object qryRezCalcObkVknzv_obk: TStringField
      FieldName = 'nzv_obk'
      ReadOnly = True
      Size = 100
    end
    object qryRezCalcObkVknazv_org: TStringField
      FieldName = 'nazv_org'
      ReadOnly = True
      Size = 100
    end
    object qryRezCalcObkVks_lkybv: TFloatField
      FieldName = 's_lkybv'
      ReadOnly = True
    end
    object qryRezCalcObkVks_lsymh: TFloatField
      FieldName = 's_lsymh'
      ReadOnly = True
    end
    object qryRezCalcObkVks_lkybk: TFloatField
      FieldName = 's_lkybk'
      ReadOnly = True
    end
    object qryRezCalcObkVks_lsymkk: TFloatField
      FieldName = 's_lsymkk'
      ReadOnly = True
    end
  end
  object dsRezCalcObkVk: TDataSource
    DataSet = qryRezCalcObkVk
    Left = 523
    Top = 61
  end
  object qryRezCalcObkOt: TMSQuery
    Connection = Conect
    SQL.Strings = (
      'select sum(gkt) as s_gkt,sum(gkv) as s_gkv,sum(symt) as s_symt,'
      'sum(symv) as s_symv,sum(pert) as s_pert,sum(perv) as s_perv,'
      'sum(pgkt) as s_pgkt,sum(pgkv) as s_pgkv,sum(symk) as s_symk,'
      
        'sum(symgv) as s_symgv,avg(tvn) as a_tvn,avg(kdo) as a_kdo,avg(ts' +
        ') as a_ts,'
      
        'avg(dgv) as a_dvg,sum(symtnds) as s_symtnds,sum(symvnds) as s_sy' +
        'mvnds,'
      
        'avg(rastarift) as a_rastarift,avg(kco) as a_kco, b.kodobk,b.kodo' +
        'rg,b.kodpr,'
      'b.nazv as nzv_obk, c.nazv as nazv_org'
      'from dataobekt a, obekt b, org c'
      'where a.kodobk = b.kodobk and b.kodorg = c.kodorg and b.podkl=0'
      'group by b.nazv, c.nazv, b.kodobk,b.kodorg,b.kodpr'
      'order by b.nazv'
      '')
    FetchRows = 1
    MasterSource = dsCalcOrg
    MasterFields = 'kodorg'
    DetailFields = 'b.kodorg'
    Left = 488
    Top = 109
    ParamData = <
      item
        DataType = ftInteger
        Name = 'kodorg'
        ParamType = ptInput
        Value = 37
      end>
    object qryRezCalcObkOts_gkt: TFloatField
      FieldName = 's_gkt'
      ReadOnly = True
    end
    object qryRezCalcObkOts_gkv: TFloatField
      FieldName = 's_gkv'
      ReadOnly = True
    end
    object qryRezCalcObkOts_symt: TFloatField
      FieldName = 's_symt'
      ReadOnly = True
    end
    object qryRezCalcObkOts_symv: TFloatField
      FieldName = 's_symv'
      ReadOnly = True
    end
    object qryRezCalcObkOts_pert: TFloatField
      FieldName = 's_pert'
      ReadOnly = True
    end
    object qryRezCalcObkOts_perv: TFloatField
      FieldName = 's_perv'
      ReadOnly = True
    end
    object qryRezCalcObkOts_pgkt: TFloatField
      FieldName = 's_pgkt'
      ReadOnly = True
    end
    object qryRezCalcObkOts_pgkv: TFloatField
      FieldName = 's_pgkv'
      ReadOnly = True
    end
    object qryRezCalcObkOts_symk: TFloatField
      FieldName = 's_symk'
      ReadOnly = True
    end
    object qryRezCalcObkOts_symgv: TFloatField
      FieldName = 's_symgv'
      ReadOnly = True
    end
    object qryRezCalcObkOta_tvn: TFloatField
      FieldName = 'a_tvn'
      ReadOnly = True
    end
    object qryRezCalcObkOta_kdo: TFloatField
      FieldName = 'a_kdo'
      ReadOnly = True
    end
    object qryRezCalcObkOta_ts: TFloatField
      FieldName = 'a_ts'
      ReadOnly = True
    end
    object qryRezCalcObkOta_dvg: TFloatField
      FieldName = 'a_dvg'
      ReadOnly = True
    end
    object qryRezCalcObkOts_symtnds: TFloatField
      FieldName = 's_symtnds'
      ReadOnly = True
    end
    object qryRezCalcObkOts_symvnds: TFloatField
      FieldName = 's_symvnds'
      ReadOnly = True
    end
    object qryRezCalcObkOta_rastarift: TFloatField
      FieldName = 'a_rastarift'
      ReadOnly = True
    end
    object qryRezCalcObkOta_kco: TFloatField
      FieldName = 'a_kco'
      ReadOnly = True
    end
    object qryRezCalcObkOtkodobk: TIntegerField
      FieldName = 'kodobk'
      ReadOnly = True
    end
    object qryRezCalcObkOtkodorg: TIntegerField
      FieldName = 'kodorg'
    end
    object qryRezCalcObkOtkodpr: TIntegerField
      FieldName = 'kodpr'
    end
    object qryRezCalcObkOtnzv_obk: TStringField
      FieldName = 'nzv_obk'
      ReadOnly = True
      Size = 100
    end
    object qryRezCalcObkOtnazv_org: TStringField
      FieldName = 'nazv_org'
      ReadOnly = True
      Size = 100
    end
  end
  object dsRezCalcObkOt: TDataSource
    DataSet = qryRezCalcObkOt
    Left = 528
    Top = 109
  end
  object qryRezCalcObkOtArh: TMSQuery
    Connection = Conect
    SQL.Strings = (
      'select sum(gkt) as s_gkt,sum(gkv) as s_gkv,sum(symt) as s_symt,'
      'sum(symv) as s_symv,sum(pert) as s_pert,sum(perv) as s_perv,'
      'sum(pgkt) as s_pgkt,sum(pgkv) as s_pgkv,sum(symk) as s_symk,'
      
        'sum(symgv) as s_symgv,avg(tvn) as a_tvn,avg(kdo) as a_kdo,avg(ts' +
        ') as a_ts,'
      
        'avg(dgv) as a_dvg,sum(symtnds) as s_symtnds,sum(symvnds) as s_sy' +
        'mvnds,'
      
        'avg(rastarift) as a_rastarift,avg(kco) as a_kco, b.kodobk,b.kodo' +
        'rg,b.kodpr,'
      'b.nazv as nzv_obk, c.nazv as nazv_org'
      'from arh_dataobekt a, obekt b, org c'
      'where a.kodobk = b.kodobk and b.kodorg = c.kodorg and b.podkl=0'
      'group by b.nazv, c.nazv, b.kodobk,b.kodorg,b.kodpr'
      'order by b.nazv'
      ''
      '')
    FetchRows = 1
    MasterSource = dsCalcOrg
    MasterFields = 'kodorg'
    DetailFields = 'b.kodorg'
    Left = 488
    Top = 157
    ParamData = <
      item
        DataType = ftInteger
        Name = 'kodorg'
        ParamType = ptInput
        Value = 37
      end>
  end
  object dsRezCalcObkOtArh: TDataSource
    DataSet = qryRezCalcObkOtArh
    Left = 523
    Top = 157
  end
  object qryRezCalcObkVkArh: TMSQuery
    Connection = Conect
    SQL.Strings = (
      'SELECT sum(kybv) AS s_kybv,sum(kybk) AS s_kybk,'
      'sum(symh) AS s_symh,sum(symkk) AS s_symkk,'
      'sum(symhnds) AS s_symhnds,sum(symknds) AS s_symknds,'
      'sum(symhs) AS s_symhs,sum(symks) AS s_symks,sum(perh) AS s_perh,'
      
        'sum(perk) AS s_perk,avg(rastarifk) AS a_rastarifk,avg(rastarifv)' +
        ' AS a_rastarifv,'
      'sum(pkybv) AS s_pkybv,sum(pkybk) AS s_pkybk,'
      'sum(perhnds) as s_perhnds,sum(perknds) as s_perknds,'
      'b.kodobk,b.kodorg,b.kodpr,'
      'b.nazv AS nzv_obk, c.nazv AS nazv_org'
      'FROM arh_dataobekt a, obekt b, org c'
      'WHERE a.kodobk = b.kodobk AND b.kodorg = c.kodorg AND b.podklv=0'
      'GROUP BY b.nazv, c.nazv, b.kodobk,b.kodorg,b.kodpr'
      'ORDER BY b.nazv'
      '')
    FetchRows = 1
    MasterSource = dsCalcOrg
    MasterFields = 'kodorg'
    DetailFields = 'b.kodorg'
    Left = 488
    Top = 205
    ParamData = <
      item
        DataType = ftInteger
        Name = 'kodorg'
        ParamType = ptInput
        Value = 37
      end>
  end
  object dsRezCalcObkVkArh: TDataSource
    DataSet = qryRezCalcObkVkArh
    Left = 528
    Top = 205
  end
  object qryUsers: TMSQuery
    Connection = Conect
    SQL.Strings = (
      'select uid,name,password from sysusers'
      'where status=2'
      'order by name')
    Left = 512
    Top = 488
  end
  object dsUsers: TDataSource
    DataSet = qryUsers
    Left = 512
    Top = 520
  end
  object qryRole: TMSQuery
    Connection = Conect
    SQL.Strings = (
      'select DbRole = g.name'
      'from sysusers u, sysusers g, sysmembers m'
      'where   g.uid = m.groupuid'
      'and g.issqlrole = 1'
      'and u.uid = m.memberuid'
      'order by 1')
    Left = 568
    Top = 488
  end
  object dsRole: TDataSource
    DataSet = qryRole
    Left = 568
    Top = 520
  end
  object qryArhCalcNas: TMSQuery
    Connection = Conect
    SQL.Strings = (
      
        'select sum(gkt) as s_gkt,sum(gkv) as s_gkv, (c.nazvul+'#39','#39'+b.ndom' +
        ') as adres, b.koddom, b.kodpr '
      'from arh_datadoma a, doma b,ulica c'
      'where b.kodul=c.kodul and a.koddom = b.koddom and b.podkl=0'
      'group by (c.nazvul+'#39','#39'+b.ndom), b.koddom, b.kodpr'
      'order by adres'
      '')
    FetchRows = 1
    Left = 408
    Top = 575
    object FloatField17: TFloatField
      FieldName = 's_gkt'
      ReadOnly = True
    end
    object FloatField18: TFloatField
      FieldName = 's_gkv'
      ReadOnly = True
    end
    object StringField4: TStringField
      FieldName = 'adres'
      Size = 23
    end
    object IntegerField24: TIntegerField
      FieldName = 'koddom'
      ReadOnly = True
    end
    object IntegerField25: TIntegerField
      FieldName = 'kodpr'
    end
  end
  object dsArhCalcNas: TDataSource
    DataSet = qryArhCalcNas
    Left = 448
    Top = 575
  end
  object qryArhCalcKvart: TMSQuery
    Connection = Conect
    SQL.Strings = (
      
        'select sum(gkt) as s_gkt,sum(gkv) as s_gkv, b.kodkv, b.koddom, b' +
        '.kv'
      'from arh_datakvart a, kvart b'
      'where a.kodkv = b.kodkv and b.podkl=0'
      'group by b.kodkv, b.koddom, b.kv'
      'order by b.kv'
      '')
    FetchRows = 1
    MasterSource = dsArhCalcNas
    MasterFields = 'koddom'
    DetailFields = 'koddom'
    Left = 488
    Top = 575
    ParamData = <
      item
        DataType = ftInteger
        Name = 'koddom'
        Value = 1
      end>
  end
  object dsArhCalcKvart: TDataSource
    DataSet = qryArhCalcKvart
    Left = 528
    Top = 575
  end
  object qryTarif_g: TMSQuery
    Connection = Conect
    SQL.Strings = (
      'select a.*, b.* from tarifg a, datatarifg b'
      'where a.kodtg=b.kodtg and b.datan = :data1'
      'order by a.kodtg')
    Left = 336
    Top = 200
    ParamData = <
      item
        DataType = ftDateTime
        Name = 'data1'
        ParamType = ptInput
        Value = 38930d
      end>
    object qryTarif_gkodtg: TIntegerField
      FieldName = 'kodtg'
      ReadOnly = True
    end
    object qryTarif_gnazt: TStringField
      FieldName = 'nazt'
      Size = 15
    end
    object qryTarif_gdata_per: TDateTimeField
      FieldName = 'data_per'
    end
    object qryTarif_gKODTG_1: TIntegerField
      FieldName = 'KODTG_1'
      ReadOnly = True
    end
    object qryTarif_gCENAG: TFloatField
      FieldName = 'CENAG'
      ReadOnly = True
    end
    object qryTarif_gDATAN: TDateTimeField
      FieldName = 'DATAN'
      ReadOnly = True
    end
    object qryTarif_gDATAK: TDateTimeField
      FieldName = 'DATAK'
      ReadOnly = True
    end
  end
  object dsTarif_g: TDataSource
    DataSet = qryTarif_g
    Left = 376
    Top = 200
  end
  object qryRezCalcObkG: TMSQuery
    Connection = Conect
    SQL.Strings = (
      'SELECT '
      'sum(kybg) AS s_kybg,'
      'sum(symg) AS s_symg,'
      'sum(symgnds) AS s_symgnds,'
      'sum(symgs) AS s_symgs,'
      'sum(perg) AS s_perg,'
      'avg(rastarifg) AS a_rastarifg,'
      'sum(pkybg) AS s_pkybg,'
      'sum(pergnds) as s_pergnds,'
      'b.kodobk,b.kodorg,b.kodpr,'
      'b.nazv AS nzv_obk, c.nazv AS nazv_org'
      'FROM dataobekt a, obekt b, org c'
      'WHERE a.kodobk = b.kodobk AND b.kodorg = c.kodorg AND b.podklg=0'
      'GROUP BY b.nazv, c.nazv, b.kodobk,b.kodorg,b.kodpr'
      'ORDER BY b.nazv')
    FetchRows = 1
    MasterSource = dsCalcOrg
    MasterFields = 'kodorg'
    DetailFields = 'b.kodorg'
    Left = 608
    Top = 61
    ParamData = <
      item
        DataType = ftInteger
        Name = 'kodorg'
        ParamType = ptInput
        Value = 37
      end>
    object qryRezCalcObkGs_kybg: TFloatField
      FieldName = 's_kybg'
      ReadOnly = True
    end
    object qryRezCalcObkGs_symg: TFloatField
      FieldName = 's_symg'
      ReadOnly = True
    end
    object qryRezCalcObkGs_symgnds: TFloatField
      FieldName = 's_symgnds'
      ReadOnly = True
    end
    object qryRezCalcObkGs_symgs: TFloatField
      FieldName = 's_symgs'
      ReadOnly = True
    end
    object qryRezCalcObkGs_perg: TFloatField
      FieldName = 's_perg'
      ReadOnly = True
    end
    object qryRezCalcObkGa_rastarifg: TFloatField
      FieldName = 'a_rastarifg'
      ReadOnly = True
    end
    object qryRezCalcObkGs_pkybg: TFloatField
      FieldName = 's_pkybg'
      ReadOnly = True
    end
    object qryRezCalcObkGs_pergnds: TFloatField
      FieldName = 's_pergnds'
      ReadOnly = True
    end
    object qryRezCalcObkGkodobk: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'kodobk'
      ReadOnly = True
    end
    object qryRezCalcObkGkodorg: TIntegerField
      FieldName = 'kodorg'
      ReadOnly = True
    end
    object qryRezCalcObkGkodpr: TIntegerField
      FieldName = 'kodpr'
      ReadOnly = True
    end
    object qryRezCalcObkGnzv_obk: TStringField
      FieldName = 'nzv_obk'
      ReadOnly = True
      Size = 100
    end
    object qryRezCalcObkGnazv_org: TStringField
      FieldName = 'nazv_org'
      ReadOnly = True
      Size = 100
    end
  end
  object dsRezCalcObkG: TDataSource
    DataSet = qryRezCalcObkG
    Left = 643
    Top = 61
  end
  object qryTarifGarbage: TMSQuery
    Connection = Conect
    SQL.Strings = (
      'select * from tarifg'
      'order by kodtg')
    Left = 560
    Top = 271
  end
  object dsTarifGarbage: TDataSource
    DataSet = qryTarifGarbage
    Left = 600
    Top = 271
  end
  object qryRezCalcObkGArh: TMSQuery
    Connection = Conect
    SQL.Strings = (
      'SELECT '
      'sum(kybg) AS s_kybg,'
      'sum(symg) AS s_symg,'
      'sum(symgnds) AS s_symgnds,'
      'sum(symgs) AS s_symgs,'
      'sum(perg) AS s_perg,'
      'avg(rastarifg) AS a_rastarifg,'
      'sum(pkybg) AS s_pkybg,'
      'sum(pergnds) as s_pergnds,'
      'b.kodobk,b.kodorg,b.kodpr,'
      'b.nazv AS nzv_obk, c.nazv AS nazv_org'
      'FROM arh_dataobekt a, obekt b, org c'
      'WHERE a.kodobk = b.kodobk AND b.kodorg = c.kodorg AND b.podklg=0'
      'GROUP BY b.nazv, c.nazv, b.kodobk,b.kodorg,b.kodpr'
      'ORDER BY b.nazv')
    FetchRows = 1
    MasterSource = dsCalcOrg
    MasterFields = 'kodorg'
    DetailFields = 'b.kodorg'
    Left = 608
    Top = 109
    ParamData = <
      item
        DataType = ftInteger
        Name = 'kodorg'
        ParamType = ptInput
        Value = 37
      end>
    object FloatField19: TFloatField
      FieldName = 's_kybg'
      ReadOnly = True
    end
    object FloatField20: TFloatField
      FieldName = 's_symg'
      ReadOnly = True
    end
    object FloatField21: TFloatField
      FieldName = 's_symgnds'
      ReadOnly = True
    end
    object FloatField22: TFloatField
      FieldName = 's_symgs'
      ReadOnly = True
    end
    object FloatField23: TFloatField
      FieldName = 's_perg'
      ReadOnly = True
    end
    object FloatField24: TFloatField
      FieldName = 'a_rastarifg'
      ReadOnly = True
    end
    object FloatField25: TFloatField
      FieldName = 's_pkybg'
      ReadOnly = True
    end
    object FloatField26: TFloatField
      FieldName = 's_pergnds'
      ReadOnly = True
    end
    object IntegerField26: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'kodobk'
      ReadOnly = True
    end
    object IntegerField27: TIntegerField
      FieldName = 'kodorg'
      ReadOnly = True
    end
    object IntegerField28: TIntegerField
      FieldName = 'kodpr'
      ReadOnly = True
    end
    object StringField5: TStringField
      FieldName = 'nzv_obk'
      ReadOnly = True
      Size = 100
    end
    object StringField6: TStringField
      FieldName = 'nazv_org'
      ReadOnly = True
      Size = 100
    end
  end
  object dsRezCalcObkGArh: TDataSource
    DataSet = qryRezCalcObkGArh
    Left = 643
    Top = 109
  end
  object qryCalcIdxOrg: TMSQuery
    Connection = Conect
    SQL.Strings = (
      'SELECT a.kodorg, a.nazv,'
      'sum(symidx) as s_symidx, sum(ndsidx) as s_ndsidx,'
      'sum(symidxv) as s_symidxv,sum(ndsidxv) as s_ndsidxv,'
      'sum(symidxk) as s_symidxk,sum(ndsidxk) as s_ndsidxk'
      'FROM org a,dataorg b'
      'WHERE a.kodorg = b.kodorg'
      'GROUP BY a.kodorg,a.nazv'
      'ORDER BY a.nazv')
    RefreshOptions = [roAfterInsert, roAfterUpdate]
    Left = 576
    Top = 11
    object qryCalcIdxOrgkodorg: TIntegerField
      FieldName = 'kodorg'
      ReadOnly = True
    end
    object qryCalcIdxOrgnazv: TStringField
      FieldName = 'nazv'
      ReadOnly = True
      Size = 100
    end
    object qryCalcIdxOrgs_symidx: TFloatField
      FieldName = 's_symidx'
      ReadOnly = True
    end
    object qryCalcIdxOrgs_ndsidx: TFloatField
      FieldName = 's_ndsidx'
      ReadOnly = True
    end
    object qryCalcIdxOrgs_symidxv: TFloatField
      FieldName = 's_symidxv'
      ReadOnly = True
    end
    object qryCalcIdxOrgs_ndsidxv: TFloatField
      FieldName = 's_ndsidxv'
      ReadOnly = True
    end
    object qryCalcIdxOrgs_symidxk: TFloatField
      FieldName = 's_symidxk'
      ReadOnly = True
    end
    object qryCalcIdxOrgs_ndsidxk: TFloatField
      FieldName = 's_ndsidxk'
      ReadOnly = True
    end
  end
  object dsCalcIdxOrg: TDataSource
    DataSet = qryCalcIdxOrg
    Left = 608
    Top = 11
  end
end

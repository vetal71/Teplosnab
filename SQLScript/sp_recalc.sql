SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO




ALTER   PROCEDURE sp_recalc
@kod int, @data datetime, @data1 datetime
AS
	-- Создаем таблицу для предоплаты		
		IF EXISTS (SELECT name FROM sysobjects
			WHERE  name = N'pr_obekt' 
	  	AND 	 type = 'U')
    DROP TABLE pr_obekt
	SELECT a.* INTO pr_obekt FROM dataobekt a, obekt b
			WHERE a.kodobk = b.kodobk and a.datan = @data1 and b.kodorg = @kod	
	UPDATE pr_obekt set datan = @data
	UPDATE pr_obekt
	SET
    symt=round(b.gkt*a.cena,0),
		symv=round(b.gkv*a.cena,0),
    symtnds=round(b.gkt*a.cena*c.nds/100,0),
		symvnds=round(b.gkv*a.cena*c.nds/100,0),
    symk=round((b.gkt*a.cena)+(b.gkt*a.cena*c.nds/100),0),
		symgv=round((b.gkv*a.cena)+(b.gkv*a.cena*c.nds/100),0),
    pertnds=round((b.pert*c.nds/(100+c.nds)),0),
		pervnds=round((b.perv*c.nds/(100+c.nds)),0),
    rastarift=a.cena
	FROM
    datatarif as a inner join pr_obekt as b on (a.datan=b.datan) join
    obekt as c on (a.kodtt=c.kodtt) and (c.kodobk=b.kodobk)
    WHERE (b.datan=@data and c.kodtt<>3) or (b.datan=@data and c.kodtt<>4)
	-- Обновляем ЖСК
	UPDATE pr_obekt
		SET symt=round((((b.gkt*a.cena)/(c.spl+c.spll)*c.spl)+((b.gkt*a.cena)/(c.spl+c.spll)*c.spll/2)),0),
    		symv=round((((b.gkv*a.cena)/(c.prj+c.prjl)*c.prj)+((b.gkv*a.cena)/(c.prj+c.prjl)*c.prjl/2)),0),
    		lgkv=round(b.gkv/(c.prj+c.prjl)*c.prjl,2),
				lgkt=round(b.gkt/(c.spl+c.spll)*c.spll,2),
    		lsymt=round(b.gkt*a.cena/(c.spl+c.spll)*c.spll/2,0),
				lsymv=round(b.gkv*a.cena/(c.prj+c.prjl)*c.prjl/2,0),
    		symtnds=0,symvnds=0,
    		symk=round((((b.gkt*a.cena)/(c.spl+c.spll)*c.spl)+((b.gkt*a.cena)/(c.spl+c.spll)*c.spll/2)),0),
    		symgv=round((((b.gkv*a.cena)/(c.prj+c.prjl)*c.prj)+((b.gkv*a.cena)/(c.prj+c.prjl)*c.prjl/2)),0),
    		pertnds=0,pervnds=0,
    		rastarift=a.cena
		FROM 
			datatarif as a inner join pr_obekt as b on (a.datan=b.datan) join
    	obekt as c on (a.kodtt=c.kodtt) and (c.kodobk=b.kodobk)
    	WHERE (b.datan=@data and c.kodtt=3) or (b.datan=@data and c.kodtt=4)

-- Обновляем все объекы, кроме ЖСК
	UPDATE pr_obekt
	SET
    symh=round(b.kybv*a.cenav,0),
		symkk=round(b.kybk*a.cenak,0),
    symhnds=round(b.kybv*a.cenav*c.nds/100,0),
		symknds=round(b.kybk*a.cenak*c.nds/100,0),
    symhs=round((b.kybv*a.cenav)+(b.kybv*a.cenav*c.nds/100),0),
		symks=round((b.kybk*a.cenak)+(b.kybk*a.cenak*c.nds/100),0),
    perhnds=round((b.perh*c.nds/(100+c.nds)),0),
		perknds=round((b.perk*c.nds/(100+c.nds)),0),
    rastarifv=a.cenav,
		rastarifk=a.cenak
	FROM	
		(datatarifv as a join pr_obekt as b on (a.datan=b.datan)) join
    obekt as c on(a.kodtv=c.kodtv) and(c.kodobk=b.kodobk) 
  WHERE b.datan=@data and c.kodtv<>3
	-- Обновляем все объекы ЖСК
	UPDATE pr_obekt
	SET
    symh=round((((b.kybv*a.cenav)/(c.prj+c.prjl)*c.prj)+((b.kybv*a.cenav)/(c.prj+c.prjl)*c.prjl/2)),0),
    symkk=round((((b.kybk*a.cenak)/(c.prj+c.prjl)*c.prj)+((b.kybk*a.cenak)/(c.prj+c.prjl)*c.prjl/2)),0),
    lsymh=round(b.kybv*a.cenav/(c.prj+c.prjl)*c.prjl/2,0),
		lsymkk=round(b.kybk*a.cenak/(c.prj+c.prjl)*c.prjl/2,0),
    lkybv=round(b.kybv/(c.prj+c.prjl)*c.prjl,2),
		lkybk=round(b.kybk/(c.prj+c.prjl)*c.prjl,2),
    symhnds=0,
		symknds=0,
    symhs=round((((b.kybv*a.cenav)/(c.prj+c.prjl)*c.prj)+((b.kybv*a.cenav)/(c.prj+c.prjl)*c.prjl/2)),0),
    symks=round((((b.kybk*a.cenak)/(c.prj+c.prjl)*c.prj)+((b.kybk*a.cenak)/(c.prj+c.prjl)*c.prjl/2)),0),
    perhnds=0,
		perknds=0,
    rastarifv=a.cenav,
		rastarifk=a.cenak
	FROM	
		(datatarifv as a join pr_obekt as b on (a.datan=b.datan)) join
    obekt as c on(a.kodtv=c.kodtv) and(c.kodobk=b.kodobk)
    WHERE b.datan=@data and c.kodtv=3

	-- Подсчет суммы

	UPDATE tPredoplata
	SET sum_t = (SELECT sum(symk+symgv) FROM pr_obekt),		
	sum_v = (SELECT sum(symhs) FROM pr_obekt),	
	sum_k = (SELECT sum(symks) FROM pr_obekt)


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO


SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


ALTER    PROCEDURE sp_calc_kot
	@kod int, @data datetime, @oper int
AS	
	SET NOCOUNT ON
	INSERT INTO dataobekt (kodobk, kybk, kybv, datan, datak)
			SELECT kodobk, qk, qv, @data, teplosnab.dbo.end_of_month(@data) 
			FROM obekt 
			WHERE kodobk NOT IN (SELECT kodobk FROM dataobekt WHERE
			datan = @data) and kodkot = @kod

	INSERT INTO datadoma (koddom,datan,datak)
			SELECT koddom,@data,teplosnab.dbo.end_of_month(@data) FROM doma
			WHERE koddom NOT IN (SELECT koddom FROM datadoma WHERE datan=@data)
			and kodkot = @kod

	IF @oper = 1 -- отопление по нормативу
	BEGIN		
		-- Обновляем объекты		
		UPDATE dataobekt
		SET
			kdo = a.kdo, kco = a.kco, ts = a.srt, dgv = a.kdg, tvn = c.t,
			gkt = ROUND(c.q*a.kdo*a.kco*(c.t-a.srt)/(c.t+27)/1000000,2),
			st = 1
		FROM
			datakoteln as a inner join dataobekt as b on (a.datan=b.datan) join
    	obekt as c on (a.kodkot=c.kodkot) and (c.kodobk=b.kodobk)
    	WHERE (a.kodkot=@kod and b.datan=@data and c.podkl=0)
			and (b.st Is Null or b.st = 1)
		-- Обновляем дома
		UPDATE datadoma
		SET
			gkt = ROUND(c.so*a.normativ_ot,2), st = 1, normativ = a.normativ_ot
		FROM
			datakoteln as a inner join datadoma as b on (a.datan=b.datan) join
    	doma as c on (a.kodkot=c.kodkot) and (c.koddom=b.koddom)
    	WHERE (a.kodkot=@kod and b.datan=@data and c.podkl=0) 
			and (b.st Is Null or b.st = 1)
	END
	IF @oper = 2 -- ГВС по нормативу
	BEGIN
		-- Обновляем объекты		
		UPDATE dataobekt
		SET
			gkv = ROUND(c.prj*a.n_gv*a.normativ_gv,2), sv = 1
		FROM
			datakoteln as a inner join dataobekt as b on (a.datan=b.datan) join
    	obekt as c on (a.kodkot=c.kodkot) and (c.kodobk=b.kodobk)
    	WHERE (a.kodkot=@kod and b.datan=@data and c.prj!=0) 
			and (b.sv Is Null or b.sv = 1)
		-- Обновляем дома
		UPDATE datadoma
		SET
			gkv = ROUND(c.prj*a.n_gv*a.normativ_gv,2), sv = 1, normativgv = a.normativ_gv
		FROM
			datakoteln as a inner join datadoma as b on (a.datan=b.datan) join
    	doma as c on (a.kodkot=c.kodkot) and (c.koddom=b.koddom)
    	WHERE (a.kodkot=@kod and b.datan=@data and c.podklgv=0) 
			and (b.sv Is Null or b.sv = 1)
	END
	IF @oper = 3 -- отопление и ГВС по нормативу
	BEGIN
		-- Обновляем объекты		
		UPDATE dataobekt
		SET
			kdo = a.kdo, kco = a.kco, ts = a.srt, dgv = a.kdg, tvn = c.t,
			gkt = ROUND(c.q*a.kdo*a.kco*(c.t-a.srt)/(c.t+27)/1000000,2),
			st = 1
		FROM
			datakoteln as a inner join dataobekt as b on (a.datan=b.datan) join
    	obekt as c on (a.kodkot=c.kodkot) and (c.kodobk=b.kodobk)
    	WHERE (a.kodkot=@kod and b.datan=@data and c.podkl=0) 
			and (b.st Is Null or b.st = 1)
		UPDATE dataobekt
		SET
			gkv = ROUND(c.prj*a.n_gv*a.normativ_gv,2), sv = 1
		FROM
			datakoteln as a inner join dataobekt as b on (a.datan=b.datan) join
    	obekt as c on (a.kodkot=c.kodkot) and (c.kodobk=b.kodobk)
    	WHERE (a.kodkot=@kod and b.datan=@data and c.prj!=0) 
			and (b.sv Is Null or b.sv = 1)
		-- Обновляем дома
		UPDATE datadoma
		SET
			gkt = ROUND(c.so*a.normativ_ot,2), st = 1, normativ = a.normativ_ot
		FROM
			datakoteln as a inner join datadoma as b on (a.datan=b.datan) join
    	doma as c on (a.kodkot=c.kodkot) and (c.koddom=b.koddom)
    	WHERE (a.kodkot=@kod and b.datan=@data and c.podkl=0) 
			and (b.st Is Null or b.st = 1)
		UPDATE datadoma
		SET
			gkv = ROUND(c.prj*a.n_gv*a.normativ_gv,2), sv = 1, normativgv = a.normativ_gv
		FROM
			datakoteln as a inner join datadoma as b on (a.datan=b.datan) join
    	doma as c on (a.kodkot=c.kodkot) and (c.koddom=b.koddom)
    	WHERE (a.kodkot=@kod and b.datan=@data and c.podklgv=0) 
			and (b.sv Is Null or b.sv = 1)
	END
	-- Вызываем процедуру расчета Гкал по квартирам
	EXECUTE sp_calc_kv @data 
	print 'Просчитали квартиры'
	-- Вызываем процедуру расчета Гкал по объектам (суммируя по квартирам)
	EXECUTE sp_calc_kv_obk @data
	print 'Просчитали квартиры по объектам'
	-- Вызываем процедуру расчета сумм по объектам
	EXECUTE sp_calc_obk @data
	print 'Просчитали объекты'
	-- Вызываем процедуру подсчета сумм по организациям
	EXECUTE sp_calc_org @data
	print 'Просчитали организации'
	SET NOCOUNT OFF


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO


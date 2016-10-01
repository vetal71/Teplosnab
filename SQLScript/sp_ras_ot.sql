SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


ALTER  PROCEDURE sp_ras_ot
--	@data1 datetime, @data2 datetime
AS
	IF EXISTS(SELECT name 
	  FROM 	 sysobjects 
	  WHERE  name = N'ras_ot' 
	  AND 	 type = 'U')
    DROP TABLE ras_ot
	CREATE TABLE ras_ot (kod int,nazv varchar(50),nazv_par varchar(100),
	f1 decimal(15,2),f2 decimal(15,2),f3 decimal(15,2),
	f4 decimal(15,2),f5 decimal(15,2),f6 decimal(15,2),
	f7 decimal(15,2),f8 decimal(15,2),f9 decimal(15,2),
	f10 decimal(15,2),f11 decimal(15,2),f12 decimal(15,2),
	f13 decimal(15,2),f14 decimal(15,2),f15 decimal(15,2),
	f16 decimal(15,2),f17 decimal(15,2),f18 decimal(15,2),
	kol_usl decimal(15,2),ps decimal(15,2), tip int)
	
	DECLARE @str_sql varchar(1000)
	DECLARE @cur_kot CURSOR -- Объявляем курсор
	DECLARE @kod int, @nazv varchar(100) 
	SET @cur_kot = CURSOR FOR 
		SELECT kodkot, nazk FROM koteln ORDER BY kodkot
	OPEN @cur_kot
	FETCH NEXT FROM @cur_kot INTO @kod, @nazv	
	WHILE @@FETCH_STATUS = 0
	BEGIN
		INSERT INTO ras_ot (kod, nazv, nazv_par, tip)
			VALUES (@kod, @nazv, 'Отопление', 
			cast(cast(@kod as varchar(2))+cast(1 as varchar(1)) as integer))
		-- Внутренний цикл по тарифу
		DECLARE @cur_tt CURSOR -- Объявляем курсор
		DECLARE @kodtt int
		SET @cur_tt = CURSOR FOR 
		SELECT kodtt FROM tarift ORDER BY kodtt		
		OPEN @cur_tt
		FETCH NEXT FROM @cur_tt INTO @kodtt
		WHILE @@FETCH_STATUS = 0
		BEGIN
			SET @str_sql = 'UPDATE ras_ot SET '+
			'f'+cast(@kodtt as varchar(2))+'='
			FETCH NEXT FROM @cur_tt INTO @kodtt
		END
		CLOSE @cur_tt
		DEALLOCATE @cur_tt
		-- Конец цикла	
		FETCH NEXT FROM @cur_kot INTO @kod, @nazv 
	END
	CLOSE @cur_kot
	DEALLOCATE @cur_kot	

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO


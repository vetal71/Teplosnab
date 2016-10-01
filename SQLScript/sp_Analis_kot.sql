-- =============================================
-- Create procedure basic template
-- =============================================
-- creating the store procedure
IF EXISTS (SELECT name 
	   FROM   sysobjects 
	   WHERE  name = N'sp_analiz_kot' 
	   AND 	  type = 'P')
    DROP PROCEDURE sp_analiz_kot
GO

CREATE PROCEDURE sp_analiz_kot
	@data datetime -- Дата окончания периода
AS
	IF EXISTS (SELECT name 
			FROM sysobjects
			WHERE name = N'tAnalisKot1'		
			AND type = 'U')
		DROP TABLE tAnalisKot1
	CREATE TABLE tAnalisKot1
		(kod int, nazv varchar(100), 
		 kdo1 decimal(3,0), kco1 decimal(3,0),
		 srt1 decimal(5,1), gkt1 decimal(15,2),
		 gkv1 decimal(15,2))
	IF EXISTS (SELECT name 
			FROM sysobjects
			WHERE name = N'tAnalisKot2'		
			AND type = 'U')
		DROP TABLE tAnalisKot2
	CREATE TABLE tAnalisKot2
		(kod int, nazv varchar(100), 
		 kdo2 decimal(3,0), kco2 decimal(3,0),
		 srt2 decimal(5,1), gkt2 decimal(15,2),
		 gkv2 decimal(15,2))		
	DECLARE @cur_kot CURSOR, @kod int, 
	@data_s datetime, -- Начало текущего года
	@data_s1 datetime, -- Начало прошлого года
	@data1 datetime -- Конец прошлого периода
	-- Начало текущего года
	select @data_s =
	dateadd(day,1-datepart(dayofyear,@data),@data),
	convert(datetime,'1/1/'+convert(char(4),year(@data)),101)
	-- Конец прошлого периода
	select @data1 = dateadd(year,-1,@data)
	-- Начало прошлого года
	select @data_s1 = dateadd(day,1-datepart(dayofyear,@data1),@data1),
	convert(datetime,'1/1/'+convert(char(4),year(@data1)),101)
	SET @cur_kot = CURSOR FOR 
		SELECT kodkot FROM koteln ORDER BY kodkot
	OPEN @cur_kot
	FETCH NEXT FROM @cur_kot INTO @kod
	WHILE @@FETCH_STATUS = 0
	BEGIN
		INSERT INTO tAnalisKot1
		SELECT a.kodkot, a.nazv, 
			sum(ISNULL(b.kdo,0)),
			sum(ISNULL(b.kco,0)),
			avg(ISNULL(b.srt,0)),	
			sum(ISNULL(b.kdg,0)),
			sum(ISNULL(b.kcg,0)),
			sum(ISNULL(c.gkt,0)),
			sum(ISNULL(c.gkv,0))
		FROM koteln a, datakoteln b, dataobekt c, obekt d
		WHERE a.kodkot = b.kodkot and a.kodkot = d.kodkot
		and c.kodobk = d.kodobk and b.datan = c.datan
		and a.kodkot = @kod and b.datan between @data_s and @data
		GROUP BY a.kodkot, a.nazv
		HAVING 
			sum(ISNULL(c.gkt,0))+
			sum(ISNULL(c.gkv,0)) != 0
		INSERT INTO tAnalisKot2
		SELECT a.kodkot, a.nazv, 
			sum(ISNULL(b.kdo,0)),
			sum(ISNULL(b.kco,0)),
			avg(ISNULL(b.srt,0)),	
			sum(ISNULL(b.kdg,0)),
			sum(ISNULL(b.kcg,0)),
			sum(ISNULL(c.gkt,0)),
			sum(ISNULL(c.gkv,0))
		FROM koteln a, datakoteln b, dataobekt c, obekt d
		WHERE a.kodkot = b.kodkot and a.kodkot = d.kodkot
		and c.kodobk = d.kodobk and b.datan = c.datan
		and a.kodkot = @kod and b.datan between @data_s1 and @data1
		GROUP BY a.kodkot, a.nazv
		HAVING 
			sum(ISNULL(c.gkt,0))+
			sum(ISNULL(c.gkv,0)) != 0
		FETCH NEXT FROM @cur_kot INTO @kod
	END
	CLOSE @cur_kot
	DEALLOCATE @cur_kot	
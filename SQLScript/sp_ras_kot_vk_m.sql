SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


ALTER  PROCEDURE sp_ras_kot_vk_m
@data1 datetime, @data2 datetime
AS
	DECLARE @cur_kot CURSOR
	DECLARE @kod int
	-- ������� �������
	IF EXISTS(SELECT name 
	  FROM 	 sysobjects 
	  WHERE  name = N'ras_kot_vk_m' 
	  AND 	 type = 'U')
    DROP TABLE ras_kot_vk_m
	CREATE TABLE ras_kot_vk_m 
	(nazv varchar(50),nazv_pot varchar(50),kybv decimal(15,2),
	 sum_nacv decimal(20,0),per_kv	decimal(15,2),sum_perv decimal(20,0),
	 kybk decimal(15,2),sum_nack decimal(20,0),per_kk	decimal(15,2),
	 sum_perk decimal(20,0),tip int)
	-- ��������� ������
	SET @cur_kot = CURSOR FOR SELECT kodkot FROM koteln ORDER BY kodkot
	OPEN @cur_kot
	FETCH NEXT FROM @cur_kot INTO @kod
	WHILE (@@FETCH_STATUS = 0)
	BEGIN
		-- ������ �� ������
		INSERT INTO ras_kot_vk_m
		SELECT 
			a.nazk,'�����',
			sum(isnull(b.kybv,0)),
			sum(isnull(b.symhs,0)),
			sum(isnull(b.pkybv,0)),
			sum(isnull(b.perh,0)),			
			sum(isnull(b.kybk,0)),
			sum(isnull(b.symks,0)),
			sum(isnull(b.pkybk,0)),
			sum(isnull(b.perk,0)),1
		FROM koteln a, dataobekt b, obekt c
		WHERE a.kodkot = c.kodkot and b.kodobk = c.kodobk
		and a.mesto = 1 and a.kodkot = @kod
		and b.datan between @data1 and @data2
		GROUP BY a.nazk
		HAVING (SUM(ISNULL(b.kybv,0))+
					SUM(ISNULL(b.symhs,0))+
					SUM(ISNULL(b.pkybv,0))+
					SUM(ISNULL(b.perh,0))+
					SUM(ISNULL(b.kybk,0))+
					SUM(ISNULL(b.symks,0))+
					SUM(ISNULL(b.pkybk,0))+
					SUM(ISNULL(b.perk,0))) !=0
		-- ������ �� ����
		INSERT INTO ras_kot_vk_m
		SELECT 
			a.nazk,'����',
			sum(isnull(b.kybv,0)),
			sum(isnull(b.symhs,0)),
			sum(isnull(b.pkybv,0)),
			sum(isnull(b.perh,0)),			
			sum(isnull(b.kybk,0)),
			sum(isnull(b.symks,0)),
			sum(isnull(b.pkybk,0)),
			sum(isnull(b.perk,0)),2
		FROM koteln a, dataobekt b, obekt c
		WHERE a.kodkot = c.kodkot and b.kodobk = c.kodobk
		and a.mesto = 2 and a.kodkot = @kod
		and b.datan between @data1 and @data2
		GROUP BY a.nazk
		HAVING (SUM(ISNULL(b.kybv,0))+
					SUM(ISNULL(b.symhs,0))+
					SUM(ISNULL(b.pkybv,0))+
					SUM(ISNULL(b.perh,0))+
					SUM(ISNULL(b.kybk,0))+
					SUM(ISNULL(b.symks,0))+
					SUM(ISNULL(b.pkybk,0))+
					SUM(ISNULL(b.perk,0))) !=0		
		-- ����� �� �������
		INSERT INTO ras_kot_vk_m
		SELECT 
			a.nazk,'�����',
			sum(isnull(b.kybv,0)),
			sum(isnull(b.symhs,0)),
			sum(isnull(b.pkybv,0)),
			sum(isnull(b.perh,0)),			
			sum(isnull(b.kybk,0)),
			sum(isnull(b.symks,0)),
			sum(isnull(b.pkybk,0)),
			sum(isnull(b.perk,0)),3
		FROM koteln a, dataobekt b, obekt c
		WHERE a.kodkot = c.kodkot and b.kodobk = c.kodobk
		and a.kodkot = @kod
		and b.datan between @data1 and @data2
		GROUP BY a.nazk
		HAVING (SUM(ISNULL(b.kybv,0))+
					SUM(ISNULL(b.symhs,0))+
					SUM(ISNULL(b.pkybv,0))+
					SUM(ISNULL(b.perh,0))+
					SUM(ISNULL(b.kybk,0))+
					SUM(ISNULL(b.symks,0))+
					SUM(ISNULL(b.pkybk,0))+
					SUM(ISNULL(b.perk,0))) !=0
		-- ��������� ������
		FETCH NEXT FROM @cur_kot INTO @kod
	END
	CLOSE @cur_kot
	DEALLOCATE @cur_kot
	-- ����� �� �����������
	INSERT INTO ras_kot_vk_m
	SELECT
		'�����','�����',sum(kybv),
	 	sum(sum_nacv),sum(per_kv),sum(sum_perv),
		sum(kybk),sum(sum_nack),sum(per_kk),sum(sum_perk),11
	FROM ras_kot_vk_m	
	WHERE tip = 1
	INSERT INTO ras_kot_vk_m
	SELECT
		'�����','����',sum(kybv),
	 	sum(sum_nacv),sum(per_kv),sum(sum_perv),
		sum(kybk),sum(sum_nack),sum(per_kk),sum(sum_perk),21
	FROM ras_kot_vk_m	
	WHERE tip = 2	
	INSERT INTO ras_kot_vk_m
	SELECT
		'�����','�����',sum(kybv),
	 	sum(sum_nacv),sum(per_kv),sum(sum_perv),
		sum(kybk),sum(sum_nack),sum(per_kk),sum(sum_perk),31
	FROM ras_kot_vk_m	
	WHERE tip = 3

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO


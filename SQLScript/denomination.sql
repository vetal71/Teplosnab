/*
Run this script on:

        (local).Teplosnab_copy    -  This database will be modified

to synchronize it with:

        (local).Teplosnab

You are recommended to back up your database before running this script

Script created by SQL Compare version 8.0.0 from Red Gate Software Ltd at 29.07.2016 23:17:22

*/
SET NUMERIC_ROUNDABORT OFF
GO
SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
IF EXISTS (SELECT * FROM tempdb..sysobjects WHERE id=OBJECT_ID('tempdb..#tmpErrors')) DROP TABLE #tmpErrors
GO
CREATE TABLE #tmpErrors (Error int)
GO
SET XACT_ABORT ON
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO
BEGIN TRANSACTION
GO
PRINT N'Altering [dbo].[Update_Org]'
GO
ALTER  PROCEDURE [dbo].[Update_Org]
@oper Integer,
@kodorg Integer,@nazv varchar(100), @adres varchar(100), @bank varchar(100), @rschet varchar(13),@unn varchar(10),
@tiporg integer, @datadog datetime, @ndog numeric(5,0), @tipbud integer, @kodbank integer 
AS
IF @oper = 1
BEGIN
	INSERT INTO org
                      ( nazv, adres, bank, rschet, unn, tiporg, datadog, ndog, tipbud, kodbank)
	VALUES     (@nazv, @adres, @bank, @rschet,@unn, @tiporg, @datadog, @ndog, @tipbud, @kodbank)
END
ELSE
BEGIN
	UPDATE org SET  nazv=@nazv, adres= @adres, bank=@bank,
	 rschet=@rschet, unn=@unn, tiporg=@tiporg, datadog=@datadog, ndog=@ndog, tipbud=@tipbud, kodbank=@kodbank
	WHERE kodorg=@kodorg
END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[ras_nac_g]'
GO
ALTER TABLE [dbo].[ras_nac_g] ALTER COLUMN [sum_nacg] [decimal] (20, 2) NULL
ALTER TABLE [dbo].[ras_nac_g] ALTER COLUMN [sum_perg] [decimal] (20, 2) NULL
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[schet]'
GO
ALTER TABLE [dbo].[schet] ALTER COLUMN [usluga] [varchar] (100) COLLATE Cyrillic_General_CI_AS NOT NULL
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[gen_report_ot]'
GO
ALTER TABLE [dbo].[gen_report_ot] ALTER COLUMN [sum_nac] [decimal] (20, 2) NULL
ALTER TABLE [dbo].[gen_report_ot] ALTER COLUMN [sum_nds] [decimal] (20, 2) NULL
ALTER TABLE [dbo].[gen_report_ot] ALTER COLUMN [sum_per] [decimal] (20, 2) NULL
ALTER TABLE [dbo].[gen_report_ot] ALTER COLUMN [razn] [decimal] (20, 2) NULL
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[ras_nac_ot]'
GO
ALTER TABLE [dbo].[ras_nac_ot] ALTER COLUMN [sum_nac] [decimal] (20, 2) NULL
ALTER TABLE [dbo].[ras_nac_ot] ALTER COLUMN [sum_per] [decimal] (20, 2) NULL
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[ras_nac_vk]'
GO
ALTER TABLE [dbo].[ras_nac_vk] ALTER COLUMN [sum_nacv] [decimal] (20, 2) NULL
ALTER TABLE [dbo].[ras_nac_vk] ALTER COLUMN [sum_perv] [decimal] (20, 2) NULL
ALTER TABLE [dbo].[ras_nac_vk] ALTER COLUMN [sum_nack] [decimal] (20, 2) NULL
ALTER TABLE [dbo].[ras_nac_vk] ALTER COLUMN [sum_perk] [decimal] (20, 2) NULL
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[sp_update_tPredoplata]'
GO
ALTER  PROCEDURE sp_update_tPredoplata
AS
	DECLARE @p_t decimal(20,2), 
    		@p_v decimal(20,2), 
            @p_k decimal(20,2),
            @p_g decimal(20,2),
            @s_t decimal(20,2), 
    		@s_v decimal(20,2), 
            @s_k decimal(20,2),
            @s_g decimal(20,2)
	SELECT 
    	@p_t = fsum_t, @p_v = fsum_v, @p_k = fsum_k, @p_g = fsum_g,
        @s_t = sum_t, @s_v = sum_v, @s_k = sum_k, @s_g = sum_g
	FROM tPredoplata

    if (@s_t=0) set @s_t=1;
    if (@s_v=0) set @s_v=1;
    if (@s_k=0) set @s_k=1;
    if (@s_g=0) set @s_g=1;
    
	IF (ISNULL(@p_t,0)+ISNULL(@p_v,0)+ISNULL(@p_k,0)+ISNULL(@p_g,0)) != 0
		UPDATE tPredoplata
        SET psum_t = round(fsum_t/@s_t,2),
          	psum_v = round(fsum_v/@s_v,2),
          	psum_k = round(fsum_k/@s_k,2),
          	psum_g = round(fsum_g/@s_g,2)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[sp_ras_kot_g]'
GO
ALTER  PROCEDURE [dbo].[sp_ras_kot_g] 
@data1 datetime, @data2 datetime
AS
	DECLARE @cur_kot CURSOR
	DECLARE @kod int
	-- Создаем таблицу
	IF EXISTS(SELECT name 
	  FROM 	 sysobjects 
	  WHERE  name = N'ras_kot_g' 
	  AND 	 type = 'U')
    DROP TABLE ras_kot_g
    
	CREATE TABLE ras_kot_g 
	(nazv varchar(50),nazv_pot varchar(50),kybg decimal(15,2),
	 sum_nacg decimal(20,2),per_kg	decimal(15,2),sum_perg decimal(20,2),tip int)
     
	-- Объявляем курсор
	SET @cur_kot = CURSOR FOR SELECT kodkot FROM koteln ORDER BY kodkot
	OPEN @cur_kot
	FETCH NEXT FROM @cur_kot INTO @kod
	WHILE (@@FETCH_STATUS = 0)
	BEGIN
		-- Данные по населению
		INSERT INTO ras_kot_g
		SELECT 
			a.nazk,'Население',
			sum(isnull(b.kybg,0)),
			sum(isnull(b.symg,0)),
			sum(isnull(b.pkybg,0)),
			sum(isnull(b.perg,0)),1
		FROM koteln a, dataobekt b, obekt c
		WHERE a.kodkot = c.kodkot and b.kodobk = c.kodobk
		and c.kodtg in (3,6,7,8) and a.kodkot = @kod
		and b.datan between @data1 and @data2
		GROUP BY a.nazk
		HAVING (SUM(ISNULL(b.kybg,0))+
					SUM(ISNULL(b.symgs,0))+
					SUM(ISNULL(b.pkybg,0))+
					SUM(ISNULL(b.perg,0))) !=0
		
        -- Данные по ЖСК
		INSERT INTO ras_kot_g
		SELECT 
			a.nazk,'в том числе ЖСК + вед.',
			sum(isnull(b.kybg,0)),
			sum(isnull(b.symg,0)),
			sum(isnull(b.pkybg,0)),
			sum(isnull(b.perg,0)),2
		FROM koteln a, dataobekt b, obekt c
		WHERE a.kodkot = c.kodkot and b.kodobk = c.kodobk
		and c.kodtg in (3,6,7) and a.kodkot = @kod
		and b.datan between @data1 and @data2
		GROUP BY a.nazk
		HAVING (SUM(ISNULL(b.kybg,0))+
					SUM(ISNULL(b.symgs,0))+
					SUM(ISNULL(b.pkybg,0))+
					SUM(ISNULL(b.perg,0))) !=0
		
        -- Данные по организациям
		INSERT INTO ras_kot_g
		SELECT 
			a.nazk,'Организации',
			sum(isnull(b.kybg,0)),
			sum(isnull(b.symg,0)),
			sum(isnull(b.pkybg,0)),
			sum(isnull(b.perg,0)),3
		FROM koteln a, dataobekt b, obekt c
		WHERE a.kodkot = c.kodkot and b.kodobk = c.kodobk
		and c.kodtg not in (3,6,7,8) and a.kodkot = @kod
		and b.datan between @data1 and @data2
		GROUP BY a.nazk
		HAVING (SUM(ISNULL(b.kybg,0))+
					SUM(ISNULL(b.symgs,0))+
					SUM(ISNULL(b.pkybg,0))+
					SUM(ISNULL(b.perg,0))) !=0
		
        -- Итоги по участку
		INSERT INTO ras_kot_g
		SELECT 
			a.nazk,'ИТОГО',
			sum(isnull(b.kybg,0)),
			sum(isnull(b.symg,0)),
			sum(isnull(b.pkybg,0)),
			sum(isnull(b.perg,0)),4
		FROM koteln a, dataobekt b, obekt c
		WHERE a.kodkot = c.kodkot and b.kodobk = c.kodobk
		and a.kodkot = @kod
		and b.datan between @data1 and @data2
		GROUP BY a.nazk
		HAVING (SUM(ISNULL(b.kybg,0))+
					SUM(ISNULL(b.symgs,0))+
					SUM(ISNULL(b.pkybg,0))+
					SUM(ISNULL(b.perg,0))) !=0
		-- Следующая запись
		FETCH NEXT FROM @cur_kot INTO @kod
	END
	CLOSE @cur_kot
	DEALLOCATE @cur_kot
	-- ИТОГИ по предприятию
	INSERT INTO ras_kot_g
	SELECT
		'ВСЕГО','Население',sum(kybg),
	 	sum(sum_nacg),sum(per_kg),sum(sum_perg),11
	FROM ras_kot_g	
	WHERE tip = 1
	INSERT INTO ras_kot_g
	SELECT
		'ВСЕГО','в том числе ЖСК + вед.',sum(kybg),
	 	sum(sum_nacg),sum(per_kg),sum(sum_perg),21
	FROM ras_kot_g	
	WHERE tip = 2
	INSERT INTO ras_kot_g
	SELECT
		'ВСЕГО','организации',sum(kybg),
	 	sum(sum_nacg),sum(per_kg),sum(sum_perg),31
	FROM ras_kot_g	
	WHERE tip = 3
	INSERT INTO ras_kot_g
	SELECT
		'ВСЕГО','ИТОГО',sum(kybg),
	 	sum(sum_nacg),sum(per_kg),sum(sum_perg),41
	FROM ras_kot_g	
	WHERE tip = 4
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[sp_ras_nac_g]'
GO
ALTER  PROCEDURE [dbo].[sp_ras_nac_g]
@data1 datetime, @data2 datetime
AS
	IF EXISTS(SELECT name 
	  FROM 	 sysobjects 
	  WHERE  name = N'ras_nac_g' 
	  AND 	 type = 'U')
    DROP TABLE ras_nac_g
    
	CREATE TABLE ras_nac_g
	(nazv char(50),tarifg decimal(15,2),kod_tarif int,kybg decimal(15,2),
	 sum_nacg decimal(20,2),per_kg	decimal(15,2),sum_perg decimal(20,2))
	
    INSERT INTO ras_nac_g
	SELECT
		a.nazt,AVG(b.cenag),a.kodtg,
		SUM(ISNULL(c.kybg,0)),
		SUM(ISNULL(c.symgs,0)),
		SUM(ISNULL(c.pkybg,0)),
		SUM(ISNULL(c.perg,0))
	FROM tarifg a, datatarifg b, dataobekt c, obekt d
	WHERE a.kodtg = b.kodtg and a.kodtg = d.kodtg and
				b.datan = c.datan and c.kodobk = d.kodobk
				and b.datan between @data1 and @data2
	GROUP BY a.nazt, a.kodtg
	HAVING (SUM(ISNULL(c.kybg,0))+
					SUM(ISNULL(c.symgs,0))+
					SUM(ISNULL(c.pkybg,0))+
					SUM(ISNULL(c.perg,0))) !=0
	ORDER BY a.kodtg
	
    -- Добавляем итог по населению
	INSERT INTO ras_nac_g
	SELECT
		'ИТОГО население',Null,Null,
		SUM(kybg),SUM(sum_nacg),SUM(per_kg),SUM(sum_perg)
	FROM ras_nac_g
	WHERE kod_tarif = 8
    
	-- Добавляем итог по ЖСК
	INSERT INTO ras_nac_g
	SELECT
		'ИТОГО ЖСК + вед.',Null,Null,
		SUM(kybg),SUM(sum_nacg),SUM(per_kg),SUM(sum_perg)
	FROM ras_nac_g
	WHERE kod_tarif in (3,6,7)
    
	-- Добавляем итог по организациям
	INSERT INTO ras_nac_g
	SELECT
		'ИТОГО организации',Null,Null,
		SUM(kybg),SUM(sum_nacg),SUM(per_kg),SUM(sum_perg)
	FROM ras_nac_g
	WHERE kod_tarif NOT IN (3,6,7,8)
	-- Добавляем итог
	INSERT INTO ras_nac_g
	SELECT
		'ВСЕГО:',Null,Null,
		SUM(kybg),SUM(sum_nacg),SUM(per_kg),SUM(sum_perg)
	FROM ras_nac_g
	WHERE kod_tarif Is Not Null
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[sp_ras_kot_ot_m]'
GO
ALTER PROCEDURE sp_ras_kot_ot_m
	@data1 datetime, @data2 datetime
AS
	DECLARE @cur_kot CURSOR
	DECLARE @kod int
	-- Создаем таблицу
	IF EXISTS(SELECT name 
	  FROM 	 sysobjects 
	  WHERE  name = N'ras_kot_ot_m' 
	  AND 	 type = 'U')
    DROP TABLE ras_kot_ot_m
	CREATE TABLE ras_kot_ot_m 
	(nazv varchar(50),nazv_pot varchar(50),gk decimal(15,2),
	 sum_nac decimal(20,2),per_gk	decimal(15,2),	
	 sum_per decimal(20,2),tip int)
	-- Объявляем курсор
	SET @cur_kot = CURSOR FOR SELECT kodkot FROM koteln ORDER BY kodkot
	OPEN @cur_kot
	FETCH NEXT FROM @cur_kot INTO @kod
	WHILE (@@FETCH_STATUS = 0)
	BEGIN
		-- Данные по городу
		INSERT INTO ras_kot_ot_m
		SELECT 
			a.nazk,'ГОРОД',
			sum(isnull(b.gkt,0)+isnull(b.gkv,0)),
			sum(isnull(b.symk,0)+isnull(b.symgv,0)),
			sum(isnull(b.pgkt,0)+isnull(b.pgkv,0)),
			sum(isnull(b.pert,0)+isnull(b.perv,0)),1
		FROM koteln a, dataobekt b, obekt c
		WHERE a.kodkot = c.kodkot and b.kodobk = c.kodobk
		and a.kodkot = @kod and a.mesto=1
		and b.datan between @data1 and @data2
		GROUP BY a.nazk
		HAVING (SUM(ISNULL(b.gkt,0)+ISNULL(b.gkv,0))+
				 SUM(ISNULL(b.symk,0)+ISNULL(b.symgv,0))+
				 SUM(ISNULL(b.pgkt,0)+ISNULL(b.pgkv,0))+
				 SUM(ISNULL(b.pert,0)+ISNULL(b.perv,0))) !=0		
		-- Данные по селу
		INSERT INTO ras_kot_ot_m
		SELECT 
			a.nazk,'СЕЛО',
			sum(isnull(b.gkt,0)+isnull(b.gkv,0)),
			sum(isnull(b.symk,0)+isnull(b.symgv,0)),
			sum(isnull(b.pgkt,0)+isnull(b.pgkv,0)),
			sum(isnull(b.pert,0)+isnull(b.perv,0)),2
		FROM koteln a, dataobekt b, obekt c
		WHERE a.kodkot = c.kodkot and b.kodobk = c.kodobk
		and a.mesto = 2 and a.kodkot = @kod
		and b.datan between @data1 and @data2
		GROUP BY a.nazk
		HAVING (SUM(ISNULL(b.gkt,0)+ISNULL(b.gkv,0))+
				 SUM(ISNULL(b.symk,0)+ISNULL(b.symgv,0))+
				 SUM(ISNULL(b.pgkt,0)+ISNULL(b.pgkv,0))+
				 SUM(ISNULL(b.pert,0)+ISNULL(b.perv,0))) !=0		
		-- Итоги по участку
		INSERT INTO ras_kot_ot_m
		SELECT 
			a.nazk,'ИТОГО',
			sum(isnull(b.gkt,0)+isnull(b.gkv,0)),
			sum(isnull(b.symk,0)+isnull(b.symgv,0)),
			sum(isnull(b.pgkt,0)+isnull(b.pgkv,0)),
			sum(isnull(b.pert,0)+isnull(b.perv,0)),3
		FROM koteln a, dataobekt b, obekt c
		WHERE a.kodkot = c.kodkot and b.kodobk = c.kodobk
		and a.kodkot = @kod
		and b.datan between @data1 and @data2
		GROUP BY a.nazk
		HAVING (SUM(ISNULL(b.gkt,0)+ISNULL(b.gkv,0))+
				 SUM(ISNULL(b.symk,0)+ISNULL(b.symgv,0))+
				 SUM(ISNULL(b.pgkt,0)+ISNULL(b.pgkv,0))+
				 SUM(ISNULL(b.pert,0)+ISNULL(b.perv,0))) !=0
		-- Следующая запись
		FETCH NEXT FROM @cur_kot INTO @kod
	END
	CLOSE @cur_kot
	DEALLOCATE @cur_kot
	-- ИТОГИ по предприятию
	INSERT INTO ras_kot_ot_m
	SELECT
		'ВСЕГО','ГОРОД',sum(gk),
	 	sum(sum_nac),sum(per_gk),sum(sum_per),11
	FROM ras_kot_ot_m	
	WHERE tip = 1
	INSERT INTO ras_kot_ot_m
	SELECT
		'ВСЕГО','СЕЛО',sum(gk),
	 	sum(sum_nac),sum(per_gk),sum(sum_per),21
	FROM ras_kot_ot_m	
	WHERE tip = 2	
	INSERT INTO ras_kot_ot_m
	SELECT
		'ВСЕГО','ИТОГО',sum(gk),
	 	sum(sum_nac),sum(per_gk),sum(sum_per),31
	FROM ras_kot_ot_m	
	WHERE tip = 3
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[sp_ras_kot_vk_m]'
GO
ALTER  PROCEDURE sp_ras_kot_vk_m
@data1 datetime, @data2 datetime
AS
	DECLARE @cur_kot CURSOR
	DECLARE @kod int
	-- Создаем таблицу
	IF EXISTS(SELECT name 
	  FROM 	 sysobjects 
	  WHERE  name = N'ras_kot_vk_m' 
	  AND 	 type = 'U')
    DROP TABLE ras_kot_vk_m
	CREATE TABLE ras_kot_vk_m 
	(nazv varchar(50),nazv_pot varchar(50),kybv decimal(15,2),
	 sum_nacv decimal(20,2),per_kv	decimal(15,2),sum_perv decimal(20,2),
	 kybk decimal(15,2),sum_nack decimal(20,2),per_kk	decimal(15,2),
	 sum_perk decimal(20,2),tip int)
---
	-- Данные по населению
		INSERT INTO ras_kot_vk_m
		SELECT 
			'ГОРОД' as naz,'Население',
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
		and c.kodtv in (3,5,12,15,16,17) and a.mesto = 1
		and b.datan between @data1 and @data2
		GROUP BY a.mesto
		HAVING (SUM(ISNULL(b.kybv,0))+
					SUM(ISNULL(b.symhs,0))+
					SUM(ISNULL(b.pkybv,0))+
					SUM(ISNULL(b.perh,0))+
					SUM(ISNULL(b.kybk,0))+
					SUM(ISNULL(b.symks,0))+
					SUM(ISNULL(b.pkybk,0))+
					SUM(ISNULL(b.perk,0))) !=0
	-- Данные по ЖСК
		INSERT INTO ras_kot_vk_m
		SELECT 
			'ГОРОД','в том числе ЖСК',
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
		and c.kodtv in (3,12,15,16,17) and a.mesto = 1
		and b.datan between @data1 and @data2
		GROUP BY a.mesto
		HAVING (SUM(ISNULL(b.kybv,0))+
					SUM(ISNULL(b.symhs,0))+
					SUM(ISNULL(b.pkybv,0))+
					SUM(ISNULL(b.perh,0))+
					SUM(ISNULL(b.kybk,0))+
					SUM(ISNULL(b.symks,0))+
					SUM(ISNULL(b.pkybk,0))+
					SUM(ISNULL(b.perk,0))) !=0
		-- Данные по организациям
		INSERT INTO ras_kot_vk_m
		SELECT 
			'ГОРОД','Организации',
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
		and c.kodtv not in (3,5,12,15,16,17) and a.mesto = 1
		and b.datan between @data1 and @data2
		GROUP BY a.mesto
		HAVING (SUM(ISNULL(b.kybv,0))+
					SUM(ISNULL(b.symhs,0))+
					SUM(ISNULL(b.pkybv,0))+
					SUM(ISNULL(b.perh,0))+
					SUM(ISNULL(b.kybk,0))+
					SUM(ISNULL(b.symks,0))+
					SUM(ISNULL(b.pkybk,0))+
					SUM(ISNULL(b.perk,0))) !=0
	-- Итоги по участку
		INSERT INTO ras_kot_vk_m
		SELECT 
			'ГОРОД','ИТОГО',
			sum(isnull(b.kybv,0)),
			sum(isnull(b.symhs,0)),
			sum(isnull(b.pkybv,0)),
			sum(isnull(b.perh,0)),			
			sum(isnull(b.kybk,0)),
			sum(isnull(b.symks,0)),
			sum(isnull(b.pkybk,0)),
			sum(isnull(b.perk,0)),4
		FROM koteln a, dataobekt b, obekt c
		WHERE a.kodkot = c.kodkot and b.kodobk = c.kodobk
		and a.mesto = 1
		and b.datan between @data1 and @data2
		GROUP BY a.mesto
		HAVING (SUM(ISNULL(b.kybv,0))+
					SUM(ISNULL(b.symhs,0))+
					SUM(ISNULL(b.pkybv,0))+
					SUM(ISNULL(b.perh,0))+
					SUM(ISNULL(b.kybk,0))+
					SUM(ISNULL(b.symks,0))+
					SUM(ISNULL(b.pkybk,0))+
					SUM(ISNULL(b.perk,0))) !=0

	-- Данные по населению
		INSERT INTO ras_kot_vk_m
		SELECT 
			'СЕЛО' as naz,'Население',
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
		and c.kodtv in (3,5) and a.mesto = 2
		and b.datan between @data1 and @data2
		GROUP BY a.mesto
		HAVING (SUM(ISNULL(b.kybv,0))+
					SUM(ISNULL(b.symhs,0))+
					SUM(ISNULL(b.pkybv,0))+
					SUM(ISNULL(b.perh,0))+
					SUM(ISNULL(b.kybk,0))+
					SUM(ISNULL(b.symks,0))+
					SUM(ISNULL(b.pkybk,0))+
					SUM(ISNULL(b.perk,0))) !=0
	-- Данные по ЖСК
		INSERT INTO ras_kot_vk_m
		SELECT 
			'СЕЛО','в том числе ЖСК',
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
		and c.kodtv in (3) and a.mesto = 2
		and b.datan between @data1 and @data2
		GROUP BY a.mesto
		HAVING (SUM(ISNULL(b.kybv,0))+
					SUM(ISNULL(b.symhs,0))+
					SUM(ISNULL(b.pkybv,0))+
					SUM(ISNULL(b.perh,0))+
					SUM(ISNULL(b.kybk,0))+
					SUM(ISNULL(b.symks,0))+
					SUM(ISNULL(b.pkybk,0))+
					SUM(ISNULL(b.perk,0))) !=0
		-- Данные по организациям
		INSERT INTO ras_kot_vk_m
		SELECT 
			'СЕЛО','Организации',
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
		and c.kodtv not in (3,5) and a.mesto = 2
		and b.datan between @data1 and @data2
		GROUP BY a.mesto
		HAVING (SUM(ISNULL(b.kybv,0))+
					SUM(ISNULL(b.symhs,0))+
					SUM(ISNULL(b.pkybv,0))+
					SUM(ISNULL(b.perh,0))+
					SUM(ISNULL(b.kybk,0))+
					SUM(ISNULL(b.symks,0))+
					SUM(ISNULL(b.pkybk,0))+
					SUM(ISNULL(b.perk,0))) !=0
	-- Итоги по участку
		INSERT INTO ras_kot_vk_m
		SELECT 
			'СЕЛО','ИТОГО',
			sum(isnull(b.kybv,0)),
			sum(isnull(b.symhs,0)),
			sum(isnull(b.pkybv,0)),
			sum(isnull(b.perh,0)),			
			sum(isnull(b.kybk,0)),
			sum(isnull(b.symks,0)),
			sum(isnull(b.pkybk,0)),
			sum(isnull(b.perk,0)),4
		FROM koteln a, dataobekt b, obekt c
		WHERE a.kodkot = c.kodkot and b.kodobk = c.kodobk
		and a.mesto = 2
		and b.datan between @data1 and @data2
		GROUP BY a.mesto
		HAVING (SUM(ISNULL(b.kybv,0))+
					SUM(ISNULL(b.symhs,0))+
					SUM(ISNULL(b.pkybv,0))+
					SUM(ISNULL(b.perh,0))+
					SUM(ISNULL(b.kybk,0))+
					SUM(ISNULL(b.symks,0))+
					SUM(ISNULL(b.pkybk,0))+
					SUM(ISNULL(b.perk,0))) !=0



/*	-- Объявляем курсор
	SET @cur_kot = CURSOR FOR SELECT kodkot FROM koteln ORDER BY kodkot
	OPEN @cur_kot
	FETCH NEXT FROM @cur_kot INTO @kod
	WHILE (@@FETCH_STATUS = 0)
	BEGIN
		-- Данные по городу
		INSERT INTO ras_kot_vk_m
		SELECT 
			a.nazk,'ГОРОД',
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
		-- Данные по селу
		INSERT INTO ras_kot_vk_m
		SELECT 
			a.nazk,'СЕЛО',
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
		-- Итоги по участку
		INSERT INTO ras_kot_vk_m
		SELECT 
			a.nazk,'ИТОГО',
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
		-- Следующая запись
		FETCH NEXT FROM @cur_kot INTO @kod
	END
	CLOSE @cur_kot
	DEALLOCATE @cur_kot
	-- ИТОГИ по предприятию
	INSERT INTO ras_kot_vk_m
	SELECT
		'ВСЕГО','ГОРОД',sum(kybv),
	 	sum(sum_nacv),sum(per_kv),sum(sum_perv),
		sum(kybk),sum(sum_nack),sum(per_kk),sum(sum_perk),11
	FROM ras_kot_vk_m	
	WHERE tip = 1
	INSERT INTO ras_kot_vk_m
	SELECT
		'ВСЕГО','СЕЛО',sum(kybv),
	 	sum(sum_nacv),sum(per_kv),sum(sum_perv),
		sum(kybk),sum(sum_nack),sum(per_kk),sum(sum_perk),21
	FROM ras_kot_vk_m	
	WHERE tip = 2	
	INSERT INTO ras_kot_vk_m
	SELECT
		'ВСЕГО','ИТОГО',sum(kybv),
	 	sum(sum_nacv),sum(per_kv),sum(sum_perv),
		sum(kybk),sum(sum_nack),sum(per_kk),sum(sum_perk),31
	FROM ras_kot_vk_m	
	WHERE tip = 3*/
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[sp_general_report_all]'
GO
ALTER PROCEDURE sp_general_report_all 
	@data1 datetime, @data2 datetime
AS
	IF EXISTS(SELECT name 
	  FROM 	 sysobjects 
	  WHERE  name = N'gen_report_all' 
	  AND 	 type = 'U')
    DROP TABLE gen_report_all
	CREATE TABLE gen_report_all 
	(kod int, nazv char(50),gk decimal(15,2),tarif decimal(15,2),kod_tarif int,
	 sum_nac decimal(20,2),sum_nds decimal(20,2),
	 per_gk	decimal(15,2),sum_per decimal(20,2),razn decimal(20,2),
	 kv decimal(15,2),tarifv decimal(15,2),kod_tarifv int,
	 sum_nacv decimal(20,2),sum_ndsv decimal(20,2),
	 per_kv	decimal(15,2),sum_perv decimal(20,2),raznv decimal(20,2),
	 kk decimal(15,2),tarifk decimal(15,2),kod_tarifk int,
	 sum_nack decimal(20,2),sum_ndsk decimal(20,2),
	 per_kk	decimal(15,2),sum_perk decimal(20,2),raznk decimal(20,2),
	 tip int)
	print 'Создали таблицу'
	-- Собираем сведения
	DECLARE @i integer
	DECLARE @kod int, @nazv varchar(100),@gk decimal(15,2),@tarif decimal(15,2),
	@kod_tarif int,@sum_nac decimal(20,2),@sum_nds decimal(20,2),
	@per_gk decimal(15,2),@sum_per decimal(20,2),@razn decimal(20,2),
	@cena_t decimal(15,2),
	@kv decimal(15,2),@tarifv decimal(15,2),
	@kod_tarifv int,@sum_nacv decimal(20,2),@sum_ndsv decimal(20,2),
	@per_kv decimal(15,2),@sum_perv decimal(20,2),@raznv decimal(20,2),
	@cena_v decimal(15,2),
  @kk decimal(15,2),@tarifk decimal(15,2),
	@kod_tarifk int,@sum_nack decimal(20,2),@sum_ndsk decimal(20,2),
	@per_kk decimal(15,2),@sum_perk decimal(20,2),@raznk decimal(20,2),
	@cena_k decimal(15,2)
	DECLARE @cur_org CURSOR
	-- Выбираем тариф №13
	/*SELECT @cena_t = AVG(cena) FROM datatarif
		WHERE kodtt = 13 and datan between @data1 and @data2
	print @cena_t*/
	SET @i=0
	WHILE @i<4 
	BEGIN 
		SET @cur_org = CURSOR FOR 
			SELECT a.kodorg,a.nazv,
				sum(ISNULL(b.gkot,0)+ISNULL(b.gkgv,0)),				
				sum(b.itog),
				sum(ISNULL(b.symnds,0)+ISNULL(b.symgvnds,0)+ISNULL(b.pertonds,0)+ISNULL(b.pergvnds,0)),
				sum(ISNULL(b.pgkto,0)+ISNULL(b.pgkvo,0)),
				sum(ISNULL(b.perto,0)+ISNULL(b.pergv,0)),
				sum(ISNULL(b.skybv,0)),				
				sum(b.itogv),
				sum(ISNULL(b.sumvnds,0)+ISNULL(b.perhonds,0)),
				sum(ISNULL(b.pkybvo,0)),
				sum(ISNULL(b.perho,0)),
				sum(ISNULL(b.skybk,0)),				
				sum(b.itogk),
				sum(ISNULL(b.sumknds,0)+ISNULL(b.perkonds,0)),
				sum(ISNULL(b.pkybko,0)),
				sum(ISNULL(b.perko,0))
				FROM org a,dataorg b 
				WHERE a.kodorg=b.kodorg and a.tiporg = @i 
				and b.datan between @data1 and @data2
				GROUP BY a.kodorg, a.nazv
				HAVING sum(b.itog+ISNULL(b.perto,0)+ISNULL(b.pergv,0)+ISNULL(b.gkot,0)+ISNULL(b.gkgv,0))+
        sum(ISNULL(b.skybv,0))+sum(ISNULL(b.skybk,0))+sum(ISNULL(b.perho,0))+sum(ISNULL(b.perko,0))!=0
				ORDER BY a.nazv 				
		OPEN @cur_org		
		FETCH NEXT FROM @cur_org INTO @kod,@nazv,@gk,@sum_nac,@sum_nds,@per_gk,@sum_per,
		@kv,@sum_nacv,@sum_ndsv,@per_kv,@sum_perv,@kk,@sum_nack,@sum_ndsk,@per_kk,@sum_perk
		-- Заполняем данные по организации
		WHILE (@@FETCH_STATUS=0)
		BEGIN
			INSERT INTO gen_report_all (kod, nazv,gk,sum_nac,sum_nds,per_gk,sum_per,
			kv,sum_nacv,sum_ndsv,per_kv,sum_perv,
			kk,sum_nack,sum_ndsk,per_kk,sum_perk,tip)
			VALUES (@kod, @nazv,@gk,@sum_nac,@sum_nds,@per_gk,@sum_per,
			@kv,@sum_nacv,@sum_ndsv,@per_kv,@sum_perv,
			@kk,@sum_nack,@sum_ndsk,@per_kk,@sum_perk,@i)				
			FETCH NEXT FROM @cur_org INTO @kod,@nazv,@gk,@sum_nac,@sum_nds,@per_gk,@sum_per,
			@kv,@sum_nacv,@sum_ndsv,@per_kv,@sum_perv,@kk,@sum_nack,@sum_ndsk,@per_kk,@sum_perk
		END
		CLOSE @cur_org
		DEALLOCATE @cur_org		
		-- Заполняем итоги
		IF @i = 0
			SET @nazv = 'ИТОГО ПО БЮДЖЕТУ:'
		IF @i = 1
			SET @nazv = 'ИТОГО ПО ХОЗРАСЧЕТУ:'
		IF @i = 2
			SET @nazv = 'ИТОГО ПО ЖСК:'
		IF @i = 3
			SET @nazv = 'ИТОГО ПО ЖСК - БСХА:'

		INSERT INTO gen_report_all (nazv,gk,sum_nac,sum_nds,per_gk,sum_per,
		kv,sum_nacv,sum_ndsv,per_kv,sum_perv,
		kk,sum_nack,sum_ndsk,per_kk,sum_perk,tip)
		SELECT @nazv,SUM(gk),SUM(sum_nac),SUM(sum_nds),SUM(per_gk),
  	SUM(sum_per),SUM(kv),SUM(sum_nacv),SUM(sum_ndsv),SUM(per_kv),SUM(sum_perv),
		SUM(kk),SUM(sum_nack),SUM(sum_ndsk),SUM(per_kk),SUM(sum_perk),@i+20
		FROM gen_report_all WHERE tip = @i	  
		SET @i = @i+1
	END
	SET @nazv = 'ИТОГО ПО ПРЕДПРИЯТИЮ:'
	INSERT INTO gen_report_all (nazv,gk,sum_nac,sum_nds,per_gk,sum_per,
	kv,sum_nacv,sum_ndsv,per_kv,sum_perv,
	kk,sum_nack,sum_ndsk,per_kk,sum_perk,tip)
	SELECT @nazv,SUM(gk),SUM(sum_nac),SUM(sum_nds),SUM(per_gk),
				 SUM(sum_per),SUM(kv),SUM(sum_nacv),SUM(sum_ndsv),SUM(per_kv),SUM(sum_perv),
		SUM(kk),SUM(sum_nack),SUM(sum_ndsk),SUM(per_kk),SUM(sum_perk),30
	FROM gen_report_all
	WHERE (tip < 4)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[up_datatarif]'
GO
ALTER       PROCEDURE up_datatarif
	@kod int, @cena1 decimal(15,4), @cena2 decimal(15,4), @data datetime, @oper int
AS
	DECLARE @cnt int
	IF @oper = 1 
	BEGIN
		-- Проверяем наличие записи
		SELECT @cnt = count(*) FROM datatarif 
			WHERE kodtt = @kod and datan = @data
		IF @cnt <> 0
			UPDATE datatarif SET cena = @cena1 
			WHERE kodtt = @kod and datan = @data
	END
	IF @oper = 11 -- Режим обновления цены добавленной записи
	BEGIN
		-- Проверяем наличие записи
		SELECT @cnt = count(*) FROM datatarif 
			WHERE cena Is Null and datan Is Null
		IF @cnt <> 0
			UPDATE datatarif 
				SET cena = @cena1, 
				datan = @data, 
				datak = teplosnab.dbo.end_of_month(@data)
			WHERE cena Is Null and datan Is Null
	END
	IF @oper = 2 -- Режим обновления цены (вода)
	BEGIN
		-- Проверяем наличие записи
		SELECT @cnt = count(*) FROM datatarifv
			WHERE kodtv = @kod and datan = @data
		IF @cnt <> 0
			UPDATE datatarifv SET cenav = @cena1, cenak = @cena2
			WHERE kodtv = @kod and datan = @data		
	END
	IF @oper = 22 -- Режим обновления цены добавленной записи (вода)
	BEGIN
		-- Проверяем наличие записи
		SELECT @cnt = count(*) FROM datatarifv
			WHERE cenav Is Null and datan Is Null
		IF @cnt <> 0
			UPDATE datatarifv 
				SET cenav = @cena1,
				cenak = @cena2, 
				datan = @data, 
				datak = teplosnab.dbo.end_of_month(@data)
			WHERE cenav Is Null and datan Is Null					
	END
    -- Обновление записей по мусору
    IF @oper = 3 
	BEGIN
		-- Проверяем наличие записи
		SELECT @cnt = count(*) FROM datatarifg 
			WHERE kodtg = @kod and datan = @data
		IF @cnt <> 0
			UPDATE datatarifg SET cenag = @cena1 
			WHERE kodtg = @kod and datan = @data
	END
	IF @oper = 31 -- Режим обновления цены добавленной записи
	BEGIN
		-- Проверяем наличие записи
		SELECT @cnt = count(*) FROM datatarifg 
			WHERE cenag Is Null and datan Is Null
		IF @cnt <> 0
			UPDATE datatarifg 
				SET cenag = @cena1, 
				datan = @data, 
				datak = teplosnab.dbo.end_of_month(@data)
			WHERE cenag Is Null and datan Is Null
	END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[sp_create_sf_tek]'
GO
ALTER       PROCEDURE sp_create_sf_tek
	@kod int = -1, @data datetime
AS
	declare @cnt integer,
  	@stavka decimal(2),
	@kodorg int,
    @okr int,
	@cur_org CURSOR
    
    if @data > '30.06.2016'
    	set @okr=2
    else
     	set @okr=0
    
	IF @kod > 0
	BEGIN
		select @cnt = tiporg from org where kodorg=@kod
  	if @cnt<2 
        	if YEAR(@data) < 2010
	            set @stavka = 18
            else
                set @stavka = 20    
  		else 
            set @stavka=0
		
		-- Обновляем ее
		UPDATE pr_obekt 
			SET 
				-- Тепло
				gkt = round(gkt*psum_t,2),
				gkv = round(gkv*psum_t,2),
				symt = round(symt*psum_t,@okr),
				symv = round(symv*psum_t,@okr),
				symtnds = round(symtnds*psum_t,@okr),
				symvnds = round(symvnds*psum_t,@okr),
				symk = round(symk*psum_t,@okr),
				symgv = round(symgv*psum_t,@okr),
				pert = 0, pertnds =0, perv = 0, pervnds = 0,pgkt = 0,pgkv = 0,
				-- Вода
				kybv = round(kybv*psum_v,2),
				kybk = round(kybk*psum_k,2),
				symh = round(symh*psum_v,@okr),
				symkk = round(symkk*psum_k,@okr),
				symhnds = round(symhnds*psum_v,@okr),
				symknds = round(symknds*psum_k,@okr),
				symhs = round(symhs*psum_v,@okr),
				symks = round(symks*psum_k,@okr),
				perh = 0, perk = 0, perhnds = 0, perknds = 0, pkybv = 0, pkybk = 0
		FROM tPredoplata
		
  	delete from schet
		-- Добавляем записи в таблицу SCHET
		INSERT INTO schet
		SELECT 'Отпуск тепловой энергии','Гкал',
				sum(b.gkt+b.gkv) as kol,
				0 as tarif,
				sum(b.symt+b.symv) as sum_b_nds,
				@stavka,
        sum(b.symtnds+b.symvnds) as nds,
				sum(b.symk+b.symgv) as sum_s_nds,
				a.kodorg,GetDate(),1,null,a.nazv,a.adres,a.unn,a.rschet,c.nazv_bank
			FROM org a,pr_obekt b,bank c,obekt d
			WHERE a.kodorg = d.kodorg and d.kodobk = b.kodobk and a.kodbank = c.kod_bank
						and b.datan = @data and a.kodorg = @kod
			GROUP BY a.kodorg,a.nazv,a.adres,a.unn,a.rschet,c.nazv_bank
			HAVING sum(b.symt+b.symv)<>0
		INSERT INTO schet
  	SELECT 'Отпуск холодной воды','Куб.м.',
				sum(b.kybv) as kol,
				0 as tarif,
				sum(b.symh) as sum_b_nds,@stavka,
         sum(b.symhnds) as nds,
				sum(b.symhs) as sum_s_nds,
				a.kodorg,GetDate(),2,null,a.nazv,a.adres,a.unn,a.rschet,c.nazv_bank
			FROM org a,pr_obekt b,bank c,obekt d
			WHERE a.kodorg = d.kodorg and d.kodobk = b.kodobk and a.kodbank = c.kod_bank
						and b.datan = @data and a.kodorg = @kod
			GROUP BY a.kodorg,a.nazv,a.adres,a.unn,a.rschet,c.nazv_bank
			HAVING sum(b.symh)<>0
		INSERT INTO schet
  	SELECT 'Пропуск сточных вод','Куб.м.',
				sum(b.kybk) as kol,
				0 as tarif,
				sum(b.symkk) as sum_b_nds,@stavka,
        sum(b.symknds) as nds,
				sum(b.symks) as sum_s_nds,
		  	a.kodorg,GetDate(),3,null,a.nazv,a.adres,a.unn,a.rschet,c.nazv_bank
			FROM org a,pr_obekt b,bank c,obekt d
			WHERE a.kodorg = d.kodorg and d.kodobk = b.kodobk and a.kodbank = c.kod_bank
						and b.datan = @data and a.kodorg = @kod
			GROUP BY a.kodorg,a.nazv,a.adres,a.unn,a.rschet,c.nazv_bank
			HAVING sum(b.symkk)<>0
	END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[sp_recalc]'
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
    symt=round(b.gkt*a.cena,2),
		symv=round(b.gkv*a.cena,2),
    symtnds=round(b.gkt*a.cena*c.nds/100,2),
		symvnds=round(b.gkv*a.cena*c.nds/100,2),
    symk=round((b.gkt*a.cena)+(b.gkt*a.cena*c.nds/100),2),
		symgv=round((b.gkv*a.cena)+(b.gkv*a.cena*c.nds/100),2),
    pertnds=round((b.pert*c.nds/(100+c.nds)),2),
		pervnds=round((b.perv*c.nds/(100+c.nds)),2),
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
    symh=round(b.kybv*a.cenav,2),
		symkk=round(b.kybk*a.cenak,2),
    symhnds=round(b.kybv*a.cenav*c.nds/100,2),
		symknds=round(b.kybk*a.cenak*c.nds/100,2),
    symhs=round((b.kybv*a.cenav)+(b.kybv*a.cenav*c.nds/100),2),
		symks=round((b.kybk*a.cenak)+(b.kybk*a.cenak*c.nds/100),2),
    perhnds=round((b.perh*c.nds/(100+c.nds)),2),
		perknds=round((b.perk*c.nds/(100+c.nds)),2),
    rastarifv=a.cenav,
		rastarifk=a.cenak
	FROM	
		(datatarifv as a join pr_obekt as b on (a.datan=b.datan)) join
    obekt as c on(a.kodtv=c.kodtv) and(c.kodobk=b.kodobk) 
  WHERE b.datan=@data and c.kodtv<>3
	-- Обновляем все объекы ЖСК
	UPDATE pr_obekt
	SET
    symh=round((((b.kybv*a.cenav)/(c.prj+c.prjl)*c.prj)+((b.kybv*a.cenav)/(c.prj+c.prjl)*c.prjl/2)),2),
    symkk=round((((b.kybk*a.cenak)/(c.prj+c.prjl)*c.prj)+((b.kybk*a.cenak)/(c.prj+c.prjl)*c.prjl/2)),2),
    lsymh=round(b.kybv*a.cenav/(c.prj+c.prjl)*c.prjl/2,2),
		lsymkk=round(b.kybk*a.cenak/(c.prj+c.prjl)*c.prjl/2,2),
    lkybv=round(b.kybv/(c.prj+c.prjl)*c.prjl,2),
		lkybk=round(b.kybk/(c.prj+c.prjl)*c.prjl,2),
    symhnds=0,
		symknds=0,
    symhs=round((((b.kybv*a.cenav)/(c.prj+c.prjl)*c.prj)+((b.kybv*a.cenav)/(c.prj+c.prjl)*c.prjl/2)),2),
    symks=round((((b.kybk*a.cenak)/(c.prj+c.prjl)*c.prj)+((b.kybk*a.cenak)/(c.prj+c.prjl)*c.prjl/2)),2),
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
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[sp_calc_org_idx]'
GO
CREATE       PROCEDURE [dbo].[sp_calc_org_idx]
	@kod  int,
	@data datetime
AS	
    
    UPDATE dataorg 
    SET 
    	ndsidx  = round((symidx*20/(120)),2),
        ndsidxv = round((symidxv*20/(120)),2),
        ndsidxk = round((symidxk*20/(120)),2),
        itog    = symtv + perto, 
        itogv   = sumvv + perho, 
        itogk   = sumkk + perko
	WHERE kodorg=@kod and datan=@data
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[sp_calc_org]'
GO
ALTER       PROCEDURE sp_calc_org
	@data datetime
AS
	DECLARE @id_org int,
    @sym decimal(15,2),
	@symgv decimal(15,2),
    @symnds decimal(15,2),
  	@symgvnds decimal(15,2),
    @symtv decimal(15,2),
	@symgvs decimal(15,2),
    @pert decimal(15,2),
	@pergv decimal(15,2),
    @pgkt decimal(15,2),
  	@pgkv decimal(15,2),
    @pertnds decimal(15,2),
	@pergvnds decimal(15,2),
    @gkot decimal(15,2),
	@gkgv decimal(15,2),
    @lsymot decimal(15,2),
	@lgkot decimal(15,2),
    @lsymgv decimal(15,2),
	@lgkgv decimal(15,2)
	-- Объявляем курсор
	DECLARE cur_org CURSOR FOR
	SELECT b.kodorg,
		isnull(SUM(symt),0),
		isnull(SUM(symv),0),
		isnull(SUM(symtnds),0),
		isnull(SUM(symvnds),0),
		isnull(SUM(gkt),0),
		isnull(SUM(gkv),0),
		isnull(SUM(symk),0),
		isnull(SUM(symgv),0),
    	isnull(SUM(pert),0),
		isnull(SUM(perv),0),
		isnull(SUM(pgkt),0),
		isnull(SUM(pgkv),0),
		isnull(SUM(pertnds),0),
		isnull(SUM(pervnds),0),
		isnull(SUM(lsymt),0),
		isnull(SUM(lgkt),0),
		isnull(SUM(lsymv),0),
		isnull(SUM(lgkv),0)
    FROM dataobekt as a join obekt as b on a.kodobk=b.kodobk
    WHERE a.datan=@data
    GROUP BY b.kodorg
	OPEN cur_org	
	FETCH NEXT FROM cur_org INTO @id_org, 
	@sym,@symgv,@symnds,
	@symgvnds,@gkot,@gkgv,@symtv,@symgvs,
	@pert,@pergv,@pgkt,@pgkv,@pertnds,
	@pergvnds,@lsymot,@lgkot,@lsymgv,@lgkgv
	WHILE (@@FETCH_STATUS <> -1)
	BEGIN
		-- Анализ данных
		print 'Считаю '+Cast(@id_org as varchar(4))
		IF (SELECT count(*) FROM dataorg WHERE kodorg = @id_org and datan = @data)=0
			INSERT INTO dataorg (kodorg,datan,datak)
				SELECT kodorg,@data,teplosnab.dbo.end_of_month(@data) FROM org
					WHERE kodorg = @id_org
		UPDATE dataorg 
		SET sym=@sym,sumgv=@symgv,symnds=@symnds,symgvnds=@symgvnds,symtv=@symtv,
    symgvs=@symgvs,perto=@pert,pergv=@pergv,pgkto=@pgkt,pgkvo=@pgkv,
		pertonds=@pertnds,pergvnds=@pergvnds,gkot=@gkot,gkgv=@gkgv,
		lsymot=@lsymot,lgkot=@lgkot,lsymgv=@lsymgv,lgkgv=@lgkgv,
		itog=@symtv+@symgvs+@pert+@pergv
    WHERE kodorg=@id_org and datan=@data 
		FETCH NEXT FROM cur_org INTO @id_org, 
		@sym,@symgv,@symnds,
		@symgvnds,@gkot,@gkgv,@symtv,@symgvs,
		@pert,@pergv,@pgkt,@pgkv,@pertnds,
		@pergvnds,@lsymot,@lgkot,@lsymgv,@lgkgv
	END
	DEALLOCATE cur_org
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[sp_calc_obk]'
GO
ALTER PROCEDURE [dbo].[sp_calc_obk]
@data datetime
AS
	DECLARE @okr int;
    if @data > '30.06.2016'
    	set @okr=2
    else
        set @okr=0
-- Обновляем все объекы, кроме ЖСК
	UPDATE dataobekt
	SET
    symt=round(b.gkt*a.cena,@okr),
		symv=round(b.gkv*a.cena,@okr),
    symtnds=round(b.gkt*a.cena*c.nds/100,@okr),
		symvnds=round(b.gkv*a.cena*c.nds/100,@okr),
    symk=round((b.gkt*a.cena)+(b.gkt*a.cena*c.nds/100),@okr),
		symgv=round((b.gkv*a.cena)+(b.gkv*a.cena*c.nds/100),@okr),
    pertnds=round((b.pert*c.nds/(100+c.nds)),@okr),
		pervnds=round((b.perv*c.nds/(100+c.nds)),@okr),
    rastarift=a.cena
	FROM
    datatarif as a inner join dataobekt as b on (a.datan=b.datan) join
    obekt as c on (a.kodtt=c.kodtt) and (c.kodobk=b.kodobk)
    WHERE (b.datan=@data and c.kodtt<>3) or (b.datan=@data and c.kodtt<>4)
	-- Обновляем ЖСК
	UPDATE dataobekt
		SET symt=round((((b.gkt*a.cena)/(c.spl+c.spll)*c.spl)+((b.gkt*a.cena)/(c.spl+c.spll)*c.spll/2)),@okr),
    		symv=round((((b.gkv*a.cena)/(c.prj+c.prjl)*c.prj)+((b.gkv*a.cena)/(c.prj+c.prjl)*c.prjl/2)),@okr),
    		lgkv=round(b.gkv/(c.prj+c.prjl)*c.prjl,2),
				lgkt=round(b.gkt/(c.spl+c.spll)*c.spll,2),
    		lsymt=round(b.gkt*a.cena/(c.spl+c.spll)*c.spll/2,@okr),
				lsymv=round(b.gkv*a.cena/(c.prj+c.prjl)*c.prjl/2,@okr),
    		symtnds=0,symvnds=0,
    		symk=round((((b.gkt*a.cena)/(c.spl+c.spll)*c.spl)+((b.gkt*a.cena)/(c.spl+c.spll)*c.spll/2)),@okr),
    		symgv=round((((b.gkv*a.cena)/(c.prj+c.prjl)*c.prj)+((b.gkv*a.cena)/(c.prj+c.prjl)*c.prjl/2)),@okr),
    		pertnds=0,pervnds=0,
    		rastarift=a.cena
		FROM 
			datatarif as a inner join dataobekt as b on (a.datan=b.datan) join
    	obekt as c on (a.kodtt=c.kodtt) and (c.kodobk=b.kodobk)
    	WHERE (b.datan=@data and c.kodtt=3) or (b.datan=@data and c.kodtt=4)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[sp_general_report]'
GO
ALTER            PROCEDURE sp_general_report 
	@data1 datetime, @data2 datetime
AS	
	IF EXISTS(SELECT name 
	  FROM 	 sysobjects 
	  WHERE  name = N'gen_report_ot' 
	  AND 	 type = 'U')
    DROP TABLE gen_report_ot
	CREATE TABLE gen_report_ot 
	(kod int, nazv varchar(100),gk decimal(15,2),tarif decimal(15,2),kod_tarif int,
	 sum_nac decimal(20,2),sum_nds decimal(20,2),
	 per_gk	decimal(15,2),sum_per decimal(20,2),razn decimal(20,2),tip int)
	-- Собираем сведения
	DECLARE @i integer
	DECLARE @kod int, @nazv varchar(100),@gk decimal(15,2),@tarif decimal(15,2),
	@kod_tarif int,@sum_nac decimal(20,2),@sum_nds decimal(20,2),
	@per_gk decimal(15,2),@sum_per decimal(20,2),@razn decimal(20,2),
	@cena_t decimal(15,2)
	DECLARE @cur_org CURSOR
	-- Выбираем тариф №13
	SELECT @cena_t = AVG(cena) FROM datatarif
		WHERE kodtt = 13 and datan between @data1 and @data2
	SET @i=0
	WHILE @i<4 
	BEGIN 
		SET @cur_org = CURSOR FOR 
			SELECT a.kodorg,a.nazv,
				sum(ISNULL(b.gkot,0)+ISNULL(b.gkgv,0)),				
				sum(b.itog),
				sum(ISNULL(b.symnds,0)+ISNULL(b.symgvnds,0)+ISNULL(b.pertonds,0)+ISNULL(b.pergvnds,0)),
				sum(ISNULL(b.pgkto,0)+ISNULL(b.pgkvo,0)),
				sum(ISNULL(b.perto,0)+ISNULL(b.pergv,0))
				FROM org a,dataorg b 
				WHERE a.kodorg=b.kodorg and a.tiporg = @i 
				and b.datan between @data1 and @data2
				GROUP BY a.kodorg, a.nazv
				HAVING sum(b.itog+ISNULL(b.perto,0)+ISNULL(b.pergv,0)+ISNULL(b.gkot,0)+ISNULL(b.gkgv,0))!=0
				ORDER BY a.nazv 
		OPEN @cur_org		
		FETCH NEXT FROM @cur_org INTO @kod,@nazv,@gk,@sum_nac,@sum_nds,@per_gk,@sum_per
		-- Заполняем данные по организации
		WHILE (@@FETCH_STATUS=0)
		BEGIN
			print @kod
			print @nazv
			print @gk
print @sum_nac
print @sum_nds
print @per_gk
print @sum_per
			INSERT INTO gen_report_ot (kod, nazv,gk,sum_nac,sum_nds,per_gk,sum_per,tip)
			VALUES (@kod, @nazv,@gk,@sum_nac,@sum_nds,@per_gk,@sum_per,@i)

			-- Заполняем данные по объектам
			INSERT INTO gen_report_ot (kod, nazv,gk,tarif,kod_tarif,sum_nac,sum_nds,
									per_gk,sum_per,tip)
			SELECT @kod, a.nazt,SUM(ISNULL(b.gkt,0)+ISNULL(b.gkv,0)),c.cena,a.kodtt,
						 SUM(ISNULL(b.symk,0)+ISNULL(b.symgv,0)),
						 SUM(ISNULL(b.symtnds,0)+ISNULL(b.symvnds,0)+
             ISNULL(b.pertnds,0)+ISNULL(b.pervnds,0)),
						 SUM(ISNULL(b.pgkt,0)+ISNULL(b.pgkv,0)),
						 SUM(ISNULL(b.pert,0)+ISNULL(b.perv,0)),@i+10						 								 
			FROM tarift a,dataobekt b,datatarif c,obekt d
			WHERE a.kodtt = d.kodtt and b.datan = c.datan and
						a.kodtt = c.kodtt and b.kodobk = d.kodobk and d.kodorg = @kod
						and b.datan between @data1 and @data2
			GROUP BY a.nazt,c.cena,a.kodtt
			ORDER BY a.kodtt

			-- Обновляем разницу
			
			UPDATE gen_report_ot 
			SET razn = round((@cena_t-tarif)*gk,0)
			WHERE kod_tarif = 10 and tip = @i+10 and kod = @kod

			FETCH NEXT FROM @cur_org INTO @kod,@nazv,@gk,@sum_nac,@sum_nds,@per_gk,@sum_per					
		END
		CLOSE @cur_org
		DEALLOCATE @cur_org		
		-- Заполняем итоги
		IF @i = 0
			SET @nazv = 'ИТОГО ПО БЮДЖЕТУ:'
		IF @i = 1
			SET @nazv = 'ИТОГО ПО ХОЗРАСЧЕТУ:'
		IF @i = 2
			SET @nazv = 'ИТОГО ПО ЖСК:'
		IF @i = 3
			SET @nazv = 'ИТОГО ПО ЖСК - БСХА:'
		INSERT INTO gen_report_ot (nazv,gk,sum_nac,sum_nds,per_gk,sum_per,tip)
		SELECT @nazv,SUM(gk),SUM(sum_nac),SUM(sum_nds),SUM(per_gk),
					 SUM(sum_per),@i+20
		FROM gen_report_ot WHERE tip = @i
	  SELECT @razn = SUM(razn) FROM gen_report_ot WHERE tip = @i+10		
		UPDATE gen_report_ot SET razn = @razn WHERE tip = @i+20
		SET @i = @i+1
	END
	SET @nazv = 'ИТОГО ПО ПРЕДПРИЯТИЮ:'
	INSERT INTO gen_report_ot (nazv,gk,sum_nac,sum_nds,per_gk,sum_per,tip)
	SELECT @nazv,SUM(gk),SUM(sum_nac),SUM(sum_nds),SUM(per_gk),
				 SUM(sum_per),30
	FROM gen_report_ot
	WHERE (tip < 4)
	SELECT @razn = SUM(razn) FROM gen_report_ot 
	WHERE (tip > 19) and (tip < 30)
	UPDATE gen_report_ot SET razn = @razn WHERE tip = 30
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[sp_create_sf]'
GO

ALTER   PROCEDURE sp_create_sf
	@kod int = -1, @data datetime
AS
	declare @cnt integer,
    @idx float,
    @stavka decimal(2),
	@kodorg int,
	@cur_org CURSOR
	delete from schet
	IF @kod=-1
	BEGIN
		SET @cur_org = CURSOR FOR
			SELECT kodorg FROM org
		OPEN @cur_org
		FETCH NEXT FROM @cur_org INTO @kodorg
		WHILE @@FETCH_STATUS=0
		BEGIN 
	  	select @cnt = tiporg from org where kodorg=@kodorg
  		if @cnt<2 
        	if YEAR(@data) < 2010
	            set @stavka = 18
            else
                set @stavka = 20    
  		else 
            set @stavka=0
  		delete from schet where kodorg=@kodorg
		-- Добавляем записи в таблицу SCHET
		INSERT INTO schet
		SELECT 'Отпуск тепловой энергии','Гкал',
					sum(b.gkt+b.gkv+b.pgkt+b.pgkv) as kol,
					0 as tarif,
					sum(b.symt+b.symv+(b.pert-b.pertnds)+(b.perv-b.pervnds)) as sum_b_nds,
					@stavka,
          sum(b.symtnds+b.symvnds+b.pertnds+b.pervnds) as nds,
					sum(b.symk+b.symgv+b.pert+b.perv) as sum_s_nds,
					a.kodorg,GetDate(),1,null,a.nazv,a.adres,a.unn,a.rschet,c.nazv_bank
				FROM org a,dataobekt b,bank c,obekt d
				WHERE a.kodorg = d.kodorg and d.kodobk = b.kodobk and a.kodbank = c.kod_bank
							and b.datan = @data and a.kodorg = @kodorg
				GROUP BY a.kodorg,a.nazv,a.adres,a.unn,a.rschet,c.nazv_bank
				HAVING sum(b.symt+b.symv+(b.pert-b.pertnds)+(b.perv-b.pervnds))<>0

		select @idx = symidx from dataorg where kodorg = @kodorg and datan = @data
		if @idx > 0 
          INSERT INTO schet (usluga, ed_izm, sum_b_nds, nds, sum_s_nds, 
          	kodorg, data_sf, kodusl, period, nazv_org, adres_org, unn_org,
            rs_org, bank_org)        
          SELECT 'Индексация (теплоснаб.)','руб.',                      
            (b.symidx - b.ndsidx), b.ndsidx, b.symidx,
            a.kodorg, GetDate(), 2, null, a.nazv, a.adres, a.unn, a.rschet, c.nazv_bank
                  FROM org a, dataorg b, bank c 
                  WHERE a.kodorg = b.kodorg and a.kodbank = c.kod_bank
                  	and b.datan = @data and a.kodorg = @kodorg
		
        INSERT INTO schet            
  		SELECT 'Отпуск холодной воды','Куб.м.',
					sum(b.kybv+b.pkybv) as kol,
					0 as tarif,
					sum(b.symh+(b.perh-b.perhnds)) as sum_b_nds,@stavka,
          sum(b.symhnds+b.perhnds) as nds,
					sum(b.symhs+b.perh) as sum_s_nds,
					a.kodorg,GetDate(),3,null,a.nazv,a.adres,a.unn,a.rschet,c.nazv_bank
				FROM org a,dataobekt b,bank c,obekt d
				WHERE a.kodorg = d.kodorg and d.kodobk = b.kodobk and a.kodbank = c.kod_bank
							and b.datan = @data and a.kodorg = @kodorg
				GROUP BY a.kodorg,a.nazv,a.adres,a.unn,a.rschet,c.nazv_bank
				HAVING sum(b.symh+(b.perh-b.perhnds))<>0
		
        select @idx = symidxv from dataorg where kodorg = @kodorg and datan = @data
		if @idx > 0
          INSERT INTO schet (usluga, ed_izm, sum_b_nds, nds, sum_s_nds, 
          	kodorg, data_sf, kodusl, period, nazv_org, adres_org, unn_org,
            rs_org, bank_org)        
          SELECT 'Индексация (водоснабжение)','руб.',                      
            (b.symidxv - b.ndsidxv), b.ndsidxv, b.symidxv,
            a.kodorg, GetDate(), 4, null, a.nazv, a.adres, a.unn, a.rschet, c.nazv_bank
                  FROM org a, dataorg b, bank c 
                  WHERE a.kodorg = b.kodorg and a.kodbank = c.kod_bank
                  	and b.datan = @data and a.kodorg = @kodorg
        
        INSERT INTO schet
  		SELECT 'Пропуск сточных вод','Куб.м.',
					sum(b.kybk+b.pkybk) as kol,
					0 as tarif,
					sum(b.symkk+(b.perk-b.perknds)) as sum_b_nds,@stavka,
          sum(b.symknds+b.perknds) as nds,
					sum(b.symks+b.perk) as sum_s_nds,
					a.kodorg,GetDate(),5,null,a.nazv,a.adres,a.unn,a.rschet,c.nazv_bank
				FROM org a,dataobekt b,bank c,obekt d
				WHERE a.kodorg = d.kodorg and d.kodobk = b.kodobk and a.kodbank = c.kod_bank
							and b.datan = @data and a.kodorg = @kodorg
				GROUP BY a.kodorg,a.nazv,a.adres,a.unn,a.rschet,c.nazv_bank
				HAVING sum(b.symkk+(b.perk-b.perknds))<>0
                
        select @idx = symidxk from dataorg where kodorg = @kodorg and datan = @data
		if @idx > 0
          INSERT INTO schet (usluga, ed_izm, sum_b_nds, nds, sum_s_nds, 
          	kodorg, data_sf, kodusl, period, nazv_org, adres_org, unn_org,
            rs_org, bank_org)        
          SELECT 'Индексация (водоотведение)','руб.',                      
            (b.symidxk - b.ndsidxk), b.ndsidxk, b.symidxk,
            a.kodorg, GetDate(), 6, null, a.nazv, a.adres, a.unn, a.rschet, c.nazv_bank
                  FROM org a, dataorg b, bank c 
                  WHERE a.kodorg = b.kodorg and a.kodbank = c.kod_bank
                  	and b.datan = @data and a.kodorg = @kodorg        
                
        INSERT INTO schet        
		SELECT 'Вывоз мусора','Куб.м.',
					sum(b.kybg+b.pkybg) as kol,
					0 as tarif,
					sum(b.symg+(b.perg-b.pergnds)) as sum_b_nds,
                    @stavka,
          			sum(b.symgnds+b.pergnds) as nds,
					sum(b.symgs+b.perg) as sum_s_nds,
					a.kodorg,GetDate(),7,null,a.nazv,a.adres,a.unn,a.rschet,c.nazv_bank
				FROM org a,dataobekt b,bank c,obekt d
				WHERE a.kodorg = d.kodorg and d.kodobk = b.kodobk and a.kodbank = c.kod_bank
							and b.datan = @data and a.kodorg = @kodorg
				GROUP BY a.kodorg,a.nazv,a.adres,a.unn,a.rschet,c.nazv_bank
				HAVING sum(b.symg+(b.perg-b.pergnds))<>0
                
        	-- Следующая запись
			FETCH NEXT FROM @cur_org INTO @kodorg
  	END
		CLOSE @cur_org
		DEALLOCATE @cur_org
	END
	IF @kod > 0
	BEGIN
		select @cnt = tiporg from org where kodorg=@kod
  		if @cnt<2 
        	if YEAR(@data) < 2010
	            set @stavka = 18
            else
                set @stavka = 20    
  		else 
            set @stavka=0
  		delete from schet where kodorg=@kod
		
        -- Добавляем записи в таблицу SCHET        
		INSERT INTO schet
		SELECT 'Отпуск тепловой энергии','Гкал',
			sum(b.gkt+b.gkv+b.pgkt+b.pgkv) as kol,
			0 as tarif,
			sum(b.symt+b.symv+(b.pert-b.pertnds)+(b.perv-b.pervnds)) as sum_b_nds,
			@stavka,
        	sum(b.symtnds+b.symvnds+b.pertnds+b.pervnds) as nds,
			sum(b.symk+b.symgv+b.pert+b.perv) as sum_s_nds,
			a.kodorg,GetDate(),1,null,a.nazv,a.adres,a.unn,a.rschet,c.nazv_bank
			FROM org a,dataobekt b,bank c,obekt d
			WHERE a.kodorg = d.kodorg and d.kodobk = b.kodobk and a.kodbank = c.kod_bank
				and b.datan = @data and a.kodorg = @kod
			GROUP BY a.kodorg,a.nazv,a.adres,a.unn,a.rschet,c.nazv_bank
			HAVING sum(b.symt+b.symv+(b.pert-b.pertnds)+(b.perv-b.pervnds))<>0
		
        select @idx = symidx from dataorg where kodorg = @kod and datan = @data
		if @idx > 0
          INSERT INTO schet (usluga, ed_izm, sum_b_nds, nds, sum_s_nds, 
          	kodorg, data_sf, kodusl, period, nazv_org, adres_org, unn_org,
            rs_org, bank_org)        
          SELECT 'Индексация (теплоснаб.)','руб.',                      
            (b.symidx - b.ndsidx), b.ndsidx, b.symidx,
            a.kodorg, GetDate(), 2, null, a.nazv, a.adres, a.unn, a.rschet, c.nazv_bank
                  FROM org a, dataorg b, bank c 
                  WHERE a.kodorg = b.kodorg and a.kodbank = c.kod_bank
                  	and b.datan = @data and a.kodorg = @kod
        
		INSERT INTO schet
  		SELECT 'Отпуск холодной воды','Куб.м.',
			sum(b.kybv+b.pkybv) as kol,
			0 as tarif,
			sum(b.symh+(b.perh-b.perhnds)) as sum_b_nds,@stavka,
         	sum(b.symhnds+b.perhnds) as nds,
			sum(b.symhs+b.perh) as sum_s_nds,
			a.kodorg,GetDate(),3,null,a.nazv,a.adres,a.unn,a.rschet,c.nazv_bank
			FROM org a,dataobekt b,bank c,obekt d
			WHERE a.kodorg = d.kodorg and d.kodobk = b.kodobk and a.kodbank = c.kod_bank
				and b.datan = @data and a.kodorg = @kod
			GROUP BY a.kodorg,a.nazv,a.adres,a.unn,a.rschet,c.nazv_bank
			HAVING sum(b.symh+(b.perh-b.perhnds))<>0
		
        select @idx = symidxv from dataorg where kodorg = @kod and datan = @data
		if @idx > 0
          INSERT INTO schet (usluga, ed_izm, sum_b_nds, nds, sum_s_nds, 
          	kodorg, data_sf, kodusl, period, nazv_org, adres_org, unn_org,
            rs_org, bank_org)        
          SELECT 'Индексация (водоснабжение)','руб.',                      
            (b.symidxv - b.ndsidxv), b.ndsidxv, b.symidxv,
            a.kodorg, GetDate(), 4, null, a.nazv, a.adres, a.unn, a.rschet, c.nazv_bank
                  FROM org a, dataorg b, bank c 
                  WHERE a.kodorg = b.kodorg and a.kodbank = c.kod_bank
                  	and b.datan = @data and a.kodorg = @kod
        
	    INSERT INTO schet
  		SELECT 'Пропуск сточных вод','Куб.м.',
			sum(b.kybk+b.pkybk) as kol,
			0 as tarif,
			sum(b.symkk+(b.perk-b.perknds)) as sum_b_nds,@stavka,
        	sum(b.symknds+b.perknds) as nds,
			sum(b.symks+b.perk) as sum_s_nds,
		  	a.kodorg,GetDate(),5,null,a.nazv,a.adres,a.unn,a.rschet,c.nazv_bank
			FROM org a,dataobekt b,bank c,obekt d
			WHERE a.kodorg = d.kodorg and d.kodobk = b.kodobk and a.kodbank = c.kod_bank
				and b.datan = @data and a.kodorg = @kod
			GROUP BY a.kodorg,a.nazv,a.adres,a.unn,a.rschet,c.nazv_bank
			HAVING sum(b.symkk+(b.perk-b.perknds))<>0
    	
        select @idx = symidxk from dataorg where kodorg = @kod and datan = @data
		if @idx > 0
          INSERT INTO schet (usluga, ed_izm, sum_b_nds, nds, sum_s_nds, 
          	kodorg, data_sf, kodusl, period, nazv_org, adres_org, unn_org,
            rs_org, bank_org)        
          SELECT 'Индексация (водоотведение)','руб.',                      
            (b.symidxk - b.ndsidxk), b.ndsidxk, b.symidxk,
            a.kodorg, GetDate(), 6, null, a.nazv, a.adres, a.unn, a.rschet, c.nazv_bank
                  FROM org a, dataorg b, bank c 
                  WHERE a.kodorg = b.kodorg and a.kodbank = c.kod_bank
                  	and b.datan = @data and a.kodorg = @kod
        
	    INSERT INTO schet
  		SELECT 'Вывоз мусора','Куб.м.',
			sum(b.kybg+b.pkybg) as kol,
			0 as tarif,
			sum(b.symg+(b.perg-b.pergnds)) as sum_b_nds,@stavka,
         	sum(b.symgnds+b.pergnds) as nds,
			sum(b.symgs+b.perg) as sum_s_nds,
			a.kodorg,GetDate(),7,null,a.nazv,a.adres,a.unn,a.rschet,c.nazv_bank
			FROM org a,dataobekt b,bank c,obekt d
			WHERE a.kodorg = d.kodorg and d.kodobk = b.kodobk and a.kodbank = c.kod_bank
				and b.datan = @data and a.kodorg = @kod
			GROUP BY a.kodorg,a.nazv,a.adres,a.unn,a.rschet,c.nazv_bank
			HAVING sum(b.symg+(b.perg-b.pergnds))<>0 
                
                           
	END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[sp_ob_svod_vk]'
GO
ALTER         PROCEDURE sp_ob_svod_vk
	@data1 datetime, @data2 datetime
AS
	IF EXISTS(SELECT name 
	  FROM 	 sysobjects 
	  WHERE  name = N'gen_report_vk' 
	  AND 	 type = 'U')
    DROP TABLE gen_report_vk
    print 'Удалили таблу'
	CREATE TABLE gen_report_vk 
	(kod int, nazv char(100),kv decimal(15,2),tarifv decimal(15,3),kod_tarifv int,
	 sum_nacv decimal(20,2),sum_ndsv decimal(20,2),
	 per_kv	decimal(15,2),sum_perv decimal(20,2),raznv decimal(20,2),
	 kk decimal(15,2),tarifk decimal(15,2),kod_tarifk int,
	 sum_nack decimal(20,2),sum_ndsk decimal(20,2),
	 per_kk	decimal(15,2),sum_perk decimal(20,2),raznk decimal(20,2),
	 tip int)
    print 'Создали таблу' 
	-- Собираем сведения
	DECLARE @i integer
	DECLARE @kod int, @nazv varchar(100),@kv decimal(15,2),@tarifv decimal(15,3),
	@kod_tarifv int,@sum_nacv decimal(20,2),@sum_ndsv decimal(20,2),
	@per_kv decimal(15,2),@sum_perv decimal(20,2),@raznv decimal(20,2),
	@cena_v decimal(15,2),
  @kk decimal(15,2),@tarifk decimal(15,3),
	@kod_tarifk int,@sum_nack decimal(20,2),@sum_ndsk decimal(20,2),
	@per_kk decimal(15,2),@sum_perk decimal(20,2),@raznk decimal(20,2),
	@cena_k decimal(15,2)
	DECLARE @cur_org CURSOR
	-- Выбираем тариф №13
	SELECT @cena_v = AVG(cenav),@cena_k = AVG(cenak)  FROM datatarifv
		WHERE kodtv = 8 and datan between @data1 and @data2
    print 'Выбрали тариф'    
	SET @i=0
	WHILE @i<4 
	BEGIN 
		SET @cur_org = CURSOR FOR 
			SELECT a.kodorg,a.nazv,
				sum(ISNULL(b.skybv,0)),				
				sum(b.itogv),
				sum(ISNULL(b.sumvnds,0)+ISNULL(b.perhonds,0)),
				sum(ISNULL(b.pkybvo,0)),
				sum(ISNULL(b.perho,0)),
				sum(ISNULL(b.skybk,0)),				
				sum(b.itogk),
				sum(ISNULL(b.sumknds,0)+ISNULL(b.perkonds,0)),
				sum(ISNULL(b.pkybko,0)),
				sum(ISNULL(b.perko,0))
				FROM org a,dataorg b 
				WHERE a.kodorg=b.kodorg and a.tiporg = @i 
				and b.datan between @data1 and @data2
				GROUP BY a.kodorg, a.nazv
				HAVING sum(ISNULL(b.skybv,0))+sum(ISNULL(b.skybk,0))+sum(ISNULL(b.perho,0))+sum(ISNULL(b.perko,0)) !=0
				ORDER BY a.nazv 				
		OPEN @cur_org		
		FETCH NEXT FROM @cur_org INTO 
		@kod,@nazv,@kv,@sum_nacv,@sum_ndsv,@per_kv,@sum_perv,
		@kk,@sum_nack,@sum_ndsk,@per_kk,@sum_perk
		print 'Заполняем данные по организации '+cast(@kod as varchar(5))
		WHILE (@@FETCH_STATUS=0)
		BEGIN
            print 'Пытаюсь вставить'
			INSERT INTO gen_report_vk (kod, nazv,kv,sum_nacv,sum_ndsv,per_kv,sum_perv,
			kk,sum_nack,sum_ndsk,per_kk,sum_perk,tip)
			VALUES (@kod, @nazv,@kv,@sum_nacv,@sum_ndsv,@per_kv,@sum_perv,
			@kk,@sum_nack,@sum_ndsk,@per_kk,@sum_perk,@i)
			print 'Заполняем данные по объектам'
			INSERT INTO gen_report_vk (kod, nazv,
									kv,tarifv,kod_tarifv,
									sum_nacv,sum_ndsv,
									per_kv,sum_perv,
									kk,tarifk,kod_tarifk,sum_nack,sum_ndsk,
									per_kk,sum_perk,tip)
			SELECT @kod, a.nazt,
						 SUM(ISNULL(b.kybv,0)),c.cenav,a.kodtv,
						 SUM(ISNULL(b.symhs,0)),SUM(ISNULL(b.symhnds,0)+ISNULL(b.perhnds,0)),
						 SUM(ISNULL(b.pkybv,0)),SUM(ISNULL(b.perh,0)),
						 SUM(ISNULL(b.kybk,0)),c.cenak,a.kodtv,
						 SUM(ISNULL(b.symks,0)),SUM(ISNULL(b.symknds,0)+ISNULL(b.perknds,0)),
						 SUM(ISNULL(b.pkybk,0)),SUM(ISNULL(b.perk,0)),	
						 @i+10						 								 
			FROM tarifv a,dataobekt b,datatarifv c,obekt d
			WHERE a.kodtv = d.kodtv and b.datan = c.datan and
						a.kodtv = c.kodtv and b.kodobk = d.kodobk and d.kodorg = @kod
						and b.datan between @data1 and @data2
			GROUP BY a.nazt,c.cenav,a.kodtv,c.cenak
			ORDER BY a.kodtv
            print 'Заполнили по организации '+cast(@kod as varchar(5))
			-- Обновляем разницу
			/*SELECT @raznv = ROUND(@cena_v*SUM(ISNULL(b.kybv,0))
						 -SUM(ISNULL(b.symhs,0)),0),
						 @raznv = ROUND(@cena_k*SUM(ISNULL(b.kybk,0))
						 -SUM(ISNULL(b.symks,0)),0)
			FROM obekt a,dataobekt b WHERE a.kodobk = b.kodobk and a.kodtv = 7
					 and b.datan between @data1 and @data2 and a.kodorg = @kod*/
			print 'Обновляем по объектам'                     
			UPDATE gen_report_vk 
			SET raznv = round((@cena_v-tarifv)*kv,0), 
			raznk = round((@cena_k-tarifk)*kk,0)
			WHERE kod_tarifv = 7 and tip = @i+10 and kod = @kod
			FETCH NEXT FROM @cur_org INTO 
			@kod,@nazv,@kv,@sum_nacv,@sum_ndsv,@per_kv,@sum_perv,
			@kk,@sum_nack,@sum_ndsk,@per_kk,@sum_perk
			print 'Следующая '+cast(@kod as varchar(5))
		END
		CLOSE @cur_org
		DEALLOCATE @cur_org		
		-- Заполняем итоги
		IF @i = 0
			SET @nazv = 'ИТОГО ПО БЮДЖЕТУ:'
		IF @i = 1
			SET @nazv = 'ИТОГО ПО ХОЗРАСЧЕТУ:'
		IF @i = 2
			SET @nazv = 'ИТОГО ПО ЖСК:'
		IF @i = 3
			SET @nazv = 'ИТОГО ПО ЖСК - БСХА:'
		INSERT INTO gen_report_vk (nazv,kv,sum_nacv,sum_ndsv,per_kv,sum_perv,
		kk,sum_nack,sum_ndsk,per_kk,sum_perk,tip)
		SELECT @nazv,SUM(kv),SUM(sum_nacv),SUM(sum_ndsv),SUM(per_kv),SUM(sum_perv),
					 SUM(kk),SUM(sum_nack),SUM(sum_ndsk),SUM(per_kk),SUM(sum_perk),@i+20
		FROM gen_report_vk WHERE tip = @i
	  SELECT @raznv = SUM(raznv),@raznk = SUM(raznk)
		FROM gen_report_vk WHERE tip = @i+10		
		UPDATE gen_report_vk SET raznv = @raznv,raznk = @raznk  WHERE tip = @i+20
		SET @i = @i+1
	END
	SET @nazv = 'ИТОГО ПО ПРЕДПРИЯТИЮ:'
	INSERT INTO gen_report_vk (nazv,kv,sum_nacv,sum_ndsv,per_kv,sum_perv,
		kk,sum_nack,sum_ndsk,per_kk,sum_perk,tip)
		SELECT @nazv,SUM(kv),SUM(sum_nacv),SUM(sum_ndsv),SUM(per_kv),SUM(sum_perv),
					 SUM(kk),SUM(sum_nack),SUM(sum_ndsk),SUM(per_kk),SUM(sum_perk),30
	FROM gen_report_vk
	WHERE (tip < 4)
    
	SELECT @raznv = SUM(raznv),@raznk = SUM(raznk)
	FROM gen_report_vk 
	WHERE (tip > 19) and (tip < 30)
	UPDATE gen_report_vk SET raznv = @raznv,raznk = @raznk WHERE tip = 30
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[sp_ras_nac]'
GO
ALTER   PROCEDURE sp_ras_nac
	@data1 datetime, @data2 datetime
AS
	IF EXISTS(SELECT name 
	  FROM 	 sysobjects 
	  WHERE  name = N'ras_nac_ot' 
	  AND 	 type = 'U')
    DROP TABLE ras_nac_ot
	CREATE TABLE ras_nac_ot
	(nazv char(50),tarif decimal(15,2),kod_tarif int,gk decimal(15,2),
	 sum_nac decimal(20,2),per_gk	decimal(15,2),sum_per decimal(20,2))
	INSERT INTO ras_nac_ot
	SELECT
		a.nazt,AVG(b.cena),a.kodtt,
		SUM(ISNULL(c.gkt,0)+ISNULL(c.gkv,0)),
		SUM(ISNULL(c.symk,0)+ISNULL(c.symgv,0)),
		SUM(ISNULL(c.pgkt,0)+ISNULL(c.pgkv,0)),
		SUM(ISNULL(c.pert,0)+ISNULL(c.perv,0))
	FROM tarift a, datatarif b, dataobekt c, obekt d
	WHERE a.kodtt = b.kodtt and a.kodtt = d.kodtt and
				b.datan = c.datan and c.kodobk = d.kodobk
				and b.datan between @data1 and @data2
	GROUP BY a.nazt, a.kodtt
	HAVING (SUM(ISNULL(c.gkt,0)+ISNULL(c.gkv,0))+
				 SUM(ISNULL(c.symk,0)+ISNULL(c.symgv,0))+
				 SUM(ISNULL(c.pgkt,0)+ISNULL(c.pgkv,0))+
				 SUM(ISNULL(c.pert,0)+ISNULL(c.perv,0))) !=0
	ORDER BY a.kodtt
	-- Добавляем итог по населению
	INSERT INTO ras_nac_ot
	SELECT
		'ИТОГО население',Null,Null,
		SUM(gk),SUM(sum_nac),SUM(per_gk),SUM(sum_per)
	FROM ras_nac_ot
	WHERE kod_tarif IN (8,9)
	-- Добавляем итог по ЖСК
	INSERT INTO ras_nac_ot
	SELECT
		'ИТОГО ЖСК + вед.',Null,Null,
		SUM(gk),SUM(sum_nac),SUM(per_gk),SUM(sum_per)
	FROM ras_nac_ot
	WHERE kod_tarif IN (3,4,10)
	-- Добавляем итог по организациям
	INSERT INTO ras_nac_ot
	SELECT
		'ИТОГО организации',Null,Null,
		SUM(gk),SUM(sum_nac),SUM(per_gk),SUM(sum_per)
	FROM ras_nac_ot
	WHERE kod_tarif NOT IN (3,4,8,9,10)
	-- Добавляем итог
	INSERT INTO ras_nac_ot
	SELECT
		'ВСЕГО:',Null,Null,
		SUM(gk),SUM(sum_nac),SUM(per_gk),SUM(sum_per)
	FROM ras_nac_ot
	WHERE kod_tarif Is Not Null
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[sp_ras_nac_vk]'
GO
ALTER  PROCEDURE sp_ras_nac_vk
@data1 datetime, @data2 datetime
AS
	IF EXISTS(SELECT name 
	  FROM 	 sysobjects 
	  WHERE  name = N'ras_nac_vk' 
	  AND 	 type = 'U')
    DROP TABLE ras_nac_vk
	CREATE TABLE ras_nac_vk
	(nazv char(50),tarifv decimal(15,2),kod_tarif int,kybv decimal(15,2),
	 sum_nacv decimal(20,2),per_kv	decimal(15,2),sum_perv decimal(20,2),
	 tarifk decimal(15,2),kybk decimal(15,2),
	 sum_nack decimal(20,2),per_kk	decimal(15,2),sum_perk decimal(20,2))
	INSERT INTO ras_nac_vk
	SELECT
		a.nazt,AVG(b.cenav),a.kodtv,
		SUM(ISNULL(c.kybv,0)),
		SUM(ISNULL(c.symhs,0)),
		SUM(ISNULL(c.pkybv,0)),
		SUM(ISNULL(c.perh,0)),
		AVG(b.cenak),
		SUM(ISNULL(c.kybk,0)),
		SUM(ISNULL(c.symks,0)),
		SUM(ISNULL(c.pkybk,0)),
		SUM(ISNULL(c.perk,0))
	FROM tarifv a, datatarifv b, dataobekt c, obekt d
	WHERE a.kodtv = b.kodtv and a.kodtv = d.kodtv and
				b.datan = c.datan and c.kodobk = d.kodobk
				and b.datan between @data1 and @data2
	GROUP BY a.nazt, a.kodtv
	HAVING (SUM(ISNULL(c.kybv,0))+
					SUM(ISNULL(c.symhs,0))+
					SUM(ISNULL(c.pkybv,0))+
					SUM(ISNULL(c.perh,0))+
					SUM(ISNULL(c.kybk,0))+
					SUM(ISNULL(c.symks,0))+
					SUM(ISNULL(c.pkybk,0))+
					SUM(ISNULL(c.perk,0))) !=0
	ORDER BY a.kodtv
	-- Добавляем итог по населению
	INSERT INTO ras_nac_vk
	SELECT
		'ИТОГО население',Null,Null,
		SUM(kybv),SUM(sum_nacv),SUM(per_kv),SUM(sum_perv),
		Null,SUM(kybk),SUM(sum_nack),SUM(per_kk),SUM(sum_perk)
	FROM ras_nac_vk
	WHERE kod_tarif = 5
	-- Добавляем итог по ЖСК
	INSERT INTO ras_nac_vk
	SELECT
		'ИТОГО ЖСК + вед.',Null,Null,
		SUM(kybv),SUM(sum_nacv),SUM(per_kv),SUM(sum_perv),
		Null,SUM(kybk),SUM(sum_nack),SUM(per_kk),SUM(sum_perk)
	FROM ras_nac_vk
	WHERE kod_tarif in (3,12,15,16,17,7,19)
	-- Добавляем итог по организациям
	INSERT INTO ras_nac_vk
	SELECT
		'ИТОГО организации',Null,Null,
		SUM(kybv),SUM(sum_nacv),SUM(per_kv),SUM(sum_perv),
		Null,SUM(kybk),SUM(sum_nack),SUM(per_kk),SUM(sum_perk)
	FROM ras_nac_vk
	WHERE kod_tarif NOT IN (3,5,12,15,16,17,7,19)
	-- Добавляем итог
	INSERT INTO ras_nac_vk
	SELECT
		'ВСЕГО:',Null,Null,
		SUM(kybv),SUM(sum_nacv),SUM(per_kv),SUM(sum_perv),
		Null,SUM(kybk),SUM(sum_nack),SUM(per_kk),SUM(sum_perk)
	FROM ras_nac_vk
	WHERE kod_tarif Is Not Null
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[sp_ras_kot_ot]'
GO
ALTER   PROCEDURE sp_ras_kot_ot 
	@data1 datetime, @data2 datetime
AS
	DECLARE @cur_kot CURSOR
	DECLARE @kod int
	-- Создаем таблицу
	IF EXISTS(SELECT name 
	  FROM 	 sysobjects 
	  WHERE  name = N'ras_kot_ot' 
	  AND 	 type = 'U')
    DROP TABLE ras_kot_ot
	CREATE TABLE ras_kot_ot 
	(nazv varchar(50),nazv_pot varchar(50),gk decimal(15,2),
	 sum_nac decimal(20,2),per_gk	decimal(15,2),	
	 sum_per decimal(20,2),tip int)
	-- Объявляем курсор
	SET @cur_kot = CURSOR FOR SELECT kodkot FROM koteln ORDER BY kodkot
	OPEN @cur_kot
	FETCH NEXT FROM @cur_kot INTO @kod
	WHILE (@@FETCH_STATUS = 0)
	BEGIN
		-- Данные по населению
		INSERT INTO ras_kot_ot
		SELECT 
			a.nazk,'Население',
			sum(isnull(b.gkt,0)+isnull(b.gkv,0)),
			sum(isnull(b.symk,0)+isnull(b.symgv,0)),
			sum(isnull(b.pgkt,0)+isnull(b.pgkv,0)),
			sum(isnull(b.pert,0)+isnull(b.perv,0)),1
		FROM koteln a, dataobekt b, obekt c
		WHERE a.kodkot = c.kodkot and b.kodobk = c.kodobk
		and c.kodtt in (3,4,8,9,10) and a.kodkot = @kod
		and b.datan between @data1 and @data2
		GROUP BY a.nazk
		HAVING (SUM(ISNULL(b.gkt,0)+ISNULL(b.gkv,0))+
				 SUM(ISNULL(b.symk,0)+ISNULL(b.symgv,0))+
				 SUM(ISNULL(b.pgkt,0)+ISNULL(b.pgkv,0))+
				 SUM(ISNULL(b.pert,0)+ISNULL(b.perv,0))) !=0
		-- Данные по ЖСК
		INSERT INTO ras_kot_ot
		SELECT 
			a.nazk,'в том числе ЖСК + вед.',
			sum(isnull(b.gkt,0)+isnull(b.gkv,0)),
			sum(isnull(b.symk,0)+isnull(b.symgv,0)),
			sum(isnull(b.pgkt,0)+isnull(b.pgkv,0)),
			sum(isnull(b.pert,0)+isnull(b.perv,0)),2
		FROM koteln a, dataobekt b, obekt c
		WHERE a.kodkot = c.kodkot and b.kodobk = c.kodobk
		and c.kodtt in (3,4,10) and a.kodkot = @kod
		and b.datan between @data1 and @data2
		GROUP BY a.nazk
		HAVING (SUM(ISNULL(b.gkt,0)+ISNULL(b.gkv,0))+
				 SUM(ISNULL(b.symk,0)+ISNULL(b.symgv,0))+
				 SUM(ISNULL(b.pgkt,0)+ISNULL(b.pgkv,0))+
				 SUM(ISNULL(b.pert,0)+ISNULL(b.perv,0))) !=0
		-- Данные по организациям
		INSERT INTO ras_kot_ot
		SELECT 
			a.nazk,'Организации',
			sum(isnull(b.gkt,0)+isnull(b.gkv,0)),
			sum(isnull(b.symk,0)+isnull(b.symgv,0)),
			sum(isnull(b.pgkt,0)+isnull(b.pgkv,0)),
			sum(isnull(b.pert,0)+isnull(b.perv,0)),3
		FROM koteln a, dataobekt b, obekt c
		WHERE a.kodkot = c.kodkot and b.kodobk = c.kodobk
		and c.kodtt not in (3,4,8,9,10) and a.kodkot = @kod
		and b.datan between @data1 and @data2
		GROUP BY a.nazk
		HAVING (SUM(ISNULL(b.gkt,0)+ISNULL(b.gkv,0))+
				 SUM(ISNULL(b.symk,0)+ISNULL(b.symgv,0))+
				 SUM(ISNULL(b.pgkt,0)+ISNULL(b.pgkv,0))+
				 SUM(ISNULL(b.pert,0)+ISNULL(b.perv,0))) !=0
		-- Итоги по участку
		INSERT INTO ras_kot_ot
		SELECT 
			a.nazk,'ИТОГО',
			sum(isnull(b.gkt,0)+isnull(b.gkv,0)),
			sum(isnull(b.symk,0)+isnull(b.symgv,0)),
			sum(isnull(b.pgkt,0)+isnull(b.pgkv,0)),
			sum(isnull(b.pert,0)+isnull(b.perv,0)),4
		FROM koteln a, dataobekt b, obekt c
		WHERE a.kodkot = c.kodkot and b.kodobk = c.kodobk
		and a.kodkot = @kod
		and b.datan between @data1 and @data2
		GROUP BY a.nazk
		HAVING (SUM(ISNULL(b.gkt,0)+ISNULL(b.gkv,0))+
				 SUM(ISNULL(b.symk,0)+ISNULL(b.symgv,0))+
				 SUM(ISNULL(b.pgkt,0)+ISNULL(b.pgkv,0))+
				 SUM(ISNULL(b.pert,0)+ISNULL(b.perv,0))) !=0
		-- Следующая запись
		FETCH NEXT FROM @cur_kot INTO @kod
	END
	CLOSE @cur_kot
	DEALLOCATE @cur_kot
	-- ИТОГИ по предприятию
	INSERT INTO ras_kot_ot
	SELECT
		'ВСЕГО','Население',sum(gk),
	 	sum(sum_nac),sum(per_gk),sum(sum_per),11
	FROM ras_kot_ot	
	WHERE tip = 1
	INSERT INTO ras_kot_ot
	SELECT
		'ВСЕГО','в том числе ЖСК + вед.',sum(gk),
	 	sum(sum_nac),sum(per_gk),sum(sum_per),21
	FROM ras_kot_ot	
	WHERE tip = 2
	INSERT INTO ras_kot_ot
	SELECT
		'ВСЕГО','организации',sum(gk),
	 	sum(sum_nac),sum(per_gk),sum(sum_per),31
	FROM ras_kot_ot	
	WHERE tip = 3
	INSERT INTO ras_kot_ot
	SELECT
		'ВСЕГО','ИТОГО',sum(gk),
	 	sum(sum_nac),sum(per_gk),sum(sum_per),41
	FROM ras_kot_ot	
	WHERE tip = 4
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[sp_ras_kot_vk]'
GO
ALTER  PROCEDURE sp_ras_kot_vk 
@data1 datetime, @data2 datetime
AS
	DECLARE @cur_kot CURSOR
	DECLARE @kod int
	-- Создаем таблицу
	IF EXISTS(SELECT name 
	  FROM 	 sysobjects 
	  WHERE  name = N'ras_kot_vk' 
	  AND 	 type = 'U')
    DROP TABLE ras_kot_vk
	CREATE TABLE ras_kot_vk 
	(nazv varchar(50),nazv_pot varchar(50),kybv decimal(15,2),
	 sum_nacv decimal(20,2),per_kv	decimal(15,2),sum_perv decimal(20,2),
	 kybk decimal(15,2),sum_nack decimal(20,2),per_kk	decimal(15,2),
	 sum_perk decimal(20,2),tip int)
	-- Объявляем курсор
	SET @cur_kot = CURSOR FOR SELECT kodkot FROM koteln ORDER BY kodkot
	OPEN @cur_kot
	FETCH NEXT FROM @cur_kot INTO @kod
	WHILE (@@FETCH_STATUS = 0)
	BEGIN
		-- Данные по населению
		INSERT INTO ras_kot_vk
		SELECT 
			a.nazk,'Население',
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
		and c.kodtv in (3,5,7,12,13,18,19) and a.kodkot = @kod
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
		-- Данные по ЖСК
		INSERT INTO ras_kot_vk
		SELECT 
			a.nazk,'в том числе ЖСК + вед.',
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
		and c.kodtv in (3,7,12,13,19) and a.kodkot = @kod
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
		-- Данные по организациям
		INSERT INTO ras_kot_vk
		SELECT 
			a.nazk,'Организации',
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
		and c.kodtv not in (3,5,7,12,13,18,19) and a.kodkot = @kod
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
		-- Итоги по участку
		INSERT INTO ras_kot_vk
		SELECT 
			a.nazk,'ИТОГО',
			sum(isnull(b.kybv,0)),
			sum(isnull(b.symhs,0)),
			sum(isnull(b.pkybv,0)),
			sum(isnull(b.perh,0)),			
			sum(isnull(b.kybk,0)),
			sum(isnull(b.symks,0)),
			sum(isnull(b.pkybk,0)),
			sum(isnull(b.perk,0)),4
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
		-- Следующая запись
		FETCH NEXT FROM @cur_kot INTO @kod
	END
	CLOSE @cur_kot
	DEALLOCATE @cur_kot
	-- ИТОГИ по предприятию
	INSERT INTO ras_kot_vk
	SELECT
		'ВСЕГО','Население',sum(kybv),
	 	sum(sum_nacv),sum(per_kv),sum(sum_perv),
		sum(kybk),sum(sum_nack),sum(per_kk),sum(sum_perk),11
	FROM ras_kot_vk	
	WHERE tip = 1
	INSERT INTO ras_kot_vk
	SELECT
		'ВСЕГО','в том числе ЖСК + вед.',sum(kybv),
	 	sum(sum_nacv),sum(per_kv),sum(sum_perv),
		sum(kybk),sum(sum_nack),sum(per_kk),sum(sum_perk),21
	FROM ras_kot_vk	
	WHERE tip = 2
	INSERT INTO ras_kot_vk
	SELECT
		'ВСЕГО','организации',sum(kybv),
	 	sum(sum_nacv),sum(per_kv),sum(sum_perv),
		sum(kybk),sum(sum_nack),sum(per_kk),sum(sum_perk),31
	FROM ras_kot_vk	
	WHERE tip = 3
	INSERT INTO ras_kot_vk
	SELECT
		'ВСЕГО','ИТОГО',sum(kybv),
	 	sum(sum_nacv),sum(per_kv),sum(sum_perv),
		sum(kybk),sum(sum_nack),sum(per_kk),sum(sum_perk),41
	FROM ras_kot_vk	
	WHERE tip = 4
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[sp_predoplata]'
GO
ALTER  PROCEDURE sp_predoplata
	@kod int, @data datetime
AS
	IF EXISTS (SELECT name
			FROM sysobjects
			WHERE name = N'tPredoplata'
			AND type = 'U')
		DROP TABLE tPredoplata
	CREATE TABLE tPredoplata
		(kodorg int, 
		 sum_t decimal(20,2), sum_v decimal(20,2), sum_k decimal(20,2), sum_g decimal(20,2),
		 fsum_t decimal(20,2), fsum_v decimal(20,2), fsum_k decimal(20,2), fsum_g decimal(20,2),
		 psum_t decimal(6,2), psum_v decimal(6,2), psum_k decimal(6,2), psum_g decimal(6,2))
	-- Выбираем данные по начислениям
	INSERT INTO tPredoplata (kodorg, sum_t, sum_v, sum_k, sum_g)
		SELECT kodorg, isnull(symtv+symgvs,0), isnull(sumvv,0), isnull(sumkk,0), isnull(sumgg,0)
		FROM dataorg
		WHERE datan = @data and kodorg = @kod
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[sp_create_sf_pred]'
GO
ALTER       PROCEDURE sp_create_sf_pred
	@kod int = -1, @data datetime
AS
	declare @cnt integer,
    @stavka decimal(2),
    @okr int,
	@kodorg int,
	@cur_org CURSOR
	
    if @data > '30.06.2016'
    	set @okr=2
    else
     	set @okr=0    
        
    IF @kod > 0
	BEGIN
		select @cnt = tiporg from org where kodorg=@kod
  	if @cnt<2 
        	if YEAR(@data) < 2010
	            set @stavka = 18
            else
                set @stavka = 20    
  		else 
            set @stavka=0
		-- Создаем таблицу для предоплаты		
		IF EXISTS (SELECT name FROM sysobjects
			WHERE  name = N'pr_obekt' 
	  	AND 	 type = 'U')
    DROP TABLE pr_obekt 
		SELECT a.* INTO pr_obekt FROM dataobekt a, obekt b
			WHERE a.kodobk = b.kodobk and a.datan = @data and b.kodorg = @kod
		-- Обновляем ее
		UPDATE pr_obekt 
			SET 
				-- Тепло
				gkt = round(gkt*psum_t,2),
				gkv = round(gkv*psum_t,2),
				symt = round(symt*psum_t,@okr),
				symv = round(symv*psum_t,@okr),
				symtnds = round(symtnds*psum_t,@okr),
				symvnds = round(symvnds*psum_t,@okr),
				symk = round(symk*psum_t,@okr),
				symgv = round(symgv*psum_t,@okr),
				pert = 0, pertnds =0, perv = 0, pervnds = 0,pgkt = 0,pgkv = 0,
				-- Вода
				kybv = round(kybv*psum_v,2),
				kybk = round(kybk*psum_k,2),
				symh = round(symh*psum_v,@okr),
				symkk = round(symkk*psum_k,@okr),
				symhnds = round(symhnds*psum_v,@okr),
				symknds = round(symknds*psum_k,@okr),
				symhs = round(symhs*psum_v,@okr),
				symks = round(symks*psum_k,@okr),
				perh = 0, perk = 0, perhnds = 0, perknds = 0, pkybv = 0, pkybk = 0,
                -- Мусор
				kybg = round(kybg*psum_g,2),
				symg = round(symg*psum_g,@okr),
				symgnds = round(symgnds*psum_g,@okr),
				symgs = round(symgs*psum_g,@okr),
				perg = 0, pergnds = 0, pkybg = 0
		FROM tPredoplata
		
  	delete from schet
		-- Добавляем записи в таблицу SCHET
		INSERT INTO schet
		SELECT 'Отпуск тепловой энергии','Гкал',
				sum(b.gkt+b.gkv) as kol,
				0 as tarif,
				sum(b.symt+b.symv) as sum_b_nds,
				@stavka,
        sum(b.symtnds+b.symvnds) as nds,
				sum(b.symk+b.symgv) as sum_s_nds,
				a.kodorg,GetDate(),1,null,a.nazv,a.adres,a.unn,a.rschet,c.nazv_bank
			FROM org a,pr_obekt b,bank c,obekt d
			WHERE a.kodorg = d.kodorg and d.kodobk = b.kodobk and a.kodbank = c.kod_bank
						and b.datan = @data and a.kodorg = @kod
			GROUP BY a.kodorg,a.nazv,a.adres,a.unn,a.rschet,c.nazv_bank
			HAVING sum(b.symt+b.symv)<>0
		INSERT INTO schet
  	SELECT 'Отпуск холодной воды','Куб.м.',
				sum(b.kybv) as kol,
				0 as tarif,
				sum(b.symh) as sum_b_nds,@stavka,
         sum(b.symhnds) as nds,
				sum(b.symhs) as sum_s_nds,
				a.kodorg,GetDate(),2,null,a.nazv,a.adres,a.unn,a.rschet,c.nazv_bank
			FROM org a,pr_obekt b,bank c,obekt d
			WHERE a.kodorg = d.kodorg and d.kodobk = b.kodobk and a.kodbank = c.kod_bank
						and b.datan = @data and a.kodorg = @kod
			GROUP BY a.kodorg,a.nazv,a.adres,a.unn,a.rschet,c.nazv_bank
			HAVING sum(b.symh)<>0
		INSERT INTO schet
  	SELECT 'Пропуск сточных вод','Куб.м.',
				sum(b.kybk) as kol,
				0 as tarif,
				sum(b.symkk) as sum_b_nds,@stavka,
        sum(b.symknds) as nds,
				sum(b.symks) as sum_s_nds,
		  	a.kodorg,GetDate(),3,null,a.nazv,a.adres,a.unn,a.rschet,c.nazv_bank
			FROM org a,pr_obekt b,bank c,obekt d
			WHERE a.kodorg = d.kodorg and d.kodobk = b.kodobk and a.kodbank = c.kod_bank
						and b.datan = @data and a.kodorg = @kod
			GROUP BY a.kodorg,a.nazv,a.adres,a.unn,a.rschet,c.nazv_bank
			HAVING sum(b.symkk)<>0
            
    INSERT INTO schet
  		SELECT 'Вывоз мусора','Куб.м.',
			sum(b.kybg) as kol,
			0 as tarif,
			sum(b.symg) as sum_b_nds,@stavka,
         	sum(b.symgnds) as nds,
			sum(b.symgs) as sum_s_nds,
			a.kodorg,GetDate(),4,null,a.nazv,a.adres,a.unn,a.rschet,c.nazv_bank
			FROM org a,pr_obekt b,bank c,obekt d
			WHERE a.kodorg = d.kodorg and d.kodobk = b.kodobk and a.kodbank = c.kod_bank
				and b.datan = @data and a.kodorg = @kod
			GROUP BY a.kodorg,a.nazv,a.adres,a.unn,a.rschet,c.nazv_bank
			HAVING sum(b.symg)<>0        
	END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[sp_calc_obk_vk]'
GO
ALTER PROCEDURE [dbo].[sp_calc_obk_vk]
@data datetime
AS
	DECLARE @okr int
    if @data > '30.06.2016'
    	set @okr=2
    else
        set @okr=0
-- Обновляем все объекы, кроме ЖСК
	UPDATE dataobekt
	SET
    symh=round(b.kybv*a.cenav,@okr),
		symkk=round(b.kybk*a.cenak,@okr),
    symhnds=round(b.kybv*a.cenav*c.nds/100,@okr),
		symknds=round(b.kybk*a.cenak*c.nds/100,@okr),
    symhs=round((b.kybv*a.cenav)+(b.kybv*a.cenav*c.nds/100),@okr),
		symks=round((b.kybk*a.cenak)+(b.kybk*a.cenak*c.nds/100),@okr),
    perhnds=round((b.perh*c.nds/(100+c.nds)),@okr),
		perknds=round((b.perk*c.nds/(100+c.nds)),@okr),
    rastarifv=a.cenav,
		rastarifk=a.cenak
	FROM	
		(datatarifv as a join dataobekt as b on (a.datan=b.datan)) join
    obekt as c on(a.kodtv=c.kodtv) and(c.kodobk=b.kodobk) 
  WHERE b.datan=@data and c.kodtv<>3
	-- Обновляем все объекы ЖСК
    UPDATE dataobekt
	SET    
    symhnds=0, symknds=0, symhs = symh, symks = symkk,
    perhnds=0, perknds=0, rastarifv=a.cenav, rastarifk=a.cenak
	FROM	
		(datatarifv as a join dataobekt as b on (a.datan=b.datan)) join
    obekt as c on(a.kodtv=c.kodtv) and(c.kodobk=b.kodobk)
    WHERE b.datan=@data and c.kodtv=3
    
	/*UPDATE dataobekt
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
		(datatarifv as a join dataobekt as b on (a.datan=b.datan)) join
    obekt as c on(a.kodtv=c.kodtv) and(c.kodobk=b.kodobk)
    WHERE b.datan=@data and c.kodtv=3*/
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[sp_calc_org_vk]'
GO
ALTER  PROCEDURE sp_calc_org_vk
	@data datetime
AS
	DECLARE @id_org integer,
    @symh decimal(15,2),
	@symhnds decimal(15,2),
    @symhs decimal(15,2),
    @perh decimal(15,2),
	@perk decimal(15,2),
    @pkybv decimal(15,2),
    @pkybk decimal(15,2),
	@perhnds decimal(15,2),
    @symkk decimal(15,2),
    @symknds decimal(15,2),
	@symks decimal(15,2),
    @perknds decimal(15,2),
    @skybv decimal(15,2),
	@skybk decimal(15,2),
    @lsumv decimal(15,2),
    @lskybv decimal(15,2),
	@lsumk decimal(15,2),
    @lskybk decimal(15,2)
	DECLARE cur_org CURSOR FOR
	SELECT a.kodorg,
	isnull(SUM(symh),0),
    isnull(SUM(symhnds),0),
    isnull(SUM(symhs),0),
    isnull(SUM(symkk),0),
    isnull(SUM(symknds),0),
    isnull(SUM(symks),0),
    isnull(SUM(perh),0),
    isnull(SUM(perk),0),
    isnull(SUM(kybv),0),
    isnull(SUM(kybk),0),
    isnull(SUM(pkybv),0),
    isnull(SUM(perhnds),0),
    isnull(SUM(pkybk),0),
    ISNULL(SUM(perknds),0),
    isnull(SUM(lkybv),0),
    isnull(SUM(lsymh),0),
    isnull(SUM(lkybk),0),
    isnull(SUM(lsymkk),0)
    FROM obekt as a join dataobekt as b on a.kodobk=b.kodobk
    WHERE b.datan=@data
    GROUP BY a.kodorg
	OPEN cur_org
	FETCH NEXT FROM cur_org INTO @id_org,
		@symh,@symhnds,
		@symhs,@symkk,
		@symknds,@symks,
		@perh,@perk,
		@skybv,@skybk,
		@pkybv,@perhnds,
		@pkybk,@perknds,
		@lsumv,@lskybv,@lsumk,@lskybk
	WHILE (@@FETCH_STATUS <> -1)
	BEGIN
		UPDATE dataorg SET sumv=@symh,sumvnds=@symhnds,sumvv=@symhs,
    perho=@perh,perko=@perk,pkybvo=@pkybv,pkybko=@pkybk,perhonds=@perhnds,
		itogv=@symhs+@perh,
    sumk=@symkk,sumknds=@symknds,sumkk=@symks,perkonds=@perknds,
		itogk=@symks+@perk,
    skybv=@skybv,skybk=@skybk,lsumv=@lsumv,lskybv=@lskybv,lsumk=@lsumk,
		lskybk=@lskybk
    WHERE kodorg=@id_org and datan=@data
		FETCH NEXT FROM cur_org INTO @id_org,
		@symh,@symhnds,
		@symhs,@symkk,
		@symknds,@symks,
		@perh,@perk,
		@skybv,@skybk,
		@pkybv,@perhnds,
		@pkybk,@perknds,
		@lsumv,@lskybv,@lsumk,@lskybk
	END
	DEALLOCATE cur_org
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[sp_calc_obk_g]'
GO
ALTER PROCEDURE [dbo].[sp_calc_obk_g]
@data datetime
AS
	DECLARE @okr int
    if @data > '30.06.2016'
    	set @okr=2
    else
        set @okr=0
-- Обновляем все объекы, кроме ЖСК
	UPDATE dataobekt
	SET
    symg=round(b.kybg*a.cenag,@okr),
    symgnds=round(b.kybg*a.cenag*c.nds/100,@okr),
    symgs=round((b.kybg*a.cenag)+(b.kybg*a.cenag*c.nds/100),@okr),
    pergnds=round((b.perg*c.nds/(100+c.nds)),@okr),
    rastarifg=a.cenag
	FROM	
		(datatarifg as a join dataobekt as b on (a.datan=b.datan)) join
    obekt as c on(a.kodtg=c.kodtg) and(c.kodobk=b.kodobk) 
  WHERE b.datan=@data and c.kodtg<>7
  
	-- Обновляем все объекы ЖСК
	UPDATE dataobekt
	SET
    kybg      = round((c.prj+c.prjl) * 0.093, 2),
    symg      = round((c.prj * a.cenag) + (c.prjl * a.cenag / 2),@okr),
    lsymg     = round((c.prjl * a.cenag / 2),@okr),
    lkybg     = round(0.093 * c.prjl, 2),
    symgnds   = 0,
    symgs     = round((c.prj * a.cenag) + (c.prjl * a.cenag / 2),@okr),
    pergnds   = 0,
    rastarifg = a.cenag
	FROM	
		(datatarifg as a join dataobekt as b on (a.datan=b.datan)) join
    obekt as c on(a.kodtg=c.kodtg) and(c.kodobk=b.kodobk)
    WHERE b.datan=@data and c.kodtg=7
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[sp_calc_org_g]'
GO
ALTER  PROCEDURE [dbo].[sp_calc_org_g]
	@data datetime
AS
	DECLARE @id_org integer,
            @symg decimal(15,2),
			@symgnds decimal(15,2),
            @symgs decimal(15,2),
            @perg decimal(15,2),
		    @pkybg decimal(15,2),
			@pergnds decimal(15,2),
			@skybg decimal(15,2),
			@lsumg decimal(15,2),
            @lskybg decimal(15,2)
-- Декларируем курсор            
	DECLARE cur_org CURSOR FOR
	SELECT a.kodorg,
		isnull(SUM(symg),0),
        isnull(SUM(symgnds),0),
    	isnull(SUM(symgs),0),
	    isnull(SUM(perg),0),
    	isnull(SUM(kybg),0),
    	isnull(SUM(pkybg),0),
        isnull(SUM(pergnds),0),
	    isnull(SUM(lkybg),0),
        isnull(SUM(lsymg),0)
    FROM obekt as a join dataobekt as b on a.kodobk=b.kodobk
    WHERE b.datan=@data
    GROUP BY a.kodorg
	OPEN cur_org
	FETCH NEXT FROM cur_org INTO @id_org,
		@symg,
        @symgnds,
		@symgs,
		@perg,
		@skybg,
		@pkybg,
        @pergnds,
        @lskybg,
		@lsumg
	WHILE (@@FETCH_STATUS <> -1)
	BEGIN
		UPDATE dataorg SET sumg=@symg,sumgnds=@symgnds,sumgg=@symgs,
    pergo=@perg,pkybgo=@pkybg,pergonds=@pergnds,
		itogg=@symgs+@perg,
    skybg=@skybg,lsumg=@lsumg,lskybg=@lskybg
    WHERE kodorg=@id_org and datan=@data
		FETCH NEXT FROM cur_org INTO @id_org,
		@symg,
        @symgnds,
		@symgs,
		@perg,
		@skybg,
		@pkybg,
        @pergnds,
        @lskybg,
		@lsumg
	END
	DEALLOCATE cur_org
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[sp_ob_svod_g]'
GO
ALTER PROCEDURE [dbo].[sp_ob_svod_g]
	@data1 datetime, @data2 datetime
AS
	IF EXISTS(SELECT name 
	  FROM 	 sysobjects 
	  WHERE  name = N'gen_report_g' 
	  AND 	 type = 'U')
    DROP TABLE gen_report_g
    print 'Удалили таблу'
	CREATE TABLE gen_report_g 
	(kod int, nazv char(100), kg decimal(15,2),tarifg decimal(15,3),kod_tarifg int,
	 sum_nacg decimal(20,2),sum_ndsg decimal(20,2),
	 per_kg	decimal(15,2),sum_perg decimal(20,2),razng decimal(20,2),
	 tip int)
    print 'Создали таблу' 
	-- Собираем сведения
	DECLARE @i integer
	DECLARE @kod int, @nazv varchar(100),@kg decimal(15,2),@tarifg decimal(15,3),
	@kod_tarifg int,@sum_nacg decimal(20,2),@sum_ndsg decimal(20,2),
	@per_kg decimal(15,2),@sum_perg decimal(20,2),@razng decimal(20,2),
	@cena_g decimal(15,2)
	DECLARE @cur_org CURSOR
	-- Выбираем тариф по вед. жилью
	SELECT @cena_g = AVG(cenag) FROM datatarifg
		WHERE kodtg = 3 and datan between @data1 and @data2
    print 'Выбрали тариф'    
	SET @i=0
	WHILE @i<4 -- цикл по типам организаций
	BEGIN 
		SET @cur_org = CURSOR FOR 
			SELECT a.kodorg,a.nazv,
				sum(ISNULL(b.skybg,0)),				
				sum(b.itogg),
				sum(ISNULL(b.sumgnds,0)+ISNULL(b.PERGONDS,0)),
				sum(ISNULL(b.PKYBGO,0)),
				sum(ISNULL(b.pergo,0))
				FROM org a,dataorg b 
				WHERE a.kodorg=b.kodorg and a.tiporg = @i 
				and b.datan between @data1 and @data2
				GROUP BY a.kodorg, a.nazv
				HAVING sum(ISNULL(b.skybg,0))+sum(ISNULL(b.pergo,0)) !=0
				ORDER BY a.nazv 				
		OPEN @cur_org		
		FETCH NEXT FROM @cur_org INTO 
		@kod,@nazv,@kg,@sum_nacg,@sum_ndsg,@per_kg,@sum_perg
        
		print 'Заполняем данные по организации '+cast(@kod as varchar(5))
		
        WHILE (@@FETCH_STATUS=0)
		BEGIN
            print 'Пытаюсь вставить'
			INSERT INTO gen_report_g (kod, nazv, kg, sum_nacg, sum_ndsg, per_kg, sum_perg, tip)
			VALUES (@kod, @nazv, @kg, @sum_nacg, @sum_ndsg, @per_kg, @sum_perg, @i)
			print 'Заполняем данные по объектам'
			INSERT INTO gen_report_g (kod, nazv,
									kg,tarifg,kod_tarifg,
									sum_nacg,sum_ndsg,
									per_kg,sum_perg,
									tip)
			SELECT @kod, a.nazt,
						 SUM(ISNULL(b.kybg,0)),c.cenag, a.kodtg,
						 SUM(ISNULL(b.symgs,0)),SUM(ISNULL(b.symgnds,0)+ISNULL(b.pergnds,0)),
						 SUM(ISNULL(b.pkybg,0)),SUM(ISNULL(b.perg,0)),	
						 @i+10						 								 
			FROM tarifg a, dataobekt b, datatarifg c, obekt d
			WHERE a.kodtg = d.kodtg and b.datan = c.datan and
						a.kodtg = c.kodtg and b.kodobk = d.kodobk and d.kodorg = @kod
						and b.datan between @data1 and @data2
			GROUP BY a.nazt,c.cenag, a.kodtg
			ORDER BY a.kodtg
            print 'Заполнили по организации '+cast(@kod as varchar(5))
			-- Обновляем разницу
			/*SELECT @raznv = ROUND(@cena_v*SUM(ISNULL(b.kybv,0))
						 -SUM(ISNULL(b.symhs,0)),0),
						 @raznv = ROUND(@cena_k*SUM(ISNULL(b.kybk,0))
						 -SUM(ISNULL(b.symks,0)),0)
			FROM obekt a,dataobekt b WHERE a.kodobk = b.kodobk and a.kodtv = 7
					 and b.datan between @data1 and @data2 and a.kodorg = @kod*/
			print 'Обновляем по объектам'                     
			UPDATE gen_report_g 
			SET razng = round((@cena_g-tarifg)*kg,0)
			WHERE kod_tarifg = 3 and tip = @i+10 and kod = @kod
			
            FETCH NEXT FROM @cur_org INTO 
			@kod,@nazv,@kg,@sum_nacg,@sum_ndsg,@per_kg,@sum_perg
			print 'Следующая '+cast(@kod as varchar(5))
		END
		CLOSE @cur_org
		DEALLOCATE @cur_org		
		-- Заполняем итоги
		IF @i = 0
			SET @nazv = 'ИТОГО ПО БЮДЖЕТУ:'
		IF @i = 1
			SET @nazv = 'ИТОГО ПО ХОЗРАСЧЕТУ:'
		IF @i = 2
			SET @nazv = 'ИТОГО ПО ЖСК:'
		IF @i = 3
			SET @nazv = 'ИТОГО ПО ЖСК - БСХА:'
		INSERT INTO gen_report_g (nazv,kg,sum_nacg,sum_ndsg,per_kg,sum_perg,tip)
		SELECT @nazv,SUM(kg),SUM(sum_nacg),SUM(sum_ndsg),SUM(per_kg),SUM(sum_perg),@i+20
		FROM gen_report_g WHERE tip = @i
	  SELECT @razng = SUM(razng)
		FROM gen_report_g WHERE tip = @i+10		
		UPDATE gen_report_g SET razng = @razng WHERE tip = @i+20
		SET @i = @i+1
	END
	SET @nazv = 'ИТОГО ПО ПРЕДПРИЯТИЮ:'
	INSERT INTO gen_report_g (nazv,kg,sum_nacg,sum_ndsg,per_kg,sum_perg,tip)
		SELECT @nazv,SUM(kg),SUM(sum_nacg),SUM(sum_ndsg),SUM(per_kg),SUM(sum_perg),30
	FROM gen_report_g
	WHERE (tip < 4)
    
	SELECT @razng = SUM(razng)
	FROM gen_report_g 
	WHERE (tip > 19) and (tip < 30)
	UPDATE gen_report_g SET razng = @razng WHERE tip = 30
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
IF EXISTS (SELECT * FROM #tmpErrors) ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT>0 BEGIN
PRINT 'The database update succeeded'
COMMIT TRANSACTION
END
ELSE PRINT 'The database update failed'
GO
DROP TABLE #tmpErrors
GO

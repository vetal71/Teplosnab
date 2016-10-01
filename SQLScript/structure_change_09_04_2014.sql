/*
Run this script on:

        (local).Teplosnab_copy    -  This database will be modified

to synchronize it with:

        (local).Teplosnab

You are recommended to back up your database before running this script

Script created by SQL Compare version 8.0.0 from Red Gate Software Ltd at 09.04.2014 9:36:43

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
PRINT N'Altering [dbo].[schet]'
GO
ALTER TABLE [dbo].[schet] ALTER COLUMN [usluga] [varchar] (100) COLLATE Cyrillic_General_CI_AS NOT NULL
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
    	ndsidx  = round((symidx*20/(120)),0),
        ndsidxv = round((symidxv*20/(120)),0),
        ndsidxk = round((symidxk*20/(120)),0),
        itog    = symtv + perto, 
        itogv   = sumvv + perho, 
        itogk   = sumkk + perko
	WHERE kodorg=@kod and datan=@data
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

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO




ALTER    PROCEDURE sp_general_report 
	@data1 datetime, @data2 datetime
AS
	IF EXISTS(SELECT name 
	  FROM 	 sysobjects 
	  WHERE  name = N'gen_report_ot' 
	  AND 	 type = 'U')
    DROP TABLE gen_report_ot
	CREATE TABLE gen_report_ot 
	(nazv char(50),gk decimal(15,2),tarif decimal(15,2),kod_tarif int,
	 sum_nac decimal(20,0),sum_nds decimal(20,0),
	 per_gk	decimal(15,2),sum_per decimal(20,0),razn decimal(20,0),tip int)
	-- Собираем сведения
	DECLARE @i integer
	DECLARE @kod int, @nazv varchar(100),@gk decimal(15,2),@tarif decimal(15,2),
	@kod_tarif int,@sum_nac decimal(20,0),@sum_nds decimal(20,0),
	@per_gk decimal(15,2),@sum_per decimal(20,0),@razn decimal(20,0),
	@cena_t decimal(15,2)
	DECLARE @cur_org CURSOR
	-- Выбираем тариф №13
	SELECT @cena_t = AVG(cena) FROM datatarif
		WHERE kodtt = 13 and datan between @data1 and @data2
	SET @i=0
	WHILE @i<4 
	BEGIN 
		SET @cur_org = CURSOR LOCAL FOR 
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
		WHILE (@@FETCH_STATUS<>0)
		BEGIN
			INSERT INTO gen_report_ot (nazv,gk,sum_nac,sum_nds,per_gk,sum_per,tip)
			VALUES (UPPER(@nazv),@gk,@sum_nac,@sum_nds,@per_gk,@sum_per,@i)
			-- Заполняем данные по объектам
			INSERT INTO gen_report_ot (nazv,gk,tarif,kod_tarif,sum_nac,sum_nds,
									per_gk,sum_per,tip)
			SELECT a.nazt,SUM(ISNULL(b.gkt,0)+ISNULL(b.gkv,0)),c.cena,a.kodtt,
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
			SELECT @razn = ROUND(@cena_t*SUM(ISNULL(b.gkt,0)+ISNULL(b.gkv,0))
			-SUM(ISNULL(b.symk,0)+ISNULL(b.symgv,0)),0)
			FROM obekt a,dataobekt b WHERE a.kodobk = b.kodobk and a.kodtt = 10
					 and b.datan between @data1 and @data2
			UPDATE gen_report_ot 
			SET razn = @razn
			WHERE kod_tarif = 10 and tip = @i+10

			FETCH NEXT FROM @cur_org INTO @kod,@nazv,@gk,@sum_nac,@sum_nds,@per_gk,@sum_per					
		END
		CLOSE @cur_org
		DEALLOCATE @cur_org		
		-- Заполняем итоги
		IF @i = 0
			SET @nazv = 'ИТОГО ПО БЮДЖЕТУ'
		IF @i = 1
			SET @nazv = 'ИТОГО ПО ХОЗРАСЧЕТУ'
		IF @i = 2
			SET @nazv = 'ИТОГО ПО ЖСК'
		IF @i = 3
			SET @nazv = 'ИТОГО ПО ЖСК - БСХА'
		INSERT INTO gen_report_ot (nazv,gk,sum_nac,sum_nds,per_gk,sum_per,tip)
		SELECT @nazv,SUM(gk),SUM(sum_nac),SUM(sum_nds),SUM(per_gk),
					 SUM(sum_per),@i+20
		FROM gen_report_ot WHERE tip = @i
	  SELECT @razn = SUM(razn) FROM gen_report_ot WHERE tip = @i+10		
		UPDATE gen_report_ot SET razn = @razn WHERE tip = @i+20
		SET @i = @i+1
	END






GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO


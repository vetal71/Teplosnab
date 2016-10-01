SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO



ALTER   PROCEDURE sp_create_sf
	@kod int = -1, @data datetime
AS
	declare @cnt integer,
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
  		if @cnt<2 set @stavka=18
  		else set @stavka=0
  		delete from schet where kodorg=@kodorg
			-- Добавляем записи в таблицу SCHET
			INSERT INTO schet
			SELECT 'Отпуск тепловой энергии','Гкал',
					sum(b.gkt+b.gkv+b.pgkt+b.pgkv) as kol,
					avg(b.rastarift) as tarif,
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
			INSERT INTO schet
  		SELECT 'Отпуск холодной воды','Куб.м.',
					sum(b.kybv+b.pkybv) as kol,
					avg(b.rastarifv) as tarif,
					sum(b.symh+(b.perh-b.perhnds)) as sum_b_nds,@stavka,
          sum(b.symhnds+b.perhnds) as nds,
					sum(b.symhs+b.perh) as sum_s_nds,
					a.kodorg,GetDate(),2,null,a.nazv,a.adres,a.unn,a.rschet,c.nazv_bank
				FROM org a,dataobekt b,bank c,obekt d
				WHERE a.kodorg = d.kodorg and d.kodobk = b.kodobk and a.kodbank = c.kod_bank
							and b.datan = @data and a.kodorg = @kodorg
				GROUP BY a.kodorg,a.nazv,a.adres,a.unn,a.rschet,c.nazv_bank
				HAVING sum(b.symh+(b.perh-b.perhnds))<>0
			INSERT INTO schet
  		SELECT 'Пропуск сточных вод','Куб.м.',
					sum(b.kybk+b.pkybk) as kol,
					avg(b.rastarifk) as tarif,
					sum(b.symkk+(b.perk-b.perknds)) as sum_b_nds,@stavka,
          sum(b.symknds+b.perknds) as nds,
					sum(b.symks+b.perk) as sum_s_nds,
					a.kodorg,GetDate(),3,null,a.nazv,a.adres,a.unn,a.rschet,c.nazv_bank
				FROM org a,dataobekt b,bank c,obekt d
				WHERE a.kodorg = d.kodorg and d.kodobk = b.kodobk and a.kodbank = c.kod_bank
							and b.datan = @data and a.kodorg = @kodorg
				GROUP BY a.kodorg,a.nazv,a.adres,a.unn,a.rschet,c.nazv_bank
				HAVING sum(b.symkk+(b.perk-b.perknds))<>0
			-- Следующая запись
			FETCH NEXT FROM @cur_org INTO @kodorg
  	END
		CLOSE @cur_org
		DEALLOCATE @cur_org
	END
	IF @kod > 0
	BEGIN
		select @cnt = tiporg from org where kodorg=@kod
  	if @cnt<2 set @stavka=18
  	else set @stavka=0
  	delete from schet where kodorg=@kod
		-- Добавляем записи в таблицу SCHET
		INSERT INTO schet
		SELECT 'Отпуск тепловой энергии','Гкал',
				sum(b.gkt+b.gkv+b.pgkt+b.pgkv) as kol,
				avg(b.rastarift) as tarif,
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
		INSERT INTO schet
  	SELECT 'Отпуск холодной воды','Куб.м.',
				sum(b.kybv+b.pkybv) as kol,
				avg(b.rastarifv) as tarif,
				sum(b.symh+(b.perh-b.perhnds)) as sum_b_nds,@stavka,
         sum(b.symhnds+b.perhnds) as nds,
				sum(b.symhs+b.perh) as sum_s_nds,
				a.kodorg,GetDate(),2,null,a.nazv,a.adres,a.unn,a.rschet,c.nazv_bank
			FROM org a,dataobekt b,bank c,obekt d
			WHERE a.kodorg = d.kodorg and d.kodobk = b.kodobk and a.kodbank = c.kod_bank
						and b.datan = @data and a.kodorg = @kod
			GROUP BY a.kodorg,a.nazv,a.adres,a.unn,a.rschet,c.nazv_bank
			HAVING sum(b.symh+(b.perh-b.perhnds))<>0
		INSERT INTO schet
  	SELECT 'Пропуск сточных вод','Куб.м.',
				sum(b.kybk+b.pkybk) as kol,
				avg(b.rastarifk) as tarif,
				sum(b.symkk+(b.perk-b.perknds)) as sum_b_nds,@stavka,
        sum(b.symknds+b.perknds) as nds,
				sum(b.symks+b.perk) as sum_s_nds,
		  	a.kodorg,GetDate(),3,null,a.nazv,a.adres,a.unn,a.rschet,c.nazv_bank
			FROM org a,dataobekt b,bank c,obekt d
			WHERE a.kodorg = d.kodorg and d.kodobk = b.kodobk and a.kodbank = c.kod_bank
						and b.datan = @data and a.kodorg = @kod
			GROUP BY a.kodorg,a.nazv,a.adres,a.unn,a.rschet,c.nazv_bank
			HAVING sum(b.symkk+(b.perk-b.perknds))<>0
	END				


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO


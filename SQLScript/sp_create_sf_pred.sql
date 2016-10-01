SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO








ALTER       PROCEDURE sp_create_sf_pred
	@kod int = -1, @data datetime
AS
	declare @cnt integer,
  @stavka decimal(2),
	@kodorg int,
	@cur_org CURSOR
	IF @kod > 0
	BEGIN
		select @cnt = tiporg from org where kodorg=@kod
  	if @cnt<2 set @stavka=18
  	else set @stavka=0
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
				symt = round(symt*psum_t,0),
				symv = round(symv*psum_t,0),
				symtnds = round(symtnds*psum_t,0),
				symvnds = round(symvnds*psum_t,0),
				symk = round(symk*psum_t,0),
				symgv = round(symgv*psum_t,0),
				pert = 0, pertnds =0, perv = 0, pervnds = 0,pgkt = 0,pgkv = 0,
				-- Вода
				kybv = round(kybv*psum_v,2),
				kybk = round(kybk*psum_k,2),
				symh = round(symh*psum_v,0),
				symkk = round(symkk*psum_k,0),
				symhnds = round(symhnds*psum_v,0),
				symknds = round(symknds*psum_k,0),
				symhs = round(symhs*psum_v,0),
				symks = round(symks*psum_k,0),
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
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO


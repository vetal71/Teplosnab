SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO




ALTER    PROCEDURE sp_create_vyr
	@data datetime
AS
	IF EXISTS (SELECT name 
	   FROM   sysobjects 
	   WHERE  name = N'tVyr' 
	   AND 	  type = 'U')
  DROP TABLE tVyr
	CREATE TABLE tVyr
		(vr decimal(15,2),rt decimal(15,2),ps decimal(15,2),
		 nas decimal(15,2),org decimal(15,2),sv_org decimal(15,2),sn decimal(15,2),
		 sl decimal(15,2),dr decimal(15,2))
	IF EXISTS (SELECT name 
	   FROM   sysobjects 
	   WHERE  name = N'tTop' 
	   AND 	  type = 'U')
  DROP TABLE tTop
	CREATE TABLE tTop
		(kt int, vid varchar(50),kol decimal(20,1),tut decimal(20,1),kper decimal(10,4))
	-- Заполняем таблицу tVyr
	INSERT INTO tVyr (vr,rt,ps) 
		SELECT sum(v_tep),sum(r_ot+r_gv),sum(ps) FROM datatop WHERE datan = @data
	UPDATE tVyr SET
		nas = (select sum(isnull(a.gkt,0)+isnull(a.pgkt,0)+
					isnull(a.gkv,0)+isnull(a.pgkv,0))
					from dataobekt a,obekt b
					where a.kodobk = b.kodobk and b.kodtt in (3,4,8,9) and a.datan = @data),
		org = (select sum(isnull(a.gkt,0)+isnull(a.pgkt,0)+
					isnull(a.gkv,0)+isnull(a.pgkv,0))
					from dataobekt a,obekt b
					where a.kodobk = b.kodobk and b.kodtt not in (3,4,8,9) and a.datan = @data),
		sv_org = (select sum(isnull(a.gkt,0)+isnull(a.pgkt,0)+
					isnull(a.gkv,0)+isnull(a.pgkv,0))
					from dataobekt a,obekt b
					where a.kodobk = b.kodobk and b.kodtt = 7 and a.datan = @data),
		sn = (select sum(isnull(a.gkt,0)+isnull(a.pgkt,0)+
					isnull(a.gkv,0)+isnull(a.pgkv,0))
					from dataobekt a,obekt b
					where a.kodobk = b.kodobk and b.kodtt = 5 and a.datan = @data),
		
		sl = (select sum(isnull(a.gkt,0)+isnull(a.pgkt,0)+
					isnull(a.gkv,0)+isnull(a.pgkv,0))
					from dataobekt a,obekt b
					where a.kodobk = b.kodobk and b.kodtt = 12 and a.datan = @data),
		dr = (select sum(isnull(a.gkt,0)+isnull(a.pgkt,0)+
					isnull(a.gkv,0)+isnull(a.pgkv,0))
					from dataobekt a,obekt b
					where a.kodobk = b.kodobk and b.kodtt = 11 and a.datan = @data)
		-- Заполняем таблицу tTop
		insert into tTop
			select a.kodtop, b.naztop,sum(kol_n),sum(kol_t),avg(a.k_per)
			from datatop a, vidtop b
			where a.kodtop = b.kodtop and datan = @data
			group by a.kodtop, b.naztop
			order by 1



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO


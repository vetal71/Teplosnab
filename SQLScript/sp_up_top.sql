-- =============================================
-- Create procedure basic template
-- =============================================
-- creating the store procedure
IF EXISTS (SELECT name 
	   FROM   sysobjects 
	   WHERE  name = N'sp_up_top' 
	   AND 	  type = 'P')
    DROP PROCEDURE sp_up_top
GO

CREATE PROCEDURE sp_up_top 
	@kodkot int,@kodtop int,
  @r_ot decimal(15,2),@r_gv decimal(15,2),@ps decimal(15,2),
	@v_tep decimal(15,2),@k_per decimal(10,4),@n_top decimal(10,4),
	@kol_n decimal(15,1),@kol_t decimal(15,1),@datan datetime
AS
	IF EXISTS (SELECT kodkot FROM datatop
		WHERE kodkot = @kodkot and kodtop = @kodtop and datan = @datan)
	  -- Обновляем
		UPDATE datatop SET
			r_ot=@r_ot, r_gv=@r_gv,
		  ps=@ps,v_tep=@v_tep,k_per=@k_per,n_top=@n_top,
			kol_n=@kol_n,kol_t=@kol_t
		WHERE kodkot = @kodkot and kodtop = @kodtop and datan = @datan
	ELSE
		INSERT INTO datatop(kodkot, kodtop, r_ot, r_gv, ps, v_tep, k_per, n_top,
		 kol_n, kol_t, datan)
		VALUES(@kodkot,@kodtop,@r_ot,@r_gv,@ps,
		@v_tep,@k_per,@n_top,@kol_n,@kol_t,@datan)
GO
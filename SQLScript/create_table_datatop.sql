-- =============================================
-- Create table basic template
-- =============================================
IF EXISTS(SELECT name 
	  FROM 	 sysobjects 
	  WHERE  name = N'datatop' 
	  AND 	 type = 'U')
    DROP TABLE datatop
GO

CREATE TABLE datatop 
( kodkot int, kodtop int, r_ot decimal(15,2), r_gv decimal(15,2),
	ps decimal(15,2), v_tep decimal(15,2), 
	k_per decimal(10,4), n_top decimal(10,4),
	kol_n decimal(15,1), kol_t decimal(15,1), datan datetime
	)
GO


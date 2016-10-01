delete from datadoma
INSERT INTO datadoma
	SELECT * FROM arh_datadoma
	WHERE datan between '20060101' and '20061231'
delete FROM arh_datadoma
	WHERE datan between '20060101' and '20061231'
delete from datakvart
INSERT INTO datakvart
	SELECT * FROM arh_datakvart
	WHERE datan between '20060101' and '20061231'
delete FROM arh_datakvart
	WHERE datan between '20060101' and '20061231'
delete from dataobekt
INSERT INTO dataobekt
	SELECT * FROM arh_dataobekt
	WHERE datan between '20060101' and '20061231'
delete FROM arh_dataobekt
	WHERE datan between '20060101' and '20061231'
-- =============================================
-- Create database for attach
-- =============================================
IF EXISTS (SELECT * 
	   FROM   master..sysdatabases 
	   WHERE  name = N'Teplosnab')
	DROP DATABASE Teplosnab
GO

CREATE DATABASE Teplosnab
ON PRIMARY 
	(FILENAME = N'd:\Teplosnab\Database\teplosnab.mdf')
FOR ATTACH
GO



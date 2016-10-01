@echo off
rem Usage: exec_sql_list filelist
osql -S ADMIN -d teplosnab -U admin -P 00 -i 'd:\temp\restore.sql'


SET VERIFY OFF
connect "SYS"/"&&sysPassword" as SYSDBA
set echo on
spool /u01/app/oracle/admin/PRRBT/scripts/CreateDBFiles.log append
CREATE BIGFILE TABLESPACE "USERS" LOGGING DATAFILE '+CONS_DATA/PRRBT/datafile/users'  SIZE 359M AUTOEXTEND ON NEXT  1280K MAXSIZE 4G EXTENT MANAGEMENT LOCAL SEGMENT SPACE MANAGEMENT  AUTO;
ALTER DATABASE DEFAULT TABLESPACE "USERS";
spool off

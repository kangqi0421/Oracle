SET VERIFY OFF
connect "SYS"/"&&sysPassword" as SYSDBA
set echo on
spool /u01/app/oracle/admin/PRRBT/scripts/postDBCreation.log append
@/u01/app/oracle/product/11.2.0.4/db_1/rdbms/admin/catbundleapply.sql;
select 'utl_recomp_begin: ' || to_char(sysdate, 'HH:MI:SS') from dual;
execute utl_recomp.recomp_serial();
select 'utl_recomp_end: ' || to_char(sysdate, 'HH:MI:SS') from dual;
shutdown immediate;
connect "SYS"/"&&sysPassword" as SYSDBA
startup mount pfile="/u01/app/oracle/admin/PRRBT/scripts/init.ora";
alter database archivelog;
alter database open;
connect "SYS"/"&&sysPassword" as SYSDBA
set echo on
create spfile='/u01/app/oracle/product/11.2.0.4/db_1/dbs/spfilerbt.ora' FROM pfile='/u01/app/oracle/admin/PRRBT/scripts/init.ora';
shutdown immediate;
host /u01/app/oracle/product/11.2.0.4/db_1/bin/srvctl enable database -d PRRBT;
host /u01/app/oracle/product/11.2.0.4/db_1/bin/srvctl start database -d PRRBT;
connect "SYS"/"&&sysPassword" as SYSDBA
spool off
exit;

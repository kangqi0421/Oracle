set verify off
ACCEPT sysPassword CHAR PROMPT 'Enter new password for SYS: ' HIDE
ACCEPT systemPassword CHAR PROMPT 'Enter new password for SYSTEM: ' HIDE
host /u01/app/oracle/product/11.2.0.4/db_1/bin/orapwd file=/u01/app/oracle/product/11.2.0.4/db_1/dbs/orapwrbt force=y
host /u01/app/11.2.0.4/grid/bin/setasmgidwrap o=/u01/app/oracle/product/11.2.0.4/db_1/bin/oracle
@/u01/app/oracle/admin/PRRBT/scripts/CreateDB.sql
@/u01/app/oracle/admin/PRRBT/scripts/CreateDBFiles.sql
@/u01/app/oracle/admin/PRRBT/scripts/CreateDBCatalog.sql
@/u01/app/oracle/admin/PRRBT/scripts/JServer.sql
@/u01/app/oracle/admin/PRRBT/scripts/xdb_protocol.sql
@/u01/app/oracle/admin/PRRBT/scripts/ordinst.sql
@/u01/app/oracle/admin/PRRBT/scripts/interMedia.sql
@/u01/app/oracle/admin/PRRBT/scripts/apex.sql
host /u01/app/oracle/product/11.2.0.4/db_1/bin/srvctl add database -d PRRBT -o /u01/app/oracle/product/11.2.0.4/db_1 -p /u01/app/oracle/product/11.2.0.4/db_1/dbs/spfilerbt.ora -n rbt -a "CONS_DATA"
--host echo "SPFILE='+CONS_DATA/PRRBT/spfilerbt.ora'" > /u01/app/oracle/product/11.2.0.4/db_1/dbs/initrbt.ora
@/u01/app/oracle/admin/PRRBT/scripts/lockAccount.sql
@/u01/app/oracle/admin/PRRBT/scripts/postDBCreation.sql

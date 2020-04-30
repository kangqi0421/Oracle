set head off
set long 1000000000
set pages 0
show user
set feedback off
set linesize 10000
column aa format a10000
set verify off
set trims on 
set echo off

execute DBMS_METADATA.SET_TRANSFORM_PARAM(DBMS_METADATA.SESSION_TRANSFORM,'STORAGE',false);
execute DBMS_METADATA.SET_TRANSFORM_PARAM(DBMS_METADATA.SESSION_TRANSFORM,'PRETTY',true);
execute DBMS_METADATA.SET_TRANSFORM_PARAM(DBMS_METADATA.SESSION_TRANSFORM,'SQLTERMINATOR',true);


spool TABLE_SWATCHER.sql
select dbms_metadata.get_ddl('TABLE',object_name,owner) aa from dba_objects where owner in ('SWATCHER') and object_type='TABLE';
spool off;

exit
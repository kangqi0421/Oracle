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

spool PACKAGE.sql
select dbms_metadata.get_ddl('PACKAGE_SPEC',object_name,owner) aa from dba_objects where owner in ('INAPI1','INAPI2','INAPI3','INAPI5') and object_type='PACKAGE';
select dbms_metadata.get_ddl('PACKAGE_BODY',object_name,owner) aa from dba_objects where owner in ('INAPI1','INAPI2','INAPI3','INAPI5') and object_type='PACKAGE BODY';
spool off;

spool LIBRARY.sql
select dbms_metadata.get_ddl('LIBRARY',object_name,owner) aa from dba_objects where owner in ('INAPI1','INAPI2','INAPI3','INAPI5') and object_type='LIBRARY';
spool off;

spool PROCEDURE.sql
select dbms_metadata.get_ddl('PROCEDURE',object_name,owner) aa from dba_objects where owner in ('INAPI1','INAPI2','INAPI3','INAPI5') and object_type='PROCEDURE';
spool off;

spool TRIGGER.sql
select dbms_metadata.get_ddl('TRIGGER',object_name,owner) aa from dba_objects where owner in ('INAPI1','INAPI2','INAPI3','INAPI5') and object_type='TRIGGER';
spool off;

spool TYPE.sql
select dbms_metadata.get_ddl('TYPE',object_name,owner) aa from dba_objects where owner in ('INAPI1','INAPI2','INAPI3','INAPI5') and object_type='TYPE';
spool off;

spool VIEW.sql
select dbms_metadata.get_ddl('VIEW',object_name,owner) aa from dba_objects where owner in ('INAPI1','INAPI2','INAPI3','INAPI5') and object_type='VIEW';
spool off;

spool FUNCTION.sql
select dbms_metadata.get_ddl('FUNCTION',object_name,owner) aa from dba_objects where owner in ('INAPI1','INAPI2','INAPI3','INAPI5') and object_type='FUNCTION';
spool off;

exit
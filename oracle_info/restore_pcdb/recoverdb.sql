SET heading OFF
SET recsep OFF
SET feedback OFF
SET echo OFF
SET trims ON
SEt VERIFY OFF
SET pagesize 0 
SET linesize 250
col text format a80 word_wrap
col text2 format a200


spool recoverdb.rmn 

SELECT 'RUN{' text FROM DUAL;
select 'ALLOCATE CHANNEL c1 ' ||value||';'  text from v$rman_configuration where name='CHANNEL';
select 'ALLOCATE CHANNEL c2 ' ||value||';'  text from v$rman_configuration where name='CHANNEL';

SELECT 'set until sequence 400712;' FROM dual;
SELECT ' RECOVER DATABASE SKIP FOREVER TABLESPACE ' FROM dual;
--SELECT '  ' || name || ',' from v$tablespace where ts# in (select distinct ts# from v$datafile where enabled = 'READ ONLY');
SELECT LISTAGG(name, ', ') WITHIN GROUP (ORDER BY 1)||';' TEXT
from v$tablespace where name not in ('SYSAUX', 'SYSTEM', 'USERS2','UNDO01','USERS','TOOLS');

SELECT '}' text FROM DUAL;
SELECT 'QUIT;' text FROM DUAL;

spool off

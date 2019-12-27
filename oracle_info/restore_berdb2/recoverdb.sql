SET heading OFF
SET recsep OFF
SET feedback OFF
SET echo OFF
SET trims ON
SEt VERIFY OFF
SET pagesize 0 
col text format a80 word_wrap



spool recoverdb.rmn 

SELECT 'RUN{' text FROM DUAL;
select 'ALLOCATE CHANNEL c1 ' ||value||';'  text from v$rman_configuration where name='CHANNEL';
select 'ALLOCATE CHANNEL c2 ' ||value||';'  text from v$rman_configuration where name='CHANNEL';

SELECT 'set until sequence 52674;' text FROM DUAL;


SELECT ' RECOVER DATABASE SKIP FOREVER TABLESPACE ' FROM dual;
SELECT '  ' || name || ',' from v$tablespace where ts# in (select distinct ts# from v$datafile where enabled = 'READ ONLY');

-- SELECT 'alter database open resetlogs;' text FROM DUAL;


SELECT '}' text FROM DUAL;
SELECT 'QUIT;' text FROM DUAL;


spool off

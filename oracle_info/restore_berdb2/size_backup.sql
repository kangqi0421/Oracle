SET heading OFF
SET recsep OFF
SET feedback OFF
SET echo OFF
SET trims ON
SEt VERIFY OFF
SET pagesize 0 
col text format a80 word_wrap


spool size_backup.rmn 
SELECT 'RUN{' text FROM DUAL;
select 'list backup of datafile ' || ts# || ';' from V$datafile where ts# not in (SELECT ts# from v$tablespace where ts# in (select distinct ts# from v$datafile where enabled = 'READ ONLY') or name like '%CALL%');
SELECT '}' text FROM DUAL;
SELECT 'QUIT;' text FROM DUAL;


spool off

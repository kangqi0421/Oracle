SET heading OFF
SET recsep OFF
SET feedback OFF
SET echo OFF
SET trims ON
SEt VERIFY OFF
SET pagesize 0 
col text format a80 word_wrap



spool drop_tbs.sql 

SELECT 'DROP TABLESPACE ' || name || 'INCLUDING CONTENTS AND DATAFILES;' from v$tablespace where ts# in (select distinct ts# from v$datafile where enabled = 'READ ONLY') or name like '%CALL%';

--DROP TABLESPACE TEST_TS INCLUDING CONTENTS AND DATAFILES;
--SELECT '}' text FROM DUAL;


spool off

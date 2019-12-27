SET heading OFF
SET recsep OFF
SET feedback OFF
SET echo OFF
SET trims ON
SEt VERIFY OFF
SET pagesize 0 
col text format a80 word_wrap



spool restoredatafile.rmn 

SELECT 'RUN{' text FROM DUAL;
select 'ALLOCATE CHANNEL c1 ' ||value||';'  text from v$rman_configuration where name='CHANNEL';
select 'ALLOCATE CHANNEL c2 ' ||value||';'  text from v$rman_configuration where name='CHANNEL';
select ' SET NEWNAME FOR DATAFILE ' || FILE# || ' TO ''' ||
       replace
        (
         replace
         (
          replace
          ( NAME, '+STPCDB_DATA/stpcdb/datafile/', '/testdb/TESTPCDB/' ),
          '+DWH_RO/dwh/datafile/', '/AMS_4D6A/TESTDWH3/data/' ),
           '/backup2/app/oracle/oradata/berdb4/', '/storage_920F1/testdb/oradata/testdb4/' )   || ''';'
from V$dbfile
where FILE# in (select FILE# from v$datafile where enabled != 'READ ONLY') 
and FILE# in (select FILE# from V$datafile d, V$tablespace t where d.TS#=t.TS# and t.name in ('SYSAUX', 'SYSTEM', 'USERS2','UNDO01','USERS','TOOLS'));

--SELECT 'set until sequence 970168061319;' text FROM DUAL;


SELECT ' RESTORE DATABASE SKIP FOREVER TABLESPACE ' FROM dual;
SELECT '  ' || name || ',' from V$tablespace where  name not in ('SYSAUX', 'SYSTEM', 'USERS2','UNDO01','USERS','TOOLS');
SELECT ' FROM TAG NIGHTLY_FULL_BACKUP;' text from dual;
-- Edit last '
--SELECT ';' FROM dual;

SELECT 'SWITCH DATAFILE ALL;' text from dual;



SELECT '}' text FROM DUAL;
SELECT 'QUIT;' text FROM DUAL;



spool off

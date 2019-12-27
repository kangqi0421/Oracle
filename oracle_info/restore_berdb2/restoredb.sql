SET heading OFF
SET recsep OFF
SET feedback OFF
SET echo OFF
SET trims ON
SEt VERIFY OFF
SET pagesize 0 
col text format a80 word_wrap



spool restoredb.rmn 

SELECT 'RUN{' text FROM DUAL;
select 'ALLOCATE CHANNEL c1 ' ||value||';'  text from v$rman_configuration where name='CHANNEL';
select 'ALLOCATE CHANNEL c2 ' ||value||';'  text from v$rman_configuration where name='CHANNEL';
select ' SET NEWNAME FOR DATAFILE ' || FILE# || ' TO ''' ||
       replace
        (
         replace
         (
          replace
          ( NAME, '+PRBERDB2_DATA/prberdb2/datafile/', '+DATA_GAM_1/ABERDB2/datafile/' ),
          '+PRBERDB2_DATA/prberdb2/datafile/', '+DATA_GAM_1/ABERDB2/datafile/' ),
           '+PRBERDB2_DATA/prberdb2/datafile/', '+DATA_GAM_1/ABERDB2/datafile/' )   || ''';'
from V$dbfile
where FILE# in (select FILE# from v$datafile where enabled != 'READ ONLY');



SELECT ' RESTORE DATABASE SKIP FOREVER TABLESPACE ' FROM dual;
SELECT '  ' || name || ',' from v$tablespace where ts# in (select distinct ts# from v$datafile where enabled = 'READ ONLY');
SELECT 'FROM TAG NIGHTLY_FULL_BACKUP_BANK;' text from dual;

SELECT 'SWITCH DATAFILE ALL;' text from dual;

SELECT '}' text FROM DUAL;
SELECT 'QUIT;' text FROM DUAL;



spool off

SET heading OFF
SET recsep OFF
SET feedback OFF
SET echo OFF
SET trims ON
SEt VERIFY OFF
SET pagesize 0 
col text format a80 word_wrap


-------------------------------------------------------------------------------------
--  SETTINGS:
--
-- Directory where the files are restored:
DEFINE s_until=04:00:00
-------------------------------------------------------------------------------------



spool refresh2_&_CONNECT_IDENTIFIER..rmn 
--
--Run block body
--
SELECT '# '  text from  v$database;
SELECT '# RMAN SCRIPT FOR RECOVER ' || name   text from  v$database;
SELECT '# Generated '||to_char(sysdate,'YYYY-MM-DD:HH24:MI:SS') ||'.' text from dual;
SELECT '# '  text from  v$database;
SELECT '# SET DBID ' || dbid ||';' text from  v$database;

SELECT 'RUN{' text FROM DUAL;
select 'ALLOCATE CHANNEL c1 ' ||value||';'  text from v$rman_configuration where name='CHANNEL';
select 'ALLOCATE CHANNEL c2 ' ||value||';'  text from v$rman_configuration where name='CHANNEL';
select 'ALLOCATE CHANNEL c2 ' ||value||';'  text from v$rman_configuration where name='CHANNEL';
select 'ALLOCATE CHANNEL c2 ' ||value||';'  text from v$rman_configuration where name='CHANNEL';
select 'SET UNTIL TIME ''' ||to_char(sysdate,'YYYY-MM-DD:')||'&s_until'';' text from dual;

SELECT ' recover database SKIP FOREVER TABLESPACE ' ||file_string || ';' text
FROM
  (SELECT ltrim(sys_connect_by_path(tablespace_name,', '),',') file_string,
    LENGTH(ltrim(sys_connect_by_path(tablespace_name,', '),',')) lng
  FROM
          (select name tablespace_name, lag(name) over(order by name) prev_id
            from v$tablespace
           where upper(NAME) LIKE TO_CHAR(sysdate, '%_MM_YYYY%')
              or upper(NAME) LIKE TO_CHAR(TRUNC(sysdate, 'MM') - 1, '%_MM_YYYY%')
              or ts# in
                 (select distinct ts# from v$datafile where enabled = 'READ ONLY')
    )
    START WITH prev_id IS NULL
    CONNECT BY prev_id  = prior tablespace_name
  ORDER BY 2 DESC
  )
WHERE rownum = 1;

SELECT 'alter database open resetlogs;' text FROM DUAL;

--
--Run block end
--
SELECT '}' text FROM DUAL;
SELECT 'QUIT;' text FROM DUAL;



spool off

-- https://docs.oracle.com/database/121/TGSQL/tgsql_sts.htm#TGSQL526

-- Выполняем на БД с хорошим планом


BEGIN
  DBMS_SQLTUNE.DROP_SQLSET(
    sqlset_name => '3fxxtvzfysr8c_pack');
END;


BEGIN
  DBMS_SQLTUNE.CREATE_SQLSET (
    sqlset_name  => '3fxxtvzfysr8c_pack',
   description  => 'STS to store SQL from the private SQL area' );
END;

SELECT NAME, S.OWNER, STATEMENT_COUNT, DESCRIPTION FROM   DBA_SQLSET S;

select * from dba_hist_snapshot

DECLARE
cur sys_refcursor;
BEGIN
 OPEN cur FOR
   SELECT VALUE(p) FROM TABLE(DBMS_SQLTUNE.select_workload_repository(basic_filter => 'sql_id = ''3fxxtvzfysr8c''',begin_snap => 126727,end_snap => 127208)) p;
-- load the tuning set
  DBMS_SQLTUNE.LOAD_SQLSET (sqlset_owner => 'FBORYMSKY', sqlset_name     => '3fxxtvzfysr8c_pack',  populate_cursor =>  cur );
END;
/

SELECT * FROM  DBA_SQLSET_STATEMENTS where sqlset_name = '3fxxtvzfysr8c_pack'
SELECT * FROM TABLE(DBMS_SQLTUNE.select_workload_repository(basic_filter => 'sql_id = ''c2n7cj9cb26gz''',begin_snap => 126655,end_snap => 127208)) p;


DECLARE
cur sys_refcursor;
BEGIN
open cur for
--select value(p) from table(dbms_sqltune.select_workload_repository(begin_snap => 126655,end_snap => 127208,basic_filter => 'sql_id = ''c2n7cj9cb26gz''')) p;
select value(p) from table(dbms_sqltune.select_workload_repository(begin_snap => 126655,end_snap => 127208,basic_filter => 'sql_id = ''c2n7cj9cb26gz''')) p;
dbms_sqltune.load_sqlset(sqlset_name     => 'c2n7cj9cb26gz_pack',  populate_cursor =>  cur);
close cur;
END;
/


DECLARE
  cur sys_refcursor;
BEGIN
open cur for
 select value(p) from table(dbms_sqltune.select_workload_repository(
      begin_snap => 126655,
      end_snap => 127208,
      basic_filter => 'plan_hash_value = ''760537659''')) p;
    dbms_sqltune.load_sqlset('c2n7cj9cb26gz_pack', cur);
  close cur;
END;
/

DECLARE
  c_sqlarea_cursor DBMS_SQLTUNE.SQLSET_CURSOR;
BEGIN
 OPEN c_sqlarea_cursor FOR
   SELECT VALUE(p) FROM TABLE(DBMS_SQLTUNE.SELECT_CURSOR_CACHE('sql_id = ''c2n7cj9cb26gz''')) p;
-- load the tuning set
  DBMS_SQLTUNE.LOAD_SQLSET (sqlset_name     => 'c2n7cj9cb26gz_pack',  populate_cursor =>  c_sqlarea_cursor );
END;
/


SELECT SQL_ID, PARSING_SCHEMA_NAME AS , SQL_TEXT, ELAPSED_TIME, BUFFER_GETS FROM   TABLE( DBMS_SQLTUNE.SELECT_SQLSET('4770QWKNSADJT_PACK',sqlset_owner => 'SMASTER'));


BEGIN
  DBMS_SQLTUNE.CREATE_STGTAB_SQLSET ( 
    table_name  => 'MY_12_STAGING_TABLE'
,   schema_name => 'FBORYMSKY');
END;


--
BEGIN
  DBMS_SQLTUNE.PACK_STGTAB_SQLSET(sqlset_name => 'c2n7cj9cb26gz_pack',
                                  sqlset_owner =>'FBORYMSKY',
                                  staging_table_name => 'MY_12_STAGING_TABLE', 
                                  staging_schema_owner => 'FBORYMSKY');
END;


select * from FBORYMSKY.MY_12_STAGING_TABLE



-- exp userid=smaster file=5SMKSQCGP7HQC_B2.dmp log=5SMKSQCGP7HQC_B2.log tables=SMASTER.SQLSET_TAB compress=no recordlength=65535 direct=y feedback=1000000 CONSISTENT=N
-- imp userid=smaster file=5SMKSQCGP7HQC_B2.dmp log=5SMKSQCGP7HQC_B2.log fromuser=smaster touser=smaster recordlength=65535 feedback=100000


-- На базе приемнике с плохим планом

BEGIN 
DBMS_SQLTUNE.unpack_stgtab_sqlset(sqlset_name => '4770QWKNSADJT_PACK', 
sqlset_owner => 'SMASTER', 
replace => TRUE, 
staging_table_name => 'MY_12_STAGING_TABLE', 
staging_schema_owner => 'FBORYMSKY'); 
END; 


declare
  cnt number;
  bf  varchar2(4000);
BEGIN
  bf  := 'plan_hash_value=''992954542''';
  cnt := DBMS_SPM.LOAD_PLANS_FROM_SQLSET(sqlset_name  => 'B2PZDVVUF3DYN_STS',
                                         sqlset_owner => 'SYS',
                                         basic_filter =>bf);
END;

declare
  cnt number;
  bf  varchar2(4000);
BEGIN
  bf  := 'sql_id=''c2n7cj9cb26gz''';
  cnt := DBMS_SPM.LOAD_PLANS_FROM_SQLSET(sqlset_name  => 'c2n7cj9cb26gz_pack',basic_filter =>bf);
END;

select * from dba_sql_plan_baselines order by created
select * from dba_sqlset_plans where sqlset_name='3fxxtvzfysr8c_pack' sql_id='c2n7cj9cb26gz'--sqlset_name='c2n7cj9cb26gz_pack'


declare
  cnt number;
BEGIN
  cnt := DBMS_SPM.load_plans_from_cursor_cache(sql_id => 'c2n7cj9cb26gz');
END;



/*SELECT SQL_ID,
       SQL_TEXT,
       PLAN_HASH_VALUE,
       PARSING_SCHEMA_NAME,
       ELAPSED_TIME,
       SQLSET_OWNER,
       SQLSET_NAME
  FROM DBA_SQLSET_STATEMENTS
 WHERE 
       upper(SQL_ID)=upper('dx2d8vm12fhkf');*/
       
select * from table( 
    dbms_xplan.display_sql_plan_baseline( 
        sql_handle=>'SQL_fb6dd5ca267dcf78', 
        format=>'basic'));       
       
select * from dba_sql_plan_baselines where plan_name='SQL_PLAN_5p4ybdv7gt6sn34ba86f3';

select * from v$sql_plan where hash_value=1754941359
       
 select *
   from dba_sql_plan_baselines
  where origin = 'MANUAL-LOAD'
    and created > sysdate - 1
    and fixed = 'NO'
       
SET SERVEROUTPUT ON
SET LONG 10000
DECLARE
    report clob;
BEGIN
    report := DBMS_SPM.EVOLVE_SQL_PLAN_BASELINE(
                  sql_handle => 'SQL_c906d0d7eef50761');
    DBMS_OUTPUT.PUT_LINE(report);
END;
/




set serveroutput on;
declare
i binary_integer;
begin
i:=dbms_spm.alter_sql_plan_baseline(sql_handle => 'SQL_5a93cb6ecefc9b14',plan_name => 'SQL_PLAN_5p4ybdv7gt6sn34ba86f3',attribute_name => 'FIXED',attribute_value => 'NO');
dbms_output.put_line(i);
end;


set serveroutput on;
declare
i binary_integer;
begin
i:=dbms_spm.alter_sql_plan_baseline(sql_handle => 'SQL_21943fddf4aa124b',plan_name => 'SQL_PLAN_2351zvruan4kb68affdeb',attribute_name => 'ENABLED',attribute_value => 'NO');
dbms_output.put_line(i);
end;


select * from dba_sql_profiles where name='SYS_SQLPROF_014c31aab0f70004'

select p.other_xml
from dba_sqltune_plans p, dba_sql_profiles s
where p.task_id=s.task_id
and s.name='SYS_SQLPROF_014c31aab0f70004'
and p.attribute='Using SQL profile'
and p.id=1;

select DBMS_SQLTUNE.REPORT_TUNING_TASK('SQL_TUNING_1426775166568') from dual;
end;


SELECT   * FROM    dba_sql_management_config;

select * from dba_sql_plan_baselines order by created

select distinct plan_hash_value from dba_hist_sql_plan where sql_id='3fxxtvzfysr8c'

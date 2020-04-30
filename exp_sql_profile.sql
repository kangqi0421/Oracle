-- http://docs.oracle.com/database/121/TGSQL/tgsql_profiles.htm#TGSQL596

BEGIN
  DBMS_SQLTUNE.CREATE_STGTAB_SQLPROF ( 
    table_name  => 'my_profile_table'
,   schema_name => 'fborymsky' 
);
END;


BEGIN
  DBMS_SQLTUNE.PACK_STGTAB_SQLPROF (  
    profile_name         => 'SYS_SQLPROF_015d08ee28880007'
,   staging_table_name   => 'my_profile_table'
,   staging_schema_owner => 'fborymsky' 
);
END;
/ 

select * from fborymsky.my_profile_table
--export import

BEGIN
  DBMS_SQLTUNE.UNPACK_STGTAB_SQLPROF(
     replace            => true,
     staging_schema_owner => 'fborymsky'
,    staging_table_name => 'my_profile_table'
);
END;
/




---


BEGIN
  DBMS_SPM.CREATE_STGTAB_BASELINE (
    table_owner => 'FBORYMSKY',  
    table_name => 'my_baseline_table');
END;
/

select * from FBORYMSKY.MY_BASELINE_TABLE
select * from dba_sql_plan_baselines b where b.PLAN_NAME='SQL_PLAN_ajf4p1bypht49436650e0'

DECLARE
  v_plan_cnt NUMBER;
BEGIN
  v_plan_cnt := DBMS_SPM.PACK_STGTAB_BASELINE (
  sql_handle =>  'SQL_a8b8950afd586489'
,   table_owner =>'FBORYMSKY'
,   table_name => 'my_baseline_table'
--,   enabled    => 'yes'
--,   creator    => 'SMASTER'
);
END;
/


-- exp imp
DECLARE
  v_plan_cnt NUMBER;
BEGIN
  v_plan_cnt := DBMS_SPM.UNPACK_STGTAB_BASELINE (
    table_name => 'stage1'
,   fixed      => 'yes'
);
END;
/

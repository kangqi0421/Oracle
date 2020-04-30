--How to Move SQL Profiles from One Database to Another (Including to Higher Versions) (Doc ID 457531.1)


select * from dba_indexes where owner='MLINK21'
select * from dba_ind_columns where index_name='ERR_PTS_IDX'

select * from MLINK21.ERRORS emp where POSTTIMESTAMP<sysdate
select /*+ no_index(emp ERR_PTS_IDX) */ * from MLINK21.ERRORS emp where POSTTIMESTAMP<sysdate

select * from V$sql_Plan where object_name like '%ERRORS%'


-- 1. Create SQL Profile in SCOTT schema

DECLARE 
my_task_name VARCHAR2(30);
my_sqltext CLOB; 
my_sqlprofile_name VARCHAR2(30); 
BEGIN 
  my_sqltext := 'select /*+ no_index(emp ERR_PTS_IDX) */ * from MLINK21.ERRORS emp where POSTTIMESTAMP<sysdate'; 
  my_task_name := DBMS_SQLTUNE.CREATE_TUNING_TASK(sql_text => my_sqltext, 
        user_name => 'FBORYMSKY', 
        scope => 'COMPREHENSIVE', 
        time_limit => 60, 
        task_name => 'my_sql_tuning_task1', 
        description => 'Demo Task to tune a query'); 
  
DBMS_SQLTUNE.EXECUTE_TUNING_TASK( task_name => 'my_sql_tuning_task1'); 

my_sqlprofile_name := DBMS_SQLTUNE.ACCEPT_SQL_PROFILE (task_name =>'my_sql_tuning_task1', 
        name => 'my_sql_profile'); 
END; 
/


--2. Creating a staging table to store the SQL Profiles

exec DBMS_SQLTUNE.CREATE_STGTAB_SQLPROF(table_name=>'STAGE',schema_name=>'FBORYMSKY');

--3. Pack the SQL Profiles into the Staging Table

exec DBMS_SQLTUNE.PACK_STGTAB_SQLPROF (staging_table_name =>'STAGE',profile_name=>'my_sql_profile');

--4. Export the Staging Table to the Target Database
--4b. Import into Target Database

--5. Unpack Staging Table
--If importing to the same schema, schema owner does not need to be specified:
EXEC DBMS_SQLTUNE.UNPACK_STGTAB_SQLPROF(replace => TRUE,staging_table_name => 'STAGE');
--However, if importing to different schema, the staging schema owner needs to be changed:|
EXEC DBMS_SQLTUNE.UNPACK_STGTAB_SQLPROF(replace => TRUE,staging_table_name => 'STAGE',staging_schema_owner => 'SQLTXPLAIN');

--6. Check the SQL Profile is enabled in Target Database

alter table SPM.PARAM MOVE tablespace WELCOMESMS_TBS parallel 4;
alter table SPM.PARAM noparallel;

alter index SPM.INDX$PARAM$SEARCH rebuild tablespace WELCOMESMS_TBS parallel 4;
alter index SPM.INDX$PARAM$SEARCH noparallel;
alter index SPM.INDX$PARAM$SDATE rebuild tablespace WELCOMESMS_TBS parallel 4;
alter index SPM.INDX$PARAM$SDATE noparallel;
alter index SPM.INDX$PARAM$EDATE rebuild tablespace WELCOMESMS_TBS parallel 4;
alter index SPM.INDX$PARAM$EDATE noparallel;

alter table SPM.VERSION MOVE tablespace WELCOMESMS_TBS parallel 4;
alter table SPM.VERSION noparallel;


select * from dba_indexes where owner='SPM' and table_name='VERSION'


select * from dba_queue_subscribers where owner='SPM'
select * from dba_queue_tables where owner='SPM'
select * from dba_queues where owner='SPM'
select * from dba_users where username='AQMOVE'
select * from dba_objects where owner='AQMOVE'
select * from dba_objects where owner='SPM'
select * from dba_users where username='SPM'
select * from dba_indexes where owner='SPM' and index_name='SYS_IOT_TOP_1465423'


create table fborymsky.sub_spm as 
select * from dba_queue_subscribers where owner='SPM';

select * from fborymsky.sub_spm

select * from dba_queue_subscribers where owner='SPM';


create table fborymsky.obj_spm as 
select * from dba_objects where owner='SPM';

select * from fborymsky.obj_spm;


begin
DBMS_UTILITY.compile_schema(schema => 'SPM');
end;



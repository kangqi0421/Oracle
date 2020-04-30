select distinct s.username,mode_held,--blocking_others,
       'alter system kill session '''||s.sid||', '|| s.SERIAL# ||''' immediate;',
       'kill -9 ' || p.spid,
       dl.name,
       s.STATUS,
       s.PROGRAM,
       s.SQL_ID,
       s.SQL_CHILD_NUMBER
  from dba_ddl_locks dl, v$session s, v$process p
 where dl.name in ('DWH_CALL_DETAILS','CDR_CALLS')-- dl.name in ('CDR_CALLS_RW')
   and s.paddr = p.addr
   and dl.session_id = s.SID
   and s.STATUS = 'ACTIVE'
   and s.PROGRAM!='sqlplus.exe'

select * from dba_ddl_locks

select 'alter system kill session '''||s.sid||', '|| s.SERIAL# ||''' immediate;',a.OWNER,a.object,a.type,s.USERNAME,s.machine, s.PROGRAM,s.OSUSER,s.status
from V$access a, V$session s where a.SID=s.SID and a.OBJECT in ('CDR_CALLS')

--select * from dba_dml_locks
select o.OWNER, o.OBJECT_NAME,o.OBJECT_TYPE, status from dba_objects o where owner='MASSMO' and status<>'VALID'
select o.OWNER, o.OBJECT_NAME,o.OBJECT_TYPE, status  from dba_objects o where owner='DWH' and object_type='VIEW' and o.OBJECT_NAME='CDR_CALLS'

select * from dba_dependencies where referenced_name ='CDR_CALLS'
select * from dba_dependencies where referenced_name ='CDR_CALLS_RW'
DWH.CDR_CALLS

select count(*), username from V$session where status='ACTIVE' and username in ('CAREM','MASSMO','MASSMOWSC')  group by username
select count(*), username from V$session where status='ACTIVE' and username in ('DET')  group by username

select count(*), username from V$session where status='ACTIVE' and username in ('')  group by username
--alter user MASSMO account lock;
--alter user MASSMOWSC account lock;
--alter user CAREM account lock;
--alter user DET account lock;
--ALTER PACKAGE MASSMO.DWH_CALL_DETAILS COMPILE PACKAGE; 
--ALTER PACKAGE MASSMO.DWH_CALL_DETAILS COMPILE BODY; 
--ALTER VIEW DWH.CDR_CALLS COMPILE;

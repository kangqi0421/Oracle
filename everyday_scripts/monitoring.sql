--select count(*)
select event, count(*) from v$session group by event order by 2 desc;

select sql_id, count(*) from v$session where event='db file sequential read' group by sql_id order by 2 desc;

SELECT s.event, /*sl.SQL_FULLTEXT,*/ p.spid, b.name, p.spid, s.sid, s.SERIAL#, p.serial#, s.osuser, s.username, s.terminal, s.STATUS,  s.PROGRAM,s.LOGON_TIME,s.SQL_EXEC_START,s.SQL_ID,s.machine,s.SERVICE_NAME
  FROM v$process p, v$session s, v$bgprocess b--, v$sql sl--, sys.audit_actions a
 WHERE p.addr = s.paddr(+)
   AND b.paddr(+) = s.paddr
--   AND sl.SQL_ID=s.SQL_ID
-- and s.event like 'library%'
--   AND s.SQL_EXEC_START>sysdate - 10/24/60 
--   AND s.LOGON_TIME > sysdate - 10/24/60
--   and s.module='OMS'
  and s.sid in (select sid from dba_jobs_running where job in (select job from dba_jobs where lower(what) like '%change_balance%'))
 --  AND s.USERNAME='KRAMARENKO_AS'
   and s.OSUSER not in ('v.bondarenko', 'oracle')
--   and s.STATUS='INACTIVE'
--   and s.seconds_in_wait>10000
--   and s.program='toad.exe'
--   and s.TERMINAL='WSRU-BONDARENKO'
--group by p.SPID;

WSRU-IT-023

-------------------------
select * from dba_hist_active_sess_history dsh where 
sql_exec_start BETWEEN TO_DATE('21.05.2018 14:36:00', 'DD.MM.YYYY HH24:MI:SS') and TO_DATE('21.05.2018 15:00:00', 'DD.MM.YYYY HH24:MI:SS')
 --------------------------------  
 

SELECT 'alter system kill session '''||s.sid||', '||s.SERIAL#||''' immediate;', s.sid, s.SERIAL#, s.*
  FROM v$process p, v$session s, v$bgprocess b--, sys.audit_actions a
 WHERE p.addr = s.paddr(+)
   AND b.paddr(+) = s.paddr
   and s.OSUSER not in ('v.bondarenko', 'oracle')
  -- and s.STATUS='INACTIVE'
--   and s.seconds_in_wait>10000
--   and s.program='toad.exe'
   and s.sid in (select sid from dba_jobs_running where job in (select job from dba_jobs where lower(what) like '%change_balance%'))
--   and s.username='APEX_PUBLIC_USER'

--alter system kill session '93, 26527' immediate;
--alter system kill session 'sid, serial#' immediate;

--Зависимости
select * from dba_dependencies t where t.REFERENCED_OWNER='SPACE' and t.OWNER<>'SPACE';
--
select p.spid, 
       'kill -9 ' || to_number(p.spid) "OS Thread",
       s.status,
       s.username "Name-User",
       s.osuser,
       s.program,
       s.action,
       s.*
  from v$process p, v$session s
 where p.addr = s.paddr
   and s.OSUSER not in ('v.bondarenko', 'oracle')
   and s.STATUS='INACTIVE'
   and s.seconds_in_wait>10000
   and s.program='toad.exe'
--   AND s.USERNAME='APEX_PUBLIC_USER'
--   and s.OSUSER='v.bondarenko';


select s.event, s.*
  from v$session s
 where /*s.username = 'VBONDARENKO'
   and */s.STATUS = 'ACTIVE'
   and s.PROGRAM like '%rman%';

SELECT p.SPID, S.EVENT, S.SECONDS_IN_WAIT AS SEC_WAIT, sw.STATE, CLIENT_INFO
  FROM V$SESSION_WAIT sw, V$SESSION s, V$PROCESS p
 WHERE sw.EVENT LIKE '%MML%'
   AND s.SID = sw.SID
   AND s.PADDR = p.ADDR;
   
--LONG OPERATIONS
select sl.SQL_PLAN_OPTIONS,
       sl.*
  from v$session_longops sl,
       v$session s
 where s.SID=sl.SID
   and s.SERIAL#=sl.SERIAL#
   and s.osuser='v.bondarenko'
--   and s.username='SYS'
 order by sl.target;
 
select event, count(*) from v$session_wait group by event;
 
--Поиск запроса по SQL_ID и SQL_EXEC_ID
select *  from v$sql_monitor m where sql_id = '48p1ruca5d2zy' and sql_exec_id = 16777216;


select * from v$active_session_history ass where ass.SESSION_ID=63


select * from dba_invalid_objects order by last_ddl_time

/*
drop table vbondarenko.invalid_objects;
create table vbondarenko.invalid_objects as select * from dba_invalid_objects;
*/
select * from dba_invalid_objects order by 1,2,6;
select count(*) from vbondarenko.invalid_objects;
select count(*) from dba_invalid_objects;
select owner, object_name, object_type from dba_invalid_objects
 minus 
select owner, object_name, object_type from vbondarenko.invalid_objects
 order by owner, object_name, object_type;




SELECT *
FROM   audit_unified_policies where policy_name like 'ALTER%'


--Проверка что политика включилась
SELECT *
FROM AUDIT_UNIFIED_ENABLED_POLICIES;

--Палевная вьюха
SELECT *
FROM   unified_audit_trail ua where ua.USERHOST='T2RU\WSRU-IT-023' ua.ACTION_NAME ='ALTER PACKAGE'
group by object_name
;

SELECT COUNT(*) FROM unified_audit_trail;


alter package SMASTER.INV_ITOG_1 compile

BEGIN
  DBMS_AUDIT_MGMT.clean_audit_trail(
   audit_trail_type        => DBMS_AUDIT_MGMT.audit_trail_unified,
   use_last_arch_timestamp => FALSE);
END;
/






select * from v$access where object like 'INV_ITOG%'

SELECT *
FROM AUDIT_UNIFIED_ENABLED_POLICIES;

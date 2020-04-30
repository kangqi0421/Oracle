--select count(*)
SELECT s.event, p.spid, b.name, p.spid, s.sid, s.SERIAL#, p.serial#, s.osuser, s.username, s.terminal,s.STATUS, s.SQL_HASH_VALUE,s.SQL_EXEC_START,s.MACHINE,s.PROGRAM,s.SQL_ID,s.SERVICE_NAME
  FROM v$process p, v$session s, v$bgprocess b--, sys.audit_actions a
 WHERE p.addr = s.paddr(+)
   AND b.paddr(+) = s.paddr
--   and s.module='OMS'
--   and s.sid in (2631,2571,2247,1983,1733,1233,1128,1091,842,769,47,45,14)
 --  AND s.USERNAME='CUSTAPI'
 --  and s.SQL_ID='fvv7j6j1fntbz'
  --- and s.SQL_EXEC_START > sysdate - 2/24
   
 --  and event =  'latch: cache buffers chains'
   and s.OSUSER not in 'oracle'
   and s.STATUS='ACTIVE'
   and s.TERMINAL='WSRU-BONDARENKO'
--group by p.SPID
--

select * from dba_jobs_running
select * from v$sqltext where sql_id = 'fvv7j6j1fntbz'

SELECT 'alter system kill session '''||s.sid||', '||s.SERIAL#||''' immediate;', s.sid, s.SERIAL#, s.*
  FROM v$process p, v$session s, v$bgprocess b--, sys.audit_actions a
 WHERE p.addr = s.paddr(+)
   AND b.paddr(+) = s.paddr
 --  and s.sid in (2631,2571,2247,1983,1733,1233,1128,1091,842,769,47,45,14)
 --  and s.username='APEX_PUBLIC_USER'
      AND s.USERNAME='CUSTAPI'
   and s.SQL_ID='fvv7j6j1fntbz'
--alter system kill session '93, 26527' immediate;
--alter system kill session 'sid, serial#' immediate;

--Зависимости
select * from dba_dependencies t where t.REFERENCED_OWNER='SPACE' and t.OWNER<>'SPACE'
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
   AND s.USERNAME='APEX_PUBLIC_USER'
--   and s.OSUSER='v.bondarenko'
   and s.PROGRAM like 'oracle@burger.nix.tele2.ru (%'
   and s.STATUS='ACTIVE'
--
select s.event, s.*
  from v$session s
 where /*s.username = 'VBONDARENKO'
   and */s.STATUS = 'ACTIVE'
   and s.PROGRAM like '%rman%'
--
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
--   and s.osuser='v.bondarenko'
--   and s.username='SYS'
 order by sl.target;
 
select event, count(*) from v$session_wait group by event;
 
--Поиск запроса по SQL_ID и SQL_EXEC_ID
select *  from v$sql_monitor m where sql_id = '8n68w95a5wz0t' and sql_exec_id = 16777216;

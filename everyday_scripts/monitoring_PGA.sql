SELECT * FROM V$PGASTAT order by 1;

SELECT p.program,
       p.pga_used_mem,
       p.pga_used_mem/1024/1024 pga_used_mem_mb,
       p.pga_alloc_mem,
       p.pga_freeable_mem,
       p.pga_max_mem,
       s.sid,
       s.serial#,
       s.event, 
       p.spid, 
       b.name, 
       p.spid, 
       s.sid, 
       s.SERIAL#,
       p.serial#, 
       s.osuser, 
       s.username, 
       s.terminal, 
       s.STATUS, 
       s.*
  FROM V$PROCESS p, v$session s, v$bgprocess b
 WHERE p.addr = s.paddr(+)
   AND b.paddr(+) = s.paddr
 order by p.pga_used_mem desc;

 
 SELECT sum(p.pga_used_mem/1024/1024) pga_used_mem_mb
      
  FROM V$PROCESS p, v$session s, v$bgprocess b
 WHERE p.addr = s.paddr(+)
   AND b.paddr(+) = s.paddr
 order by p.pga_used_mem desc;

select * from v$pga_target_advice order by pga_target_for_estimate;

select max(pga_used_mem)/1024/1024/1024, max(pga_alloc_mem)/1024/1024/1024, max(pga_max_mem)/1024/1024/1024 from v$process;


select sum(PGA_MB_USED)/1024 from
(
SELECT DECODE(TRUNC(SYSDATE - LOGON_TIME), 0, NULL, TRUNC(SYSDATE - LOGON_TIME) || ' Days' || ' + ') || 
TO_CHAR(TO_DATE(TRUNC(MOD(SYSDATE-LOGON_TIME,1) * 86400), 'SSSSS'), 'HH24:MI:SS') LOGON, 
SID, v$session.SERIAL#, v$process.SPID , ROUND(v$process.pga_used_mem/(1024*1024), 2) PGA_MB_USED, 
v$session.USERNAME, STATUS, OSUSER, MACHINE, v$session.PROGRAM, MODULE 
FROM v$session, v$process 
WHERE v$session.paddr = v$process.addr
--and status = 'ACTIVE' 
--and v$session.sid in (select sid from v$session where username='CAREM')
--and v$session.username = 'CAREM' 
--and v$process.spid = 24301
ORDER BY pga_used_mem DESC
) 

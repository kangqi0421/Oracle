SELECT DECODE(TRUNC(SYSDATE - LOGON_TIME), 0, NULL, TRUNC(SYSDATE - LOGON_TIME) || ' Days' || ' + ') || 
TO_CHAR(TO_DATE(TRUNC(MOD(SYSDATE-LOGON_TIME,1) * 86400), 'SSSSS'), 'HH24:MI:SS') LOGON, 
SID, v$session.SERIAL#, v$process.SPID , ROUND(v$process.pga_used_mem/(1024*1024), 2) PGA_MB_USED, 
v$session.USERNAME, STATUS, OSUSER, MACHINE, v$session.PROGRAM, MODULE 
FROM v$session, v$process 
WHERE v$session.paddr = v$process.addr 
--and status = 'ACTIVE' 
--and v$session.sid = 97
--and v$session.username = 'SYSTEM' 
--and v$process.spid = 24301
--and osuser = 'Michail.Drugomilov'
ORDER BY pga_used_mem DESC;

SELECT ROUND(SUM(pga_used_mem)/(1024*1024),2) PGA_USED_MB FROM v$process;
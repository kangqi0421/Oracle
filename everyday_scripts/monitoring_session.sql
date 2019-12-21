SELECT s.event, /*sl.SQL_FULLTEXT,*/ p.spid, b.name, s.sid, s.SERIAL#, p.serial#, s.osuser, s.username, s.terminal, s.STATUS, s.SQL_ID
  FROM v$process p, v$session s, v$bgprocess b--, v$sql sl--, sys.audit_actions a
 WHERE p.addr = s.paddr(+)
   AND b.paddr(+) = s.paddr
--   AND sl.SQL_ID=s.SQL_ID
--   and s.event='db file sequential read'
--   and s.module='OMS'
--   and s.sid in (2631,2571,2247,1983,1733,1233,1128,1091,842,769,47,45,14)
 --  AND s.USERNAME='CAREM'
   and s.OSUSER = 'sergey.gavrilov'
   and s.STATUS='ACTIVE'
--   and s.seconds_in_wait>10000
--   and s.program='toad.exe'
--   and s.TERMINAL='WSRU-BONDARENKO'
--group by p.SPID;
select 'kill -9 ' || to_number(p.spid) "OS Thread",
       s.status,
       s.username "Name-User",
       s.osuser,
       s.program,
       s.action
  from v$process p, v$session s
 where p.addr = s.paddr
   and s.username = 'SMASTER'
   and s.program like '%(J%';

--PARALLEL PROCESSES
select * from v$px_process t where t.STATUS='AVAILABLE';
--
select * from v$px_process t order by t.STATUS;

--SESSIONS
select pp.*, s.USERNAME
  from v$px_process pp,
       v$session s
 where pp.SID=s.SID
   and pp.STATUS='IN USE'
--   and s.USERNAME='VBONDARENKO'
 order by s.USERNAME;
--
select count(*), s.USERNAME
  from v$px_process pp,
       v$session s
 where pp.SID=s.SID
   and pp.STATUS='IN USE'
 group by s.USERNAME
 order by s.USERNAME;

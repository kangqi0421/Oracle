--Wait_class
select count(1), sum(seconds_in_wait) all_seconds, wait_class
  from v$session
 where status = 'ACTIVE'
   and type != 'BACKGROUND'
   and wait_class != 'Idle'
   and module not like 'backup%'
 group by wait_class
 order by 1 desc;

--Events in wait_class
select count(1), sum(seconds_in_wait) all_seconds, event
  from v$session
 where wait_class = 'Concurrency'
   and status = 'ACTIVE'
   and type != 'BACKGROUND'
   and module not like 'backup%'
 group by event
 order by 1 desc;

--Sessions with event
select sid, event
  from v$session
 where status = 'ACTIVE'
   and type != 'BACKGROUND'
   and wait_class != 'Idle'
   and event = 'buffer busy waits'
 order by 1 desc;

select ses.sid,
       ses.event,
       ses.username,
       ses.program,
       ses.module,
       sql.sql_id,
       sql.sql_text
  from v$session ses, v$sql sql
 where ses.status = 'ACTIVE'
   and ses.type != 'BACKGROUND'
   and ses.wait_class != 'Idle'
   and ses.event = 'buffer busy waits'
   and ses.sql_id = sql.sql_id;

select * from v$sql where sql_id = '5vnzcxp8mgwj2';

SELECT a.sid, a.serial#, b.spid
  FROM v$session a, v$process b
 WHERE a.paddr = b.addr
   and a.sid = 97;

SELECT Decode(request, 0, 'Holder: ', 'Waiter: ') || vl.sid sess,
       status,
       id1,
       id2,
       lmode,
       request,
       vl.TYPE
  FROM v$lock vl, v$session vs
 WHERE (id1, id2, vl.TYPE) IN
       (SELECT id1, id2, TYPE FROM v$lock WHERE request > 0)
   AND vl.sid = vs.sid
 ORDER BY id1, request;

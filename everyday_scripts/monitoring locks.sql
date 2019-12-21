--================================================================
--Список блокировок:
--================================================================
SELECT username, osuser, program, blocking_session FROM V$session WHERE blocking_session is not NULL;
------------------------------------------------------------------------------
SELECT DECODE(request, 0, 'Держит: ', ' Ждет: ') || vl.sid sess,
       CTIME,
       vl.SID,
       serial#,
       audsid,
       SQL_ID,
       CLIENT_IDENTIFIER,
       program,
       MODULE,
       action
  FROM V$LOCK vl
  JOIN v$session vs
    ON vl.sid = vs.sid
 WHERE (id1, id2, vl.type) IN
       (SELECT id1, id2, type FROM V$LOCK WHERE request > 0)
 ORDER BY id1, request;

SELECT LEVEL, LPAD (' ', (LEVEL - 1) * 2, ' ')
           || NVL (s.username, '(oracle)') AS username,
           s.osuser, s.SID, s.serial#, s.lockwait, s.status, s.module,
           s.machine, s.program,
           TO_CHAR (s.logon_time, 'DD-MON-YYYY HH24:MI:SS') AS logon_time
      FROM v$session s
CONNECT BY PRIOR s.SID = s.blocking_session
START WITH s.blocking_session IS NULL
ORDER BY LEVEL;
------------------------------------------------------------------------------
select distinct o.object_name,
                sh.username || '(' || sh.sid || ',' || sh.serial# || ')' Holder,
                sh.osuser,
                sw.username || '(' || sw.sid || ',' || sw.serial# || ')' Waiter,
                decode(lh.lmode,
                       1,
                       'null',
                       2,
                       'row share',
                       3,
                       'row exclusive',
                       4,
                       'share',
                       5,
                       'share row exclusive',
                       6,
                       'exclusive') Lock_Type
  from v$session sw, v$lock lw, all_objects o, v$session sh, v$lock lh
 where lh.id1 = o.object_id
   and lh.id1 = lw.id1
   and sh.sid = lh.sid
   and sw.sid = lw.sid
   and sh.lockwait is null
   and sw.lockwait is not null
   and lh.type = 'TM'
   and lw.type = 'TM';
------------------------------------------------------------------------------

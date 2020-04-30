select /*+rule*/distinct t.sid,t1.OSUSER,t1.MACHINE,t.USERNAME,t.OPNAME,t.TARGET,t.TIME_REMAINING rem,t.ELAPSED_SECONDS ela,sq.SQL_TEXT,t.SQL_HASH_VALUE,t.SQL_ID
from v$session_longops t,v$session t1,v$sql sq,dba_jobs_running dj
where t.TIME_REMAINING!=0
and t1.STATUS='ACTIVE'
and t.SID=t1.SID
and t.sid=dj.sid(+)
and t.SERIAL#=t1.SERIAL#
and sq.ADDRESS(+)=t1.SQL_ADDRESS
and sq.HASH_VALUE(+)=t1.SQL_HASH_VALUE
--select /*+rule*/* from dba_jobs_running
--and t1.OSUSER='adamenko'

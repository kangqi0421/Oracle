select 
s.PROCESS
--,s.PID
,s.PID
,s.STATUS
,s.BLOCK#
,s.BLOCKS
,s.SEQUENCE#
,s.DELAY_MINS
from 
   v$managed_standby s;
   
   
   select * from v$archive_processes
   
   
   V$STANDBY_EVENT_HISTOGRAM
   V$DATAGUARD_STATS
   
     
   
    select GROUP#,SEQUENCE#,USED,STATUS from v$standby_log;
    
    
    
    
    
    select * from v$archived_log a where a.SEQUENCE#>=250316
    
    select * from v$standby_apply_snapshot
    
SELECT ARCHIVED_THREAD#, ARCHIVED_SEQ#, APPLIED_THREAD#, APPLIED_SEQ#
FROM V$ARCHIVE_DEST_STATUS;

SELECT m.TIMESTAMP time,MESSAGE FROM V$DATAGUARD_STATUS m order by m.MESSAGE_NUM;

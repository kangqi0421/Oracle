select s.EVENT,'alter system kill session '''||s.sid||', '|| s.SERIAL# ||''' immediate;','kill -9 ' ||p.SPID,s.SQL_ID, s.sid, s.serial#, p.spid, s.STATUS,s.SQL_EXEC_START, s.username, s.osuser, s.machine, p.terminal, s.program, s.CLIENT_INFO
from v$session s, v$process p
where p.addr = s.paddr
--and w.event = 'SQL*Net message from client'
--and s.status = 'ACTIVE'
--and s.SID in (3174)
and s.USERNAME='SRF01'
and status='ACTIVE'
and s.SQL_EXEC_START<sysdate-1/24/2
--and sql_id='4r14kndjp4fr7'
and sql_id in ('ak8tgtxgda1u3','4r14kndjp4fr7')

select * from dba_users where username='DET'

alter user DET profile prof_sys_s300;

--and s.SQL_EXEC_START between sysdate-1/24 and sysdate-1/24/60
--and s.CLIENT_INFO like '%KRISTINA.PUSTOVETOVA%'
order by s.osuser, s.terminal, s.SQL_EXEC_START

alter system kill session '3174, 44666' immediate;
--91g4udymptp3q

select * from dba_objects where object_name in ('IN_CALL_S','GPRS_CALLS_AGG')
select sum(bytes)/1024/1024/1024 from dba_segments where segment_name='GPRS_CALLS_AGG'

alter system kill session '479, 34614' immediate;

select * from V$sql where sql_id in ('91g4udymptp3q','66zf8n3bun2hk')

DWH.CLIENT_BALANCE_TYPE_NAMES ("BALANCE_TYPE")


select * from dba_ind_partitions

﻿select /*jr.job,*/sysdate dt_snap, s.logon_time,s.ACTION,a.SQL_FULLTEXT,u.BLOCKS*(select value from V$parameter p where p.NAME='db_block_size')/1024/1024 MB,s.USERNAME,s.SCHEMANAME, s.SQL_ID, s.SID,s.SERVICE_NAME , u.TABLESPACE, s.TERMINAL, s.PROGRAM, s.MACHINE, u.SEGTYPE, s.MODULE  
from V$tempseg_Usage u, V$session s, V$sql a--, dba_jobs_running jr 
where 
u.SESSION_ADDR=s.SADDR 
AND u.SESSION_NUM=S.SERIAL#
and a.SQL_ID=s.SQL_ID 
AND S.SQL_ADDRESS=a.ADDRESS
AND S.SQL_CHILD_NUMBER=a.CHILD_NUMBER
--and jr.sid=s.SID
--and jr.job in (20000041, 20000042, 20000043, 20000044, 20000045)
order by u.BLOCKS*(select value from V$parameter p where p.NAME='db_block_size')/1024/1024 desc
-- and s.username='YARAKHMEDOV_O_T';
----

select value from V$parameter p where p.NAME='db_block_size'

select * from dba_jobs_running where job in (20000041, 20000042, 20000043, 20000044, 20000045)
----

-- Запросы из истории, которые потребили тепов, более чем значение 

select sql_id,max(TEMP_SPACE_ALLOCATED)/(1024*1024*1024) gig 
from DBA_HIST_ACTIVE_SESS_HISTORY 
where 
sample_time > sysdate-3 and 
TEMP_SPACE_ALLOCATED > (50*1024*1024*1024) 
group by sql_id order by sql_id;


select * from V$sql where sql_id in ('0vpxgc1mnx6bv','7sk4b5zdqhb9c', 'g00y0kw3zcsds')
select * from dba_hist_sqltext where sql_id in ('0vpxgc1mnx6bv','7sk4b5zdqhb9c', 'g00y0kw3zcsds') 


--This will show you all the SQL queries that ran during the chosen snap interval/s, ranked by their maximum sampled temp space allocation per snap interval.

select round(temp_space_gb,1) temp_space_gb,
c.sql_text,
a.snap_id,
to_char(begin_interval_time,’dd/mm/yyyy hh24:mi’) begin_interval_time,
to_char(end_interval_time,’dd/mm/yyyy hh24:mi’) end_interval_time,
b.sql_id
from dba_hist_snapshot a
left join dba_hist_sqlstat b
on b.snap_id = a.snap_id
left join dba_hist_sqltext c
on c.sql_id = b.sql_id
inner join (
select snap_id, sql_id, max(temp_space_allocated) / (1024*1024*1024) temp_space_gb
from dba_hist_active_sess_history
group by snap_id, sql_id) d
on d.snap_id = a.snap_id
and d.sql_id = b.sql_id
where
begin_interval_time >= to_date (’02/05/2017 12:00′,’dd/mm/yyyy hh24:mi’)
and end_interval_time <= to_date ('02/05/2017 13:01 ','dd/mm/yyyy hh24:mi')
and temp_space_gb is not null
order by temp_space_gb desc;

-- Following query gives sql_id and maximum allocated temp space of any queries that ran in the past 2 hours and exceeded 10 GB of temp space.
select sql_id,session_id,session_serial#,max(TEMP_SPACE_ALLOCATED)/(1024*1024*1024) gig
from gv$active_session_history
where
sample_time > sysdate-2/24 and
TEMP_SPACE_ALLOCATED > (10*1024*1024*1024)
group by sql_id,session_id,session_serial# order by GIG desc;


SELECT A.tablespace_name tablespace,
       D.mb_total,
       SUM(A.used_blocks * D.block_size) / 1024 / 1024 mb_used,
       D.mb_total - SUM(A.used_blocks * D.block_size) / 1024 / 1024 mb_free
  FROM v$sort_segment A,
       (SELECT B.name, C.block_size, SUM(C.bytes) / 1024 / 1024 mb_total
          FROM v$tablespace B, v$tempfile C
         WHERE B.ts# = C.ts#
         GROUP BY B.name, C.block_size) D
 WHERE A.tablespace_name = D.name
 GROUP by A.tablespace_name, D.mb_total;
----
SELECT se.username username,
       se.SID sid,
       se.serial# serial#,
       se.status status,
       se.sql_hash_value,
       se.prev_hash_value,
       se.machine machine,
       su.TABLESPACE tablespace,
       su.segtype,
       su.CONTENTS CONTENTS
  FROM v$session se, v$sort_usage su
 WHERE se.saddr = su.session_addr;

----
select u.USERNAME, sum(u.BLOCKS)*8192*2/1024/1024/1024 MB, sum(blocks) AS blocks
from v$tempseg_usage u 
where USERNAME ='BERESCHENKO_AV'
group by (u.USERNAME) 
order by 2 desc; 

----

select * /*sum(MB)/1024*/ from fborymsky.temp_tempseg_usage where dt_snap 
between to_date ('00:10:00 18.05.2018', 'hh24:mi:ss dd.mm.yyyy') and to_date ('01:00:00 18.05.2018', 'hh24:mi:ss dd.mm.yyyy') 
and tablespace='TEMP_FAST'


---

select * /*sum(MB)/1024*/ from fborymsky.temp_tempseg_usage where dt_snap 
between to_date ('00:10:00 18.05.2018', 'hh24:mi:ss dd.mm.yyyy') and to_date ('01:00:00 18.05.2018', 'hh24:mi:ss dd.mm.yyyy') 
and tablespace='TEMP_FAST'



 
select sum(MB)/1024 from fborymsky.temp_tempseg_usage where trunc(dt_snap,'MI')>=to_date('180520180120','DDMMYYYYHH24MI') and trunc(dt_snap,'MI')<=to_date('180520180140','DDMMYYYYHH24MI') and tablespace='TEMP_FAST' order by mb desc ;
select sum(MB)/1024 from fborymsky.temp_tempseg_usage where trunc(dt_snap,'MI')>=to_date('170520180040','DDMMYYYYHH24MI') and trunc(dt_snap,'MI')<=to_date('170520180110','DDMMYYYYHH24MI') and tablespace='TEMP_FAST' order by mb desc; 

--How To Find Where The Memory Is Growing For A Process (Doc ID 822527.1)


SELECT * FROM V$PGASTAT order by 1;

SELECT pga_used_mem/1024/1024, pga_alloc_mem/1024/1024, pga_freeable_mem/1024/1024, pga_max_mem/1024/1024, s.* FROM V$PROCESS p, V$session s where p.addr = s.paddr order by pga_used_mem desc;

SELECT sum(pga_alloc_mem/1024/1024/1024)FROM V$PROCESS p, V$session s where p.addr = s.paddr order by pga_used_mem desc;

SELECT pga_used_mem/1024/1024, pga_alloc_mem/1024/1024, pga_freeable_mem/1024/1024, pga_max_mem/1024/1024, s.* FROM V$PROCESS p, V$session s where p.addr = s.paddr and s.ACTION='GPRS_DATA_SHIFT' order by pga_used_mem desc;


SELECT pga_used_mem/1024/1024, pga_alloc_mem/1024/1024, pga_freeable_mem/1024/1024, pga_max_mem/1024/1024, s.* FROM V$PROCESS p, V$session s where p.addr = s.paddr order by pga_used_mem desc;


select ((select value from sys.v_$parameter where name='pga_aggregate_limit') - (SELECT sum(pga_alloc_mem) FROM V$PROCESS p, V$session s where p.addr = s.paddr))/1024/1024/1024 as "Доступно PGA в гигабайтах"
from dual;



SELECT 'alter system kill session '''||s.sid||', '|| s.SERIAL# ||''' immediate;', pga_used_mem/1024/1024, pga_alloc_mem/1024/1024, pga_freeable_mem/1024/1024, pga_max_mem/1024/1024, s.* FROM V$PROCESS p, V$session s 
where p.addr = s.paddr and s.username='STAT' and pga_alloc_mem/1024/1024>800 order by pga_used_mem desc;

SELECT sum(pga_used_mem)/1024/1024 Mb,s.USERNAME FROM V$PROCESS p, V$session s where p.addr = s.paddr group by s.USERNAME order by sum(pga_used_mem)/1024/1024 desc;

select * from v$pga_target_advice order by pga_target_for_estimate;

select  p.snap_id, s.BEGIN_INTERVAL_TIME, name, value/1024/1024 Mb from DBA_HIST_PGASTAT p, DBA_HIST_SNAPSHOT s where name='maximum PGA allocated' and p.SNAP_ID=s.SNAP_ID 
and s.BEGIN_INTERVAL_TIME >sysdate -10
order by snap_id




select max(pga_used_mem), max(pga_alloc_mem), max(pga_max_mem) from v$process;

SELECT pid, category, allocated, used, max_allocated
FROM   v$process_memory
WHERE  pid = (SELECT pid
              FROM   v$process
              WHERE  addr= (select paddr
                            FROM   v$session
                            WHERE  sid = 2995));



select * from v$process_memory


SELECT category, name, heap_name, bytes, allocation_count,
       heap_descriptor, parent_heap_descriptor
FROM   v$process_memory_detail
WHERE  pid      = 3141
AND    category = 'PL/SQL';

create table mem_detail2 as select * from v$process_memory_detail ;
select * from v$process_memory_detail  where heap_name like '%kxs-heap-w%'
select * from v$process_memory_detail  where heap_name like '%koh dur heap d%'
select * from v$process_memory_detail  where heap_name like '%koh%dur%heap%d%'


SELECT tab2.category, tab2.name, tab2.heap_name, tab1.bytes q1, tab2.bytes q2, tab2.bytes-tab1.bytes diff
FROM   tab1, tab2
WHERE  tab1.category  =  tab2.category
AND    tab1.name      =  tab2.name
AND    tab1.heap_name =  tab2.heap_name
AND    tab1.bytes     <> tab2.bytes
ORDER BY 6 DESC;


select * from dba_hist_active_sess_history h

cast(systimestamp as date)

select sum(h.PGA_ALLOCATED)/1024/1024 Mb,  cast(h.SAMPLE_TIME as date) from dba_hist_active_sess_history h where 
h.SAMPLE_TIME>sysdate-2 and h.USER_ID=19037
group by cast(h.SAMPLE_TIME as date) order by 2 desc


select * from dba_users where username='INVAPI'

--h.SESSION_ID=560 and h.SESSION_SERIAL#=9634 and 
sample_id=351537312 order by h.PGA_ALLOCATED


select s.SNAP_ID,cast(s.begin_interval_time as date), p.name,round(p.value/1024/1024/1024) Gb from DBA_HIST_PGASTAT p,Dba_Hist_Ash_Snapshot s 
where s.begin_interval_time between to_date('07.10.2019 00:00:00','dd.mm.yyyy hh24:mi:ss') and to_date('04.12.2019 12:54:00','dd.mm.yyyy hh24:mi:ss')
and p.NAME in ('total PGA allocated','maximum PGA allocated')
and p.SNAP_ID=s.SNAP_ID order by s.begin_interval_time desc

select VERSION, DESCRIPTION, INSTALL_DATE from inv_version order by install_date desc;


select distinct name from DBA_HIST_PGASTAT p





select * from Dba_Hist_Ash_Snapshot s  where s.end_interval_time between to_date('18.10.2017 04:00:00','dd.mm.yyyy hh24:mi:ss') and to_date('18.10.2017 05:25:45','dd.mm.yyyy hh24:mi:ss')


select name, value from v$sysstat where name like 'workarea executions %'
select * from V$sgastat

select * from v$sysstat
select * from dba_hist_sysstat




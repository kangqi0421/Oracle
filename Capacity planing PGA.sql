select s.SNAP_ID,cast(s.begin_interval_time as date), p.name,round(p.value/1024/1024/1024) Gb, 'berdb2_gamma' from DBA_HIST_PGASTAT@berdb2 p,Dba_Hist_Ash_Snapshot @berdb2 s 
where s.begin_interval_time between to_date('01.01.2019 00:00:00','dd.mm.yyyy hh24:mi:ss') and to_date('04.12.2019 12:54:00','dd.mm.yyyy hh24:mi:ss')
and p.NAME in ('total PGA allocated','maximum PGA allocated')
and p.SNAP_ID=s.SNAP_ID order by s.begin_interval_time desc
union
select s.SNAP_ID,cast(s.begin_interval_time as date), p.name,round(p.value/1024/1024/1024) Gb, 'berdb3_crusader' from DBA_HIST_PGASTAT@berdb3 p,Dba_Hist_Ash_Snapshot @berdb3 s 
where s.begin_interval_time between to_date('01.01.2019 00:00:00','dd.mm.yyyy hh24:mi:ss') and to_date('04.12.2019 12:54:00','dd.mm.yyyy hh24:mi:ss')
and p.NAME in ('total PGA allocated','maximum PGA allocated')
and p.SNAP_ID=s.SNAP_ID order by s.begin_interval_time desc
union
select s.SNAP_ID,cast(s.begin_interval_time as date), p.name,round(p.value/1024/1024/1024) Gb, 'berdb4_alpha' from DBA_HIST_PGASTAT@berdb4 p,Dba_Hist_Ash_Snapshot@berdb4 s 
where s.begin_interval_time between to_date('01.01.2019 00:00:00','dd.mm.yyyy hh24:mi:ss') and to_date('04.12.2019 12:54:00','dd.mm.yyyy hh24:mi:ss')
and p.NAME in ('total PGA allocated','maximum PGA allocated')
and p.SNAP_ID=s.SNAP_ID order by s.begin_interval_time desc
union
select s.SNAP_ID,cast(s.begin_interval_time as date), p.name,round(p.value/1024/1024/1024) Gb, 'berdb5_alpha' from DBA_HIST_PGASTAT@berdb5 p,Dba_Hist_Ash_Snapshot@berdb5 s 
where s.begin_interval_time between to_date('01.01.2019 00:00:00','dd.mm.yyyy hh24:mi:ss') and to_date('04.12.2019 12:54:00','dd.mm.yyyy hh24:mi:ss')
and p.NAME in ('total PGA allocated','maximum PGA allocated')
and p.SNAP_ID=s.SNAP_ID order by s.begin_interval_time desc
union
select s.SNAP_ID,cast(s.begin_interval_time as date), p.name,round(p.value/1024/1024/1024) Gb, 'pcdb_alpha' from DBA_HIST_PGASTAT@pcdb p,Dba_Hist_Ash_Snapshot@pcdb s 
where s.begin_interval_time between to_date('01.01.2019 00:00:00','dd.mm.yyyy hh24:mi:ss') and to_date('04.12.2019 12:54:00','dd.mm.yyyy hh24:mi:ss')
and p.NAME in ('total PGA allocated','maximum PGA allocated')
and p.SNAP_ID=s.SNAP_ID order by s.begin_interval_time desc

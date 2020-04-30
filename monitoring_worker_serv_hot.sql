select /*+RULE*/
 s.username,
 dl.SID,
 s.SID,
 s.SERIAL#,
 dl.JOB,
 p.spid,
 'kill -9 ' || p.SPID,
 'alter system kill session ''' || s.sid || ',' || s.serial# || '''' || ';'
  from dba_jobs_running dl, v$session s, v$process p
 where
--dl.name like 'INV_INV%' and
 s.paddr = p.addr
 and dl.sid = s.SID
 and dl.JOB in
 (select job
    from dba_jobs
   where what like '%inv_swch_serv_worker_serv_hot(I_PARTITION=>%') --122--28814--767 and dl.JOB<=22781--in (27577,27576,27575)--=24900--  and dl.JOB <= 24075 
 order by 5

select * from dba_hist_sqlstat

select * from DBA_HIST_SNAPSHOT

select parsing_schema_name,trunc(sum(s.DISK_READS_DELTA)/(select sum(s.DISK_READS_DELTA) from dba_hist_sqlstat s where s.PARSING_SCHEMA_NAME<>'SYS')*100,5) from dba_hist_sqlstat s where s.PARSING_SCHEMA_NAME<>'SYS'
group by parsing_schema_name order by sum(s.DISK_READS_DELTA) desc


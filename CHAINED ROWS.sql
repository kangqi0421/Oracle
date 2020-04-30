smaster.payment

select * from dba_indexes where index_name='PAYMENT$NOT_USED$FUN'

alter index smaster.PAYMENT$NOT_USED$FUN visible;



select * from dba_tables where table_name='CHARGE'

select * from dba_tab_partitions where table_name='CHARGE'

--
ANALYZE TABLE smaster.charge LIST CHAINED ROWS;

ANALYZE TABLE smaster.charge partition (SYS_P54955) LIST CHAINED ROWS;
ANALYZE TABLE smaster.charge LIST CHAINED ROWS;

ANALYZE TABLE smaster.charge partition (SYS_P25360) VALIDATE STRUCTURE CASCADE COMPLETE ONLINE;
ANALYZE TABLE smaster.charge partition (SYS_P25360) VALIDATE STRUCTURE CASCADE FAST;

select count(*) from smaster.charge partition (SYS_P25360)

select * from fborymsky.chained_rows

truncate table fborymsky.chained_rows


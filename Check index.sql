Quick method to identify table/index mismatch when analyze validate structure cascade takes significant time (Doc ID 1554054.1)

select /*+ full(t1) parallel(8) */ sum(ora_hash(rowid))
from  smaster.charge t1
where chrg_id is not null
minus
select /*+ index(t CHARGE$CHR_ID$PK) parallel(8)*/ sum(ora_hash(rowid))
from smaster.charge t
where chrg_id is not null

-- Quick method to identify table/index mismatch when analyze validate structure cascade takes significant time (Doc ID 1554054.1)

alter session set optimizer_use_invisible_indexes=true;

select /*+ full(t1) parallel(8) */ sum(ora_hash(rowid))
from  smaster.charge t1
where chrg_id is not null
minus
select /*+ index(t CHARGE$CHR_ID$PK) parallel(8)*/ sum(ora_hash(rowid))
from smaster.charge t
where chrg_id is not null

select index_name from dba_indexes where table_name='CHARGE'

-----------------------------------------------------------

select index_name from dba_indexes where table_name='PAY_DOC_GG';
select index_name from dba_indexes where table_name='PAYMENT_GG';

-----------------------------------------------------------

DECLARE
  s varchar2(30000);
  num_indexes number := 0;
  sum_hash number;
  
  owner_table varchar2(50) :='SMASTER';
  name_table  varchar2(50) :='PAYMENT_GG';
  name_index  varchar2(50) :='PAYMENT_GG$PAY_ID$P2';
  
begin
  for i in (select a.owner, a.index_name, b.column_name
               from dba_indexes a, dba_ind_columns b
               where a.table_owner = upper(owner_table)
                 and a.table_name  = upper(name_table)
                 and (a.index_name = upper(name_index) or name_index is null)
                 and a.index_type not in ('IOT - TOP'
                                       ,'LOB'
                                       ,'FUNCTION-BASED NORMAL'
                                       ,'FUNCTION-BASED DOMAIN'
                                       ,'CLUSTER')
                 and a.owner = b.index_owner
                 and a.index_name = b.index_name
                 and a.table_name = b.table_name
                 and b.column_position = 1) loop
    num_indexes := num_indexes+1;

  
    s := 'select /*+ full(t1) parallel(16) */ sum(ora_hash(rowid)) from ';
    s := s || owner_table || '.' || name_table || ' t1 where ' || i.column_name ||' is not null MINUS ';
    s := s || 'select /*+ index_ffs(t '|| i.index_name||') parallel(16) */ sum(ora_hash(rowid)) from ';
    s := s || owner_table || '.' || name_table || ' t where ' || i.column_name ||' is not null';

    begin
      Dbms_Output.put_line(s);
    end;
  end loop;
  if num_indexes = 0 and name_index is not null then
     raise_application_error(-20221,'Check was not executed. Index '||upper(name_index)||' does not exist for table '||upper(name_table)|| ' or table does not exist');
  elsif num_indexes = 0 then
     raise_application_error(-20222,'Check was not executed. No INDEXES with index_type=NORMAL found for table '||upper(name_table)|| ' or table does not exist');
  end if;

end;

-----------------------------------------------------------

select /*+ full(t1) parallel(16) */
 sum(ora_hash(rowid))
  from SMASTER.PAY_DOC_GG t1
 where PDOC_ID is not null
MINUS
select /*+ index_ffs(t PAY_DOC_GG$PDOC_ID$P) parallel(16) */
 sum(ora_hash(rowid))
  from SMASTER.PAY_DOC_GG t
 where PDOC_ID is not null;

select /*+ full(t1) parallel(16) */
 sum(ora_hash(rowid))
  from SMASTER.PAY_DOC_GG t1
 where PDOC_ID is not null
MINUS
select /*+ index_ffs(t PAY_DOC_GG$PDOC_ID$P2) parallel(16) */
 sum(ora_hash(rowid))
  from SMASTER.PAY_DOC_GG t
 where PDOC_ID is not null;

select /*+ full(t1) parallel(16) */
 sum(ora_hash(rowid))
  from SMASTER.PAYMENT_GG t1
 where PAY_ID is not null
MINUS
select /*+ index_ffs(t PAYMENT_GG$PAY_ID$P) parallel(16) */
 sum(ora_hash(rowid))
  from SMASTER.PAYMENT_GG t
 where PAY_ID is not null;
 
select /*+ full(t1) parallel(16) */
 sum(ora_hash(rowid))
  from SMASTER.PAYMENT_GG t1
 where PAY_ID is not null
MINUS
select /*+ index_ffs(t PAYMENT_GG$PAY_ID$P2) parallel(16) */
 sum(ora_hash(rowid))
  from SMASTER.PAYMENT_GG t
 where PAY_ID is not null;
 

select /*+ full(t1) parallel(16) */
 count(*), 'F'
  from SMASTER.PAYMENT_GG t1
 where PAY_ID is not null
union all
select /*+ index_ffs(t PAYMENT_GG$PAY_ID$P) parallel(16) */
  count(*), 'I'
  from SMASTER.PAYMENT_GG t
 where PAY_ID is not null

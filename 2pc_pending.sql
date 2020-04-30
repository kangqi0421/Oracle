-- Manually Resolving In-Doubt Transactions: Different Scenarios (Doc ID 126069.1)
-- DBMS_LOGSTDBY.BUILD Seems to Hang And Does Not Return To SQL prompt. (Doc ID 747495.1)

select * from dba_2pc_pending where local_tran_id='992.22.8769528'

select * from dba_2pc_neighbors;

--ROLLBACK FORCE '992.22.8769528'
--exec DBMS_TRANSACTION.PURGE_LOST_DB_ENTRY('474.29.9913655');

select a.sql_text, s.osuser, s.username
from v$transaction t, v$session s, v$sqlarea a where s.taddr = t.addr
and a.address = s.prev_sql_addr
and t.xidusn = 474
and t.xidslot = 29
and t.xidsqn = 9913655;

select 'exec ROLLBACK FORCE ''' || local_tran_id  || ''';' from dba_2pc_pending;
select 'exec DBMS_TRANSACTION.PURGE_LOST_DB_ENTRY (''' || local_tran_id  || '''); commit;' from dba_2pc_pending;


select local_tran_id, state from dba_2pc_pending;

SELECT KTUXEUSN, KTUXESLT, KTUXESQN, /* Transaction ID */ KTUXESTA Status,KTUXECFL Flags FROM x$ktuxe WHERE ktuxesta!='INACTIVE' AND ktuxeusn= 174;

/*
DECLARE
 cursor cTI is select local_tran_id from dba_2pc_pending;
 ti cTI%ROWTYPE;
BEGIN
  dbms_output.enable(10000000);
  open cTI;
  LOOP
   FETCH cTI into ti;
   EXIT WHEN cTI%NOTFOUND;
   dbms_output.put_line('--------- '|| ti.local_tran_id ||' ---------');
   dbms_output.put_line('');
   
   dbms_output.put_line('delete from sys.pending_trans$ where local_tran_id = '''|| ti.local_tran_id ||''';');
   dbms_output.put_line('delete from sys.pending_sessions$ where local_tran_id = '''|| ti.local_tran_id ||''';');
   dbms_output.put_line('delete from sys.pending_sub_sessions$ where local_tran_id = '''|| ti.local_tran_id ||''';');
   dbms_output.put_line('commit;');
   dbms_output.put_line('');
   
   dbms_output.put_line('alter system disable distributed recovery;');
   dbms_output.put_line('');
   
   dbms_output.put_line('insert into pending_trans$
  (LOCAL_TRAN_ID,
   GLOBAL_TRAN_FMT,
   GLOBAL_ORACLE_ID,
   STATE,
   STATUS,
   SESSION_VECTOR,
   RECO_VECTOR,
   TYPE#,
   FAIL_TIME,
   RECO_TIME)
values
  ('''|| ti.local_tran_id ||''',
   306206,
   ''XXXXXXX.12345.1.2.3'',
   ''prepared'',
   ''P'',
   hextoraw(''00000001''),
   hextoraw(''00000000''),
   0,
   sysdate,
   sysdate);');
   dbms_output.put_line('');
      
   dbms_output.put_line('insert into pending_sessions$ values('''|| ti.local_tran_id ||''', 1, hextoraw(''05004F003A1500000104''), ''C'', 0, 30258592, '''', 146);');
   dbms_output.put_line('commit;');
   dbms_output.put_line('');   
   
   dbms_output.put_line('rollback force '''|| ti.local_tran_id ||''';');
   dbms_output.put_line('');
   
   dbms_output.put_line('------- If commit force/rollback raises an error then note the error message and execute the following:');
   dbms_output.put_line('------- delete from pending_trans$ where local_tran_id='''|| ti.local_tran_id ||''';');
   dbms_output.put_line('------- delete from pending_sessions$ where local_tran_id='''|| ti.local_tran_id ||''';');
   dbms_output.put_line('------- commit;');
   dbms_output.put_line('------- alter system enable distributed recovery;');
   dbms_output.put_line('-------');   
   dbms_output.put_line('');
   
   dbms_output.put_line('alter system enable distributed recovery;');
   dbms_output.put_line('');
   dbms_output.put_line('exec dbms_transaction.purge_lost_db_entry('''|| ti.local_tran_id ||''');');
   
   dbms_output.put_line('');
   dbms_output.put_line('');
   
  END LOOP;
  close cTI;
END;
*/



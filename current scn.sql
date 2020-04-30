

select d.CURRENT_SCN from V$database d 
select to_char(min(START_DATE),'DD-MM-YYYY HH24:MI:SS'),min(START_SCN), s.sid from v$transaction t, V$session s  where rawtohex(t.addr) = s.taddr (+) group by s.sid
select to_char(min(START_DATE),'DD-MM-YYYY HH24:MI:SS'),min(START_SCN) from v$transaction;

select * from sales.aa_agents_code as of scn 2502737193581

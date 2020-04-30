select 'kill -9 '||to_number(p.spid) "OS Thread"
,s.status, s.username "Name-User", s.osuser, s.program,'alter system kill session '''||s.SID||','||s.SERIAL#||''';'
from v$process p, v$session s
where p.addr = s.paddr
and s.username is not null 
--and p.SPID in ( 8444)
--and s.SID='647'
--and s.USERNAME in  -- ('CAREM','CAREM_API','SPP_USER','AUTOPAY','MOBIPAY','RBT_ECT','GGADMIN','PUBLIC')
--AND s.USERNAME not in ('SYS', 'SYSTEM','EM_CONNECT','SZOLOTKO','DBSNMP','SMASTER')
--and s.USERNAME='SMASTER' --in ('INAPI1','MLINK21')
-- like '%APEX_PUBLIC_USER%'
--and (s.OSUSER!='vladimir.adamenko')
--and s.PROGRAM!='OMS'
--and (s.OSUSER!='agentcc')

select * from dba_directories
select current_scn from V$database

2970929851752 --b2 
2971027135501 --b5
2971117849752 --b4
2971142853655 --b3 (из V$database) ( 2971142844221 из V$restore_point) (CURRENT 2971142844223 из list incarnation пока была открыта) 


select * from V$database

create or replace directory EXP_FOR_TEST as '/RO_berdb5/app/oracle/oradata/berdb5';

create or replace directory EXP_FOR_TEST as '/RO_berdb4/app/oracle/oradata/berdb4';

create or replace directory EXP_FOR_TEST as '/RO_berdb3/app/oracle/oradata/berdb3';



select * from V$restore_point

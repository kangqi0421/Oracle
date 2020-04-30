--row 0x0098b736.1f continuation at: 0x0098b736.1f file# 1024 block# 10008374 slot 31 not found (dscnt: 0)

SELECT segment_type, owner, segment_name
FROM dba_extents
WHERE relative_fno = 1024
AND 10008374 BETWEEN block_id and block_id+blocks-1;


Select * 
From dba_extents 
Where relative_fno = 1024
And 
10008374 between block_id and (block_id+blocks-1);

--SUBS_COUNTER_RESERVE

select * from SMASTER.SUBS_COUNTER_RESERVE partition (P5)


select * from DBA_DATA_FILES where relative_fno=1024

select * from dba_extents
select * from V$datafile

select * from V$session where username='INVPAPI'

SELECT A.tablespace_name tablespace,
       D.mb_total,
       SUM(A.used_blocks * D.block_size) / 1024 / 1024 mb_used,
       D.mb_total - SUM(A.used_blocks * D.block_size) / 1024 / 1024 mb_free
  FROM v$sort_segment A,
       (SELECT B.name, C.block_size, SUM(C.bytes) / 1024 / 1024 mb_total
          FROM v$tablespace B, v$tempfile C
         WHERE B.ts# = C.ts#
         GROUP BY B.name, C.block_size) D
 WHERE A.tablespace_name = D.name
 GROUP by A.tablespace_name, D.mb_total;

SELECT se.username username,
       se.SID sid,
       se.serial# serial#,
       se.status status,
       se.sql_hash_value,
       se.prev_hash_value,
       se.machine machine,
       su.TABLESPACE tablespace,
       su.segtype,
       su.CONTENTS CONTENTS
  FROM v$session se, v$sort_usage su
 WHERE se.saddr = su.session_addr;

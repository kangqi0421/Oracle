--UNDO MONITORING
select t1.SID,
       t1.SERIAL#,
       t1.USERNAME,
       t2.START_TIME,
       t2.USED_UBLK * (Select display_value
                         from v$parameter p
                        where p.NAME = 'db_block_size') / 1024 / 1024 segment_undo_Mb,
       t2.LOG_IO,
       t2.PHY_IO,
       t2.USED_UREC,
       t1.SQL_HASH_VALUE,
       t1.MACHINE,
       t1.TERMINAL,
       t1.MODULE,
       t1.action
  from v$session t1, V$TRANSACTION t2
 where t1.SADDR = t2.SES_ADDR
--   and t1.USERNAME = 'VBONDARENKO'
 ORDER BY segment_undo_Mb desc;

-- % использования
SELECT tablespace_name,
       ROUND(((SELECT (NVL(SUM(e.bytes), 0))
                 FROM dba_undo_extents e
                WHERE e.tablespace_name = t.tablespace_name
                  AND e.status IN ('ACTIVE', 'UNEXPIRED')) * 100) /
             (SELECT SUM(f.bytes)
                FROM dba_data_files f
               WHERE f.tablespace_name = t.tablespace_name),
             2) as "pct_usage"
  FROM dba_tablespaces t
 where contents = 'UNDO';

--Чем используется
SELECT COUNT(segment_name), SUM(bytes / 1024 / 1024) SIZE_MB, status
  FROM dba_undo_extents
 GROUP BY status;

--UNDO-size monitoring
SELECT TABLESPACE_NAME,
       round(real_mb, 2) real_mb,
       round(max_MB, 2) max_MB,
       round(EXPIRED_MB, 2) EXPIRED_MB,
       round(FREE_MB, 2) FREE_MB,
       round(ACTIVE_MB, 2) ACTIVE_MB,
       round(UNEXPIRED_MB, 2) UNEXPIRED_MB,
       ceil((EXPIRED_MB + NVL(FREE_MB, 0)) * 100 / real_mb) PCT_FREE,
       ceil(100 - (EXPIRED_MB + NVL(FREE_MB, 0)) * 100 / real_mb) PCT_USED
  FROM (SELECT TABLESPACE_NAME,
               max_MB,
               real_mb,
               SUM(CASE
                     WHEN STATUS = 'EXPIRED' THEN
                      EXPIRED_MB
                     ELSE
                      0
                   END) EXPIRED_MB,
               SUM(CASE
                     WHEN STATUS = 'ACTIVE' THEN
                      EXPIRED_MB
                     ELSE
                      0
                   END) ACTIVE_MB,
               SUM(CASE
                     WHEN STATUS = 'UNEXPIRED' THEN
                      EXPIRED_MB
                     ELSE
                      0
                   END) UNEXPIRED_MB,
               ROUND(NVL(FREE_MB, 0)) FREE_MB
          FROM (SELECT A.TABLESPACE_NAME,
                       A.max_MB,
                       a.real_mb,
                       B.STATUS,
                       B.EXPIRED_MB,
                       C.FREE_MB
                  FROM (SELECT TABLESPACE_NAME,
                               SUM(DECODE(MAXBYTES, 0, BYTES, MAXBYTES)) / 1024 / 1024 max_MB,
                               SUM(BYTES) / 1024 / 1024 real_mb
                          FROM DBA_DATA_FILES
                         WHERE TABLESPACE_NAME IN
                               (SELECT TABLESPACE_NAME
                                  FROM DBA_TABLESPACES
                                 WHERE CONTENTS = 'UNDO')
                         GROUP BY TABLESPACE_NAME) A,
                       (SELECT TABLESPACE_NAME,
                               STATUS,
                               SUM(BYTES) / 1024 / 1024 EXPIRED_MB
                          FROM DBA_UNDO_EXTENTS
                         GROUP BY TABLESPACE_NAME, STATUS) B,
                       (SELECT TABLESPACE_NAME,
                               SUM(BYTES) / 1204 / 1024 FREE_MB
                          FROM SYS.DBA_FREE_SPACE
                         WHERE TABLESPACE_NAME IN
                               (SELECT TABLESPACE_NAME
                                  FROM DBA_TABLESPACES
                                 WHERE CONTENTS = 'UNDO')
                         GROUP BY TABLESPACE_NAME) C
                 WHERE A.TABLESPACE_NAME = B.TABLESPACE_NAME(+)
                   AND A.TABLESPACE_NAME = C.TABLESPACE_NAME(+)
                 ORDER BY 1, 2)
         GROUP BY TABLESPACE_NAME, max_MB, real_mb, FREE_MB);

select state,
       undoblocksdone,
       undoblockstotal,
       undoblocksdone / undoblockstotal * 100
  from v$fast_start_transactions;

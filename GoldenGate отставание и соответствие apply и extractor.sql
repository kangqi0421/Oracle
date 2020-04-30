SELECT * FROM 
(
 SELECT ID || ' ' || EXTRACT_NAME,
               SRC_DB,
               EXTRACT_NAME,
               DELGROUP,
               ROUND(EXTRACT(DAY FROM iLAG) * 24 * 60 * 60 +
                     EXTRACT(HOUR FROM iLAG) * 60 * 60 +
                     EXTRACT(MINUTE FROM iLAG) * 60 +
                     EXTRACT(SECOND FROM iLAG)) as LAG
          FROM (SELECT ID, SRC_DB, EXTRACT_NAME, DELGROUP, MAX(iLAG) iLAG
                  FROM (SELECT ID,
                               SRC_DB,
                               EXTRACT_NAME,
                               DELGROUP,
                               SYSDATE - MAX(SOURCE_COMMIT) AS iLAG
                          FROM GGADMIN.HEARTBEAT
                         WHERE SOURCE_COMMIT > (sysdate - 3)
                         GROUP BY ID, SRC_DB, EXTRACT_NAME, DELGROUP)
                 GROUP BY ID, SRC_DB, EXTRACT_NAME, DELGROUP)
         ORDER BY ID
)
WHERE (select database_role db_role from v$database) = 'PRIMARY'

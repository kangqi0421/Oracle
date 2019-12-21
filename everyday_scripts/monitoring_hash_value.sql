select m.status,m.username,m.module,m.action,m.service_name, m.program,m.sql_id,m.sql_text,
m.SQL_EXEC_START,m.SQL_PLAN_HASH_VALUE from v$sql_monitor m
where
 sql_id = 'dpr8ypj29kq7s'
order by m.SQL_EXEC_START desc
select count(*) from SMASTER.AQ$BILL_QUEUE_TABLE;
-- старая
select to_number
       (
        decode((select count(*)
                from boss.bil_period
               where fin_time = trunc(sysdate, 'mm') - 1 / 86400
                 and calc_id = 99
                 and nvl(f_close, 1) != 0),
              0,
              111111112,
              nvl((select result_msg
                    from (select result_msg, cre_time
                            from boss.bil_logbook
                           where step_id = 200
                             and action_name = 'SPEED'
                             and cre_time >= trunc(sysdate, 'mm')
                           order by cre_time desc)
                   where rownum < 2),
                  222222224
                 )
              )
        ) as bill_speed
from dual;

-- новая
SELECT *
FROM
(
select value_p as bill_speed from table (smaster.cb_monitoring.get_billing) where KEY_P='Billing Calculation'
)
WHERE (select database_role db_role from v$database)='PRIMARY'

select * from boss.bil_logbook where action_name = 'SPEED' and cre_time >= trunc(sysdate-90, 'mm')

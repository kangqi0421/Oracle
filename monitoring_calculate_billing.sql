-- Начало расчета биллинга
select *
  from boss.bil_logbook
 where cre_time > to_date('01.09.2017 01:55:00', 'DD.MM.YYYY HH24:MI:SS') /*and result_msg like 'СТАРТ%'*/
 order by cre_time;
-- Завершение отчета биллинга
select to_char(cre_time, 'dd.mm.yyyy hh24:mi:ss')
   from boss.bil_logbook 
  where cre_time > sysdate - 1
    and result_msg like '%БИЛ%';


-- Завершение отчета абонентской платы
select *
   from boss.bil_logbook 
  where cre_time > sysdate - 1
    and result_msg like '%АП%';


select *
   from boss.bil_logbook 
  where cre_time > sysdate - 1
    and ACTION_NAME like '%АП%';
    
    
    

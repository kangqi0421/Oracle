--Таинственная ошибка "ORA-04023: Object could not be validated or authorized" и что с ней можно сделать
--http://gpanov.blogspot.ru/2017/06/ora-04023-object-could-not-be-validated.html

/*Как известно, согласно законам Мерфи "если есть вероятность того, что какая-нибудь неприятность может случиться, то она обязательно произойдёт". Так случилось и у меня. На фазе внедрения, перед показом системы Заказчику прибежал ко мне аналитик, ответственный за демонстрацию и рассказал, что при переходе на одно из закладок в клиентском ПО стабильно возникает ошибка ORA-04023. Согласно этой ошибке, object could not be validated or authorized. Сперва не нашел ничего лучше, чем пересоздать проблемное view. Помогло ровно на сутки, после чего аналитик пришел вновь и убитым голосом подтвердил, что проблема вновь присутствует и стабильно повторяется. 
Я начал разбираться и обнаружил, что описания этой ошибки, собственно, не существует. Иначе, как еще можно понять следующий пассаж  в документации:

ORA-04023: Object could not be validated or authorized

Cause: A number of attempts were made to validate or authorize an object but failed.

Action: Please report this error to Oracle Support Services.

Но это ведь не наш метод. Я подключил своего sysdba и мы вместе начали курить инет, но ровным счетом ничего интересного, решавшего нашу проблему не нашли. Например у Бурлесона был приведен следующий текст

The ORA-04023 error may indicate that the shared pool has a RAM corruption.  One emergency workaround is to bounce the database or to flush the shared pool:
alter system flush shared pool;
If this does not stop the ORA-04023 error, then open a service request on MOSC.

У нас при сбросе разделяемого пула ошибка вновь воспроизводилась без проблем. Так в поисках прошло 4 дня. Временно помогала пересборка проблемного view, которая откладывала появление ошибки до следующего дня.
Наконец, на одном из форумов нашел ссылку на нижеприведенный SQL запрос и предположение, что данная ошибка на 12.1 может возникать из-за рассинхронизации времени между датой создания объекта и датой жестких привязок (hard dependencies) между самим объектом и его зависимыми объектами, т.е., например, табличный индекс имеет дату привязке к таблице раньше, чем дата создания самой таблицы. ORACLE, пытаясь получить данные из view (а в моем случае это и было view), для начала проверяет эту информацию в системном словаре для пользователей, не входящих в SYSDBA. Для SYSDBA рабочим является режим ограниченных/отключенных проверок, таким образом данная проверка не выполняется и данные из проблемной view достаются без проблем. Это объяснение идеально подходило под описание нашего случая.

Вот сам SQL запрос
*/


select
    du.name d_owner, d.name d_name, d.defining_edition d_edition,
    pu.name p_owner, p.name p_name, p.defining_edition p_edition,
   case
      when p.status not in (1, 2, 4) then 'P Status: ' || to_char(p.status)
   else 'TS mismatch:      ' ||
      to_char(dep.p_timestamp, 'DD-MON-YY HH24:MI:SS') || ' -> ' ||
      to_char(p.stime, 'DD-MON-YY HH24:MI:SS')
   end reason
from
    sys."_ACTUAL_EDITION_OBJ" d,
    sys.user$ du,
    sys.dependency$ dep,
    sys."_ACTUAL_EDITION_OBJ" p, sys.user$ pu
where
    d.obj# = dep.d_obj# and p.obj# = dep.p_obj#
     and d.owner# = du.user# and p.owner# = pu.user#
     and d.status = 1                                    -- Valid dependent
     and bitand(dep.property, 1) = 1                     -- Hard dependency
     and d.subname is null                               -- !Old type version
     and not(p.type# = 32 and d.type# = 1)               -- Index to indextype
     and not(p.type# = 29 and d.type# = 5)               -- Synonym to Java
     and not(p.type# in(5, 13) and d.type# in (2, 55))   -- TABL/XDBS to TYPE
     and (p.status not in (1, 2, 4) or p.stime != dep.p_timestamp);
     
     
     
     
     
     
/*     Для моего случая этот запрос вернул некоторое количество проблемных объектов базы данных (причем проблемная view в их состав не входила, но были, например, таблицы, которые в проблемном view использовались ), которые были мной пересобраны, т.е. были выполнены команды 

DROP <theObjectFromResultSet>;

и

CREATE <theObjectFromResultSet>;

После того как список, полученный с помощью вышеуказанного запроса опустел, но ошибка при обращении к проблемному view так и не исчезла, мной был сброшен shared pool

alter system flush shared_pool;

На двух из трех серверов ошибка исчезла сразу и к проблемному view вновь стало можно обращаться, не получая ошибки. На третьем сервере ошибка исчезла только после переподключения к серверу базы данных. Обращаю внимание, что пересборка самого проблемного view не производилась. Надеюсь, что приведенное мной описание решения проблемы ошибки ORA-04023 когда-нибудь поможет и вам.*/

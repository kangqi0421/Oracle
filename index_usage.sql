Мониторинг использования индекса (alter index <> monitoring usage):
-------
1. Включить
alter index <index_name> monitoring usage;

2. Прогнать запросы или отработать приложениями, 
которые используют индекс 
(сбор статистики переключит его в используемые).

3. Отключить мониторинг
alter index <index_name> nomonitoring usage;

4. Посмотреть использовался он или нет.
select * from dba_object_usage order by index_name;

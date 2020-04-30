--Установка тбс для таблицы логов
BEGIN
DBMS_AUDIT_MGMT.SET_AUDIT_TRAIL_LOCATION(
       audit_trail_type            => DBMS_AUDIT_MGMT.AUDIT_TRAIL_UNIFIED,
       audit_trail_location_value  =>  'AUD_TBS');
END;
/
--Проверка параметров
SELECT * FROM DBA_AUDIT_MGMT_CONFIG_PARAMS;

--Создание политики
CREATE AUDIT POLICY CONTRACT_SELECT
ACTIONS SELECT ON DWH.CONTRACT;

--Проверка политики
SELECT *
FROM   audit_unified_policies
where policy_name = 'CONTRACT_SELECT';

--Включение политики
audit policy CONTRACT_SELECT;

--Выключение политики
noaudit policy CONTRACT_SELECT;

--Проверка что политика включилась
SELECT *
FROM AUDIT_UNIFIED_ENABLED_POLICIES;

--Палевная вьюха
SELECT count(*), object_name
FROM   unified_audit_trail
group by object_name
;

--Если надо добавить в политику
ALTER AUDIT POLICY CONTRACT_SELECT
ADD ACTIONS select ON DWH.CDR_CALLS_RO;

--Выставление даты для крайнего лога
BEGIN
  DBMS_AUDIT_MGMT.set_last_archive_timestamp(
    audit_trail_type     => DBMS_AUDIT_MGMT.audit_trail_unified,
    last_archive_time    => SYSTIMESTAMP
  );
END;
/

--Проверка даты
SELECT audit_trail,
       last_archive_ts
FROM   dba_audit_mgmt_last_arch_ts;

--Удаление логов до крайней даты
BEGIN
  DBMS_AUDIT_MGMT.clean_audit_trail(
   audit_trail_type        => DBMS_AUDIT_MGMT.audit_trail_unified,
   use_last_arch_timestamp => TRUE);
END;
/

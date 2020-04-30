--��������� ��� ��� ������� �����
BEGIN
DBMS_AUDIT_MGMT.SET_AUDIT_TRAIL_LOCATION(
       audit_trail_type            => DBMS_AUDIT_MGMT.AUDIT_TRAIL_UNIFIED,
       audit_trail_location_value  =>  'AUD_TBS');
END;
/
--�������� ����������
SELECT * FROM DBA_AUDIT_MGMT_CONFIG_PARAMS;

--�������� ��������
CREATE AUDIT POLICY CONTRACT_SELECT
ACTIONS SELECT ON DWH.CONTRACT;

--�������� ��������
SELECT *
FROM   audit_unified_policies
where policy_name = 'CONTRACT_SELECT';

--��������� ��������
audit policy CONTRACT_SELECT;

--���������� ��������
noaudit policy CONTRACT_SELECT;

--�������� ��� �������� ����������
SELECT *
FROM AUDIT_UNIFIED_ENABLED_POLICIES;

--�������� �����
SELECT count(*), object_name
FROM   unified_audit_trail
group by object_name
;

--���� ���� �������� � ��������
ALTER AUDIT POLICY CONTRACT_SELECT
ADD ACTIONS select ON DWH.CDR_CALLS_RO;

--����������� ���� ��� �������� ����
BEGIN
  DBMS_AUDIT_MGMT.set_last_archive_timestamp(
    audit_trail_type     => DBMS_AUDIT_MGMT.audit_trail_unified,
    last_archive_time    => SYSTIMESTAMP
  );
END;
/

--�������� ����
SELECT audit_trail,
       last_archive_ts
FROM   dba_audit_mgmt_last_arch_ts;

--�������� ����� �� ������� ����
BEGIN
  DBMS_AUDIT_MGMT.clean_audit_trail(
   audit_trail_type        => DBMS_AUDIT_MGMT.audit_trail_unified,
   use_last_arch_timestamp => TRUE);
END;
/

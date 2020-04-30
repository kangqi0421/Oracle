select * from V$version

select * from dba_scheduler_job_run_details where upper(job_name)='STANDARD_OS_AUDIT_TRAIL_PURGE'

BEGIN
DBMS_AUDIT_MGMT.CREATE_PURGE_JOB (
AUDIT_TRAIL_TYPE => DBMS_AUDIT_MGMT.AUDIT_TRAIL_OS,
AUDIT_TRAIL_PURGE_INTERVAL => 24*7,
AUDIT_TRAIL_PURGE_NAME => 'Standard_OS_Audit_Trail_Purge',
USE_LAST_ARCH_TIMESTAMP => FALSE );
END;
/

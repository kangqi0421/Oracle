select * from dba_java_policy
select * from dba_users 
select * from dba_directories

create directory AVAYA_CORP_CDR_TEST as '/import/AVAYA_CORP_CDR/TEST';

grant read on directory AVAYA_CORP_CDR_TEST to AVAYA_CORP_CDR;
grant write on directory AVAYA_CORP_CDR_TEST to AVAYA_CORP_CDR;


select 'dbms_java.grant_permission(' ||''''||grantee||''''||', '|| '''SYS:java.io.FilePermission'''||', '||''''||name||''''||', ' ||''''||action||''''||');', p.* 
from dba_java_policy p
where name like '%/import/LOAD2DWH05%'


begin
dbms_java.grant_permission( 'DWH_LOADER', 'SYS:java.io.FilePermission', '/import/dwh/IN_CP', 'write' );
dbms_java.grant_permission( 'DWH_LOADER', 'SYS:java.io.FilePermission', '/import/dwh/IN_CP', 'read' );
--dbms_java.grant_permission( 'DWH_LOADER', 'SYS:java.io.FilePermission', '/import/dwh/IN_CP', 'execute' );
end;


begin
dbms_java.grant_permission( 'AVAYA_CORP_CDR', 'SYS:java.io.FilePermission', '<<ALL FILES>>', 'execute' );
end;


begin
--dbms_java.revoke_permission( 'AVAYA_CORP_CDR', 'SYS:java.io.FilePermission', '<<ALL FILES>>', 'execute' );
dbms_java.disable_permission(275);
dbms_java.delete_permission(275);
dbms_java.disable_permission(276);
dbms_java.delete_permission(276);
end;


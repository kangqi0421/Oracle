select * from dba_network_acl_privileges
select * from dba_network_acls



BEGIN
  DBMS_NETWORK_ACL_ADMIN.CREATE_ACL(acl => '/sys/acls/teradata.xml',  description =>'for teradata',  principal   => 'TESTSDM',  is_grant=> true, privilege   => 'connect');
end;

BEGIN
DBMS_NETWORK_ACL_ADMIN.add_privilege (acl => '/sys/acls/teradata.xml',principal => 'TESTSDM', is_grant => true, privilege => 'resolve');
end;

begin
DBMS_NETWORK_ACL_ADMIN.SET_HOST_ACL (host =>'10.12.47.158',  lower_port   => 9000, upper_port   => 9000,  acl=>'/sys/acls/teradata.xml');
end;

begin
DBMS_NETWORK_ACL_ADMIN.APPEND_HOST_ACL (   host =>'10.77.44.72',   acl=>'/sys/acls/oracle-sysman-ocm-Resolve-Access.xml');
end;

begin
DBMS_NETWORK_ACL_ADMIN.DROP_ACL (acl=>'/sys/acls/teradata.xml');
end;

BEGIN
 DBMS_NETWORK_ACL_ADMIN.APPEND_HOST_ACE (
  host         => '10.12.47.158', 
 lower_port   => 9000,
 upper_port   => 9000
  ); 
END;

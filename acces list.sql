select * from dba_network_acls
select * from dba_host_aces

begin
 dbms_java.grant_permission('REPORT21', 'SYS:java.net.SocketPermission', '10.12.15.28', 'connect, resolve');
end;

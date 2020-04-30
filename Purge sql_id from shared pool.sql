select address, hash_value from v$sqlarea where sql_id like 'drj9vs5vgf9tr';

begin
exec dbms_shared_pool.purge('0000000D13DF5718, 1995908919','C');
end;

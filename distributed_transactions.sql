exec ROLLBACK FORCE '281.33.13480997';

SQL> exec ROLLBACK FORCE '281.33.13480997';
BEGIN ROLLBACK FORCE '281.33.13480997'; END;

*
ERROR at line 1:
ORA-02058: no prepared transaction found with ID 281.33.13480997
ORA-06512: at line 1


SQL>

exec COMMIT FORCE '281.33.13480997';


SQL> exec COMMIT FORCE '281.33.13480997';
BEGIN COMMIT FORCE '281.33.13480997'; END;

*
ERROR at line 1:
ORA-02058: no prepared transaction found with ID 281.33.13480997
ORA-06512: at line 1


SQL>

SQL> exec DBMS_TRANSACTION.PURGE_LOST_DB_ENTRY ('281.33.13480997'); commit;

PL/SQL procedure successfully completed.


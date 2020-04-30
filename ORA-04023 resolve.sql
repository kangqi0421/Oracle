--������������ ������ "ORA-04023: Object could not be validated or authorized" � ��� � ��� ����� �������
--http://gpanov.blogspot.ru/2017/06/ora-04023-object-could-not-be-validated.html

/*��� ��������, �������� ������� ����� "���� ���� ����������� ����, ��� �����-������ ������������ ����� ���������, �� ��� ����������� ���������". ��� ��������� � � ����. �� ���� ���������, ����� ������� ������� ��������� �������� �� ��� ��������, ������������� �� ������������ � ���������, ��� ��� �������� �� ���� �� �������� � ���������� �� ��������� ��������� ������ ORA-04023. �������� ���� ������, object could not be validated or authorized. ������ �� ����� ������ �����, ��� ����������� ���������� view. ������� ����� �� �����, ����� ���� �������� ������ ����� � ������ ������� ����������, ��� �������� ����� ������������ � ��������� �����������. 
� ����� ����������� � ���������, ��� �������� ���� ������, ����������, �� ����������. �����, ��� ��� ����� ������ ��������� ������  � ������������:

ORA-04023: Object could not be validated or authorized

Cause: A number of attempts were made to validate or authorize an object but failed.

Action: Please report this error to Oracle Support Services.

�� ��� ���� �� ��� �����. � ��������� ������ sysdba � �� ������ ������ ������ ����, �� ������ ������ ������ �����������, ��������� ���� �������� �� �����. �������� � ��������� ��� �������� ��������� �����

The ORA-04023 error may indicate that the shared pool has a RAM corruption.  One emergency workaround is to bounce the database or to flush the shared pool:
alter system flush shared pool;
If this does not stop the ORA-04023 error, then open a service request on MOSC.

� ��� ��� ������ ������������ ���� ������ ����� ���������������� ��� �������. ��� � ������� ������ 4 ���. �������� �������� ���������� ����������� view, ������� ����������� ��������� ������ �� ���������� ���.
�������, �� ����� �� ������� ����� ������ �� ��������������� SQL ������ � �������������, ��� ������ ������ �� 12.1 ����� ��������� ��-�� ���������������� ������� ����� ����� �������� ������� � ����� ������� �������� (hard dependencies) ����� ����� �������� � ��� ���������� ���������, �.�., ��������, ��������� ������ ����� ���� �������� � ������� ������, ��� ���� �������� ����� �������. ORACLE, ������� �������� ������ �� view (� � ���� ������ ��� � ���� view), ��� ������ ��������� ��� ���������� � ��������� ������� ��� �������������, �� �������� � SYSDBA. ��� SYSDBA ������� �������� ����� ������������/����������� ��������, ����� ������� ������ �������� �� ����������� � ������ �� ���������� view ��������� ��� �������. ��� ���������� �������� ��������� ��� �������� ������ ������.

��� ��� SQL ������
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
     
     
     
     
     
     
/*     ��� ����� ������ ���� ������ ������ ��������� ���������� ���������� �������� ���� ������ (������ ���������� view � �� ������ �� �������, �� ����, ��������, �������, ������� � ���������� view �������������� ), ������� ���� ���� �����������, �.�. ���� ��������� ������� 

DROP <theObjectFromResultSet>;

�

CREATE <theObjectFromResultSet>;

����� ���� ��� ������, ���������� � ������� �������������� ������� �������, �� ������ ��� ��������� � ����������� view ��� � �� �������, ���� ��� ������� shared pool

alter system flush shared_pool;

�� ���� �� ���� �������� ������ ������� ����� � � ����������� view ����� ����� ����� ����������, �� ������� ������. �� ������� ������� ������ ������� ������ ����� ��������������� � ������� ���� ������. ������� ��������, ��� ���������� ������ ����������� view �� �������������. �������, ��� ����������� ���� �������� ������� �������� ������ ORA-04023 �����-������ ������� � ���.*/

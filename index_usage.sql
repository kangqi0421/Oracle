���������� ������������� ������� (alter index <> monitoring usage):
-------
1. ��������
alter index <index_name> monitoring usage;

2. �������� ������� ��� ���������� ������������, 
������� ���������� ������ 
(���� ���������� ���������� ��� � ������������).

3. ��������� ����������
alter index <index_name> nomonitoring usage;

4. ���������� ������������� �� ��� ���.
select * from dba_object_usage order by index_name;

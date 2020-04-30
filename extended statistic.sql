SELECT DBMS_STATS.show_extended_stats_name(ownname => 'DWH', tabname=> 'CDR_CALLS_RW',extension=>'(CALL_TYPE,START_TIME,SWITCH_NAME,NO_BILLABLE,ROAMING,NO_IN)') FROM dual;

select column_name, data_default, hidden_column from   dba_tab_cols where  table_name = 'CDR_CALLS_RW';

select * from dba_tab_col_statistics where table_name='CDR_CALLS_RW' and column_name='ROAMING'
SELECT * FROM   dba_stat_extensions WHERE  table_name = 'CDR_CALLS_RW';

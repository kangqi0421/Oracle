



create user IVANCHENKO_IV
  identified by rtphrt
  default tablespace WORKFLOW
  temporary tablespace TEMP_DEV_FAST
  profile DEFAULT
  quota 102400m on workflow;
-- Grant/Revoke role privileges 
grant dev_junior to IVANCHENKO_IV;

select * from V$datafile where ts# in( 3480,3429)
--file#=14

select 'alter table SMASTER.FACTURA_ARCH ' || ' drop partition '||partition_name ||';', tablespace_name from dba_tab_partitions where table_name=upper('factura_arch') and tablespace_name ='ITOGS_ARCH_TBS_2017'

select * from V$tablespace t where t.NAME in ('ITOGS_ARCH_TBS_2018')

select read_only from dba_tables where table_name=upper('factura_arch')


alter table SMASTER.FACTURA_ARCH drop partition P_01_2017;
alter table SMASTER.FACTURA_ARCH drop partition P_02_2017;
alter table SMASTER.FACTURA_ARCH drop partition P_03_2017;
alter table SMASTER.FACTURA_ARCH drop partition P_04_2017;
alter table SMASTER.FACTURA_ARCH drop partition P_05_2017;
alter table SMASTER.FACTURA_ARCH drop partition P_06_2017;
alter table SMASTER.FACTURA_ARCH drop partition P_07_2017;
alter table SMASTER.FACTURA_ARCH drop partition P_08_2017;
alter table SMASTER.FACTURA_ARCH drop partition P_09_2017;
alter table SMASTER.FACTURA_ARCH drop partition P_10_2017;
alter table SMASTER.FACTURA_ARCH drop partition P_11_2017;
alter table SMASTER.FACTURA_ARCH drop partition P_12_2017;


drop table SMASTER.FACTURA_ARCH_EXC;
create table SMASTER.FACTURA_ARCH_EXC tablespace USERS as select * from SMASTER.FACTURA_ARCH where 1=0;


create index SMASTER.F_EXC_ARCH$CLNT_ID$IDX on SMASTER.FACTURA_ARCH_EXC (CLNT_ID) tablespace USERS;
create index SMASTER.F_EXC_ARCH$FACT_DATE on SMASTER.FACTURA_ARCH_EXC (FACT_DATE) tablespace USERS;
create unique index SMASTER.F_EXC_ARCH$FACT_ID$PK on SMASTER.FACTURA_ARCH_EXC (FACT_ID, EDATE) tablespace USERS;
create index SMASTER.F_EXC_ARCH$FACT_NUM$IDX on SMASTER.FACTURA_ARCH_EXC (FACT_NUM) tablespace USERS;
create index SMASTER.F_EXC_ARCH$INV_ID$IDX on SMASTER.FACTURA_ARCH_EXC (INV_ID) tablespace USERS;
create index SMASTER.F_EXC_ARCH$ITG_CLNT_ID$IDX on SMASTER.FACTURA_ARCH_EXC (ITG_CLNT_ID) tablespace USERS;
create index SMASTER.F_EXC_ARCH$MAIN_FACT_ID$IDX on SMASTER.FACTURA_ARCH_EXC (MAIN_FACT_ID) tablespace USERS;

alter table SMASTER.FACTURA_ARCH read only


ALTER TABLE SMASTER.FACTURA_ARCH EXCHANGE PARTITION P_12_2017 WITH TABLE SMASTER.FACTURA_ARCH_EXC INCLUDING INDEXES WITHOUT VALIDATION;

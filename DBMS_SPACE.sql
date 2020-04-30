DECLARE
 SMPP_MESSAGEub NUMBER;
 SMPP_MESSAGEab NUMBER;

 SMPP_MESSAGE_PARTSub NUMBER;
 SMPP_MESSAGE_PARTSab NUMBER;
  
 clSMPP_MESSAGE sys.create_table_cost_columns;
 clSMPP_MESSAGE_PARTS sys.create_table_cost_columns;
 BEGIN
  clSMPP_MESSAGE := sys.create_table_cost_columns(sys.create_table_cost_colinfo('NUMBER',22),
sys.create_table_cost_colinfo('NUMBER',22),
sys.create_table_cost_colinfo('NUMBER',22),
sys.create_table_cost_colinfo('VARCHAR2',2048),
sys.create_table_cost_colinfo('VARCHAR2',2048),
sys.create_table_cost_colinfo('NUMBER',22),
sys.create_table_cost_colinfo('DATE',7),
sys.create_table_cost_colinfo('VARCHAR2',50),
sys.create_table_cost_colinfo('VARCHAR2',50),
sys.create_table_cost_colinfo('DATE',7),
sys.create_table_cost_colinfo('DATE',7),
sys.create_table_cost_colinfo('VARCHAR2',5),
sys.create_table_cost_colinfo('VARCHAR2',5),
sys.create_table_cost_colinfo('NUMBER',22),
sys.create_table_cost_colinfo('NUMBER',22),
sys.create_table_cost_colinfo('NUMBER',22),
sys.create_table_cost_colinfo('VARCHAR2',1024),
sys.create_table_cost_colinfo('BLOB',4000),
sys.create_table_cost_colinfo('VARCHAR2',1024),
sys.create_table_cost_colinfo('DATE',7),
sys.create_table_cost_colinfo('VARCHAR2',50),
sys.create_table_cost_colinfo('DATE',7),
sys.create_table_cost_colinfo('NUMBER',22),
sys.create_table_cost_colinfo('NUMBER',22),
sys.create_table_cost_colinfo('NUMBER',22),
sys.create_table_cost_colinfo('NUMBER',22),
sys.create_table_cost_colinfo('NUMBER',22),
sys.create_table_cost_colinfo('NUMBER',22),
sys.create_table_cost_colinfo('NUMBER',22),
sys.create_table_cost_colinfo('DATE',7),
sys.create_table_cost_colinfo('VARCHAR2',30));
  DBMS_SPACE.CREATE_TABLE_COST('USERS',clSMPP_MESSAGE,33261087,5,SMPP_MESSAGEub,SMPP_MESSAGEab);
--  DBMS_OUTPUT.PUT_LINE('Used Bytes: ' || TO_CHAR(ub));
  DBMS_OUTPUT.PUT_LINE('SMPP_MESSAGE Alloc MBytes: ' || TO_CHAR(trunc(SMPP_MESSAGEab/1024/1024)));


  clSMPP_MESSAGE_PARTS := sys.create_table_cost_columns(
sys.create_table_cost_colinfo('NUMBER',22),
sys.create_table_cost_colinfo('VARCHAR2',50)
);
  DBMS_SPACE.CREATE_TABLE_COST('USERS',clSMPP_MESSAGE_PARTS,33261087,5,SMPP_MESSAGE_PARTSub,SMPP_MESSAGE_PARTSab);
--  DBMS_OUTPUT.PUT_LINE('Used Bytes: ' || TO_CHAR(ub));
  DBMS_OUTPUT.PUT_LINE('SMPP_MESSAGE_PARTS Alloc MBytes: ' || TO_CHAR(trunc(SMPP_MESSAGE_PARTSab/1024/1024)));
END;
/


select * from dba_indexes where table_name in ('SMPP_MESSAGE','SMPP_MESSAGE_PARTS') and owner='MLINK21'
/table_SMPP_MESSAGE.1

select ind_SMPP_MESSAGE.*, table_SMPP_MESSAGE.*, ind_SMPP_MESSAGE.a/table_SMPP_MESSAGE.b from (select trunc(sum(bytes/1024/1024/1024)) a from dba_segments where segment_name in (
'SMPP_MESSAGE#TAG',
'IDX$$_2C58A0001',
'SYS_IL0001502047C00018$$',
'PK_SMPP_MESSAGE',
'SMPPMSG_STATE_IDX',
'SMPPMSG_EXPIRE_IDX',
'SMPPMSG_RECIP_IDX',
'SMPPMSG_TRANSP_IDX')  and owner='MLINK21') ind_SMPP_MESSAGE, 
(select trunc(sum(bytes/1024/1024/1024)) b from dba_segments where segment_name in ('SMPP_MESSAGE','MLINK21')) table_SMPP_MESSAGE

(select trunc(sum(bytes/1024/1024/1024)) a from dba_segments where segment_name in 
'MSGPART_MSG_ID_IDX',
'MSGPART_TRANSP_IDX') and owner='MLINK21') (select trunc(sum(bytes/1024/1024/1024)) from dba_segments where segment_name in ('SMPP_MESSAGE_PARTS')) from dual;


select 'sys.create_table_cost_colinfo('''||DATA_TYPE||''','||DATA_LENGTH||'),' from dba_tab_columns c where owner='MLINK21' and table_name='SMPP_MESSAGE'
select 'sys.create_table_cost_colinfo('''||DATA_TYPE||''','||DATA_LENGTH||'),' from dba_tab_columns c where owner='MLINK21' and table_name=upper('SMPP_MESSAGE_PARTS')

mlink21.



MLINK21.SMPP_MESSAGE
MLINK21.SMPP_MESSAGE_PARTS
MLINK21.ERRORS
MLINK21.LOGGING

select * from dba_segments where owner ='MLINK21'

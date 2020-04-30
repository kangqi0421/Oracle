select * from dba_users where username='USER_FROM_DWH'

create table USER_FROM_DWH.db_tables tablespace CB_UTILS_TBS as select * from dba_tables;
--grant select on USER_FROM_DWH.db_tables to user_from_IPC;

create table USER_FROM_DWH.db_tab_columns tablespace CB_UTILS_TBS as select 
OWNER,
TABLE_NAME,
COLUMN_NAME,
DATA_TYPE,
DATA_TYPE_MOD,
DATA_TYPE_OWNER,
DATA_LENGTH,
DATA_PRECISION,
DATA_SCALE,
NULLABLE,
COLUMN_ID,
DEFAULT_LENGTH,
--DATA_DEFAULT,
NUM_DISTINCT,
LOW_VALUE,
HIGH_VALUE,
DENSITY,
NUM_NULLS,
NUM_BUCKETS,
LAST_ANALYZED,
SAMPLE_SIZE,
CHARACTER_SET_NAME,
CHAR_COL_DECL_LENGTH,
GLOBAL_STATS,
USER_STATS,
AVG_COL_LEN,
CHAR_LENGTH,
CHAR_USED,
V80_FMT_IMAGE,
DATA_UPGRADED,
HISTOGRAM,
DEFAULT_ON_NULL,
IDENTITY_COLUMN,
SENSITIVE_COLUMN,
EVALUATION_EDITION,
UNUSABLE_BEFORE,
UNUSABLE_BEGINNING
from dba_tab_columns c;

grant select on USER_FROM_DWH.db_tab_columns to user_from_IPC;


#!/usr/bin/bash

rman target / <<EOF
SPOOL LOG TO 'restor_db_${ORACLE_SID}_$(date +%d_%m_%Y_%H_%M).log';
@restoredatafile.rmn
EOF
rman target / <<EOF
SPOOL LOG TO 'recover_db_${ORACLE_SID}_$(date +%d_%m_%Y_%H_%M).log';
@recoverdb.rmn
EOF


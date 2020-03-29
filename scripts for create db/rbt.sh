#!/bin/sh

OLD_UMASK=`umask`
umask 0027
mkdir -p /u01/app/oracle/admin/PRRBT/adump
mkdir -p /u01/app/oracle/admin/PRRBT/dpdump
mkdir -p /u01/app/oracle/admin/PRRBT/pfile
mkdir -p /u01/app/oracle/cfgtoollogs/dbca/PRRBT
umask ${OLD_UMASK}
ORACLE_SID=rbt; export ORACLE_SID
PATH=$ORACLE_HOME/bin:$PATH; export PATH
echo You should Add this entry in the /etc/oratab: rbt:/u01/app/oracle/product/11.2.0.4/db_1:Y
/u01/app/oracle/product/11.2.0.4/db_1/bin/sqlplus /nolog @/u01/app/oracle/admin/PRRBT/scripts/rbt.sql

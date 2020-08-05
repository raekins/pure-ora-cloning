#!/bin/bash

export RED='\e[0;31m' # '\e[1;32m' is too bright for white bg.
export GREEN='\e[0;32m' # '\e[1;32m' is too bright for white bg.
export BLUE='\e[1;34m' # '\e[1;32m' is too bright for white bg.
export NC='\e[0m'

export ORACLE_SID=oraslob
export ORACLE_HOME=/u01/app/oracle/product/18.0.0/dbhome_1
export PATH=$PATH:$ORACLE_HOME/bin

echo -e "${BLUE}Startup database clone as ${ORACLE_SID} ${NC}"

sqlplus -s / as sysdba << EOF
startup pfile='/u01/app/oracle/product/18.0.0/dbhome_1/dbs/initoraslob.ora'
alter system switch logfile;
@rename.sql
alter database disable block change tracking;
shutdown immediate;
startup mount pfile='/u01/app/oracle/product/18.0.0/dbhome_1/dbs/initoraslob.ora'
exit
EOF

echo -e "${BLUE}Running ${ORACLE_SID} database ${NC}"
ps -eo pid,user,cmd | egrep [ora_s]mon_${ORACLE_SID}

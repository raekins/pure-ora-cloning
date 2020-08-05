#!/bin/bash

export RED='\e[0;31m' # '\e[1;32m' is too bright for white bg.
export GREEN='\e[0;32m' # '\e[1;32m' is too bright for white bg.
export BLUE='\e[1;34m' # '\e[1;32m' is too bright for white bg.
export NC='\e[0m'

export ORACLE_SID=psta
export ORACLE_HOME=/u01/app/oracle/product/18.0.0/dbhome_1
export PATH=$PATH:$ORACLE_HOME/bin

echo -e "${GREEN}Startup database clone as ${ORACLE_SID} ${NC}"

sqlplus -s / as sysdba << EOF
set echo off
set termout off
set feedback off
set timing on

startup 
EOF
echo -e ""
echo -e "${BLUE}Check for ${ORACLE_SID} database running ${NC}"
ps -eo pid,user,cmd | egrep [ora_s]mon_${ORACLE_SID}

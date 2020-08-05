#!/bin/bash

export RED='\e[0;31m' # '\e[1;32m' is too bright for white bg.
export GREEN='\e[0;32m' # '\e[1;32m' is too bright for white bg.
export BLUE='\e[1;34m' # '\e[1;32m' is too bright for white bg.
export NC='\e[0m'

export ORACLE_SID=psta
export NEW_SID=pstb
export ORACLE_HOME=/u01/app/oracle/product/18.0.0/dbhome_1
export PATH=$PATH:$ORACLE_HOME/bin

echo -e "${GREEN}Shutdown Database ${ORACLE_SID} and startup mount${NC}"
sqlplus -s / as sysdba @restart-mount-asm.sql
echo ""

echo -e "${GREEN}Rename Database ${ORACLE_SID} as ${NEW_SID} using Oracle nid utility${NC}"
nid target=sys/Osmium76 dbname=${NEW_SID} logfile=dbnamechg.log setname='YES'

echo -e ""
echo -e "${BLUE}Show Running database(s) ${NC}"
ps -eo pid,user,cmd | egrep [ora_s]mon

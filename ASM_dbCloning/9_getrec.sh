#!/bin/bash

export RED='\e[0;31m' # '\e[1;32m' is too bright for white bg.
export GREEN='\e[0;32m' # '\e[1;32m' is too bright for white bg.
export BLUE='\e[1;34m' # '\e[1;32m' is too bright for white bg.
export NC='\e[0m'

export ORACLE_HOME=/u01/app/oracle/product/18.0.0/dbhome_1
export PATH=$PATH:$ORACLE_HOME/bin

echo -e "${GREEN}Show Connection database ${NC}"
sqlplus -s HR/HR@//z-oracle2:1521/pdb1.uklab.purestorage.com @showservice.sql

echo -e "${GREEN}Get test record from pstb pdb1 pluggable database ${NC}"
sqlplus -s HR/HR@//z-oracle2:1521/pdb1.uklab.purestorage.com @emp_sel.sql
exit

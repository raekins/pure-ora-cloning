#!/bin/bash

export RED='\e[0;31m' # '\e[1;32m' is too bright for white bg.
export GREEN='\e[0;32m' # '\e[1;32m' is too bright for white bg.
export BLUE='\e[1;34m' # '\e[1;32m' is too bright for white bg.
export NC='\e[0m'

export ORACLE_HOME=/u01/app/oracle/product/18.0.0/dbhome_1
export PATH=$PATH:$ORACLE_HOME/bin

echo -e "${BLUE}Show database details psta${NC}"
sqlplus -s system/Osmium76@//z-oracle1:1521/psta.uklab.purestorage.com @database_details
echo -e "${BLUE}Show database details psta:pdb1${NC}"
sqlplus -s system/Osmium76@//z-oracle1:1521/pdb1.uklab.purestorage.com @showspace

#!/bin/bash
export RED='\e[0;31m' # '\e[1;32m' is too bright for white bg.
export GREEN='\e[0;32m' # '\e[1;32m' is too bright for white bg.
export BLUE='\e[1;34m' # '\e[1;32m' is too bright for white bg.
export NC='\e[0m'

export ORACLE_SID=+ASM
export ORACLE_HOME=/u01/app/18.0.0/grid

source ~/grid_env

echo -e "${GREEN}Re-Mount ASM Diskgroups ${NC}"
sqlplus -s / as sysasm @mount.sql
echo -e ""

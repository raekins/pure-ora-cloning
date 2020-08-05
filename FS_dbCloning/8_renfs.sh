#!/bin/bash

export RED='\e[0;31m' # '\e[1;32m' is too bright for white bg.
export GREEN='\e[0;32m' # '\e[1;32m' is too bright for white bg.
export BLUE='\e[1;34m' # '\e[1;32m' is too bright for white bg.
export NC='\e[0m'

echo -e "${BLUE}Rename operating system directories ${NC}"

mv /u02/oradata/ORASLOB /u02/oradata/DEVSLOB
mv /u03/oraredo/ORASLOB /u03/oraredo/DEVSLOB
mv /u03/fast_recovery_area/ORASLOB/ /u03/fast_recovery_area/DEVSLOB

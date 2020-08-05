#!/bin/bash

export RED='\e[0;31m' # '\e[1;32m' is too bright for white bg.
export GREEN='\e[0;32m' # '\e[1;32m' is too bright for white bg.
export BLUE='\e[1;34m' # '\e[1;32m' is too bright for white bg.
export NC='\e[0m'

echo -e "${BLUE}Mounted Volumes ${NC}"
df -h | grep u0[1-3]
echo -e ""

sudo umount /u02
sudo umount /u03

echo -e "${BLUE}Unmount Database Volumes ${NC}"
df -h | grep u0[1-3]

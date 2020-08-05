#!/bin/bash

export RED='\e[0;31m' # '\e[1;32m' is too bright for white bg.
export GREEN='\e[0;32m' # '\e[1;32m' is too bright for white bg.
export BLUE='\e[1;34m' # '\e[1;32m' is too bright for white bg.
export NC='\e[0m'

Suffix=`date +%s`
JsonContent="Content-Type: application/json"
XmlContent="Content-Type: application/xml"
ApiToken=5d8ad02f-547d-fc24-bb51-fa0d2b0de973
Cookie=/tmp/cookie.jar

MaxTimeout=30
Array=10.225.112.80
SourceHost=z-oracle1
TargetHost=z-oracle2

Curl=/usr/bin/curl
Rm=/bin/rm


cleanup () {

exit
${Rm} ${Cookie} ${PgroupTmp} ${PgroupNames} ${CloneList}  ${PgroupSnapshots}

echo -e "\n\n\n\nExiting.\n\n\n"
exit

}

trap_interrupt () {

echo -e "\n\n\n\n***   Interrupt caught. Exiting   ***\n\n\n\n"
cleanup
exit $?
}


trap trap_interrupt SIGINT


#
# To get the API token use "pureadmin list --api-token --expose" on the array
# This is needed for ReST authentication throughout the script
#
echo -e "${GREEN}Perform Protection Group Snapshot of ${SourceHost}PG ${NC}"

${Curl} -s -k -m ${MaxTimeout} -H "${JsonContent}" -c ${Cookie} -X POST https://${Array}/api/1.17/auth/session -d "
{
        \"api_token\": \"${ApiToken}\"
}
"  >/dev/null



${Curl} -s -k -m ${MaxTimeout} -H "${JsonContent}" -b ${Cookie} -X POST https://${Array}/api/1.17/pgroup -d "
{
	\"apply_retention\": true,
	\"snap\": true,
	\"source\": [ 
		\"${SourceHost}PG\" 
	],
	\"suffix\": \"SNAP-${Suffix}\"
}
" >/dev/null

SourceVol=${SourceHost}-u02
TargetVol=${TargetHost}-u02
echo -e "${GREEN}\nOverwriting $TargetVol with $SourceVol ${NC}"
${Curl} -s -k -m ${MaxTimeout} -H "${JsonContent}" -b ${Cookie} -X POST https://${Array}/api/1.17/volume/${TargetVol} -d "
{
	\"source\": \"${SourceHost}PG.SNAP-${Suffix}.${SourceVol}\",
	\"overwrite\": true
}
"  >/dev/null

SourceVol=${SourceHost}-u03
TargetVol=${TargetHost}-u03
echo -e "${GREEN}\nOverwriting $TargetVol with $SourceVol ${NC}"
${Curl} -s -k -m ${MaxTimeout} -H "${JsonContent}" -b ${Cookie} -X POST https://${Array}/api/1.17/volume/${TargetVol} -d "
{
	\"source\": \"${SourceHost}PG.SNAP-${Suffix}.${SourceVol}\",
	\"overwrite\": true
}
"  >/dev/null

echo

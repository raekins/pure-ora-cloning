#!/bin/bash

export RED='\e[0;31m' # '\e[1;32m' is too bright for white bg.
export GREEN='\e[0;32m' # '\e[1;32m' is too bright for white bg.
export BLUE='\e[1;34m' # '\e[1;32m' is too bright for white bg.
export NC='\e[0m'

Suffix=`date +%s`
JsonContent="Content-Type: application/json"
XmlContent="Content-Type: application/xml"
ApiToken=aaa441be-898d-0c8b-7d91-e453f5cc183b
#ApiToken=5d8ad02f-547d-fc24-bb51-fa0d2b0de973
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
echo -e "${GREEN}Perform Protection Group Snapshot of ${SourceHost}-pstaPG ${NC}"

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
		\"${SourceHost}-pstaPG\" 
	],
	\"suffix\": \"SNAP-${Suffix}\"
}
" >/dev/null

SourceVol=${SourceHost}-dg_oradata1
TargetVol=${TargetHost}-dg_oradata1
echo -e "${GREEN}\nOverwriting $TargetVol with $SourceVol ${NC}"
${Curl} -s -k -m ${MaxTimeout} -H "${JsonContent}" -b ${Cookie} -X POST https://${Array}/api/1.17/volume/${TargetVol} -d "
{
	\"source\": \"${SourceHost}-pstaPG.SNAP-${Suffix}.${SourceVol}\",
	\"overwrite\": true
}
"  >/dev/null

SourceVol=${SourceHost}-dg_oraredo1
TargetVol=${TargetHost}-dg_oraredo1
echo -e "${GREEN}\nOverwriting $TargetVol with $SourceVol ${NC}"
${Curl} -s -k -m ${MaxTimeout} -H "${JsonContent}" -b ${Cookie} -X POST https://${Array}/api/1.17/volume/${TargetVol} -d "
{
	\"source\": \"${SourceHost}-pstaPG.SNAP-${Suffix}.${SourceVol}\",
	\"overwrite\": true
}
"  >/dev/null

#SourceVol=${SourceHost}-dg_orafra1
#TargetVol=${TargetHost}-dg_orafra1
#echo -e "${GREEN}\nOverwriting $TargetVol with $SourceVol ${NC}"
#${Curl} -s -k -m ${MaxTimeout} -H "${JsonContent}" -b ${Cookie} -X POST https://${Array}/api/1.17/volume/${TargetVol} -d "
#{
#	\"source\": \"${SourceHost}-pstaPG.SNAP-${Suffix}.${SourceVol}\",
#	\"overwrite\": true
#}
#"  >/dev/null

#echo

set feed off
set verify off
set pagesize 0
set linesize 132
set echo off
set heading off
set termout off

col ht noprint new_value ht
col ih noprint new_value ih
col sn noprint new_value sn
col sd noprint new_value sd
col st noprint new_value st
col su noprint new_value su

SELECT to_char(sysdate,'dd/mm/yy hh24:mi:ss') as sd FROM dual;
SELECT SYS_CONTEXT ('USERENV','SERVER_HOST') as ht FROM dual;
SELECT SYS_CONTEXT ('USERENV','INSTANCE_NAME') as ih FROM dual;
SELECT SYS_CONTEXT ('USERENV','SERVICE_NAME') as sn FROM dual;
SELECT SYS_CONTEXT ('USERENV','SESSION_USER') as su FROM dual;

set termout on

prompt Current Time   : &sd
prompt
prompt Database Details
prompt ===============================================
prompt Hostname       : &ht
prompt Database Name  : &ih
prompt Service Name   : &sn
prompt User Name      : &su
prompt
EXIT

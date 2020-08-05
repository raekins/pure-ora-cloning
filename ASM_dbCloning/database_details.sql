set feed off
set verify off
set pagesize 0
set linesize 132
set echo off
set heading off
set termout off

col dc noprint new_value dc
col ds noprint new_value ds
col ht noprint new_value ht
col ih noprint new_value ih
col rt noprint new_value rt
col sd noprint new_value sd
col st noprint new_value st
col no noprint new_value no
col pt noprint new_value pt
col sa noprint new_value sa
col su noprint new_value su

SELECT to_char(sysdate,'dd/mm/yy hh24:mi:ss') as sd FROM dual;
SELECT to_char(created,'dd/mm/yy hh24:mi:ss') dc FROM v$database;
SELECT instance_name ih, host_name ht, to_char(startup_time,'dd/mm/yy hh24:mi:ss') ds, status st FROM v$instance;
SELECT to_char(resetlogs_time,'dd/mm/yy hh24:mi:ss') rt FROM v$database_incarnation;
SELECT to_char(sum(bytes)/1024/1024/1024,'9,999.99') || ' GB' as sa FROM dba_data_files;
SELECT to_char(sum(bytes)/1024/1024/1024,'9,999.99') || ' GB' as su FROM dba_segments;
set termout on

prompt Current Time   : &sd
prompt
prompt Database Details
prompt ===============================================
prompt Hostname       : &ht
prompt Database Name  : &ih
prompt Date Created   : &dc
prompt Date Started   : &ds
prompt Resetlogs Date : &rt
prompt DB Status      : &st
prompt Space Allocated: &sa
prompt Space Used     : &su
prompt
EXIT

set echo off
set termout off 
set feedback off
set timing off

shutdown immediate;
startup nomount;
alter system set db_name=pstb SCOPE=spfile;
alter system set local_listener=LISTENER_PSTB SCOPE=both;
shutdown immediate;
startup mount;
alter database open;
show con_name;
show pdbs;
ALTER PLUGGABLE DATABASE pdb1 OPEN;
ALTER PLUGGABLE DATABASE pdb1 SAVE STATE;
show pdbs;
exit

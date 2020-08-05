set echo on
set termout on 
set feedback on
set timing on

startup mount;
alter database open resetlogs;
show con_name;
show pdbs;
ALTER PLUGGABLE DATABASE pdb1 OPEN;
ALTER PLUGGABLE DATABASE pdb1 SAVE STATE;
show pdbs;
exit

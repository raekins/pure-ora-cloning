set veri off
set feed off
set echo off

col ih noprint new_value ih
col ht noprint new_value ht
select instance_name ih, host_name ht from v$instance;
prompt Connected to Instance "&ih" on Host "&ht"
prompt
accept nm prompt 'Please enter your first name: '
accept cst prompt 'What is your second name: '
insert into sys.pure_demo values ('&nm','&cst','Pure',sysdate);
commit;

prompt
col ct format a32 heading 'Record Count'
select 'Total number of records: '||count(*) ct from pure_demo;
prompt
prompt Host-Server    : &ih-&ht
prompt Name           : &nm
prompt Current Storage: &cst
prompt

@showspace.sql
prompt
alter system archive log current;
exit

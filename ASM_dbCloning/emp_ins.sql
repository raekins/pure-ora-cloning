set veri off
set feed off
set echo off

col ih noprint new_value ih
col ht noprint new_value ht
col ei noprint new_value ei
SELECT SYS_CONTEXT ('USERENV','SERVER_HOST') as ht FROM dual;
SELECT SYS_CONTEXT ('USERENV','INSTANCE_NAME') as ih FROM dual;
SELECT employee_seq.nextval as ei FROM dual;

prompt Connected to Instance "&ih" on Host "&ht"
prompt
accept nm prompt 'Please enter your first name: '
accept cst prompt 'What is your second name: '
insert into employees values (&ei,'&nm','&cst','&nm.&cst@&ht','01234-567890',to_date(sysdate,'dd-MON-yyyy'),'IT_PROG',10000,NULL,103,60);

commit;

prompt
col ct format a32 heading 'Record Count'
select 'Total number of records: '||count(*) ct from employees;
prompt

exit

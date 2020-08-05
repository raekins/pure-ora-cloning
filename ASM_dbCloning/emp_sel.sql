set verify off
set pagesize 0
set linesize 132
set echo on
set heading off
set termout on

col ct format a32 heading 'Record Count'
prompt Last employee entered was:
select EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL from employees where rownum=1 order by EMPLOYEE_ID DESC;
select 'Total number of Employees: '||count(*) as ct  from employees;
prompt

exit

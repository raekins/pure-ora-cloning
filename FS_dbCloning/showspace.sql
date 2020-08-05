col msg format a50 heading 'Space Details'
select 'Allocated Space : '||to_char(sum(bytes)/1024/1024/1024,'9,999.99')||' GB' msg
  from dba_data_files
union all
select 'Used Space      : '||to_char(sum(bytes)/1024/1024/1024,'9,999.99')||' GB'  msg
  from dba_segments
/
prompt 
exit

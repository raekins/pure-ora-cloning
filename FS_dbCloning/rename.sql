set lines 256
set head off
set echo off
set veri off
set feed off
set term off
spool rename_files.sql
prompt set veri off
prompt set echo off
prompt set feed off
prompt set term off
select 'alter database rename file '''||
        name||''' to '''||
        substr(name,1,instr(name,'ORASLOB')-1) ||'DEVSLOB'||substr(name,instr(name,'ORASLOB')+7) ||''';'
  from v$datafile;
select 'alter database rename file '''||member||''' to '''||
       substr(member,1,instr(member,'ORASLOB')-1) ||'DEVSLOB'||substr(member,instr(member,'ORASLOB')+7) ||''';'
  from v$logfile;
select 'alter database enable block change tracking using file '''||
        substr(filename,1,instr(filename,'ORASLOB')-1) ||'DEVSLOB'||substr(filename,instr(filename,'ORASLOB')+7) ||''';'
  from v$block_change_tracking;
prompt set term on
spool off

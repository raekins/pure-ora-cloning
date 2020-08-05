alter diskgroup DATA1 dismount
/
alter diskgroup CONTROL_REDO1 dismount
/
alter diskgroup FRA1 dismount
/
SELECT	name, state FROM v$asm_diskgroup ORDER BY name
/
exit

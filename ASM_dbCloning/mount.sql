alter diskgroup DATA1 mount force
/
alter diskgroup CONTROL_REDO1 mount force
/
alter diskgroup FRA1 mount force
/
SELECT	name, state FROM v$asm_diskgroup ORDER BY name
/
exit

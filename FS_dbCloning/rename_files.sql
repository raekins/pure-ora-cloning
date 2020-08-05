set veri off
set echo off
set feed off
set term off

alter database rename file '/u02/oradata/ORASLOB/system01.dbf' to '/u02/oradata/DEVSLOB/system01.dbf';                                                                                                                                                          
alter database rename file '/u02/oradata/ORASLOB/sysaux01.dbf' to '/u02/oradata/DEVSLOB/sysaux01.dbf';                                                                                                                                                          
alter database rename file '/u02/oradata/ORASLOB/undotbs01.dbf' to '/u02/oradata/DEVSLOB/undotbs01.dbf';                                                                                                                                                        
alter database rename file '/u02/oradata/ORASLOB/iops.dbf' to '/u02/oradata/DEVSLOB/iops.dbf';                                                                                                                                                                  
alter database rename file '/u02/oradata/ORASLOB/users01.dbf' to '/u02/oradata/DEVSLOB/users01.dbf';                                                                                                                                                            

alter database rename file '/u03/oraredo/ORASLOB/redo03.log' to '/u03/oraredo/DEVSLOB/redo03.log';                                                                                                                                                              
alter database rename file '/u03/oraredo/ORASLOB/redo02.log' to '/u03/oraredo/DEVSLOB/redo02.log';                                                                                                                                                              
alter database rename file '/u03/oraredo/ORASLOB/redo01.log' to '/u03/oraredo/DEVSLOB/redo01.log';                                                                                                                                                              

alter database enable block change tracking using file '/u02/oradata/DEVSLOB/bct.dbf';                                                                                                                                                                          
set term on

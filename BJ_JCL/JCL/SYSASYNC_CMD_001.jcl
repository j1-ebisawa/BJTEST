@display 'Test start'
>P001
\SYSASYNC CMD.EXE /c "copy /b %INDATA%SYSASYNC_CMD_001 %OTDATA%SYSASYNC_CMD_001"
@display 'Test end'
@SET QUTESTID  'SYSASYNC_CMD_001'
@INSERT jcl\QU_INSERT_T.txt
@end

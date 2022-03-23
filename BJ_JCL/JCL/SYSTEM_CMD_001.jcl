@display 'Test start'
>P001
\SYSTEM CMD.EXE /c copy /b %INDATA%SYSTEM_CMD_001 %OTDATA%SYSTEM_CMD_001
@display 'Test end'
@SET QUTESTID  'SYSTEM_CMD_001'
@INSERT jcl\QU_INSERT_T.txt
@end

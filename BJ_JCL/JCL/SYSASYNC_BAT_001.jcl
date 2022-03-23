@display 'Test start'
>P001
\SYSASYNC CMD.EXE /c bat\SYSASYNC_BAT_001.bat
@display 'Test end'
@SET QUTESTID  'SYSASYNC_BAT_001'
@INSERT jcl\QU_INSERT_T.txt
@end

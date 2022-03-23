@display 'Test start'
>P001
\SYSTEM CMD.EXE /c bat\SYSTEM_BAT_001.bat
@display 'Test end'
@SET QUTESTID  'SYSTEM_BAT_001'
@INSERT jcl\QU_INSERT_T.txt
@end

@display 'Test start'
>P001
\SYSASYNC CMD.EXE /c iscrun BJ_ISRUN -c config\usercfg.txt BJ_JCL jcl\PROG_USER_001.jcl
@display 'Test end'
@SET QUTESTID  'SYSASYNC_JCL_001'
@SET QUFNAME1  '%OLOG%&QUTESTID&.log'
@SET QUFNAME2  '%CLOG%&QUTESTID&.log'
\QUCOMPLOG 0002:0004 0007:0007
@end

@display 'Test start'
>P001
\BJ_JCL jcl\PROG_JCL_SUB01.jcl
@display 'Test end'
@SET QUTESTID  'PROG_JCL_001'
@SET QUFNAME1  '%OLOG%&QUTESTID&.log'
@SET QUFNAME2  '%CLOG%&QUTESTID&.log'
\QUCOMPLOG 0002:0004 0006:0009
@end

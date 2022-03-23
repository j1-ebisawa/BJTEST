@display 'Test start'
>P001
\CALL ARG001  aaa bbb ccc ddd
@SET QUTESTID  'CALL_ARG_001'
@SET QUFNAME1  '%OLOG%&QUTESTID&.log'
@SET QUFNAME2  '%CLOG%&QUTESTID&.log'
@display 'Test end'
\QUCOMPLOG 0006:0009
@end

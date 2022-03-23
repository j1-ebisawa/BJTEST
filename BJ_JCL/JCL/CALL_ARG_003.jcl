@display 'Test start'
>P001
@DCL ?VAR_1 int 123
@DCL ?VAR_2 int 567
@DCL ?VAR_3 int 0
\CALL ARG002  ?VAR_1 ?VAR_2 ?VAR_3
@SET QUTESTID  'CALL_ARG_003'
@SET QUFNAME1  '%OLOG%&QUTESTID&.log'
@SET QUFNAME2  '%CLOG%&QUTESTID&.log'
@display 'Test end'
\QUCOMPLOG 0006:0010
@end

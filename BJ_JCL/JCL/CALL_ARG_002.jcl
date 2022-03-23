@display 'Test start'
>P001
@DCL ?VAR_1 char*10 'abcde'
@DCL ?VAR_2 char*10 'fghij'
@DCL ?VAR_3 char*10 '123'
@DCL ?VAR_4 char*10 '789'
\CALL ARG001  ?VAR_1 ?VAR_2 ?VAR_3 ?VAR_4
@SET QUTESTID  'CALL_ARG_002'
@SET QUFNAME1  '%OLOG%&QUTESTID&.log'
@SET QUFNAME2  '%CLOG%&QUTESTID&.log'
@display 'Test end'
\QUCOMPLOG 0006:0009
@end

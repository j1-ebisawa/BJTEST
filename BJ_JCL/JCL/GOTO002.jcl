@display 'Test start'
>P000
@GOTO P003
>P001
@display 'P001'
>P002
@display 'P002'
@GOTO P004
>P003
@display 'P003'
@GOTO P002
>P004
@display 'P004'
@display 'Test end'
@SET QUTESTID  'GOTO002'
@SET QUFNAME1  '%OLOG%&QUTESTID&.log'
@SET QUFNAME2  '%CLOG%&QUTESTID&.log'
\QUCOMPLOG 0002:0010
@end

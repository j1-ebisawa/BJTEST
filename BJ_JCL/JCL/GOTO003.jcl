@display 'Test start'
>P000
@DCL  ?WKLBL char*10 'P003'
@GOTO ?WKLBL
>P001
@display 'P001'
>P002
@display 'P002'
>P003
@display 'P003'
>P004
@display 'P004'
@display 'Test end'
@SET QUTESTID  'GOTO003'
@SET QUFNAME1  '%OLOG%&QUTESTID&.log'
@SET QUFNAME2  '%CLOG%&QUTESTID&.log'
\QUCOMPLOG 0002:0008
@end

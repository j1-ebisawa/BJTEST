@display 'Test start'
>P000
@SET SW5 ON
@JUMP SW5 NE OFF P003
>P001
@display 'P001'
>P002
@display 'P002'
>P003
@display 'P003'
>P004
@display 'P004'
@display 'Test end'
@SET QUTESTID  'JUMP_SW_NE_001'
@SET QUFNAME1  '%OLOG%&QUTESTID&.log'
@SET QUFNAME2  '%CLOG%&QUTESTID&.log'
\QUCOMPLOG 0002:0008
@end

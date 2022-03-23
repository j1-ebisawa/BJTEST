@display 'Test start'
>P000
@DCL  ?WK1 char*10 'abc'
@DCL  ?WK2 char*10 'abcdef'
@IF ?WK1 NE ?WK2
   @GOTO P003
@ELSE
   @GOTO P004
@END-IF
>P001
@display 'P001'
>P002
@display 'P002'
>P003
@display 'P003'
>P004
@display 'P004'
@display 'Test end'
@SET QUTESTID  'IF_DCL_CH_001'
@SET QUFNAME1  '%OLOG%&QUTESTID&.log'
@SET QUFNAME2  '%CLOG%&QUTESTID&.log'
\QUCOMPLOG 0002:0008
@end

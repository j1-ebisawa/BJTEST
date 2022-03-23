@display 'Test start'
>P000
@DCL  ?WK1 int 3
@IF ?WK1 = 1
   @GOTO P001
@ELSE
   @IF ?WK1 = 2
        @GOTO P002
   @ELSE
   @IF ?WK1 = 3
        @GOTO P003
   @END-IF
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
@SET QUTESTID  'IF_DCL_INT_002'
@SET QUFNAME1  '%OLOG%&QUTESTID&.log'
@SET QUFNAME2  '%CLOG%&QUTESTID&.log'
\QUCOMPLOG 0002:0008
@end

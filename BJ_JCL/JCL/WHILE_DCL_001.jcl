@display 'Test start'
>P000
@DCL  ?WK1 int 1
@WHILE ?WK1 < 5
   @DISPLAY ?WK1
   @SET ?WK1 = ?WK1 + 1
@END-WHILE
>P001
@display 'P001'
>P002
@display 'P002'
>P003
@display 'P003'
>P004
@display 'P004'
@display 'Test end'
@SET QUTESTID  'WHILE_DCL_001'
@SET QUFNAME1  '%OLOG%&QUTESTID&.log'
@SET QUFNAME2  '%CLOG%&QUTESTID&.log'
\QUCOMPLOG 0002:0016
@end

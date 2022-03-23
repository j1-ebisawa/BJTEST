@display 'Test start'
>P000
@DCL  ?WK1 int 123
@DCL  ?WK2 int 5
@SET  ?WK2 = ?WK1 * ?WK2
@IF ?WK2 EQ 615
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
@SET QUTESTID  'IF_DCL_INT_001'
@SET QUFNAME1  '%OLOG%&QUTESTID&.log'
@SET QUFNAME2  '%CLOG%&QUTESTID&.log'
\QUCOMPLOG 0002:0008
@end

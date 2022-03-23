@display 'Test start'
>P001
@set  @RETCD  100
#COND=(50) exec if (@RETCD <= 100)
\STEP ARG001 COND=(100) aaa bbbb cccc ddd
\EXEC
@display 'Test end'
@SET QUTESTID  'STEP_COND_002'
@SET QUFNAME1  '%OLOG%&QUTESTID&.log'
@SET QUFNAME2  '%CLOG%&QUTESTID&.log'
\QUCOMPLOG 0006:0009
@end

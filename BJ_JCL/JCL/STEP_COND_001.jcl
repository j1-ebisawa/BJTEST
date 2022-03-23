@display 'Test start'
>P001
@set  @RETCD  100
#COND=(50) exec if (@RETCD <= 50)
\STEP ARG001 COND=(50)  111 222 333 444
\EXEC
@display 'Test end'
@SET QUTESTID  'STEP_COND_001'
@SET QUFNAME1  '%OLOG%&QUTESTID&.log'
@SET QUFNAME2  '%CLOG%&QUTESTID&.log'
\QUCOMPLOG 0002:0004
@end

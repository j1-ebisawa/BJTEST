@display 'Test start'
>P001
@set  @RETCD  130
#COND=(50) exec if (150>=@RETCD >= 80)
\STEP ARG001 COND=(80,150) aaa bbbb cccc ddd
\EXEC
@display 'Test end'
@SET QUTESTID  'STEP_COND_007'
@SET QUFNAME1  '%OLOG%&QUTESTID&.log'
@SET QUFNAME2  '%CLOG%&QUTESTID&.log'
\QUCOMPLOG 0006:0009
@end

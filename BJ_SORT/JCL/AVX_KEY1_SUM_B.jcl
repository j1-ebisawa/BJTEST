@PARAM
IF=(FN=%INDATA%FSEQ_40,RECL=40)
OF=(FN=%OTDATA%AVX_KEY1_SUM_B,RECL=40)
KEY=(4,2,C)
SUM=(16,4,B)
@PEND
\BJ_SORT
@SET QUTESTID  'AVX_KEY1_SUM_B'
@INSERT jcl\QU_INSERT.txt

@PARAM
IF=(FN=%INDATA%FSEQ_40,RECL=40)
OF=(FN=%OTDATA%AVX_KEY1_SUM_ALL,RECL=40)
KEY=(4,2,C)
SUM=((1,3,N),(7,5,S),(16,4,B),(21,5,P))
@PEND
\BJ_SORT
@SET QUTESTID  'AVX_KEY1_SUM_ALL'
@INSERT jcl\QU_INSERT.txt

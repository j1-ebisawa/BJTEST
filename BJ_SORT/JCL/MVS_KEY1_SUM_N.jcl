@SET BJ_FUTIL_PARAOPT 'MVS'
@PARAM
IF=(FN=%INDATA%FSEQ_40,RECL=40)
OF=(FN=%OTDATA%MVS_KEY1_SUM_N,RECL=40)
 SORT FIELDS=(4,2,CH,A)
 SUM  FIELDS=(1,3,ZD)
@PEND
\BJ_SORT
@SET QUTESTID  'MVS_KEY1_SUM_N'
@INSERT jcl\QU_INSERT.txt

@SET BJ_FUTIL_PARAOPT 'MVS'
@PARAM
IF=(FN=%INDATA%FSEQ_40,RECL=40)
OF=(FN=%OTDATA%MVS_KEY1_N,RECL=40)
 SORT FIELDS=(2,2,ZD,A)
@PEND
\BJ_SORT
@SET QUTESTID  'MVS_KEY1_N'
@INSERT jcl\QU_INSERT.txt
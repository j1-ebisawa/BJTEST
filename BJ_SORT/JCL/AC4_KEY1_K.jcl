@SET BJ_FUTIL_PARAOPT 'AC4'
@PARAM
IF=(FN=%INDATA%FSEQ_30,ORG=SEQ,RECL=30)
OF=(FN=%OTDATA%AC4_KEY1_K,ORG=S,RECL=30)
 KEY=(6,4,NCHR)
@PEND
\BJ_SORT
@SET QUTESTID  'AC4_KEY1_K'
@INSERT jcl\QU_INSERT30.txt

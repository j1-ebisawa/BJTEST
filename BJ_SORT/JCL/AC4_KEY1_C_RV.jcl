@SET BJ_FUTIL_PARAOPT 'AC4'
@PARAM
IF=(FN=%INDATA%FSEQ_10,ORG=SEQ,RECL=10)
OF=(FN=%OTDATA%AC4_KEY1_C_RV,ORG=T,RECL=10)
 KEY=(1 1 CHAR RV)
@PEND
\BJ_SORT
@SET QUTESTID  'AC4_KEY1_C_RV'
@INSERT jcl\QU_INSERT_T.txt
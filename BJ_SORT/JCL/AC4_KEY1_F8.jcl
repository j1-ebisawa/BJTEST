@SET BJ_FUTIL_PARAOPT 'AC4'
@PARAM
IF=(FN=%INDATA%FSEQ_40,ORG=SEQ,RECL=40)
OF=(FN=%OTDATA%AC4_KEY1_F8,ORG=S,RECL=40)
 KEY=(32,8,FBIN)
@PEND
\BJ_SORT
@SET QUTESTID  'AC4_KEY1_F8'
@INSERT jcl\QU_INSERT.txt

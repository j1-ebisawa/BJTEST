@SET BJ_FUTIL_PARAOPT 'AC4'
@PARAM
IF=(FN=%INDATA%FSEQ_40,RECL=40)
OF=(FN=%OTDATA%AC4_KEY1_P,ORG=S,RECL=40)
 KEY=(21,5,PDEC)
@PEND
\BJ_SORT
@SET QUTESTID  'AC4_KEY1_P'
@INSERT jcl\QU_INSERT.txt


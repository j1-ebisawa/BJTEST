@SET BJ_FUTIL_PARAOPT 'AC4'
@PARAM
IF=(FN=%INDATA%FSEQ_40,RECL=40)
OF=(FN=%OTDATA%AC4_KEY3_CCS,RECL=40)
KEY=((1,1,CHAR)(4,2,CHAR)(7,5,UDEC))
@PEND
\BJ_SORT
@SET QUTESTID  'AC4_KEY3_CCS'
@INSERT jcl\QU_INSERT.txt
@SET BJ_FUTIL_PARAOPT 'MSP'
@PARAM
IF=(FN=%INDATA%FSEQ_40,RECL=40)
OF=(FN=%OTDATA%ISS_KEY1_FI,RECL=40)
 SORT FIELDS=(16,4,FI,A)
@PEND
\BJ_SORT
@SET QUTESTID  'ISS_KEY1_FI'
@INSERT jcl\QU_INSERT.txt
@SET BJ_FUTIL_PARAOPT 'MSP'
@PARAM
IF=(FN=%INDATA%FSEQ_40,ORG=SEQ,RECL=40)
OF=(FN=%OTDATA%MVS_KEY1_CH_DSC,RECL=40)
 SORT FIELDS=(4,3,CH,D)
@PEND
\BJ_SORT
@SET QUTESTID  'MVS_KEY1_CH_DSC'
@INSERT jcl\QU_INSERT.txt
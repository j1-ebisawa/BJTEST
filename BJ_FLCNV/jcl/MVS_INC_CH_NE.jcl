@SET    BJ_FUTIL_PARAOPT 'MSP'
@PARAM
IF=(FN=%INDATA%FSEQ_40,RECL=40)
OF=(FN=%OTDATA%MVS_INC_CH_NE,ORG=S,RECL=40)
 INCLUDE COND=(4,2,CH,NE,C'EE')
@PEND
\BJ_FLCNV
@SET QUTESTID  'MVS_INC_CH_NE'
@INSERT jcl\QU_INSERT.txt

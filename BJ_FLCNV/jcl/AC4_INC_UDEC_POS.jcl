@SET    BJ_FUTIL_PARAOPT 'AC4'
@PARAM
IF=(FN=%INDATA%FSEQ_40,RECL=40)
OF=(FN=%OTDATA%AC4_INC_UDEC_POS,RECL=40)
INCLUDE=(7,5,POS,UDEC)
@PEND
\BJ_FLCNV
@SET QUTESTID  'AC4_INC_UDEC_POS'
@INSERT jcl\QU_INSERT.txt
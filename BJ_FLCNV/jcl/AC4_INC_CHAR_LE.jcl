@SET    BJ_FUTIL_PARAOPT 'AC4'
@PARAM
IF=(FN=%INDATA%FSEQ_40,ORG=S,RECL=40)
OF=(FN=%OTDATA%AC4_INC_CHAR_LE,ORG=S,RECL=40)
INCLUDE=(1 5 LE CHAR "020MM")
@PEND
\BJ_FLCNV
@SET QUTESTID  'AC4_INC_CHAR_LE'
@INSERT jcl\QU_INSERT.txt
@SET    BJ_FUTIL_PARAOPT 'MSP'
@PARAM
IF=(FN=%INDATA%FSEQ_40,RECL=40)
OF=(FN=%OTDATA%MVS_INC_OR1,ORG=S,RECL=40)
 INCLUDE COND=(1,3,CH,LE,C'050',OR,7,5,ZD,LE,-300)
@PEND
\BJ_FLCNV
@SET QUTESTID  'MVS_INC_OR1'
@INSERT jcl\QU_INSERT.txt

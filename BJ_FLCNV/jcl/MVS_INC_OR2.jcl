@SET    BJ_FUTIL_PARAOPT 'MSP'
@PARAM
IF=(FN=%INDATA%FSEQ_40,RECL=40)
OF=(FN=%OTDATA%MVS_INC_OR2,ORG=S,RECL=40)
 SORT FIELDS=COPY
 INCLUDE COND=(1,3,CH,EQ,C'080',|,1,3,CH,EQ,C'110')
@PEND
\BJ_FLCNV
@SET QUTESTID  'MVS_INC_OR2'
@INSERT jcl\QU_INSERT.txt

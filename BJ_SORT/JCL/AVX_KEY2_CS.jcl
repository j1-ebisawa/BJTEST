@PARAM
IF=(FN=%INDATA%FSEQ_40,RECL=40)
OF=(FN=%OTDATA%AVX_KEY2_CS,RECL=40)
KEY=((1,1,C),(7,5,S))
@PEND
\BJ_SORT
@SET QUTESTID  'AVX_KEY2_CS'
@INSERT jcl\QU_INSERT.txt

@PARAM
IF=(FN=%INDATA%FSEQ_40,RECL=40)
OF=(FN=%OTDATA%AVX_KEY1_SEL_AND3,RECL=40)
SEL=((4,2,C,GE,@FF@)AND(4,2,C,LE,@PP@)A(7,5,P,GT,@0@))
KEY=(4,2,C)
@PEND
\BJ_SORT
@SET QUTESTID  'AVX_KEY1_SEL_AND3'
@INSERT jcl\QU_INSERT.txt


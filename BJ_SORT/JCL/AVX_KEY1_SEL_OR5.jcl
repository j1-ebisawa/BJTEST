@PARAM
IF=(FN=%INDATA%FSEQ_40,RECL=40)
OF=(FN=%OTDATA%AVX_KEY1_SEL_OR5,RECL=40)
SEL=((1,3,C,GE,@150@)OR(4,2,C,EQ,@EE@)O(7,5,S,EQ,@-435@)O(21,5,P,EQ,@-63628@)O(21,5,P,EQ,@287363@))
KEY=(1,5,C)
@PEND
\BJ_SORT
@SET QUTESTID  'AVX_KEY1_SEL_OR5'
@INSERT jcl\QU_INSERT.txt
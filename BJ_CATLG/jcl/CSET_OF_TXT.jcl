#
@PARAM
IF=(FN=%INDATA%FTXT_20,ORG=T)
OF=(FN=%OTDATA%CSET_OF_TXT,ORG=T,RECL=20)
@PEND
\BJ_FUTIL
@SET QUTESTID  'CSET_OF_TXT'
@INSERT jcl\QU_INSERT_T.txt
>end

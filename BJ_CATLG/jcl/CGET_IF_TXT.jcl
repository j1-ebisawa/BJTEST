#IFのRECLはCATLGから取得
@PARAM
IF=(FN=%INDATA%FTXT_10,ORG=T)
OF=(FN=%OTDATA%CGET_IF_TXT,ORG=T,RECL=10)
@PEND
\BJ_FLCNV
@SET QUTESTID  'CGET_IF_TXT'
@INSERT jcl\QU_INSERT_T.txt
>end

#OF=IDXにRECLとKINFを指定
@PARAM
IF=(FN=%INDATA%FTXT_10,ORG=T,RECL=0,10)
OF=(FN=%OTDATA%WIDX_1X,ORG=I,RECL=10,KINF='1,1,0,1,0')
@PEND
\BJ_FUTIL
>end

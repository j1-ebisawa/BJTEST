#OF=IDXにRECLとKINFを指定
@PARAM
IF=(FN=%INDATA%FTXT_10,ORG=T,RECL=0,10)
OF=(FN=%OTDATA%WIDX_1M,ORG=I,RECL=10,KINF='2,2,0,1,0,1,4,2,1,1,1,2,2')
@PEND
\BJ_FUTIL
>end

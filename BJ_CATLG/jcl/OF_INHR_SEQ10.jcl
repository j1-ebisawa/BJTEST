#OFのRECLはIFからINHERITされる
@SET BJ_FUTIL_OFRECL_INHERIT_IF 'Y'
@PARAM
IF=(FN=%INDATA%FSEQ_10,ORG=S)
OF=(FN=%OTDATA%OF_INHR_SEQ10,ORG=S)
@PEND
\BJ_FUTIL
>end

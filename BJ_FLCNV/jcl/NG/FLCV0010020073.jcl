@PARAM
IF=(FN=%INDATA%FSEQ_10,RECL=10)
OF=(FN=%OTDATA%FLCV0010020073_O,RECL=10)
@PEND
\AJ_FLCNV
@PARAM
IF=(FN=%INDATA%FSEQ_10,RECL=10)
OF=(FN=%OTDATA%FLCV0010020073_O,RECL=10,MOD=LOCK,ADD)
@PEND
\AJ_FLCNV
@SET QUTESTID  'FLCV0010020073'
@SET QUFNAME1  '%OTDATA%FLCV0010020073_O'
@SET QUFNAME2  '%CTDATA%FSEQ_10_2'
\QUCOMP

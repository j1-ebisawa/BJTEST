@PARAM
IF=(FN=%INDATA%FSEQ_10,ORG=S,RECL=10)
OF=(FN=%OTDATA%IF_SEQ_001I,ORG=I)
@PEND
\BJ_FUTIL
@PARAM
IF=(FN=%INDATA%FSEQ_10,ORG=S,RECL=10)
OF=(FN=%OTDATA%IF_SEQ_001R,ORG=R,RECL=10)
@PEND
\BJ_FUTIL
@PARAM
IF=(FN=%INDATA%FSEQ_10,ORG=S,RECL=10)
OF=(FN=%OTDATA%IF_SEQ_001S,ORG=S,RECL=10)
@PEND
\BJ_FUTIL
@PARAM
IF=(FN=%INDATA%FSEQ_10,ORG=S,RECL=10)
OF=(FN=%OTDATA%IF_SEQ_001T,ORG=T,RECL=10)
@PEND
\BJ_FUTIL

@SET QUTESTID  'IF_SEQ_001I'
@PARAM
F1=(FN=%OTDATA%IF_SEQ_001I,ORG=I)
F2=(FN=%CTDATA%FIDX_10,ORG=I)
@PEND
\QU_FCOMP
@SET QUTESTID  'IF_SEQ_001R'
@SET QUFNAME1  '%OTDATA%IF_SEQ_001R'
@SET QUFNAME2  '%CTDATA%FREL_10'
\QUCOMP
@SET QUTESTID  'IF_SEQ_001S'
@SET QUFNAME1  '%OTDATA%IF_SEQ_001S'
@SET QUFNAME2  '%CTDATA%FSEQ_10'
\QUCOMP
@SET QUTESTID  'IF_SEQ_001T'
@SET QUFNAME1  '%OTDATA%IF_SEQ_001T'
@SET QUFNAME2  '%CTDATA%FTXT_10'
\QUCOMP
>end

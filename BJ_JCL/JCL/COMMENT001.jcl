@display 'Test start'
>P001
@set ABC '%INDATA%XXXXX'
## This is comment
## this is comment
@display &ABC&
>P002
@set ABC '%OTDATA%YYYY'
@display &ABC&
@display 'Test end'
@SET QUTESTID  'COMMENT001'
@SET QUFNAME1  '%OLOG%&QUTESTID&.log'
@SET QUFNAME2  '%CLOG%&QUTESTID&.log'
\QUCOMPLOG 0002:0007
@end

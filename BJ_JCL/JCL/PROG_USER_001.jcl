@display 'Test start'
>P001
\PROG001
####@goto P003
>P002
\PROG002
>P003
\PROG003
@display 'Test end'
@SET QUTESTID  'PROG_USER_001'
@SET QUFNAME1  '%OLOG%&QUTESTID&.log'
@SET QUFNAME2  '%CLOG%&QUTESTID&.log'
\QUCOMPLOG 0002:0004 0007:0008 0011:0012 0015:0015
@end

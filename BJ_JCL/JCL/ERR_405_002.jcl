@display 'Test start'
>P001
\AJ_MISS
@display 'Test end'
@SET QUTESTID  'ERR_405_001'
@SET QUFNAME1  '%OLOG%&QUTESTID&.log'
@SET QUFNAME2  '%CLOG%&QUTESTID&.log'
\QUCOMPLOG 0002:0004
@end

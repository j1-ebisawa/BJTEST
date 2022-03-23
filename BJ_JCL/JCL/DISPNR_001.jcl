@display 'Test start'
>P001
@displaynr abcdef 12345 
@displaynr ghijklm 7890
@pause
>P002
@display 'Test end'
@SET QUTESTID  'DISPNR_001'
@SET QUFNAME1  '%OLOG%&QUTESTID&.log'
@SET QUFNAME2  '%CLOG%&QUTESTID&.log'
\QUCOMPLOG 0002:0008
@end

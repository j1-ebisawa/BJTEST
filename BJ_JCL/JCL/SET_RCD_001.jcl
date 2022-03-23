@display 'Test start'
>P000
@DCL ?VAR_CH1 char*1 'a'
@DCL ?VAR_CH5 char*5 'opqrs'
@DCL ?VAR_INT1 int  123
@DCL ?W_RCD    int  987
>P001
@set RETURN-CODE  99
@set ?W_RCD RETURN-CODE
@display ?W_RCD
>P002
@set RETURN-CODE  ?VAR_INT1
@set ?W_RCD RETURN-CODE
@display ?W_RCD
>P003
@SET CFG_03 456
@set RETURN-CODE  CFG_03
@set ?W_RCD RETURN-CODE
@DISPLAY ?W_RCD
>P004
@SET RETURN-CODE 0
@display 'Test end'
@SET QUTESTID  'SET_RCD_001'
@SET QUFNAME1  '%OLOG%&QUTESTID&.log'
@SET QUFNAME2  '%CLOG%&QUTESTID&.log'
\QUCOMPLOG 0002:0011
@end

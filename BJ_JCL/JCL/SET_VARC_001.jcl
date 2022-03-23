@display 'Test start'
>P000
@DCL ?VAR_CH1 char*1 'a'
@DCL ?VAR_CH5 char*5 'opqrs'
@DCL ?VAR_INT1 int  123
@DCL ?VAR_INT2 int  987
@DCL ?W_CH10   char*10
>P001
@set ?W_CH10  'abcdef'
@display ?W_CH10
>P002
@set ?W_CH10  ?VAR_CH5
@display ?W_CH10
>P003
@SET RETURN-CODE 111
@SET ?W_CH10  RETURN-CODE
@DISPLAY ?W_CH10
>P004
@set ?W_CH10 = ?VAR_CH5 + 'xyz'
@display ?W_CH10
>P005
@SET RETURN-CODE 0
@display 'Test end'
@SET QUTESTID  'SET_VARC_001'
@SET QUFNAME1  '%OLOG%&QUTESTID&.log'
@SET QUFNAME2  '%CLOG%&QUTESTID&.log'
\QUCOMPLOG 0002:0013
@end

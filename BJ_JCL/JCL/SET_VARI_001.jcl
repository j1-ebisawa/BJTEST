@display 'Test start'
>P000
@DCL ?VAR_CH1 char*1 'a'
@DCL ?VAR_CH5 char*5 'opqrs'
@DCL ?VAR_INT1 int  123
@DCL ?VAR_INT2 int  987
@DCL ?W_INT    int
>P001
@set ?W_INT  428
@display ?W_INT
>P002
@set ?W_INT  ?VAR_INT1
@display ?W_INT
>P003
@SET RETURN-CODE 222
@SET ?W_INT  RETURN-CODE
@DISPLAY ?W_INT
>P004
@set ?W_INT = ?VAR_INT1 * 2
@display ?W_INT
>P005
@SET RETURN-CODE 0
@display 'Test end'
@SET QUTESTID  'SET_VARI_001'
@SET QUFNAME1  '%OLOG%&QUTESTID&.log'
@SET QUFNAME2  '%CLOG%&QUTESTID&.log'
\QUCOMPLOG 0002:0013
@end

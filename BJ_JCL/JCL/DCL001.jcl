@display 'Test start'
>P000
@DCL ?VAR_CH1 char*1 'a'
@DCL ?VAR_CH5 char*5 'abcde'
@DCL ?VAR_INT1 int  123
@DCL ?VAR_INT2 int  987
>P001
@display ?VAR_CH1
@display ?VAR_CH5
@display ?VAR_INT1
@display ?VAR_INT2
>P002
@set ?VAR_CH1 = 'x'
@set ?VAR_CH5 = 'wxyz'
@set ?VAR_INT1 = 456
@set ?VAR_INT2 = 654
>P003
@display ?VAR_CH1
@display ?VAR_CH5
@display ?VAR_INT1
@display ?VAR_INT2
>P004
@display 'Test end'
@SET QUTESTID  'DCL001'
@SET QUFNAME1  '%OLOG%&QUTESTID&.log'
@SET QUFNAME2  '%CLOG%&QUTESTID&.log'
\QUCOMPLOG 0002:0016
@end

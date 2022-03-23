@display 'Test start'
>P000
@DCL ?VAR_CH1 char*1 'a'
@DCL ?VAR_CH5 char*5 'abcde'
@DCL ?VAR_INT1 int  123
@DCL ?VAR_INT2 int  987
>P001
@display 'abcdef'
@display 123
@display 'abc' + 'efg'
@display '123   xyz'
>P002
@set ?VAR_CH5 = '1' + ?VAR_CH1 + '9' 
@display ?VAR_CH5
@set ?VAR_INT1 = ?VAR_INT1 + ?VAR_INT2
@display ?VAR_INT1
>P003
@display xyz 987
>P004
@display 'Test end'
@SET QUTESTID  'DISPLAY_001'
@SET QUFNAME1  '%OLOG%&QUTESTID&.log'
@SET QUFNAME2  '%CLOG%&QUTESTID&.log'
\QUCOMPLOG 0002:0015
@end

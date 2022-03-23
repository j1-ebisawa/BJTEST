@display 'Test start'
>P000
@PAR ?PAR_CH1  char*1 1
@PAR ?PAR_CH5  char*5 2
@PAR ?PAR_INT1 int    3
@PAR ?PAR_INT2 int    4
>P001
@display ?PAR_CH1
@display ?PAR_CH5
@display ?PAR_INT1
@display ?PAR_INT2
>P002
@set ?PAR_CH1 = 'x'
@set ?PAR_CH5 = 'wxyz'
@set ?PAR_INT1 = 456
@set ?PAR_INT2 = 654
>P003
@display ?PAR_CH1
@display ?PAR_CH5
@display ?PAR_INT1
@display ?PAR_INT2
>P004
@display 'Test end'
@SET QUTESTID  'PAR001'
@SET QUFNAME1  '%OLOG%&QUTESTID&.log'
@SET QUFNAME2  '%CLOG%&QUTESTID&.log'
\QUCOMPLOG 0005:0019
@end

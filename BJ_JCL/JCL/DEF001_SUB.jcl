@display 'Test start'
>P000
@DEFINE PARAM01
@DEFINE PARAM02 
@DEFINE PARAM03 
@DEFINE PARAM04 
>P001
@display &PARAM01&
@display &PARAM02&
@display &PARAM03&
@display &PARAM04&
>P002
@set PARAM01  'x'
@set PARAM02  'wxyz'
@set PARAM03  456
@set PARAM04  654
>P003
@display &PARAM01&
@display &PARAM02&
@display &PARAM03&
@display &PARAM04&
>P004
@display 'Test end'
@SET QUTESTID  'DEF001'
@SET QUFNAME1  '%OLOG%&QUTESTID&.log'
@SET QUFNAME2  '%CLOG%&QUTESTID&.log'
\QUCOMPLOG 0005:0019
@end

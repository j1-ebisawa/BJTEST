@display 'Test start'
>P000
@param
aaaaaaaa
bbbbbbbbbbbbbbbb
ffffffffff
123gfht
zzzzzzzzzzz
@pend
\PARAG01
>P-02
@display 'Test end'
@SET QUTESTID  'PARAM001'
@SET QUFNAME1  '%OLOG%&QUTESTID&.log'
@SET QUFNAME2  '%CLOG%&QUTESTID&.log'
\QUCOMPLOG 0006:0012
@end

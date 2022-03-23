@display 'Test start'
>P000
@DCL ?VAR_CH1 char*1 'a'
@DCL ?VAR_CH5 char*5 'opqrs'
@DCL ?VAR_INT1 int  123
@DCL ?VAR_INT2 int  987
>P001
@set CFG_01  'abcdef'
@display &CFG_01&
>P002
@SET CFG_02  ?VAR_CH5
@display &CFG_02&
>P003
@SET CFG_03 = 'cba' + 'gfd'
@DISPLAY &CFG_03&
>P004
# @SET CFG_04 = ?VAR_INT1 * 2 バグじゃないドキュメント間違い
@DISPLAY &CFG_04&
>P005
@SET CFG_05 AJ_JOB_TEMPDIR
@DISPLAY &CFG_05&
>P006
@SET RETURN-CODE 123
@SET CFG_06 RETURN-CODE
@DISPLAY &CFG_06&
>P007
@SET RETURN-CODE 0
@display 'Test end'
@SET QUTESTID  'SET_CFG_001'
@SET QUFNAME1  '%OLOG%&QUTESTID&.log'
@SET QUFNAME2  '%CLOG%&QUTESTID&.log'
\QUCOMPLOG 0002:0017
@end

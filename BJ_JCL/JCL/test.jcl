@display 'Test start'
>P000
@DCL ?VAR_CH1 char*1 'a'
@DCL ?VAR_CH5 char*5 'opqrs'
@DCL ?VAR_INT1 int  123
@DCL ?VAR_INT2 int  987
>P001
>P004
@SET CFG_04 = ?VAR_INT1 * 2
@DISPLAY &CFG_04&
@end

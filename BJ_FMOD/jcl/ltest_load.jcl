@SET JOBNM 'ftest_load'
>STEP00A1
@PARAM
IF=(FN=data\ltest_org.txt,ORG=T,RECL=30,40)
OF=(FN=data\LTEST.txt,ORG=T,RECL=30,40)
@PEND
\BJ_FLCNV
@end

@SET JOBNM 'rtest_load'
>STEP00A1
@PARAM
IF=(FN=data\ftest_org.txt,ORG=T,RECL=00040)
OF=(FN=data\RTEST,ORG=R,RECL=40)
@PEND
\BJ_FLCNV
@end

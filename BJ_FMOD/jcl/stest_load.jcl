@SET JOBNM 'stest_load'
>STEP00A1
@PARAM
IF=(FN=data\ftest_org.txt,ORG=T,RECL=00040)
OF=(FN=data\STEST,ORG=S,RECL=00040)
@PEND
\BJ_FLCNV
@end

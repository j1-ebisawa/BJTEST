@SET JOBNM 'ftest_load'
>STEP00A1
@PARAM
IF=(FN=data\ftest_org.txt,ORG=T,RECL=00040)
OF=(FN=data\FTEST,ORG=I)
@PEND
\BJ_FLCNV
@end

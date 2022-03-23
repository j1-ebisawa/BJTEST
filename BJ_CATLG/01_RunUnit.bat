set CLASSPATH=%CLASSPATH%;../BJTOOL_IS/jar/bjtool.jar
set /P IN_STR="InJCL->"
iscrun BJ_ISRUN -c myconfig.txt BJ_JCL jcl\%IN_STR%.jcl

set CLASSPATH=%CLASSPATH%;../BJTOOL_IS/jar/bjtool.jar
echo off
set /P IN_STR="Input JCL name->"
iscrun BJ_ISRUN -c config\usercfg.txt BJ_JCL jcl\%IN_STR%.jcl

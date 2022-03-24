set CLASSPATH=%CLASSPATH%;../BJTOOL_IS/jar/bjtool.jar
call 00_runJcl FUTIL_CRE_001
call 00_runJcl IF_IDX_001
call 00_runJcl IF_REL_001
call 00_runJcl IF_SEQ_001
call 00_runJcl IF_TXT_001
call 00_runJcl MVS_IF_VSEQ
call 00_runJcl PF_SEQ_001
call 00_runJcl PF_TXT_001

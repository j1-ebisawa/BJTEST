set CLASSPATH=%CLASSPATH%;../BJTOOL_IS/jar/bjtool.jar
call 00_runJcl MVS_FORMAT_CH
call 00_runJcl MVS_FORMAT_PD
call 00_runJcl MVS_FORMAT_ZD
call 00_runJcl MVS_INC_ALL
call 00_runJcl MVS_INC_AND1
call 00_runJcl MVS_INC_AND2
call 00_runJcl MVS_INC_CH_EQ
call 00_runJcl MVS_INC_CH_EQ2
call 00_runJcl MVS_INC_CH_GE
call 00_runJcl MVS_INC_CH_GT
call 00_runJcl MVS_INC_CH_LT
call 00_runJcl MVS_INC_CH_LT2
call 00_runJcl MVS_INC_CH_NE
call 00_runJcl MVS_INC_OR1
call 00_runJcl MVS_INC_OR2
call 00_runJcl MVS_INC_PD_EQ
call 00_runJcl MVS_INC_ZD_GE
call 00_runJcl MVS_OMIT_CH_GE
call 00_runJcl MVS_OMIT_CH_LT
call 00_runJcl MVS_OMIT_ZD_LE
call 00_runJcl MVS_OUTF2_001
call 00_runJcl MVS_OUT_001
call 00_runJcl MVS_OUT_002
call 00_runJcl MVS_OUT_003

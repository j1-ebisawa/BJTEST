set CLASSPATH=%CLASSPATH%;../BJTOOL_IS/jar/bjtool.jar
call 00_runJcl AVX_OUT_001
call 00_runJcl AVX_SEL_AND_AND
call 00_runJcl AVX_SEL_AND_OR
call 00_runJcl AVX_SEL_C_EQ
call 00_runJcl AVX_SEL_C_EQ2
call 00_runJcl AVX_SEL_C_LT
call 00_runJcl AVX_SEL_N_EQ
call 00_runJcl AVX_SEL_N_GE
call 00_runJcl AVX_SEL_P_EQ
call 00_runJcl AVX_SEL_P_GT
call 00_runJcl AVX_SEL_P_LE
call 00_runJcl AVX_SEL_S_EQ
call 00_runJcl AVX_SEL_S_NE

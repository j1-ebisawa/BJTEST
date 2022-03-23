000010 IDENTIFICATION         DIVISION.
000020 PROGRAM-ID.            mk_FIDX_10_M.
000100 ENVIRONMENT            DIVISION.
000110 CONFIGURATION          SECTION.
000120 SOURCE-COMPUTER.       PC.
000130 OBJECT-COMPUTER.       PC.
000140 INPUT-OUTPUT           SECTION.
       FILE-CONTROL.
       SELECT FSEQ            ASSIGN TO FSEQ-NAME
              ORGANIZATION    SEQUENTIAL
              ACCESS MODE     SEQUENTIAL
              FILE STATUS     FSEQ-STS.
       SELECT FIDX            ASSIGN TO FIDX-NAME
              ORGANIZATION    INDEXED
              ACCESS MODE     SEQUENTIAL
              RECORD KEY      FIDX-PKEY = FIDX-F1 FIDX-F5
              ALTERNATE KEY   FIDX-AKEY = FIDX-F2 FIDX-F3-4
                              with duplicates
              FILE STATUS     FIDX-STS.
000360 DATA                   DIVISION.
       FILE SECTION.
       FD    FSEQ.       
       01    FSEQ-REC          PIC X(10).
       FD    FIDX.
       01    FIDX-REC.
             05  FIDX-F1       PIC X(01).
             05  FIDX-F2       PIC X(01).
             05  FIDX-F3-4     PIC X(02).
             05  FIDX-F5       PIC X(01).
             05  FIDX-6-10     PIC X(05).
       WORKING-STORAGE SECTION.
       01  W-X.
           05  W-CNT   PIC 9(5).
       01  FSEQ-NAME      PIC X(128).
       01  FIDX-NAME      PIC X(128).
       
       01  FSEQ-STS       PIC XX.
       01  FIDX-STS       PIC XX.
      *
002220******************************************************************
002230*****     ÇoÇqÇnÇbÇdÇcÇtÇqÇdÅ@ÇcÇhÇuÇhÇrÇhÇnÇmÅ@Å@****************
002240******************************************************************
002250 PROCEDURE  DIVISION.
002260 HAJIME.
           PERFORM MAKE-FIDX.
           accept omitted.
           goback.
      *
       MAKE-FIDX.
           display "Make FIDX_10_M start".
           move "data\FSEQ_10"      TO FSEQ-NAME.
           move "data\FIDX_10_M"    TO FIDX-NAME.
      *
           OPEN INPUT  FSEQ.
           OPEN OUTPUT FIDX.
           PERFORM UNTIL 1 = 0
              READ FSEQ AT END 
                        EXIT PERFORM
              END-READ
              MOVE FSEQ-REC TO FIDX-REC
              WRITE FIDX-REC
           END-PERFORM.
      *
           CLOSE FSEQ FIDX.
           display "Make FIDX_10_M end".

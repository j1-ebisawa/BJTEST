000010 IDENTIFICATION         DIVISION.
000020 PROGRAM-ID.            mk_FIDX_40.
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
              ACCESS MODE     DYNAMIC
              RECORD KEY      IDX-P-KEY
              ALTERNATE KEY   IDX-A-KEY WITH DUPLICATES
              FILE STATUS     FIDX-STS.
             
000360 DATA                   DIVISION.
       FILE SECTION.
      *
       FD    FSEQ.       
       01    SEQ-REC.
         05  SEQ-P-KEY   PIC  9(03).               *> 1:3 ZD
         05  SEQ-A-KEY   PIC  X(02).               *> 4:2 CH
         05  filler      PIC  X(1).
         05  SEQ-A-1     PIC  S9(5).               *> 7:5 ZD
         05  filler      PIC  X(1).
         05  SEQ-A-2     PIC  S9(4)      COMP.     *>13:2 BIN
         05  filler      PIC  X(1).
         05  SEQ-A-3     PIC  S9(8)      COMP.     *>16:4 BIN
         05  filler      PIC  X(1).
         05  SEQ-A-4     PIC  S9(5)V9(3) COMP-3.   *>21:5 PACK
         05  filler      PIC  X(1).
         05  SEQ-A-5                     float.    *>27:4 FLOAT
         05  filler      PIC  X(1). 
         05  SEQ-A-6                     double.   *>32:8 DOUBLE
         05  filler      PIC  X(1). 
      *
       FD    FIDX.
       01    IDX-REC.
         05  IDX-P-KEY   PIC  9(03).               *> 1:3 ZD
         05  IDX-A-KEY   PIC  X(02).               *> 4:2 CH
         05  filler      PIC  X(1).
         05  IDX-A-1     PIC  S9(5).               *> 7:5 ZD
         05  filler      PIC  X(1).
         05  IDX-A-2     PIC  S9(4)      COMP.     *>13:2 BIN
         05  filler      PIC  X(1).
         05  IDX-A-3     PIC  S9(8)      COMP.     *>16:4 BIN
         05  filler      PIC  X(1).
         05  IDX-A-4     PIC  S9(5)V9(3) COMP-3.   *>21:5 PACK
         05  filler      PIC  X(1).
         05  IDX-A-5                     float.    *>27:4 FLOAT
         05  filler      PIC  X(1). 
         05  IDX-A-6                     double.   *>32:8 DOUBLE
         05  filler      PIC  X(1). 
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
           display "Make FIDX_40 start".
           move "data\FSEQ_40" TO FSEQ-NAME.
           move "data\FIDX_40" TO FIDX-NAME.
      *
           OPEN INPUT  FSEQ.
           OPEN OUTPUT FIDX.
           PERFORM UNTIL 1 = 0
              READ FSEQ AT END 
                        EXIT PERFORM
              END-READ
              MOVE SPACE TO IDX-REC
              MOVE SEQ-P-KEY   TO IDX-P-KEY
              MOVE SEQ-A-KEY   TO IDX-A-KEY
              MOVE SEQ-A-1     TO IDX-A-1
              MOVE SEQ-A-2     TO IDX-A-2
              MOVE SEQ-A-3     TO IDX-A-3
              MOVE SEQ-A-4     TO IDX-A-4
              MOVE SEQ-A-5     TO IDX-A-5
              MOVE SEQ-A-6     TO IDX-A-6
              WRITE IDX-REC
           END-PERFORM.
      *
           CLOSE FSEQ FIDX.
           display "Make FIDX_40 end".
      *

000010 IDENTIFICATION         DIVISION.
000020 PROGRAM-ID.            mk_FSEQ_40.
000100 ENVIRONMENT            DIVISION.
000110 CONFIGURATION          SECTION.
000120 SOURCE-COMPUTER.       PC.
000130 OBJECT-COMPUTER.       PC.
000140 INPUT-OUTPUT           SECTION.
       FILE-CONTROL.
       SELECT INTXT           ASSIGN TO INTXT-NAME
              ORGANIZATION    LINE SEQUENTIAL
              ACCESS MODE     SEQUENTIAL
              FILE STATUS     INTXT-STS.
       SELECT FSEQ            ASSIGN TO FSEQ-NAME
              ORGANIZATION    SEQUENTIAL
              ACCESS MODE     SEQUENTIAL
              FILE STATUS     FSEQ-STS.
000360 DATA                   DIVISION.
       FILE SECTION.
       FD    INTXT.
       01    INTXT-REC.
         05  IN-01   PIC  9(03).
         05  IN-02   PIC  X(02).
         05  filler  PIC  X(01).
         05  IN-03   PIC  X(06).
         05  filler  PIC  X(01).
         05  IN-04   PIC  X(05).
         05  filler  PIC  X(01).
         05  IN-05   PIC  X(09).
         05  filler  PIC  X(01).
         05  IN-06   PIC  X(10).
         05  filler  PIC  X(01).
         05  IN-07   PIC  X(11).
         05  filler  PIC  X(01). 
         05  IN-08   PIC  X(11).
         05  filler  PIC  X(01). 
       
       FD    FSEQ.       
       01    FSEQ-REC.
         05  P-KEY   PIC  9(03).                *> 1:3 ZD
         05  A-KEY   PIC  X(02).                *> 4:2 CH
         05  filler  PIC  X(01).
         05  A-1     PIC  S9(05).               *> 7:5 ZD
         05  filler  PIC  X(01).
         05  A-2     PIC  S9(04)      COMP.     *>13:2 BIN
         05  filler  PIC  X(01).
         05  A-3     PIC  S9(08)      COMP.     *>16:4 BIN
         05  filler  PIC  X(01).
         05  A-4     PIC  S9(5)V9(3)  COMP-3.   *>21:5 PACK
         05  filler  PIC  X(01).
         05  A-5                     float.    *>27:4 FLOAT
         05  filler  PIC  X(01). 
         05  A-6                     double.   *>32:8 DOUBLE
         05  filler  PIC  X(01). 
       
       WORKING-STORAGE SECTION.
       01  W-X.
           05  W-CNT   PIC 9(5).
       01  INTXT-NAME     PIC X(128).
       01  FSEQ-NAME      PIC X(128).
       01  INTXT-STS      PIC XX.
       01  FSEQ-STS       PIC XX.
      *
002220******************************************************************
002230*****     ?o?q?n?b?d?c?t?q?d?@?c?h?u?h?r?h?n?m?@?@****************
002240******************************************************************
002250 PROCEDURE  DIVISION.
002260 HAJIME.
           PERFORM MAKE-FSEQ.
           accept omitted.
           goback.
      *
       MAKE-FSEQ.
           display "Make FSEQ_40 start".
           move "data\ORG_FSEQ_40.txt" TO INTXT-NAME.
           move "data\FSEQ_40"         TO FSEQ-NAME.
      *
           OPEN INPUT  INTXT.
           OPEN OUTPUT FSEQ.
      *
           PERFORM UNTIL 1 = 0
              MOVE SPACE TO INTXT-REC
              READ INTXT AT END 
                        EXIT PERFORM
              END-READ
              MOVE ALL "_"   TO FSEQ-REC
              MOVE IN-01     TO P-KEY
              MOVE IN-02     TO A-KEY
              MOVE IN-03     TO A-1
              MOVE FUNCTION NUMVAL-C(IN-04) TO A-2
              MOVE FUNCTION NUMVAL-C(IN-05) TO A-3
              MOVE FUNCTION NUMVAL-C(IN-06) TO A-4
              MOVE FUNCTION NUMVAL-C(IN-07) TO A-5
              MOVE FUNCTION NUMVAL-C(IN-08) TO A-6
              WRITE FSEQ-REC
           END-PERFORM.
      *
           CLOSE FSEQ.
           CLOSE INTXT.
      *
           display "Make FSEQ_40 end".

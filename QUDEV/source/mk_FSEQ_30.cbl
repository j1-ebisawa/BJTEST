000010 IDENTIFICATION         DIVISION.
000020 PROGRAM-ID.            mk_FSEQ_30.
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
           05  IN-01          PIC X(04).     *>1:4  C
           05  FILLER         PIC X(01).
           05  IN-02          PIC X(04).     *>6:4  K
           05  FILLER         PIC X(01).
           05  IN-03          PIC X(04).     *>11:4 N
           05  FILLER         PIC X(01).
           05  IN-04          PIC X(04).     *>16:4 S
           05  FILLER         PIC X(01).
           05  IN-05          PIC X(04).     *>21:4 P
           05  FILLER         PIC X(01).
           05  IN-06          PIC X(04).     *>26:4 B
           05  FILLER         PIC X(01).
       
       FD    FSEQ.       
       01    FSEQ-REC.
           05  OT-01          PIC  X(04).        *>1:4  C
           05  FILLER         PIC  X(01).
           05  OT-02          PIC  X(04).        *>6:4  K
           05  FILLER         PIC  X(01).
           05  OT-03          PIC  9(04).        *>11:4 N
           05  FILLER         PIC  X(01).
           05  OT-04          PIC S9(04).        *>16:4 S
           05  FILLER         PIC  X(01).
           05  OT-05          PIC S9(07) COMP-3. *>21:4 P
           05  FILLER         PIC  X(01).
           05  OT-06          PIC S9(09) COMP.   *>26:4 B
           05  FILLER         PIC  X(01).
       
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
           display "Make FSEQ_30 start".
           move "data\ORG_FSEQ_30.txt" TO INTXT-NAME.
           move "data\FSEQ_30"         TO FSEQ-NAME.
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
              MOVE IN-01     TO OT-01
              MOVE IN-02     TO OT-02
              MOVE IN-03     TO OT-03
              MOVE FUNCTION NUMVAL-C(IN-04) TO OT-04
              MOVE FUNCTION NUMVAL-C(IN-05) TO OT-05
              MOVE FUNCTION NUMVAL-C(IN-06) TO OT-06
              WRITE FSEQ-REC
           END-PERFORM.
      *
           CLOSE FSEQ.
           CLOSE INTXT.
      *
           display "Make FSEQ_30 end".

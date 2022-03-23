000010 IDENTIFICATION         DIVISION.
000020 PROGRAM-ID.            mk_VSEQ_20.
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
       SELECT VSEQ            ASSIGN TO VSEQ-NAME
              ORGANIZATION    SEQUENTIAL
              ACCESS MODE     SEQUENTIAL
              FILE STATUS     VSEQ-STS.
             
000360 DATA                   DIVISION.
       FILE SECTION.
       FD    INTXT.
       01    INTXT-REC.
           05  IN-RECL        PIC 9(03).
           05  FILLER         PIC X(01).
           05  IN-VAL         PIC X(30).
       FD    VSEQ      RECORD IS VARYING 1 to 20 depending on VSEQ-L.
       01    VSEQ-REC         PIC X(20).
       WORKING-STORAGE SECTION.
       01  W-X.
           05  W-CNT   PIC 9(5).
       01  INTXT-NAME     PIC X(128).
       01  VSEQ-NAME      PIC X(128).
       
       01  INTXT-STS      PIC XX.
       01  VSEQ-STS       PIC XX.
       
       01  VSEQ-L         PIC 9(05).
      *
002220******************************************************************
002230*****     ÇoÇqÇnÇbÇdÇcÇtÇqÇdÅ@ÇcÇhÇuÇhÇrÇhÇnÇmÅ@Å@****************
002240******************************************************************
002250 PROCEDURE  DIVISION.
002260 HAJIME.
           PERFORM MAKE-VSEQ.
           accept omitted.
           goback.
      *
       MAKE-VSEQ..
           display "Make VSEQ_20 start".
           move "data\ORG_VSEQ_20.txt" to INTXT-NAME.
           move "data\VSEQ_20"         to VSEQ-NAME.
           
      *
           OPEN INPUT  INTXT.
           OPEN OUTPUT VSEQ.
      *
           PERFORM UNTIL 1 = 0
              MOVE space to INTXT-REC
              READ INTXT AT END
                         EXIT PERFORM
              END-READ
              move IN-RECL to VSEQ-L
              move IN-VAL(1:IN-RECL) TO VSEQ-REC
              WRITE VSEQ-REC
           END-PERFORM.
      *
           CLOSE VSEQ INTXT.
      *
           OPEN INPUT VSEQ.
           PERFORM UNTIL 1 = 0
              move space to VSEQ-REC
              READ VSEQ
                   at end exit perform
              END-READ
            
              display "VSEQ-L=" VSEQ-L
              display  VSEQ-REC
           END-PERFORM.
      *
           CLOSE VSEQ.
      *
           display "Make VSEQ_20 end".

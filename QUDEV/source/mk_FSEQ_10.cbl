000010 IDENTIFICATION         DIVISION.
000020 PROGRAM-ID.            mk_FSEQ_10.
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
       01    INTXT-REC        PIC X(10).
       
       FD    FSEQ.       
       01    FSEQ-REC         PIC X(10).
       
       WORKING-STORAGE SECTION.
       01  W-X.
           05  W-CNT   PIC 9(5).
       01  INTXT-NAME     PIC X(128).
       01  FSEQ-NAME      PIC X(128).
       01  INTXT-STS      PIC XX.
       01  FSEQ-STS       PIC XX.
      *
002220******************************************************************
002230*****     ÇoÇqÇnÇbÇdÇcÇtÇqÇdÅ@ÇcÇhÇuÇhÇrÇhÇnÇmÅ@Å@****************
002240******************************************************************
002250 PROCEDURE  DIVISION.
002260 HAJIME.
           PERFORM MAKE-FSEQ.
           accept omitted.
           goback.
      *
       MAKE-FSEQ.
           display "Make FSEQ_10 start".
           move "data\ORG_FSEQ_10.txt" TO INTXT-NAME.
           move "data\FSEQ_10"         TO FSEQ-NAME.
      *
           OPEN INPUT  INTXT.
           OPEN OUTPUT FSEQ.
      *
           PERFORM UNTIL 1 = 0
              MOVE SPACE TO INTXT-REC
              READ INTXT AT END 
                        EXIT PERFORM
              END-READ
              MOVE INTXT-REC TO FSEQ-REC
              WRITE FSEQ-REC
           END-PERFORM.
      *
           CLOSE FSEQ.
           CLOSE INTXT.
      *
           display "Make FSEQ_10 end".

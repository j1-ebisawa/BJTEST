000010 IDENTIFICATION         DIVISION.
000020 PROGRAM-ID.            mk_FREL_10.
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
       SELECT FREL            ASSIGN TO FREL-NAME
              ORGANIZATION    RELATIVE
              ACCESS MODE     SEQUENTIAL
              RELATIVE KEY    FREL-KEY
              FILE STATUS     FREL-STS.
000360 DATA                   DIVISION.
       FILE SECTION.
       FD    FSEQ.       
       01    FSEQ-REC          PIC X(10).
       FD    FREL.
       01    FREL-REC          PIC X(10).
       WORKING-STORAGE SECTION.
       01  W-X.
           05  W-CNT   PIC 9(5).
       01  FSEQ-NAME      PIC X(128).
       01  FREL-NAME      PIC X(128).
       
       01  FSEQ-STS       PIC XX.
       01  FREL-STS       PIC XX.
       
       01  FREL-KEY       PIC 9(05).
      *
002220******************************************************************
002230*****     ÇoÇqÇnÇbÇdÇcÇtÇqÇdÅ@ÇcÇhÇuÇhÇrÇhÇnÇmÅ@Å@****************
002240******************************************************************
002250 PROCEDURE  DIVISION.
002260 HAJIME.
           PERFORM MAKE-FREL.
           accept omitted.
           goback.
      *
      *
       MAKE-FREL.
           display "Make FREL_10 start".
           MOVE "data\FSEQ_10" TO FSEQ-NAME.
           MOVE "data\FREL_10" TO FREL-NAME.
      *
           OPEN INPUT  FSEQ.
           OPEN OUTPUT FREL.
           PERFORM UNTIL 1 = 0
              READ FSEQ AT END 
                        EXIT PERFORM
              END-READ
              MOVE FSEQ-REC TO FREL-REC
              WRITE FREL-REC
           END-PERFORM.
      *
           CLOSE FSEQ FREL.
           display "Make FREL_10 end".

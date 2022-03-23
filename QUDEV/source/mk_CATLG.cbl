000010 IDENTIFICATION         DIVISION.
000020 PROGRAM-ID.            mk_CATLG.
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
       COPY "BJ_CATLG_SL.CPY".
000360 DATA                   DIVISION.
       FILE SECTION.
       FD    INTXT.       
       01    INTXT-REC        PIC X(200).
       COPY "BJ_CATLG_FD.CPY".
       WORKING-STORAGE SECTION.
       01  W-X.
           05  W-CNT          PIC 9(5).
       01  INTXT-NAME         PIC X(128).
       01  CATLG-FNAME        PIC X(128).
       
       01  INTXT-STS          PIC XX.
       01  F-STS              PIC XX.
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
           display "Make CATLG start".
           move    "data\CATLG_org.txt"    TO INTXT-NAME.
           accept CATLG-FNAME   from environment "BJ_CATLG_MAST".
      *
           OPEN INPUT  INTXT.
           OPEN OUTPUT CATLG-F.
           PERFORM UNTIL 1 = 0
              MOVE SPACE TO INTXT-REC
              READ INTXT AT END 
                        EXIT PERFORM
              END-READ
              PERFORM BUILD-CATLG-REC
              WRITE CATLG-REC
           END-PERFORM.
      *
           CLOSE INTXT CATLG-F.
      *
           
           display "Make CATLG end".
      *
       BUILD-CATLG-REC.
           INITIALIZE CATLG-REC.
           UNSTRING  INTXT-REC DELIMITED BY ";"
               INTO  CATLG-MIN-RECL
                     CATLG-MAX-RECL
                     CATLG-FORG
                     CATLG-FPATH.

000010 IDENTIFICATION         DIVISION.
000020 PROGRAM-ID.            mk_FSEQ_30.
000100 ENVIRONMENT            DIVISION.
000110 CONFIGURATION          SECTION.
000120 SOURCE-COMPUTER.       PC.
000130 OBJECT-COMPUTER.       PC.
000140 INPUT-OUTPUT           SECTION.
       FILE-CONTROL.
       SELECT FSEQ            ASSIGN TO external INFILE
              ORGANIZATION    SEQUENTIAL
              ACCESS MODE     SEQUENTIAL
              FILE STATUS     FSEQ-STS.
       select P-file          assign TO external PRFILE
              organization line sequential
              FILE STATUS     PRNT-STS.
000360 DATA                   DIVISION.
       FILE SECTION.
       
       FD    FSEQ.       
       01    FSEQ-REC.
           05  IN-01          PIC  X(04).        *>1:4  C
           05  FILLER         PIC  X(01).
           05  IN-02          PIC  X(04).        *>6:4  K
           05  FILLER         PIC  X(01).
           05  IN-03          PIC  9(04).        *>11:4 N
           05  FILLER         PIC  X(01).
           05  IN-04          PIC S9(04).        *>16:4 S
           05  FILLER         PIC  X(01).
           05  IN-05          PIC S9(07) COMP-3. *>21:4 P
           05  FILLER         PIC  X(01).
           05  IN-06          PIC S9(09) COMP.   *>26:4 B
           05  FILLER         PIC  X(01).
       FD P-file.
       01 P-rec.
         05  P-01             PIC  X(04).
         05  filler           PIC  X(01).
         05  P-02             PIC  X(04).
         05  filler           PIC  X(01).
         05  P-03             PIC  9(04).
         05  filler           PIC  X(01).
         05  P-04             PIC -9(04).
         05  filler           PIC  X(01).
         05  P-05             PIC -9(07).
         05  filler           PIC  X(01).
         05  P-06             PIC -9(09).
         05  filler           PIC  X(01).
       
       WORKING-STORAGE SECTION.
       01  W-X.
           05  W-CNT          PIC 9(5).
       01  FSEQ-NAME          PIC X(128).
       01  PRNT-NAME          PIC X(128).
       01  FSEQ-STS           PIC XX.
       01  PRNT-STS           PIC XX.
      *
002220******************************************************************
002230*****     ‚o‚q‚n‚b‚d‚c‚t‚q‚d@‚c‚h‚u‚h‚r‚h‚n‚m@@****************
002240******************************************************************
002250 PROCEDURE  DIVISION.
002260 HAJIME.
           PERFORM PRINT-FSEQ.
           *>accept omitted.
           goback.
      *
       PRINT-FSEQ.
           display "Print FSEQ_30 start".
      *
           OPEN OUTPUT P-FILE.
           OPEN INPUT  FSEQ.
           if FSEQ-STS NOT = "00"
              go to P-02
           end-if.
      *
           PERFORM UNTIL 1 = 0
              MOVE SPACE TO FSEQ-REC
              READ FSEQ AT END 
                        EXIT PERFORM
              END-READ
              MOVE ALL "_"   TO P-REC
              MOVE IN-01     TO P-01
              MOVE IN-02     TO P-02
              MOVE IN-03     TO P-03
              MOVE IN-04     TO P-04
              MOVE IN-05     TO P-05
              MOVE IN-06     TO P-06
              WRITE P-REC
           END-PERFORM.
      *
           CLOSE FSEQ.
       P-02.
           CLOSE P-FILE.
      *
           display "Print FSEQ_30 end".

       IDENTIFICATION                  DIVISION.
       PROGRAM-ID.                     QUREPORT.
       ENVIRONMENT                     DIVISION.
       CONFIGURATION                   SECTION.
       INPUT-OUTPUT                    SECTION.
       FILE-CONTROL.
       COPY "QUTESTF.sl"      replacing QU-KEY1 BY
                              == QU-KEY1 OF QUTESTF==.
       SELECT PRINT-F         ASSIGN TO dynamic PRINT-FNM
                              ORGANIZATION LINE SEQUENTIAL
                              ACCESS MODE       SEQUENTIAL
                              FILE STATUS F-STS.
       DATA                            DIVISION.
       FILE                            SECTION.
       COPY "QUTESTF.fd".
       FD    PRINT-F.
       01    P-REC                     PIC X(256).
       WORKING-STORAGE                 SECTION.
       01  F-STS                       PIC XX.
       01  FILE-STS                    PIC XX.
       01  PRINT-FNM                   PIC X(128).
      ******** 
       01  QU-REC-WK.
           03 QU-KEY1.
               05 QU-MANID         PIC  X(20).
               05 QU-IDSEQ         PIC  X(01).
           03 QU-DATE.
               05 QU-YYYY          PIC  9(04).
               05 QU-MM            PIC  9(02).
               05 QU-DD            PIC  9(02).
           03 QU-TIME.
               05 QU-HH            PIC  9(02).
               05 QU-NN            PIC  9(02).
               05 QU-SS            PIC  9(02).
               05 QU-10MS          PIC  9(02).
           03 QU-RES           PIC  X(02).
           03 QU-COMM1         PIC  X(40).
           03 QU-MACID1        PIC  X(04).
           03 QU-MACID2        PIC  X(04).
           03 QU-USER-ID       PIC  X(12).
           03 QU-STATION-ID    PIC  X(12).
           03  PRODUCT-VERSION.
               05  QU-OSI-PRODUCT                     pic x(2) comp-x.
               05  QU-OSI-PRODUCT-VERSION             pic x(2) comp-x.
               05  QU-OSI-PRODUCT-REVISION            pic x(2) comp-x.
               05  QU-OSI-PRODUCT-SP                  pic x(2) comp-x.
               05  QU-OSI-FIXPACK                     pic x(2) comp-x.
           03 QU-RUNTIME-BYTE  PIC  X.
           03 QU-USER          PIC  X(14).
           03 QU-LOGNAME       PIC  X(14).
           03 QU-SSH-CLIENT    PIC  X(50).
           03 QU-SSH-CONNECT   PIC  X(60).
           03 QU-LANG          PIC  X(20).
           03 QU-PWD           PIC  X(50).
       
       01  PRINT-WK.
           03 QU-KEY1.
               05 QU-MANID         PIC  X(20).
               05 QU-IDSEQ         PIC  X(01).
           03 FILLER               PIC  X VALUE ",".
           03 QU-DATE.
               05 QU-YYYY          PIC  9(04).
               05 QU-MM            PIC  9(02).
               05 QU-DD            PIC  9(02).
           03 QU-TIME.
               05 FILLER           PIC  X VALUE ",".
               05 QU-HH            PIC  9(02).
               05 QU-NN            PIC  9(02).
               05 QU-SS            PIC  9(02).
               05 QU-10MS          PIC  9(02).
           03 FILLER               PIC  X VALUE ",".
           03 QU-RES           PIC  X(02).
           03 FILLER               PIC  X VALUE ",".
           03 QU-MACID1        PIC  X(04).
           03 FILLER               PIC  X VALUE ",".
           03 QU-MACID2        PIC  X(04).
           03 FILLER           PIC  X VALUE ",".
           03 QU-USER-ID       PIC  X(12).
           03 FILLER           PIC  X VALUE ",".
           03 QU-STATION-ID    PIC  X(12).
           03 FILLER               PIC  X VALUE ",".
           03 QU-COMM1         PIC  X(40).
       PROCEDURE DIVISION.
       DECLARATIVES.
       IN-FILE-ERROR SECTION.
          USE AFTER STANDARD ERROR PROCEDURE ON QUTESTF.
              DISPLAY "QUTESTF ERROR : " FILE-STS
              move -1 to return-code.
              goback.
       OT-FILE-ERROR SECTION.
          USE AFTER STANDARD ERROR PROCEDURE ON PRINT-F.
              DISPLAY "PRINT-F ERROR : " F-STS
              move -1 to return-code.
              goback.
       end declaratives.
       
       MAIN-ROUTINE.
           PERFORM INIT-PROC.
           PERFORM WRIT-PROC.
           PERFORM TERM-PROC.
           GOBACK.
      *
       INIT-PROC.
           OPEN INPUT QUTESTF.
      *
           MOVE "data\QUREPORT.txt" to PRINT-FNM.
      *>     MOVE SPACE TO PRINT-FNM.
      *>     DISPLAY "QUREPORT_FNAME"   UPON ENVIRONMENT-NAME.
      *>     ACCEPT  PRINT-FNM          FROM ENVIRONMENT-VALUE.
           OPEN OUTPUT PRINT-F.
       TERM-PROC.
           CLOSE QUTESTF.
           CLOSE PRINT-F.
       WRIT-PROC.
           PERFORM UNTIL 1 = 0
              READ QUTESTF NEXT
                   AT END EXIT PERFORM
              END-READ
              PERFORM PRINT-PROC
           END-PERFORM.
       PRINT-PROC.
           MOVE QU-REC TO QU-REC-WK.
           MOVE CORR QU-REC-WK TO PRINT-WK.
           WRITE P-REC FROM PRINT-WK AFTER 1.

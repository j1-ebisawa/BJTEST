       IDENTIFICATION DIVISION.
       PROGRAM-ID. PARAG01.
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SOURCE-COMPUTER.  PC.
       OBJECT-COMPUTER.  PC.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 WK-CNT        PIC 99.
       01 PARAM-REC     PIC X(256).
       PROCEDURE DIVISION.
       MAIN SECTION.
       P-X.
           DISPLAY "PARAG01 start".
       P-02.
           CALL "BJ_PARAG" USING PARAM-REC.
           CALL "BJ_DSPER" USING PARAM-REC.
           IF PARAM-REC NOT = SPACE
              GO TO P-02
           END-IF.
       P-EXIT.
           DISPLAY "PARAG01 end".
           GOBACK.


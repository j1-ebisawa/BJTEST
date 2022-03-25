       IDENTIFICATION DIVISION.

       PROGRAM-ID. TEST_CCOPY.
       AUTHOR. j1_eb.

       ENVIRONMENT DIVISION.

       CONFIGURATION SECTION.

       INPUT-OUTPUT SECTION.

       DATA DIVISION.

       FILE SECTION.

       WORKING-STORAGE SECTION.
       01  IN-FPATH    pic x(50) value "data/STEST".
       01  OT-FPATH    pic x(50) value "data/WSEQ01".
       01  R-CD        PIC XX COMP-X.

       LINKAGE SECTION.

       PROCEDURE DIVISION.

       MAIN.
           display "test start".
           call "C$COPY" using IN-FPATH OT-FPATH "S"
                         giving R-CD.
           Display "R-CD=" R-CD.
           display "test end".
           accept omitted.
           goback.

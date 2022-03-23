       IDENTIFICATION DIVISION.

       PROGRAM-ID. TEST_FDEL.
       AUTHOR. j1_eb.

       ENVIRONMENT DIVISION.

       CONFIGURATION SECTION.

       INPUT-OUTPUT SECTION.

       DATA DIVISION.

       FILE SECTION.

       WORKING-STORAGE SECTION.
       01  DEL-FPATH   pic x(50) value "data/WSEQ01".
       01  R-CD        PIC XX COMP-X.

       LINKAGE SECTION.

       PROCEDURE DIVISION.

       MAIN.
           display "test start".
           call "C$DELETE" using DEL-FPATH "S"
                           giving R-CD.
           Display "R-CD=" R-CD.
           display "test end".
           accept omitted.
           goback.

       IDENTIFICATION DIVISION.
       PROGRAM-ID. FLOATCHK.
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SOURCE-COMPUTER.  NCR-ITX.
       OBJECT-COMPUTER.  NCR-ITX.
       INPUT-OUTPUT    SECTION.
       FILE-CONTROL.
       SELECT   A-FILE   ASSIGN TO external DATAIN.
       select   P-file   assign to external DATAOUT
                organization line sequential.
       DATA DIVISION.
       FILE SECTION.
       FD  A-FILE.
       01  A-REC.
         05  filler  PIC  X(21).
         05  A-6     usage   double.   *>32:8 DOUBLE
         05  filler  PIC  X(7).
       FD P-file.
       01 P-rec.
         05  filler  pic x.
      *>   05  A-6     PIC  +9.99999E+99.       *>30:8 DOUBLE
         05  filler  PIC  X(1). 

       WORKING-STORAGE SECTION.
       01  W-01      PIC S9(5).
       01  W-02      PIC S9(5).
       01  W-03      PIC S9(5).
       01  W-INT     PIC S9(8) BINARY VALUE 1.
       PROCEDURE DIVISION.
       MAIN SECTION.
        P-01. 
             open input A-FILE.
             open output P-file.
             perform until 1 = 0
                move space to A-REC
                read A-FILE at end 
                            exit perform
                end-read
                move space to P-rec
                move corr A-rec to P-rec
                write P-rec
             end-perform.
             close A-FILE.
             close P-file.
             goback.

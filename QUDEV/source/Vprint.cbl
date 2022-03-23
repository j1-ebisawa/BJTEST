       IDENTIFICATION DIVISION.
       PROGRAM-ID. DPRINT.
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SOURCE-COMPUTER.  PC.
       OBJECT-COMPUTER.  PC.
       INPUT-OUTPUT    SECTION.
       FILE-CONTROL.
       SELECT VSEQ            ASSIGN TO VSEQ-NAME
              ORGANIZATION    SEQUENTIAL
              ACCESS MODE     SEQUENTIAL
              FILE STATUS     VSEQ-STS.
       select   P-file   assign TO  PR-NAME
                organization line sequential.
       DATA DIVISION.
       FILE SECTION.
       FD    VSEQ      RECORD IS VARYING 1 to 20 depending on VSEQ-L.

       01    VSEQ-REC         PIC X(20).
       FD P-file.
       01 P-rec.
         05  P-LENG   PIC  9(3). 
         05  FILLER   PIC  X.               
         05  P-VALUE  PIC  X(20).
       WORKING-STORAGE SECTION.
       01  VSEQ-NAME      PIC X(128).
       01  VSEQ-STS       PIC XX.
       01  VSEQ-L         PIC 9(5).
       01  PR-NAME        PIC X(128).
       PROCEDURE DIVISION.
       MAIN SECTION.
        P-01. 
           display "VPRINT start".
           move "data\\VSEQ_20"   to VSEQ-NAME.
           move "data\Vprint.txt" to PR-NAME.
           
             open input VSEQ.
             open output P-file.
             perform until 1 = 0
                move space to VSEQ-REC
                read VSEQ   at end 
                            exit perform
                end-read
                move space  to P-rec
                move VSEQ-L   to P-LENG
                move VSEQ-REC to P-value
                write P-rec
             end-perform.
             close VSEQ.
             close P-file.
             
           display "VPRINT end".
             goback.

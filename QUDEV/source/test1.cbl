       IDENTIFICATION DIVISION.

       PROGRAM-ID. TEST1.
       AUTHOR. j1_eb.

       ENVIRONMENT DIVISION.

       CONFIGURATION SECTION.

       INPUT-OUTPUT SECTION.
       file-control.
           select file1 assign to "text01.txt"
               organization line sequential
               file status fsts.
           select file2 assign to "text02.txt"
               organization line sequential
               file status fsts.
       DATA DIVISION.
       file section.
       fd  file1.
       01  file1-rec     pic x(20).
       fd  file2.
       01  file2-rec     pic x(20).
       working-storage section.
       01 fsts    pic x(02).
       01 w-rec.
           05 filler  pic  x(4)       value "ABCD".
           05 filler  pic s9(6)       value 123456.
           05 filler  pic s9(3)  comp-3 value +0.
           05 filler  pic  x(8)       value "123&5678".
       
       PROCEDURE DIVISION.
       MAIN.

           open output  file1.
           move w-rec to file1-rec.
           write file1-rec.
           close file1.
           
           open input  file1.
           open output file2.
           perform until 1 = 0
             read file1 
                  at end exit perform
             end-read
             move file1-rec to file2-rec
             write file2-rec
           end-perform.
           close file1.
           close file2.
           goback.                   
       
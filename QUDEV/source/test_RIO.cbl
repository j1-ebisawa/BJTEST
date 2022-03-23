**********
IDENTIFICATION DIVISION.
    PROGRAM-ID. test_RIO.
ENVIRONMENT DIVISION.
CONFIGURATION SECTION.
DATA DIVISION.
WORKING-STORAGE SECTION.
 copy "isfilesys.def".
 
 77  f                       handle .
 77  file-io                 pic x(128).
 77  rec-buffer              pic x(22).
 
 01  rio-lparms.
     03 max-rec-sz           pic 999.
     03 filler               pic x value ",".
     03 min-rec-sz           pic 999.
 77  key-val                 pic 9(5) value 0.
 
 procedure division.
 main.
 *> creates the file
 *> this is the FD
 *>  01 record.
 *>   03 r-key    pic 99.
 *>   03 r-data   pic x(20).
   *>go to main-05
   display "Creating file..."
 
   move "C:\ISLAB\isTest\Test_RIO\data\myrelfile" to file-io
   move 22 to max-rec-sz, min-rec-sz
   set r-make-function to true                      
   call "r$io" using rio-function, file-io, rio-lparms
              
   if return-code = 0
      display message "R$IO Error: make : " F_ERRNO 
   end-if.           
  main-05.
   *> opening 
   display "Opening file..."
           
   set r-open-function to true
   move fio to open-mode
   move 22  to max-rec-size, min-rec-size
   call "r$io" using rio-function, file-io, open-mode 
                     max-rec-size, min-rec-size
   if return-code > 0
      move return-code to f
   else
      display message "R$IO Error: open : " F_ERRNO 
   end-if           
 
 
   *> record writing
   move 0 to key-val.
   display "Writing into file..."  
   set r-write-function to true
   perform 5 times
      add 1 to key-val
      move all "A" to rec-buffer
      move key-val to rec-buffer(1:5)
      *>move "00xxx" to rec-buffer     
      call "r$io" using rio-function, f, rec-buffer, 
                                max-rec-size, key-val
      if return-code = 0
         display message "R$IO Error: write : " F_ERRNO 
      end-if
   end-perform
 
   *> start
   display "Getting the first record..." 
   set r-start-function to true
   set f-equals       to true
   move 1             to key-val
   call "r$io" using rio-function, f, key-val, start-mode
   if return-code = 0
      display message "R$IO Error: start : " F_ERRNO 
   end-if
 
   *> read next
   display "Reading next record..."
   set r-next-function to true
   call "r$io" using rio-function, f, rec-buffer 
               giving return-code
   if return-code = 0
      display message "R$IO Error: next : " F_ERRNO 
   end-if.
   *>
   display "????? return-code dosen't return reclengthl+1"
   display "return-code=" return-code
   display "rec-buffer=" rec-buffer.
   *>
   *> close
   display "Closing file..."
   set r-close-function to true
   call "r$io" using rio-function, f
 
   goback.
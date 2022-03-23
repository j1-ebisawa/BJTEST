**********
IDENTIFICATION DIVISION.
    PROGRAM-ID. test_SIO.
ENVIRONMENT DIVISION.
CONFIGURATION SECTION.
DATA DIVISION.
WORKING-STORAGE SECTION.
 copy "isfilesys.def".
 
 77  f                       handle .
 77  file-io                 pic x(128).
 77  rec-buffer              pic x(22).
 
 01  sio-lparms.
     03 rec-sz               pic 999.
     03 filler               pic x value ",".
     03 f-type               signed-short.
     03 filler               pic x value ",".
     03 block-sz             pic 9 value 0.
     
 01 key-val    pic 9(05).
 
 procedure division.
 main.
   display "Creating file..."
 
   move "data/mySEQ" to file-io
   move s-fixed to f-type
   move 22 to rec-sz
   set s-make-function to true                      
   call "s$io" using sio-function, file-io, sio-lparms.
              
   if return-code = 0
      display message "S$IO Error: make : " F_ERRNO 
   end-if.           
  main-05.
   *> opening 
   display "Opening file..."
           
   set s-open-function to true
   move foutput to open-mode
   move 22  to rec-sz
   call "s$io" using sio-function, file-io, open-mode, 
                     rec-sz f-type, 0, 0
   if return-code > 0
      move return-code to f
   else
      display message "S$IO Error: open : " F_ERRNO 
   end-if           
 
 
   *> record writing
   move 0 to key-val.
   display "Writing into file..."  
   set s-write-function to true
   perform 5 times
      add 1 to key-val
      move all "A" to rec-buffer
      move key-val to rec-buffer(1:5)
      *>move "00xxx" to rec-buffer     
      call "s$io" using sio-function, f, rec-buffer, 0
      
      if return-code = 0
         display message "s$IO Error: write : " F_ERRNO 
      end-if
   end-perform
   *> close
   display "Closing file..."
   set s-close-function to true
   call "s$io" using sio-function, f

   *> opening 
   display "Opening file..."
           
   set s-open-function to true
   move finput to open-mode
   call "s$io" using sio-function, file-io, open-mode 
                     rec-sz f-type
   if return-code > 0
      move return-code to f
   else
      display message "S$IO Error: open : " F_ERRNO 
   end-if           
 
   *> read next
   display "Reading next record...".
main-read.
   set s-read-function to true
   call "s$io" using sio-function, f, rec-buffer 
               giving return-code
   if return-code = 0
      if F_ERRNO NOT = 8
      display message "S$IO Error: next : " F_ERRNO 
      end-if
      go to read-end
   end-if.
   *>
   display "return-code=" return-code
   display "rec-buffer=" rec-buffer.
   go to main-read.
read-end.
   *>
   *> close
   display "Closing file..."
   set s-close-function to true
   call "s$io" using sio-function, f
 
   goback.
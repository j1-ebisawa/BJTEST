**********
IDENTIFICATION DIVISION.
    PROGRAM-ID. test_IIO.
ENVIRONMENT DIVISION.
CONFIGURATION SECTION.
DATA DIVISION.
WORKING-STORAGE SECTION. 
copy "isgui.def".
copy "isfilesys.def".
77  f                       handle .
77  file-io                 pic x(128).
77  key-io                  pic x(10).
77  rec-buffer              pic x(22).
      *> 01 record.
      *>  03 rec-key    pic 9(5).  *> This is the record key
      *>  03 rec-data   pic x(17).

77  key-val                 pic 9(5) value 0.


       
procedure division.
create-file.
   display "test start".
   display "Creating ISAM file...".  
   move "data/myISAM" to file-io
   move zero to block-multiple pre-allocation-amount 
                extension-amount compression-factor encrypted-flag
   move 22 to max-rec-size
   move 22 to min-rec-size
   move 1 to num-keys
   move "1,0,5,0" to key-io
   inspect file-io replacing trailing spaces by low-value
   inspect key-io  replacing trailing spaces by low-value
   inspect logical-info  replacing trailing spaces by low-value
   set make-function to true                      
   call "i$io" using io-function, file-io, 0, physical-info, 
                                          logical-info, key-io.
   
   if f_errno not = 0
      display message "I$IO Error: make : " f_errno 
   end-if.
open-out.
   set open-function to true
   move foutput to open-mode    
   call "i$io" using io-function, file-io, 
                             open-mode, logical-info
   
   if return-code = 0
      display message "I$IO Error: open out: " F_ERRNO 
   else
      move return-code to f
   end-if.

   *> record writing
   move 0 to key-val.
   display "Writing into file..."  
   set write-function to true
   perform 5 times
      add 1 to key-val
      move all "A" to rec-buffer
      move key-val to rec-buffer(1:5)
      *>move "00xxx" to rec-buffer     
      call "i$io" using io-function, f, rec-buffer, 
                                max-rec-size
      if return-code = 0
         display message "I$IO Error: write : " F_ERRNO 
      end-if
   end-perform.

   set close-function to true
   call "i$io" using io-function  f
   if return-Code = 0
      display message "I$IO Error: close : " F_ERRNO 
   end-if.
open-io.                     
   set open-function to true
   move fio to open-mode    
   call "i$io" using io-function, file-io, 
                             open-mode, logical-info
   
   if return-code = 0
      display message "I$IO Error: open i-o: " F_ERRNO 
   else
      move return-code to f
   end-if.
get-record-count.
   set info-function to true
   set get-record-count to true
   call "I$IO" using io-function, f, info-mode, 
                     record-count-info.
   if return-Code = 0
      display message "I$IO Error: get-rec-cnt : " F_ERRNO 
   end-if. 
   display "record-count=" number-of-records.
   display "Reading file..."  
   SET NEXT-FUNCTION TO TRUE.
   move 0 to key-num.
read-next.
   CALL "I$IO" USING IO-FUNCTION, f, rec-buffer, key-num
   if return-Code = 0
      if F_ERRNO not = 8
      display message "I$IO Error: read : " F_ERRNO
      end-if
      go to close-file
   end-if.
   display "return-code=" return-code
   display "rec-buffer=" rec-buffer.
   go to read-next.
   
close-file.
   set close-function to true
   call "i$io" using io-function  f
   if return-Code = 0
      display message "I$IO Error: close : " F_ERRNO 
   end-if.
end-proc.
  display "test end".
  accept omitted.
  goback.

**********
IDENTIFICATION DIVISION.
    PROGRAM-ID. get_idx_info.
ENVIRONMENT DIVISION.
CONFIGURATION SECTION.
DATA DIVISION.
WORKING-STORAGE SECTION. 
copy "isgui.def".
copy "isfilesys.def".
77  f                       handle .
77  file-path                 pic x(128).
77  key-io                  pic x(10).
77  rec-buffer              pic x(22).
      *> 01 record.
      *>  03 rec-key    pic 9(5).  *> This is the record key
      *>  03 rec-data   pic x(17).

77  key-val                 pic 9(5) value 0.

01  wk-i    pic 99.
       
procedure division.
main-00.
   display "input file-path->".
   accept file-path.
   inspect file-path     replacing trailing spaces by low-value
   inspect key-io        replacing trailing spaces by low-value
   inspect logical-info  replacing trailing spaces by low-value.
   
get-logical-info.
   set open-function to true
   move finput to open-mode    
   call "i$io" using io-function, file-path, 
                     open-mode, logical-info
   
   if return-code = 0
      display "I$IO Error: open input: " F_ERRNO 
      go to main-exit
   else
      move return-code to f
   end-if.
   set info-function to true
   set get-logical-params to true
   call "I$IO" using io-function f info-mode logical-info
   if return-code = 0
      display "I$IO Error: get-logical-param: " F_ERRNO 
      go to main-exit
   end-if.   
   display "max-rec-size=" max-rec-size
   display "min-rec-size=" min-rec-size
   display "num-keys="     num-keys.
   
   perform varying wk-i from 0 by 1 until wk-i >= num-keys 
      move wk-i to info-mode
      call "I$IO" using io-function, f, info-mode, 
                        key-info
      display "key-info("     wk-i ")=" key-info
   end-perform.
      
   set get-record-count to true
   call "I$IO" using io-function, f, info-mode, 
                     record-count-info.
   if return-Code = 0
      display "I$IO Error: get-rec-cnt : " F_ERRNO 
      go to main-exit
   end-if. 
   display "record-count=" number-of-records.
close-file.
   set close-function to true
   call "i$io" using io-function  f
   if return-Code = 0
      display "I$IO Error: close : " F_ERRNO 
      go to main-exit
   end-if.
main-exit.
  display "get-idx-info end".
  accept omitted.
  goback.

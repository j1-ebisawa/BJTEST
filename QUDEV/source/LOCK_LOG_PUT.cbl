       identification division.
       program-id. LOCK_LOG_PUT.
       environment division.
        CONFIGURATION SECTION.
        SPECIAL-NAMES.
       input-output section.
       file-control.
       select sts-file
           assign to external CSVFL
           organization      sequential
           access mode       sequential
           status is sts-sts.
       data division.
       file section.
       fd  sts-file.
       01  sts-rec           pic x.
       working-storage section.
       77  sts-sts                     pic x(2).
       01  f-errno.
           05  f-err-bin               pic x comp-x.
       01  f-err-dec                   pic 999.
       01  SLEEP-TIME                  pic 9(6)v9(4).
       01  log-msg.
           03 log-comma                pic x(1).
           03 status-msg               pic x(5).
           03 filler                   pic x(30).
       *>---------------------------------------------------
       01  ftest-status            pic xx.
       01  wk-i                    pic 9(4).
       01  wk-l                    pic 9(4).
       01  omit-wk                 pic x.
       linkage section.
       01  p-length                pic 99.
       01  p-msg                   pic x(100).
       procedure division using p-length p-msg.
       
       level-1 section.
       main-logic.
      *>  
           if p-length = 2     *>file-status
              move p-msg to ftest-status
              if ftest-status(1:1) = "9"
                 move ftest-status(2:1) to f-errno
                 move f-err-bin to f-err-dec
                 move ftest-status(1:1) to status-msg
                 move "-"               to status-msg(2:1)
                 move f-err-dec         to status-msg(3:3)
              else
                 move ftest-status to status-msg
              end-if
              move "," to log-comma
              move 6 to wk-l
           else
              move p-length             to wk-l
              move p-msg(1:p-length)    to log-msg
           end-if.
      *>
           perform until 1 = 0
              open extend sts-file
              if sts-sts = "00"
                 perform varying wk-i from 1 by 1 until wk-i > wk-l
                    move log-msg(wk-i:1) to sts-rec
                    write sts-rec
                 end-perform
                 close sts-file
                 exit perform
              end-if
              move 0.1 to SLEEP-TIME
              call "BJ_SLEEP" using SLEEP-TIME
           end-perform.    
           goback.

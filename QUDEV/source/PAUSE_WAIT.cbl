       identification division.
       program-id. PAUSE_WAIT.
       environment division.
        CONFIGURATION SECTION.
        SPECIAL-NAMES.
       input-output section.
       file-control.
       select pause-file
           assign to "dat/pause.dat"
           organization is    relative
           access mode        sequential
           lock mode is exclusive
           status is pause-sts.
       data division.
       file section.
       fd  pause-file.
       01  pause-rec                   pic 9(01).
       working-storage section.
       77  pause-sts                   pic x(2).
       01  wk-i                        pic 99.
       01  wk-j                        pic 99.
       01  SLEEP-TIME                  pic 9(6)v9(4).
       01  omit-wk                     pic x.
       procedure division.
       
       level-1 section.
       main-logic.
      *>
           display "pause_wait start".
           perform pause-set1
           perform pause-wait2
           display "pause_wait end".
           goback.
      *>
        pause-set1.
           perform until 0 = 1
             open output sharing NO pause-file
             if pause-sts = "00"
                move 1 to pause-rec
                write pause-rec
                close pause-file
                exit perform
             end-if
           end-perform.
      *>
        pause-wait2.   
           perform until 0 = 1
             open i-o sharing NO pause-file
             if pause-sts = "00"
                read pause-file at end continue
                end-read
                if pause-rec = 2
                   move 3 to pause-rec
                   rewrite pause-rec
                   close pause-file
                   exit perform
                end-if
                close pause-file
                display "pause_waiting"
             end-if
             move 1 to SLEEP-TIME
             call "BJ_SLEEP" using SLEEP-TIME
           end-perform.
      *>

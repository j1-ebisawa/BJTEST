       identification division.
       program-id. LOCK_TESTER.
       environment division.
        CONFIGURATION SECTION.
        SPECIAL-NAMES.
       input-output section.
       file-control.
       select pause-file
           assign to "dat/pause.dat"
           organization is    sequential
           access mode        sequential
           status is pause-sts.
       data division.
       file section.
       fd  pause-file.
       01  pause-rec                   pic 9(01).
       working-storage section.
       77  pause-sts                   pic x(2).
       01  wk-i                        pic 99.
       01  wk-j                        pic 99.
       01  omit-wk                     pic x.
       procedure division.
       
       level-1 section.
       main-logic.
      *>  
           display "BJ_FUTIL_LOCK_CHK1"  upon environment-name.
           display "N"                   upon environment-value.
      *>
           open output pause-file.
           move 0 to pause-rec.
           write pause-rec.
           close pause-file.
      *>
           goback.

       identification division.
       program-id. PAUSE_ON.
       environment division.
        CONFIGURATION SECTION.
        SPECIAL-NAMES.
       input-output section.
       file-control.
       data division.
       working-storage section.
       procedure division.
       
       level-1 section.
       main-logic.
      *>
           display "BJ_FUTIL_LOCK_CHK1"  upon environment-name.
           display "Y"                   upon environment-value.
           Goback.

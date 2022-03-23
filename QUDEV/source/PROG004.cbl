       identification division.
         program-id. PROG004.
       environment division.
       configuration section.
         input-output section.
         file-control.
       data division.
       working-storage section.
       01  display-text   pic x(256).
       01  omit-wk        pic x.
       screen section.
       01  erase-scr     line 01 col 01 erase eos.
       01  input-f       line 07 col 30 using omit-wk.
       
       procedure division.
       p-001.
           display standard window erase-scr.
           display "Start PROG004" at 0510.
           display "Press Enter!!" at 0710.
           accept  input-f.
           display "End   PROG004" at 0910.
           *>close window.
           GOBACK.


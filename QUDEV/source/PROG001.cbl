       identification division.
         program-id. PROG001.
       environment division.
       configuration section.
         input-output section.
         file-control.
       data division.
       working-storage section.
       01  display-text   pic x(256).
       procedure division.
       p-001.
           display "Start PROG001".
           display "End   PROG001".
           GOBACK.


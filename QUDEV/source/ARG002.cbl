       identification division.
         program-id. ARG002.
       environment division.
       configuration section.
         input-output section.
         file-control.
       data division.
       working-storage section.
       01  w-text   pic x(256).
       linkage section.
       01  p1             pic S9(18).
       01  p2             pic S9(18).
       01  p3             pic S9(18).
       procedure division using p1 p2 p3.
       p-001.
           display "Start ARG002".
           move p1 to w-text.
           call "BJ_DSPER" using w-text.
           move p2 to w-text.
           call "BJ_DSPER" using w-text.
           move p3 to w-text.
           call "BJ_DSPER" using w-text.
           move "---p1+p2=------" to w-text
           call "BJ_DSPER" using w-text.
           compute p3 = p1 + p2
           move p3 to w-text.
           call "BJ_DSPER" using w-text.
           display "End   ARG002".
           GOBACK.


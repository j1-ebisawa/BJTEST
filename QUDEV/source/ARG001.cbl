       identification division.
         program-id. BAT001.
       environment division.
       configuration section.
         input-output section.
         file-control.
       data division.
       working-storage section.
        01  w-text   pic x(256).
        01  main-handle usage handle.
       linkage section.
       01  p1             pic x(10).
       01  p2             pic x(10).
       01  p3             pic x(10).
       01  p4             pic x(10).
       procedure division using p1 p2 p3 p4..
       p-001.
           display floating window erase screen handle main-handle.
           display "Start ARG001".
           move p1 to w-text.
           call "BJ_DSPER" using w-text.
           move p2 to w-text.
           call "BJ_DSPER" using w-text.
           move p3 to w-text.
           call "BJ_DSPER" using w-text.
           move p4 to w-text.
           call "BJ_DSPER" using w-text.
           display "End   ARG001".
           close window main-handle.
           GOBACK.


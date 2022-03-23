       identification division.
         program-id. PRG002.
       environment division.
       configuration section.
         input-output section.
         file-control.
       data division.
       working-storage section.
       01  w-text   pic x(256).
       01  main-handle usage handle.
       procedure division.
       p-001.
           display floating window erase screen handle main-handle.
           display "Start BAT002".
           move "abc" to w-text.
           call "BJ_DSPER" using w-text.
           move "123" to w-text.
           call "BJ_DSPER" using w-text.
           move "def" to w-text.
           call "BJ_DSPER" using w-text.
           move "456" to w-text.
           call "BJ_DSPER" using w-text.
           display "End   BAT002".
           close window main-handle.
           GOBACK.


       IDENTIFICATION          DIVISION.
       PROGRAM-ID.             test_ASYNC.
       DATA                    DIVISION.
       working-storage section.
       01  CMD-LINE          PIC X(512)   VALUE SPACE.
       01    FLAGS           pic x(02) comp-x.
       01    EXIT-STATUS     pic x(02) comp-x.
       01  CMD-01   pic x(50) 
           value "CMD.EXE /c copy data\a.txt data\b.txt".
       01  CMD-02   pic x(50) 
           value "CMD.EXE /c copy data\a.txt data\c.txt".
      *
       procedure division.
       P-01.
           *>go to p-02. 
           display "------------------------"
           display "test-01 run-flag:H'0001'".
           move H'0007'  to flags.
           *>move 50       to cmd-line-len.
           move CMD-01   to CMD-LINE.
           call "BJ_CSYS" using CMD-LINE FLAGS EXIT-STATUS.
                                   *> by value      cmd-line-len
                                   *> by reference  run-unit-id
                                   *> by value      stack-size
                                   *>               run-flags
                                   *> returning     status-code.
           display "exit-status=" exit-status.
           
       P-02.
           display "------------------------"
           display "test-02 run-flag:H'0000'".
           move H'0006'  to flags.
           move CMD-02   to CMD-LINE.
           *>move 50       to cmd-line-len.
           call "BJ_CSYS" using CMD-LINE FLAGS EXIT-STATUS.
                                   *> by value      cmd-line-len
                                   *> by reference  run-unit-id
                                   *> by value      stack-size
                                   *>               run-flags
                                   *> returning     status-code.
           display "exit-status=" exit-status.
       P-EXIT.
           accept omitted.
           exit program.

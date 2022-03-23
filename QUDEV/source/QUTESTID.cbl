       IDENTIFICATION                  DIVISION.
       PROGRAM-ID.                     QUTESTID.
       ENVIRONMENT                     DIVISION.
       CONFIGURATION                   SECTION.
       SPECIAL-NAMES.
       INPUT-OUTPUT                    SECTION.
       FILE-CONTROL.
       COPY "QUTESTF.sl".
       DATA                            DIVISION.
       FILE                            SECTION.
       COPY "QUTESTF.fd".
       WORKING-STORAGE                 SECTION.
       COPY "QUTESTID.wrk".
       copy "SYSTEMINFO.DEF".
       78  MB-YES                              VALUE 1.
       78  MB-NO                               VALUE 2.
       78  MB-CANCEL                           VALUE 3.
       01  DISP-NG-MODE      PIC X     value 'Y'.
           88  DISP-NG       VALUE "Y".
       01  WK-I              PIC S9(02) COMP.
       LINKAGE                         SECTION.
       COPY "QUTESTID.lks".
       PROCEDURE DIVISION  USING QUL-PROC-ID QUL-PARAM-ID QUL-RES
                                 QUL-COMM1 QUL-RETURNCD.
       MAIN-ROUTINE.
           EVALUATE QUL-PROC-ID
             WHEN "INT"
               PERFORM INIT-PROC
             WHEN "WRT"
               PERFORM WRIT-PROC
             WHEN "TRM"
               PERFORM TERM-PROC
           END-EVALUATE.
           GOBACK.
      *
       INIT-PROC.
           OPEN I-O QUTESTF.
           *>IF MAC1 = SPACE
           *>    CALL "QUMACIO" USING MAC1 MAC2
           *>END-IF.
       TERM-PROC.
           CLOSE QUTESTF.
       WRIT-PROC.
           MOVE 0 TO QUL-RETURNCD.
           PERFORM WRITE-INIT.
           IF MSG-RES = MB-CANCEL
               EXIT PARAGRAPH
           END-IF.
           IF DISP-NG AND QUL-RES NOT = "OK"
               MOVE "非""OK""表示モード" TO MSG-TITLE MSG-LINE1
               PERFORM DISP-MSG
               IF MSG-RES = MB-CANCEL
                   PERFORM ROLLBACK-RTN
                   EXIT PARAGRAPH
               END-IF
           END-IF
           MOVE QUL-PARAM-ID TO QU-TESTID.
           MOVE LOW-VALUE    TO QU-IDSEQ.
           MOVE 0 TO LAST-OK.
           MOVE 0 TO MSG-RES.
      * 履歴チェック(過去３レコード保存：1ID最大４レコード)
           START QUTESTF KEY > QU-KEY1
             INVALID SET START-INV TO TRUE
             NOT INVALID SET START-NOT-INV TO TRUE
           END-START.
           IF START-NOT-INV
      *
           PERFORM VARYING WK-I FROM 3 BY -1 UNTIL WK-I < 0
               MOVE WK-I TO QU-IDSEQ
               READ QUTESTF INVALID 
                            EXIT PERFORM CYCLE
               END-READ
               IF QU-RES = "OK"
                   MOVE QU-IDSEQ TO LAST-OK
               END-IF
               IF QU-IDSEQ >= 3   *> 破棄する
      *             CONTINUE
                    MOVE QU-REC TO PRE3-SAVE
               ELSE            *> 2, 1, 0
                    ADD 1 TO QU-IDSEQ
                    WRITE QU-REC
                      INVALID REWRITE QU-REC
                    END-WRITE
               END-IF
           END-PERFORM
      *
           END-IF.
      * ＯＫチェック
      * レコード組み立て
           MOVE ZERO TO QU-IDSEQ.
           ACCEPT QU-DATE FROM DATE YYYYMMDD.   *>MF
           ACCEPT QU-TIME FROM TIME.
           MOVE QUL-RES TO QU-RES.
           MOVE QUL-COMM1(1:COM-LEN) TO QU-COMM1.
           *>MOVE MACTYPE1 TO QU-MACTYPE1.
           *>MOVE MACTYPE2 TO QU-MACTYPE2.
           *>MOVE MACID1   TO QU-MACID1.
           *>MOVE MACID2   TO QU-MACID2.
           PERFORM GET-ENV.
           *>MOVE OSI-PRODUCT           TO QU-OSI-PRODUCT.
           *>MOVE OSI-PRODUCT-VERSION   TO QU-OSI-PRODUCT-VERSION.
           *>MOVE OSI-PRODUCT-REVISION  TO QU-OSI-PRODUCT-REVISION.
           *>MOVE OSI-PRODUCT-SP        TO QU-OSI-PRODUCT-SP.
           *>MOVE OSI-FIXPACK           TO QU-OSI-FIXPACK.
           *>MOVE LENGTH OF WRK-PTR     TO QU-RUNTIME-BYTE.
           WRITE QU-REC
             INVALID REWRITE QU-REC
           END-WRITE
           .
       WRITE-INIT.
           CALL "C$PARAMSIZE" USING 4 GIVING COM-LEN
      *>
           CALL "C$CALLEDBY" USING CALLING-PROGRAM GIVING CALL-STATUS.
      *>
           MOVE 0 TO MSG-RES.
      
       DISP-MSG.
           *>DISPLAY
           *>  MSG-LINE1 LF
           *>  "TEST-ID:" QUL-PARAM-ID "  RES:" QUL-RES
           *>          "  COM:" QUL-COMM1(1:COM-LEN) LF
           *>  "CALLED:" CALL-STATUS " " CALLING-PROGRAM LF
           *>  "宜しいですか？" *>AT 2001
           DISPLAY MSG-LINE1.
           DISPLAY "TEST-ID:" QUL-PARAM-ID "  RES:" QUL-RES
                   "  COM:" QUL-COMM1(1:COM-LEN).
           DISPLAY "CALLED:" CALL-STATUS " " CALLING-PROGRAM
           DISPLAY "宜しいですか？".
           .
           *>ACCEPT MSG-RES. *>AT 2479.
       ROLLBACK-RTN.
           MOVE QUL-PARAM-ID TO QU-KEY1.
      * 履歴チェック(過去３レコード保存：1ID最大４レコード)
           START QUTESTF KEY > QU-KEY1
             INVALID CONTINUE
           END-START.
           READ QUTESTF NEXT.
      *    END-READ.
           PERFORM UNTIL QUL-PROC-ID NOT = QU-KEY1
               IF QU-IDSEQ IS NOT NUMERIC OR  *> 空白(直前テストREC)は上書きされていない
                  QU-IDSEQ = 1
                   EXIT PERFORM CYCLE
               END-IF
               SUBTRACT 1 FROM QU-IDSEQ
               REWRITE QU-REC
               READ QUTESTF NEXT
           END-PERFORM.
           DELETE QUTESTF INVALID
               DISPLAY "??? - 2"
               ACCEPT RES AT 2479
           END-DELETE.
       GET-ENV.
           MOVE SPACE TO QU-USER-ID.
           display "QU_USER_ID"       upon environment-name.
           accept  QU-USER-ID         from environment-value.
           MOVE SPACE TO QU-STATION-ID.
           display "QU_STATION_ID"    upon environment-name.
           accept  QU-STATION-ID       from environment-value.
           MOVE SPACE TO QU-LOGNAME.
           display "LOGNAME"          upon environment-name.
           accept  QU-LOGNAME         from environment-value.
           MOVE SPACE TO QU-SSH-CLIENT.
           display "SSH_CLIENT"       upon environment-name.
           accept  QU-SSH-CLIENT      from environment-value.
           MOVE SPACE TO QU-SSH-CONNECT.
           display "SSH_CONNECTION"   upon environment-name.
           accept  QU-SSH-CONNECT     from environment-value.
           MOVE SPACE TO QU-LANG.
           display "LANG"             upon environment-name.
           accept  QU-LANG            from environment-value.
           MOVE SPACE TO QU-PWD.
           display "PWD"              upon environment-name.
           accept  QU-PWD             from environment-value.

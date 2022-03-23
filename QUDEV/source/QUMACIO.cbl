      ******************************************************************
       IDENTIFICATION              DIVISION.
      ******************************************************************
       PROGRAM-ID.                 QUMACIO.
      * REMARKS.
      *     テスト機情報ＤＢをアクセス.
      *     MAIN-ROUTINE.
      *       ホスト情報・検索、登録
      *         1ST-PROC
      *           GET-MAC-INFO
      *             "QUGETIP" -> READ MAC-IDF
      *             無ければ GET-DETAIL
      *                      REG-NEW-REC
      *         TYPE-SRCH
      *       シン・クライアント情報・検索、登録
      *         REMOTE-PROC
      *           GET-MAC-INFO
      *         TYPE-SRCH
      ******************************************************************
       ENVIRONMENT                 DIVISION.
       CONFIGURATION               SECTION.
       INPUT-OUTPUT                SECTION.
       FILE-CONTROL.
           SELECT MAC-IDF  ASSIGN TO "data\QUMACID"
               ORGANIZATION        INDEXED
               ACCESS  MODE        DYNAMIC
               RECORD   KEY        MAC-ID
               ALTERNATE RECORD    MAC-ALT = MAC-NAME, MAC-IP,
                                      OPERATING-SYSTEM OF MAC-IDF
               FILE  STATUS        FILE-STS.
           SELECT MAC-TYF  ASSIGN TO "data\QUMTYPE"
               ORGANIZATION        INDEXED
               ACCESS  MODE        DYNAMIC
               RECORD   KEY        MACTY-ID
               ALTERNATE RECORD    MACTY-ALT
               FILE  STATUS        FILE-STS.
           SELECT UNAMEOUT ASSIGN TO "/tmp/qatest1"
               ORGANIZATION LINE SEQUENTIAL.
      ******************************************************************
       DATA                        DIVISION.
      ******************************************************************
       FILE                        SECTION.
           COPY "QUMACID.def".
           COPY "QUMTYPE.def".
       FD UNAMEOUT.
       01 UNAME-REC                    PIC  X(200).
      ******************************************************************
       WORKING-STORAGE             SECTION.
       01  FILE-STS                PIC  X(02).
       01  ret                     SIGNED-LONG.
       01  I                       SIGNED-LONG.
       01  J                       SIGNED-LONG.
       01  MAC-BASE                PIC  9(04).
       01  WK-KEY1                 PIC  9(04).
       01  WK-KEYX                 PIC  X(04).
       78  MAC-BASE2               VALUE 1000.
       01  SAVE-REC                PIC  X(300).
       01  SAVE-HOSTID             PIC  X(20).
       01  SAVE-UNAME              PIC  X(200).
       01  THIN-FLG                PIC X.
       01  UNIX-FLG                PIC X.
       01  L-HOST                  PIC X(32).
       01  L-IP                    PIC X(32).
       01  CMD-LINE                pic x(180).
       01  FLAGS                   pic x(02) comp-x.
       01  EXIT-STATUS             pic x(02) comp-x.
           COPY "QUEXT.def".
           copy "SYSTEMINFO.DEF".
      *     COPY "QUWINID.def".
      *     COPY "acucobol.def".
       LINKAGE                     SECTION.
       01  P-MAC-ID                PIC X(07).
       01  P-MAC-ID2               PIC X(07).
      ******************************************************************
       PROCEDURE                   DIVISION USING P-MAC-ID P-MAC-ID2.
      ******************************************************************
       MAIN-ROUTINE.
           MOVE SPACE TO THIN-FLG UNIX-FLG.
           PERFORM 1ST-PROC.
           MOVE MAC-ID TO P-MAC-ID.
           PERFORM TYPE-SRCH.
           MOVE MACTY-ID TO P-MAC-ID(5:3).
           MOVE SPACE TO P-MAC-ID2.
           CLOSE MAC-IDF.
           GOBACK.
       1ST-PROC.
           MOVE SPACE TO MAC-IDR.
      *     ACCEPT TERMINAL-ABILITIES FROM TERMINAL-INFO.
           ACCEPT SYSTEM-INFORMATION FROM SYSTEM-INFO.
      *   value 28
      *     move 28 to OSI-LENGHT.
           display "TSH_MAC_BASE"     upon environment-name.
           accept MAC-BASE(1:)        from environment-value.
           IF MAC-BASE IS NOT NUMERIC
               MOVE "0000" TO MAC-BASE(1:)
           END-IF.
           OPEN I-O MAC-IDF.
           IF OS-IS-UNIX
               MOVE "1" TO  UNIX-FLG
               MOVE 2 TO MAC-OS
             ELSE
               MOVE 1 TO MAC-OS
           END-IF.
           MOVE CORR SYSTEM-INFORMATION TO MAC-WIN-INFO.
           PERFORM GET-MAC-INFO.
       GET-MAC-INFO.
           CALL "QUGETIP" USING MAC-NAME MAC-IP THIN-FLG UNIX-FLG.
      *     IF THIN-FLG = "1" AND UNIX-FLG = "1"
      *         MOVE "1" TO MAC-OS
      *     END-IF.
           READ MAC-IDF KEY IS MAC-ALT
             INVALID
               PERFORM GET-DETAIL
               PERFORM REG-NEW-REC
             NOT INVALID
               CONTINUE
           END-READ.
       REG-NEW-REC.
           MOVE MAC-IDR TO SAVE-REC.
           IF MAC-BASE = 0
               MOVE MAC-BASE2 TO MAC-IDR
             ELSE
               MOVE HIGH-VALUE TO MAC-IDR
           END-IF.
           START MAC-IDF KEY LESS THAN MAC-ID
             INVALID
               COMPUTE WK-KEY1 = MAC-BASE + 1
             NOT INVALID
               READ MAC-IDF PREVIOUS
               MOVE MAC-ID TO WK-KEY1(1:)
               ADD 1 TO WK-KEY1
           END-START
           MOVE WK-KEY1 TO SAVE-REC(1:4).
           MOVE SAVE-REC TO MAC-IDR.
           MOVE SAVE-HOSTID TO MAC-HOSTID.
           MOVE SAVE-UNAME TO MAC-UNAME MACTY-UNAME OF MAC-IDF.
           WRITE MAC-IDR.
       TYPE-SRCH.
           OPEN I-O MAC-TYF.
      *>MF     MOVE MAC-OS TO MACTY-OS.
           MOVE CORR SYSTEM-INFORMATION TO MACTY-ALT
           MOVE SAVE-UNAME TO MACTY-UNAME OF MAC-TYF.
           READ MAC-TYF KEY IS MACTY-ALT
             INVALID
               MOVE MAC-TYR TO SAVE-REC
               MOVE HIGH-VALUE TO MAC-TYR
               START MAC-TYF KEY LESS THAN MACTY-ID
                 INVALID
                   MOVE SAVE-REC TO MAC-TYR
                   MOVE "001" TO MACTY-ID
                 NOT INVALID
                   READ MAC-TYF PREVIOUS
                   STRING "0" DELIMITED BY SIZE
                          MACTY-ID DELIMITED BY SIZE
                       INTO WK-KEYX
                   MOVE WK-KEYX TO WK-KEY1(1:)
                   ADD 1 TO WK-KEY1
                   MOVE SAVE-REC TO MAC-TYR
                   MOVE WK-KEY1(2:) TO MACTY-ID
               END-START
               MOVE SAVE-UNAME TO MACTY-UNAME OF MAC-TYF
               WRITE MAC-TYR END-WRITE
             NOT INVALID
               CONTINUE
           END-READ.
           CLOSE MAC-TYF.
       GET-DETAIL.
           IF THIN-FLG = "1" OR OS-IS-WINDOWS
              OR MAC-OS = 1
      *        CALL "QUGETWINID" USING
      *               MAC-OS-NAME MAC-OS-VERSION THIN-FLG
      *               THIN-FLG
               CONTINUE
             ELSE
               PERFORM GET-UNIX-INFO
           END-IF.
       GET-UNIX-INFO.
           MOVE H'0007' TO FLAGS.
           MOVE "bash -c ""hostid > /tmp/qatest1""" TO CMD-LINE
           CALL "C$SYSTEM" USING CMD-LINE FLAGS EXIT-STATUS.
           OPEN INPUT UNAMEOUT.
           MOVE SPACE TO UNAME-REC.
           READ UNAMEOUT INTO SAVE-HOSTID.
           CLOSE UNAMEOUT.
           MOVE "bash -c ""uname -a > /tmp/qatest1""" TO CMD-LINE.
           CALL "C$SYSTEM" USING CMD-LINE FLAGS EXIT-STATUS.
           OPEN INPUT UNAMEOUT.
           MOVE SPACE TO UNAME-REC.
           READ UNAMEOUT INTO SAVE-UNAME.
           CLOSE UNAMEOUT.

      ******************************************************************
       IDENTIFICATION              DIVISION.
      ******************************************************************
       PROGRAM-ID.                 QUGETIP.
      * REMARKS.
      *     IP address Žæ“¾iWindows/unix—¼—pj
      *> SPECIAL-NAMES.
      *>     call-convention 74 is winapi.
      ******************************************************************
       DATA                        DIVISION.
      ******************************************************************
       WORKING-STORAGE             SECTION.
       01  HOSTENT-P           POINTER.
       01  IP-P                POINTER.
       01  CNT                 PIC S9(4) COMP.
       01  errno               SIGNED-LONG EXTERNAL.
       01  RET                 SIGNED-LONG.
       01  H-LEN               SIGNED-LONG VALUE 20.
       01  RES                 PIC S9(9) COMP-5.
       78  MAX-ADDR       VALUE 16.
       01  SAVE-DLLC               PIC X(20).
       01  FUNC-NAME               PIC X(30).
       01  REF7010100193.
      *    03  dummy-x         pic x.                                   BYVALUE
           03  H_ADDR_X        PIC X(4).
        01  myptr USAGE POINTER.
      *
           COPY "QUEXT.def".
       LINKAGE                     SECTION.
       01  HOSTNAME            PIC X(20).
       01  IP-ADR              PIC X(16).
       01  THIN-FLG                PIC X.
       01  UNIX-FLG                PIC X.
       01  DUMMY1                  PIC XX.
       01  HOSTENT_W.                         *> for Windows
           03  H_NAME          POINTER.       *> char FAR*
           03  H_ALIASES       POINTER.       *> char FAR  FAR**
           03  H_ADDRTYPE      SIGNED-SHORT.  *>
           03  H_LENGTH        SIGNED-SHORT.  *>
           03  H_ADDR_LIST     POINTER.       *> char FAR  FAR**
       01  HOSTENT_U.                         *> for UNIX
           03  H_NAME          POINTER.       *> char FAR*
           03  H_ALIASES       POINTER.       *> char FAR  FAR**
           03  H_ADDRTYPE      SIGNED-LONG.    *>
           03  H_LENGTH        SIGNED-LONG.    *>
           03  H_ADDR_LIST     POINTER.       *> char FAR  FAR**
       01  H_ADDR_LIST_0       POINTER.
       01  H_ADDR_0            PIC X(4).
       01  IP-CHR              PIC X(MAX-ADDR).
      ******************************************************************
       PROCEDURE                   DIVISION
                 USING HOSTNAME IP-ADR THIN-FLG UNIX-FLG.
      ******************************************************************
       MAIN-ROUTINE.
      *  ‚n‚rî•ñ‚ðŽæ“¾

           MOVE "SPPC103" TO HOSTNAME.
           MOVE "172.31.70.103" TO IP-ADR.
           GOBACK.
           EVALUATE TRUE
             WHEN UNIX-FLG NOT = "1" AND   *> Windows
                  (QU-WS2-32 = SPACE OR ALL X"00")
      *>          set myptr to entry "ws2_32.dll"
      *         MOVE winapi "ws2_32.dll" TO QU-WS2-32
      *         CALL QU-WS2-32 ON EXCEPTION
      *             DISPLAY "ws2_32.dll Fail"
      *             GO TO EXIT-PROC
      *         END-CALL
      *       WHEN UNIX-FLG = "1" AND
      *            (QU-WS2-32 = SPACE OR ALL X"00")
      *         MOVE "libnsl.so" TO QU-WS2-32
      *         CALL QU-WS2-32 ON EXCEPTION
      *             DISPLAY MESSAGE BOX "libnsl.so Fail"
      *             GO TO EXIT-PROC
      *         END-CALL
           END-EVALUATE.
           IF UNIX-FLG = "1"
               PERFORM UNIX-HOST
             ELSE
               PERFORM WIN-HOST
           END-IF.

      *
           CALL "gethostbyname" USING HOSTNAME
                                GIVING HOSTENT-P
             ON EXCEPTION
               DISPLAY "gethostbyname Fail"
               GO TO EXIT-PROC
           END-CALL
           IF HOSTENT-P = NULL

               MOVE "WSAGetLastError" TO FUNC-NAME
               CALL FUNC-NAME GIVING RET
               DISPLAY "gethostbyname Error! thin:"
                                   THIN-FLG X"0a" "err-cd:" RET

               CALL "WSAGetLastError" GIVING RET
               DISPLAY "gethostbyname Error!"
                    X"0a" "err-cd:" RET "errno:" errno
               GO TO EXIT-PROC
           END-IF.
           IF UNIX-FLG NOT = "1"   *> Windows
           SET ADDRESS OF HOSTENT_W TO HOSTENT-P
           SET ADDRESS OF H_ADDR_LIST_0 TO H_ADDR_LIST OF HOSTENT_W
             ELSE
               SET ADDRESS OF HOSTENT_U TO HOSTENT-P
               SET ADDRESS OF H_ADDR_LIST_0 TO H_ADDR_LIST OF HOSTENT_U
           END-IF.
           SET ADDRESS OF H_ADDR_0 TO H_ADDR_LIST_0
           MOVE SPACE TO IP-ADR.
           MOVE H_ADDR_0 TO H_ADDR_X.
      *
           CALL "inet_ntoa" USING BY VALUE H_ADDR_X
                            GIVING IP-P
           SET ADDRESS OF IP-CHR TO IP-P
           PERFORM VARYING CNT FROM 1 BY 1 UNTIL CNT > MAX-ADDR OR
                                                 IP-CHR(CNT:1) = X"00"
               MOVE IP-CHR(CNT:1) TO IP-ADR(CNT:1)
           END-PERFORM.
           PERFORM INSPECT2-PROC.
       EXIT-PROC.
           DISPLAY "IP address:" IP-ADR.
           GOBACK.
       UNIX-HOST.
           MOVE SPACE TO HOSTNAME
           CALL "gethostname" USING HOSTNAME H-LEN GIVING RET
           IF RET NOT = 0
               DISPLAY "gethostname Fail!!"
           END-IF
           PERFORM INSPECT-PROC.
       WIN-HOST.
           MOVE SPACE TO HOSTNAME
           CALL "gethostname" USING HOSTNAME H-LEN GIVING RET
           IF RET NOT = 0
               DISPLAY "gethostname Fail!!"
               MOVE "SUMYDUMY" TO HOSTNAME
           END-IF
           PERFORM INSPECT-PROC.
       INSPECT-PROC.
           PERFORM VARYING CNT FROM 20 BY -1 UNTIL CNT <= 0
               IF HOSTNAME(CNT:1) NOT = SPACE
                   IF CNT NOT = 20
                       MOVE X"00" TO HOSTNAME(CNT + 1:1)
                   END-IF
                   EXIT PERFORM
               END-IF
           END-PERFORM.
       INSPECT2-PROC.
           PERFORM VARYING CNT FROM 20 BY -1 UNTIL CNT <= 0
               IF HOSTNAME(CNT:1) = X"00"
                   MOVE SPACE TO HOSTNAME(CNT:1)
               END-IF
           END-PERFORM.

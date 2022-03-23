      ******************************************************************
       IDENTIFICATION              DIVISION.
      ******************************************************************
       PROGRAM-ID.                 QUWINIP.
      * REMARKS.
      *     IP address Žæ“¾iWindows—pj
       SPECIAL-NAMES.
           call-convention 74 is winapi.
      ******************************************************************
       DATA                        DIVISION.
      ******************************************************************
       WORKING-STORAGE             SECTION.

       01  HOSTENT-P       POINTER.
       01  IP-P            POINTER.
       01  CNT             PIC S9(4) COMP.
       01  RET                 BINARY-LONG SIGNED.
       01  RES             PIC S9(9) COMP-5.
       78  MAX-ADDR   VALUE 16.
       01  FUNC-NAME               PIC X(30).
       01  myptr                   PROCEDURE-POINTER.
           COPY "QUEXT.def".
       LINKAGE                     SECTION.
       01  HOSTNAME        PIC X(20).
       01  IP-ADR          PIC X(16).
       01  THIN-FLG                PIC X.
       01  HOSTENT.
           03  H_NAME      POINTER.       *> char FAR*
           03  H_ALIASES   POINTER.       *> char FAR  FAR**
           03  H_ADDRTYPE  BINARY-SHORT SIGNED.  *> 
           03  H_LENGTH    BINARY-SHORT SIGNED.  *> 
           03  H_ADDR_LIST POINTER.       *> char FAR  FAR**
       01  H_ADDR_LIST_0   POINTER.
       01  H_ADDR_0        PIC X(4).
       01  IP-CHR          PIC X(MAX-ADDR).
      ******************************************************************
       PROCEDURE                   DIVISION USING
                                     HOSTNAME IP-ADR THIN-FLG.
      ******************************************************************
       MAIN-ROUTINE.
      *  ‚n‚rî•ñ‚ðŽæ“¾
           IF THIN-FLG NOT = "1"
               MOVE SPACE TO HOSTNAME
               CALL "C$SOCKET" USING 9, HOSTNAME GIVING RES
           END-IF.
      *     INSPECT HOSTNAME REPLACING TRAILING SPACES BY LOW-VALUES.
           PERFORM INSPECT-PROC
           set myptr to entry "ws2_32.dll".
      *     ACCEPT SAVE-DLLC FROM ENVIRONMENT "DLL_CONVENTION".
      *     SET      ENVIRONMENT "DLL_CONVENTION"    TO  "1".
      *     EVALUATE TRUE
      *       WHEN
060208* THIN-FLG NOT = "1" AND
      *            (QU-WS2-32 = SPACE OR ALL X"00")
      *         MOVE "ws2_32.dll" TO QU-WS2-32
      *         CALL QU-WS2-32 ON EXCEPTION
      *             DISPLAY MESSAGE BOX "ws2_32.dll Fail"
      *             GO TO EXIT-PROC
      *         END-CALL
      *       WHEN THIN-FLG = "1" AND
      *            (QU-T-WS2-32 = SPACE OR ALL X"00")
      *         MOVE "@[DISPLAY]:ws2_32.dll" TO QU-T-WS2-32
      *         CALL QU-T-WS2-32 ON EXCEPTION
      *             DISPLAY MESSAGE BOX "Thin ws2_32.dll Fail"
      *             GO TO EXIT-PROC
      *         END-CALL
      *     END-EVALUATE.
      *
      *     IF THIN-FLG NOT = "1"
               MOVE "gethostbyname" TO FUNC-NAME
      *       ELSE
      *         MOVE "@[DISPLAY]:gethostbyname" TO FUNC-NAME
      *     END-IF.
           CALL winapi FUNC-NAME USING HOSTNAME
                                GIVING HOSTENT-P
             ON EXCEPTION
               DISPLAY "gethostbyname Fail thin:" THIN-FLG
               GO TO EXIT-PROC
           END-CALL
           IF HOSTENT-P = NULL
      *         IF THIN-FLG NOT = "1"
                   MOVE "WSAGetLastError" TO FUNC-NAME
      *           ELSE
      *             MOVE "@[DISPLAY]:WSAGetLastError" TO FUNC-NAME
      *         END-IF
               CALL winapi FUNC-NAME GIVING RET
               DISPLAY "gethostbyname Error! thin:"
                                   THIN-FLG X"0a" "err-cd:" RET
               GO TO EXIT-PROC
           END-IF.
           SET ADDRESS OF HOSTENT TO HOSTENT-P.
           SET ADDRESS OF H_ADDR_LIST_0 TO H_ADDR_LIST
           SET ADDRESS OF H_ADDR_0 TO H_ADDR_LIST_0
           MOVE SPACE TO IP-ADR.
      *
      *     IF THIN-FLG NOT = "1"
               MOVE "inet_ntoa" TO FUNC-NAME
      *       ELSE
      *         MOVE "@[DISPLAY]:inet_ntoa" TO FUNC-NAME
      *     END-IF.
           CALL winapi FUNC-NAME USING BY VALUE H_ADDR_0
                            GIVING IP-P
           SET ADDRESS OF IP-CHR TO IP-P
           PERFORM VARYING CNT FROM 1 BY 1 UNTIL CNT > MAX-ADDR OR
                                                 IP-CHR(CNT:1) = X"00"
               MOVE IP-CHR(CNT:1) TO IP-ADR(CNT:1)
           END-PERFORM.
           PERFORM INSPECT2-PROC.
       EXIT-PROC.
           GOBACK.
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

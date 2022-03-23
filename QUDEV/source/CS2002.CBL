       IDENTIFICATION DIVISION.
           PROGRAM-ID. CS2002.
       CONFIGURATION SECTION.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       COPY "codeset_2002.cpy".     *>for HITACHI EBCDIC

       01 Func-No                  pic x comp-x value 0.
       01 tmp-byte                 pic x.
       01 tmp-string               pic x(256).
       01 Source-Length            pic 9(9) comp-x.
       78 NChr                     value x"C7".
       78 AdScan                   value x"A1".
       01 Pure-DBCS-Flag           pic 9(2) comp-x.
           88 Pure-DBCS            value 1.
       01 ignored                  pic 9(2) comp-x value 0.
       01 func-1                   pic 9(2) comp-x value 1.
       01 Len-Left                 pic 9(9) comp-x.
       01 Len-of-DBCS              pic 9(9) comp-x.
       01 Start-Pos                PIC 9(9) comp-x.

       01  mem-flags                   pic x(4) comp-5 value 0.

       LINKAGE SECTION.
       01  Cset-Flag                       PIC 9(2) COMP-X.
       01  Cset-Length                     PIC 9(9) COMP-X.
       01  Cset-Area                       PIC X(256).

       PROCEDURE DIVISION USING Cset-Flag, Cset-Length, Cset-Area.
       Convertion SECTION.
       Conv-Control.

           MOVE Cset-Length TO Area-Length

           MOVE 0 TO Current-Position.

           EVALUATE Cset-Flag
           WHEN 0
               move 4 to func-no
               PERFORM Conv-EB-JIS
           WHEN 1
               move 5 to func-no
               PERFORM Conv-JIS-EB
           WHEN 2
               MOVE Cset-EBCDIC-ASCII TO Cset-AREA
           WHEN 3
               MOVE Cset-ASCII-EBCDIC TO Cset-AREA
           WHEN 4
               move 4 to func-no
               Perform Pure-DBCS-EB-JIS
           WHEN 5
               move 5 to func-no
               Perform Pure-DBCS-JIS-EB
           END-EVALUATE.
       Conv-Exit.
           GOBACK.

      * Converts mixed strings of SBCS and DBCS characters. SBCS
      * characters are converted using the internal table. DBCS
      * strings, surrounded by SO and SI characters, are passed to the
      * OS for conversion.
       Conv-EB-JIS SECTION.
       Conv-EB-JIS-Next.
           IF Current-Position < Area-Length
               if Cset-Area (Current-Position + 1:1) not = x"0E"
                   MOVE Cset-Area  (Current-Position + 1:1)
                     TO Char-Value (1                   :1)
                   MOVE Cset-EBAS (Char-Value + 1)
                     TO Cset-Area (Current-Position + 1: 1)
                   ADD 1 TO Current-Position
                   GO TO Conv-EB-JIS-Next
               else
                   compute len-left = Area-length - Current-position
                   move Current-position to Start-Pos
                   inspect Cset-area (Start-Pos + 1:len-left)
                       tallying Current-Position for characters before
                       initial x"0F"
                   Add 1 to Current-position
                   compute len-of-dbcs =  Current-position - Start-pos
      * Strip off the SO/SI characters
                   subtract 2 from len-of-dbcs

                   move len-of-dbcs to Source-Length
                   call "MFTRNSDT" USING Func-No
                                         Source-Length
                                   Cset-area (Start-Pos + 2:len-of-dbcs)
                   on exception
                       perform Call-Failed
                   end-call
                   GO TO Conv-EB-JIS-Next
               end-if
           end-if.

      * Converts mixed strings of SBCS and DBCS characters. SBCS
      * characters are converted using the internal table. DBCS
      * strings, surrounded by SO and SI characters, are passed to the
      * OS for conversion.
       Conv-JIS-EB SECTION.
       Conv-JIS-EB-Next.
           IF Current-Position < Area-Length
                   if Cset-Area (Current-Position + 1:1) not = x"0E"
                       MOVE Cset-Area  (Current-Position + 1:1)
                         TO Char-Value (1                   :1)
                       MOVE Cset-ASEB (Char-Value + 1)
                         TO Cset-Area (Current-Position + 1: 1)
                       ADD 1 TO Current-Position
                       GO TO Conv-JIS-EB-Next
                   else
                       compute len-left = Area-length - Current-position
                       move Current-position to Start-Pos
                       inspect Cset-area (Start-Pos + 1:len-left)
                           tallying Current-Position for characters
                           before initial x"0F"
                       Add 1 to Current-position
                       compute len-of-dbcs =  Current-position -
                                                   Start-pos
      * Strip off the SO/SI characters
                   subtract 2 from len-of-dbcs

                       move len-of-dbcs to Source-Length
                       call "MFTRNSDT" USING
                               Func-No
                               Source-length
                               Cset-area (Start-Pos + 2:len-of-dbcs)
                       on exception
                           perform Call-Failed
                       end-call
                       GO TO Conv-JIS-EB-Next
                   end-if
           end-if.

      * Converts Pure DBCS strings (PIC G etc). These strings do not
      * contain SO or SI characters or SBCS characters.
       Pure-DBCS-EB-JIS SECTION.
           move Area-Length to Source-Length
           call "MFTRNSDT" USING Func-No
                                 Source-length
                                 Cset-area (1:Area-length)
           on exception
               perform Call-Failed
           end-call
           .

      * Converts Pure DBCS strings (PIC G etc). These strings do not
      * contain SO or SI characters or SBCS characters.
       Pure-DBCS-JIS-EB SECTION.
           perform validate-pure
           if Pure-DBCS
               move Area-Length to Source-Length
               call "MFTRNSDT" USING Func-No
                                     Source-length
                                     Cset-area (1:Area-length)
               on exception
                   perform Call-Failed
               end-call
           else
      *        display "Illegal characters in string" Area-length
               Perform Conv-JIS-EB
           end-if
           .

       Validate-Pure SECTION.
           move 0 to Pure-DBCS-Flag
           move Cset-area(1:1) to tmp-byte
           if area-length > 256
               move Cset-area(1:256) to tmp-string
               call AdScan using func-1 tmp-string
           else
               move Cset-area(1:area-length) to
                       tmp-string(1:area-length)
               call AdScan using func-1 tmp-string(1:area-length)
           end-if
           if tmp-byte = tmp-string(1:1)
               move 1 to Pure-DBCS-Flag
           end-if.

      *
      * Performed if call to MFTRNSDT(.DLL) fails for whatever reason.
      *                                    >> SCM << 28/1/92
       Call-Failed Section.
           display
             "* CODESET unable to call MFTRNSDT. Data may be incorrect."
           goback.


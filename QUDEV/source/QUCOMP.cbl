       identification division.
       program-id. QUCOMP.
       environment division.
        CONFIGURATION SECTION.
        SPECIAL-NAMES.
       input-output section.
       file-control.
           select file1 assign to fname1
               file status fsts.
           select file2 assign to fname2
               file status fsts.
       data division.
       file section.
       fd  file1.
       01  f1-rec   pic x(4096).
       fd  file2.
       01  f2-rec   pic x(4096).
       working-storage section.
           copy "QUTESTID.lks".
       01  fsts     pic xx.
       01  fname1   pic x(80).
       01  fname2   pic x(80).
       01  file-details1.
           03 cblte-fe-filesize1       pic x(8) comp-x.
           03  cblte-fe-filedate1.
             05  cblte-fe-day1         pic x comp-x.
             05   cblte-fe-month1      pic x comp-x.
             05   cblte-fe-year1       pic x(2) comp-x.
           03  cblte-fe-filetime1.
             05   cblte-fe-hours1      pic x comp-x.
             05   cblte-fe-minutes1    pic x comp-x.
             05   cblte-fe-seconds1    pic x comp-x.
             05   cblte-fe-hundredths1 pic x comp-x.
       01  file-details2.
           03 cblte-fe-filesize2       pic x(8) comp-x.
           03  cblte-fe-filedate2.
             05  cblte-fe-day2         pic x comp-x.
             05   cblte-fe-month2      pic x comp-x.
             05   cblte-fe-year2       pic x(2) comp-x.
           03  cblte-fe-filetime2.
             05   cblte-fe-hours2      pic x comp-x.
             05   cblte-fe-minutes2    pic x comp-x.
             05   cblte-fe-seconds2    pic x comp-x.
             05   cblte-fe-hundredths2 pic x comp-x.
       01  status-code                pic X(2) COMP-5.
       01  wk18-1                     pic 9(18).
       01  wk18-2                     pic 9(18).
       01  DSPERp                     pic x(256).
       01  reccnt                     pic x(8) comp-5.
       01  loop-max                   pic x(4) comp-5.
       01  loop-cnt                   pic x(4) comp-5.
       78  diff-max                   value 100.
       01  diff-cnt                   pic x(4) comp-5.
       01  wk1-x                      pic x.
       01  wk1-n redefines wk1-x      pic x comp-x.
       01  wk2-x                      pic x.
       01  wk2-n redefines wk2-x      pic x comp-x.
       01  i                          pic xx comp-5.
       01  adr                        pic x(8) comp-x.
       01  ad-hex                     pic x(16).
       01  dmp                        pic x(32).
       01  f1-eofd                    pic 9.
         88  f1-eof   value 1.
       01  f2-eofd                    pic 9.
         88  f2-eof   value 1.
        01  x-returncd                     pic x(32).
       procedure division.
       proc1.
           perform init-proc.
           perform comp-proc.
           perform last-proc.
           goback.
       init-proc.
           move "OK" to QUL-RES.
           move space to fname1, fname2.
           display "QUFNAME1" upon environment-name.
           accept fname1      from environment-value.
           display "QUFNAME2" upon environment-name.
           accept fname2      from environment-value.
           if fname1 = space or fname2 = space
               move 255 to return-code
               goback
           end-if.
           call "CBL_CHECK_FILE_EXIST"  using    fname1
                                      file-details1
                            returning status-code.
           call "CBL_CHECK_FILE_EXIST"  using    fname2
                                      file-details2
                            returning status-code.
           open input file1 file2.
           display "QUTESTID"      upon environment-name.
           accept QUL-PARAM-ID     from environment-value.
           move 0 to reccnt diff-cnt f1-eofd f2-eofd.
       comp-proc.
           if cblte-fe-filesize1 not = cblte-fe-filesize2
               move cblte-fe-filesize1 to wk18-1
               move cblte-fe-filesize2 to wk18-2
               string "File size unmatch!! size1:" delimited size
                      wk18-1 delimited size
                      "/ size2:" delimited size
                      wk18-2 delimited size
                   into DSPERp
               call "BJ_DSPER" using DSPERp
               move "NG" to QUL-RES
           end-if.
           move space to f1-rec f2-rec.
           read file1 at end set f1-eof to true end-read.
           read file2 at end set f2-eof to true end-read.
           perform until f1-eof or f2-eof
               add 1 to reccnt
               move function
                   min(cblte-fe-filesize1, cblte-fe-filesize2, 4096)
                   to loop-max
               perform varying loop-cnt from 1 by 16
                       until loop-cnt > loop-max or f1-eof
                   if f1-rec(loop-cnt:16) not = f2-rec(loop-cnt:16)
                       perform dump-proc
                   end-if
               end-perform
               compute cblte-fe-filesize1 = cblte-fe-filesize1 - 4096
               compute cblte-fe-filesize2 = cblte-fe-filesize2 - 4096
               move space to f1-rec f2-rec
               read file1 at end
                   set f1-eof to true
                   exit perform
               end-read
               read file2 at end
                   set f2-eof to true
                   exit perform
               end-read
           end-perform.
       last-proc.
           close file1 file2.
           if diff-cnt = 0
               move "OK!!!" to DSPERp
             else
               move diff-cnt to wk18-1
               string "NG!! diff-cnt:" delimited size
                      wk18-1(10:)      delimited size
                   into DSPERp
           end-if.
           call "BJ_DSPER" using DSPERp.
           CALL "QUTESTID" USING "INT". 
           CALL "QUTESTID" USING "WRT" 
                     QUL-PARAM-ID QUL-RES QUL-COMM1  QUL-RETURNCD.
           CALL "QUTESTID" USING "TRM".
       dump-proc.
           add 1 to diff-cnt.
           if diff-cnt > diff-max     *> 差分出力はdiff-maxまで
               set f1-eof to true
               exit paragraph
           end-if.
           perform varying i from 1 by 1 until i > 16
               move f1-rec(loop-cnt + i:1) to wk1-x
               compute wk2-n = wk1-n / 16 + 48   *> 上位4bit, 0 -> '0'
               if wk2-x > '9'    *> 'A'-'F'
                   add 7 to wk2-n
               end-if
               move wk2-x to dmp(i * 2 - 1:1)
               compute wk2-n = function mod(wk1-n, 16) + 48   *> 下位4bit, 0 -> '0'
               if wk2-x > '9'    *> 'A'-'F'
                   add 7 to wk2-n
               end-if
               move wk2-x to dmp(i * 2:1)
           end-perform.
           compute adr = (reccnt - 1) * 4096 + loop-cnt.
           perform varying i from 1 by 1 until i > 8
               move adr(i:1) to wk1-x
               compute wk2-n = wk1-n / 16 + 48   *> 上位4bit, 0 -> '0'
               if wk2-x > '9'    *> 'A'-'F'
                   add 7 to wk2-n
               end-if
               move wk2-x to ad-hex(i * 2 - 1:1)
               compute wk2-n = function mod(wk1-n, 16) + 48   *> 下位4bit, 0 -> '0'
               if wk2-x > '9'    *> 'A'-'F'
                   add 7 to wk2-n
               end-if
               move wk2-x to ad-hex(i * 2:1)
           end-perform.
           string "Dump-out addr:" delimited size
                  ad-hex delimited size
                  " : " delimited size
                  dmp delimited size
               into DSPERp.
           call "BJ_DSPER" using DSPERp.
           move "NG" to QUL-RES.

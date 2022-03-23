        identification division.
        program-id. QUCOMPLOGS.
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SOURCE-COMPUTER.  PC.
       OBJECT-COMPUTER.  PC.
       INPUT-OUTPUT    SECTION.
       FILE-CONTROL.
        file-control.
            select file1 assign to tlog-name
                file status fsts.
            select file2 assign to fname2
                file status fsts.
        data division.
        file section.
        fd  file1.
        01  f1-rec   pic x(1).
        fd  file2.
        01  f2-rec   pic x(1).
        working-storage section.
           copy "QUTESTID.lks".
        01  fsts     pic xx.
        01  fname1   pic x(80).
        01  fname2   pic x(80).
        01  tlog-name   pic x(200) value
             "WORK\temp_logf.log".
        01  file-details1.
            03  cblte-fe-filedate1.
                05   cblte-fe-day1         pic x comp-x.
                05   cblte-fe-month1       pic x comp-x.
                05   cblte-fe-year1        pic x(2) comp-x.
            03  cblte-fe-filetime1.
                05   cblte-fe-hours1       pic x comp-x.
                05   cblte-fe-minutes1     pic x comp-x.
                05   cblte-fe-seconds1     pic x comp-x.
                05   cblte-fe-hundredths1  pic x comp-x.
        01  file-details2.
            03  cblte-fe-filedate2.
                05  cblte-fe-day2          pic x comp-x.
                05  cblte-fe-month2        pic x comp-x.
                05  cblte-fe-year2         pic x(2) comp-x.
            03  cblte-fe-filetime2.
                05   cblte-fe-hours2       pic x comp-x.
                05   cblte-fe-minutes2     pic x comp-x.
                05   cblte-fe-seconds2     pic x comp-x.
                05   cblte-fe-hundredths2  pic x comp-x.
        01  status-code                    pic X(2) COMP-5.
        01  wk18-1                         pic 9(18).
        01  wk18-2                         pic 9(18).
        01  DSPERp                         pic x(256).
        01  loop-cnt                       pic 9(18).
        01  diff-cnt                       pic x(4) comp-5.
        01  wk1-x                          pic x.
        01  wk1-n redefines wk1-x          pic x comp-x.
        01  wk2-x                          pic x.
        01  wk2-n redefines wk2-x          pic x comp-x.
        01  f1-eofd                        pic 9.
        88  f1-eof   value 1.
        01  f2-eofd                        pic 9.
        88  f2-eof   value 1.
        01  line-from                      pic 9(4).
        01  line-to                        pic 9(4).
        01  chk-file                       pic 9(1).
        01  line-cnt-1                     pic 9(4).
        01  line-cnt-2                     pic 9(4).
        01  line-loop                      pic 9(2).
        01  x-enter                        pic x(1).
        01  x-crg                          pic x(1).
        01  chk-line.
        	03  chk OCCURS 32 TIMES.
        	    05  chk-from               pic 9(4).
        	    05  colon-1                pic x(1).
        	    05  chk-to                 pic 9(4).
        	    05  colon-2                pic x(1).
        	    05  chk-file-no            pic 9(1).
        	    05  colon-3                pic x(1).
        procedure division chaining chk-line.
        proc1.
            move "OK" to QUL-RES.
            move 0 to diff-cnt chk-file.
            perform varying line-loop from 1 by 1
                until line-loop > 32 or
                      chk-from(line-loop) is not numeric or
                      chk-from(line-loop) not > 0
                if chk-file-no(line-loop) not = chk-file
                	move chk-file-no(line-loop) to chk-file
                	move space to DSPERp
                	move chk-file-no(line-loop) to wk18-1
                	string "chk-file:" delimited size
                	    wk18-1(10:) delimited size
                	into DSPERp
                	call "BJ_DSPER" using DSPERp
                	perform init-proc
                end-if
                move chk-from(line-loop) to wk18-1
                move chk-to(line-loop) to wk18-2
                move space to DSPERp
                string "chk-line:" delimited size
                    wk18-1(10:) delimited size
                    " - " delimited size
                    wk18-2(10:) delimited size
                into DSPERp
                call "BJ_DSPER" using DSPERp
                move chk-from(line-loop) to line-from
                move chk-to(line-loop) to line-to
                perform comp-proc
            end-perform.
      *      display "END".
            perform last-proc.
            exit program.        	
        init0-proc.
            CALL "BJ_FCOPY" USING fname1 tlog-name.
            if return-code not = 0
            	goback
            end-if.
            move tlog-name to fname1.
        init-proc.
            move space to fname1 fname2.
            move space to f1-rec f2-rec.
            move 1 to line-cnt-1 line-cnt-2.
            close file1 file2.
            if chk-file = 1 or chk-file = 0
            	display "QUFNAME1" upon environment-name
            	accept fname1      from environment-value
            	display "QUFNAME2" upon environment-name
            	accept fname2      from environment-value
            end-if.
            if chk-file = 2
            	display "QUFNAME3" upon environment-name
            	accept fname1      from environment-value
            	display "QUFNAME4" upon environment-name
            	accept fname2      from environment-value
            end-if.
            if chk-file = 3
            	display "QUFNAME5" upon environment-name
            	accept fname1      from environment-value
            	display "QUFNAME6" upon environment-name
            	accept fname2      from environment-value
            end-if.
            if chk-file = 4
            	display "QUFNAME7" upon environment-name
            	accept fname1      from environment-value
            	display "QUFNAME8" upon environment-name
            	accept fname2      from environment-value
            end-if.
            if chk-file = 5
            	display "QUFNAME9" upon environment-name
            	accept fname1      from environment-value
            	display "QUFNAME10" upon environment-name
            	accept fname2      from environment-value
            end-if.
            if chk-file = 6
            	display "QUFNAME11" upon environment-name
            	accept fname1      from environment-value
            	display "QUFNAME12" upon environment-name
            	accept fname2      from environment-value
            end-if.
            if chk-file = 7
            	display "QUFNAME13" upon environment-name
            	accept fname1      from environment-value
            	display "QUFNAME14" upon environment-name
            	accept fname2      from environment-value
            end-if.
            if chk-file = 8
            	display "QUFNAME15" upon environment-name
            	accept fname1      from environment-value
            	display "QUFNAME16" upon environment-name
            	accept fname2      from environment-value
            end-if.
            if chk-file = 9
            	display "QUFNAME17" upon environment-name
            	accept fname1      from environment-value
            	display "QUFNAME18" upon environment-name
            	accept fname2      from environment-value
            end-if.
            if fname1 = space or fname2 = space
                move 255 to return-code
                goback
            end-if.          
            call "CBL_CHECK_FILE_EXIST"  using    fname1
                file-details1
            returning status-code.
            if status-code not = "0000"
            	move status-code to return-code
            	goback
            end-if.
            call "CBL_CHECK_FILE_EXIST"  using    fname2
                file-details2
            returning status-code.
            if status-code not = "0000"
            	move status-code to return-code
            	goback
            end-if.
            perform init0-proc.    *> 080701
            open input file1 file2.
            move X'0A' to  x-enter.
            move X'0D' to  x-crg.
            display "QUTESTID"      upon environment-name.
            accept QUL-PARAM-ID     from environment-value.
            move 0 to f1-eofd f2-eofd.
        comp-proc.
            perform varying loop-cnt from 1 by 1
                until f1-eof or line-cnt-1 not < line-from
                read file1 at end
                    set f1-eof to true
                    exit perform
                end-read
                if f1-rec = x-enter
                    add 1 to line-cnt-1
                end-if
            end-perform.
            perform varying loop-cnt from 1 by 1
                until f2-eof or line-cnt-2 not < line-from
                read file2 at end
                    set f2-eof to true
                    exit perform
                end-read
                if f2-rec = x-enter
                    add 1 to line-cnt-2
                end-if
            end-perform.
            perform varying loop-cnt from 1 by 1
                until f1-eof or f2-eof or line-cnt-1 < line-from
                or line-cnt-1 > line-to
                read file1 at end
                    set f1-eof to true
                    exit perform
                end-read
                if f1-rec = x-crg
                    read file1 at end
                        set f1-eof to true
                        exit perform
                    end-read
                end-if
                read file2 at end
                    set f2-eof to true
                    exit perform
                end-read
                if f2-rec = x-crg
                    read file2 at end
                        set f2-eof to true
                        exit perform
                    end-read
                end-if
                if f1-rec not = f2-rec
                    and f1-rec not = x-enter and f2-rec not = x-enter
                    add 1 to diff-cnt
                    move space to DSPERp
                    move line-cnt-1 to wk18-1
                    move loop-cnt to wk18-2
                    string "Dump-out line:" delimited size
                        wk18-1(10:) delimited size
                        wk18-2(10:) delimited size
                    into DSPERp
                    call "BJ_DSPER" using DSPERp
                    move "NG" to QUL-RES
                end-if
                if f1-rec = x-enter
                    add 1 to line-cnt-1
                end-if
                if f2-rec = x-enter
                    add 1 to line-cnt-2
                end-if
                if f1-rec = x-enter
                    if line-cnt-1 > line-cnt-2
                        move space to DSPERp
                        move line-cnt-2 to wk18-1
                        string "Dump-out line:" delimited size
                            wk18-1(10:) delimited size
                            " -- Line size unmatch" delimited size
                        into DSPERp
                        call "BJ_DSPER" using DSPERp
                        move "NG" to QUL-RES
                        perform varying loop-cnt from 1 by 1
                            until f2-eof or f2-rec = x-enter
                            read file2 at end
                                set f2-eof to true
                                exit perform
                            end-read
                        end-perform
                    	add 1 to diff-cnt
                        add 1 to line-cnt-2
                    end-if
                    move 0 to loop-cnt
                end-if
                if f2-rec = x-enter
                    if line-cnt-2 > line-cnt-1
                        move space to DSPERp
                        move line-cnt-1 to wk18-1
                        string "Dump-out line:" delimited size
                            wk18-1(10:) delimited size
                            " -- Line size unmatch" delimited size
                        into DSPERp
                        call "BJ_DSPER" using DSPERp
                        move "NG" to QUL-RES
                        perform varying loop-cnt from 1 by 1
                            until f1-eof or f1-rec = x-enter
                            read file1 at end
                                set f1-eof to true
                                exit perform
                            end-read
                        end-perform
                    	add 1 to diff-cnt
                        add 1 to line-cnt-1
                    end-if
                    move 0 to loop-cnt
                end-if
            end-perform.
        last-proc.
            close file1 file2.
            if diff-cnt = 0
                move "OK!!!" to DSPERp
            else
                move space to DSPERp
                move diff-cnt to wk18-1
                string "NG!  diff-cnt:" delimited size
                    wk18-1(10:) delimited size
                into DSPERp
            end-if.
            call "BJ_DSPER" using DSPERp.
            CALL "QUTESTID" USING "INT".             
            CALL "QUTESTID" USING "WRT" 
                     QUL-PARAM-ID QUL-RES QUL-COMM1  QUL-RETURNCD.
            CALL "QUTESTID" USING "TRM".
            
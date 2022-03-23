identification division.
program-id. STEST.
environment division.
 CONFIGURATION SECTION.
 SPECIAL-NAMES.
input-output section.
file-control.

select ftest-file
    assign to  external STEST
    organization is sequential
    access mode  is sequential
    lock mode automatic
    status is ftest-status.
data division.
file section.

fd  ftest-file.
01  ftest-record.
    03  ftest-key            pic x(4).
    03  ftest-altkey1.
    05  ftest_key1_seg1      pic x(5).
    05  ftest_key1_seg2      pic x(5).
    03  ftest-altkey2        pic x(10).
    03  ftest-number         pic S9(4)V99.
    03  ftest-info           pic x(10).

working-storage section.
01  ftest-status.
    05 ftest-status-1       pic x.
    05 ftest-status-2       pic x.
    05 ftest-status-x       redefines ftest-status-2
                            pic 99 comp-x.
77  menu-option                pic 9(2).
    88  next-selected              value 1.
    88  previous-selected          value 2.
    88  read-selected              value 3.
    88  write-selected             value 4.
    88  delete-selected            value 5.
    88  rewrite-selected           value 6.
    88  start-1-selected           value 7.
    88  start-2-selected           value 8.
    88  open-inp-selected          value 10.
    88  open-out-selected          value 11.
    88  open-io-selected           value 12.
    88  open-extend-selected       value 13.
    88  close-selected             value 14.
    88  end-selected               value 18.

    01 error-status.
       05 error-status-1           pic x(1).
       05 error-status-2           pic x.
       05 error-status-3           pic 9(3).
*>---------------------------------------------------
01  share-mode-x.
    03  share-mode          pic 9.
01  share-msg               pic x(20).

01  omit-wk                 pic x.
 LINKAGE SECTION.
screen section.
01  erase-screen    erase eos.
01  record-screen.    
    03  primary-screen.
        05  "STEST RECORD"      line 3   column 2.
        05  "Primary: "         line 5   column 5.
        05  using ftest-key     pic x(4) column 20.
    03  alt1-screen.
        05  "Alt1: "            line + 1 column 5.
        05  using ftest-altkey1 pic x(10) column 20.
    03  alt2-screen.
        05  "Alt2: "            line + 1 column 5.
        05  using ftest-altkey2 pic x(10) column 20.
    03  info-screen.
        05  "Info Field: "      line + 1 column 5.
        05  using ftest-info    pic x(10) column 20.
    03  number-screen.
        05  "number Field: "    line + 1 column 5.
        05  pic zzzzz9 blank when zero    column 20
                                using ftest-number.

01  options-screen.
    03  value "1. Next"            line 13 column 5.
    03  value "3. Read"            line + 1 column 5.
    03  value "4. Write"           line + 1 column 5.
    03  value "5. Delete"          line + 1 column 5.
    03  value "6. Rewrite"         line + 1 column 5.
    03  value "10. Open Input"     line 13  column 24.
    03  value "11. Open Output"    line + 1 column 24.
    03  value "12. Open IO"        line + 1 column 24.
    03  value "13. Open extend"    line + 1 column 24.
    03  value "14. Close"          line + 1 column 24.
    
    03  value "18. End"            line + 1 column 24.

    03  value "Enter option:"      line 21 column 5. 
    03  pic 99 using menu-option            column + 2.
    
01  error-msg.
    03 "ERROR file status:"     line 24 column 40.
    03 filler pic x(5)         from error-status.
    03 " Press <RETURN>".
    
procedure division.
declaratives.
ftest-err-handling section.
    use after standard error procedure on ftest-file.
ftest-err.
    if ftest-status-1 = "9"
       move ftest-status-1   to error-status-1
       move "-"              to error-status-2
       move ftest-status-2   to error-status-3
    else
       move space            to error-status
       move ftest-status-1   to error-status-1
       move ftest-status-2   to error-status-2
    end-if.
    display error-msg.
    accept  omit-wk   at 2480.
    display omit-wk line 24 column 40 erase eol.
end declaratives.

level-1 section.
main-logic.
*>
    *>set environment "file.sequential" to "BJ_FModSeq".
    *>set environment "STEST" to "data\STEST.seq".
*>
    move space to SHARE-MODE-x.
    display "FTEST_SHARE" upon environment-name.
    accept  SHARE-MODE-X  from environment-value.
    if      SHARE-MODE-X = SPACE MOVE "0" to SHARE-MODE-X.
    evaluate SHARE-MODE-X
      when "0" move "No share phrase" to share-msg
      when "1" move "Share ALL"       to share-msg
      when "2" move "Share NO"        to share-msg
      when "3" move "Share READ ONLY" to share-msg
    end-evaluate.

*>
    display erase-screen.
    display "STEST - Acucobol file test program" line 1 col 5.
    display "        (No lock mode phrase)"       line 2 col 5.
    display share-msg                             line 2 col 50.
    initialize ftest-record.
    display record-screen.
    display options-screen.
    perform get-option with test after until end-selected.
    goback.

get-option.
    accept options-screen.
    display omit-wk line 24 column 60.
    evaluate true
      when next-selected
    perform do-next
      when read-selected
    perform do-read
      when write-selected
    perform do-write
      when delete-selected
    perform do-delete
      when rewrite-selected
    perform do-rewrite
      when open-extend-selected
         evaluate share-mode-x
           when "0" open extend                    ftest-file 
           when "1" open extend sharing ALL        ftest-file
           when "2" open extend sharing NO         ftest-file
           when "3" open extend sharing READ ONLY  ftest-file
          end-evaluate
    if ftest-status = "00"
        display "open successful" line 24 column 60
    end-if
      when open-inp-selected
          evaluate share-mode-x
           when "0" open input                    ftest-file 
           when "1" open input sharing ALL        ftest-file
           when "2" open input sharing NO         ftest-file
           when "3" open input sharing READ ONLY  ftest-file
          end-evaluate
    if ftest-status = "00"
        display "open successful" line 24 column 60
    end-if
    move 0 to menu-option
      when open-out-selected
         evaluate share-mode-x
           when "0" open output                    ftest-file 
           when "1" open output sharing ALL        ftest-file
           when "2" open output sharing NO         ftest-file
           when "3" open output sharing READ ONLY  ftest-file
          end-evaluate
    if ftest-status = "00"
        display "open successful" line 24 column 60
    end-if
    move 0 to menu-option
      when open-io-selected
         evaluate share-mode-x
           when "0" open i-o                    ftest-file 
           when "1" open i-o sharing ALL        ftest-file
           when "2" open i-o sharing NO         ftest-file
           when "3" open i-o sharing READ ONLY  ftest-file
          end-evaluate
    if ftest-status = "00"
        display "open successful" line 24 column 60
    end-if
    move 0 to menu-option
      when close-selected
    close ftest-file
    if ftest-status = "00"
        display "close successful" line 24 column 60
    end-if
    move 0 to menu-option
      when end-selected
    continue
    end-evaluate.

file-operations.
do-next.
    read ftest-file next record.
    if ftest-status = "00"
    display "next successful" line 24 column 60
    end-if.
    display record-screen.

do-read.
    accept primary-screen.
    read ftest-file record.
    if ftest-status = "00"
    display "read successful" line 24 column 60
    end-if.
    display record-screen.

do-write.
    accept record-screen.
    write ftest-record.
    if ftest-status = "00"
    display "write successful" line 24 column 60
    end-if.

do-delete.
    accept primary-screen.
    delete ftest-file record.
    if ftest-status = "00"
    display "delete successful" line 24 column 60
    end-if.

do-rewrite.
    accept record-screen.
    rewrite ftest-record.
    if ftest-status = "00"
    display "rewrite successful" line 24 column 60
    end-if.


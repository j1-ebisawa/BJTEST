       identification division.
       program-id. FTEST_GUI.
       environment division.
        CONFIGURATION SECTION.
        SPECIAL-NAMES.
       input-output section.
       file-control.
       select ftest-file
           assign to "data\FTEST"
           organization is indexed
           access is dynamic
           record key is ftest-key
           alternate record key is ftest-altkey1 with duplicates
           alternate record key is ftest-altkey2 with duplicates
           LOCK MODE automatic
           status is ftest-status.
       data division.
       file section.
       fd  ftest-file.
       01  ftest-record.
           03  ftest-key           pic x(4).
           03  ftest-altkey1.
             05  ftest_key1_seg1   pic x(5).
             05  ftest_key1_seg2   pic x(5).
           03  ftest-altkey2       pic x(10).
           03  ftest-number        pic S9(4)V99.
           03  ftest-info          pic x(10).
       working-storage section.
       01  ftest-status.
           05 ftest-status-1       pic x.
           05 ftest-status-2       pic x.
           05 ftest-status-x       redefines ftest-status-2
                                   pic 99 comp-x.
       77  menu-option             pic 9(2) value 0.
           88  next-selected           value 1.
           88  previous-selected       value 2.
           88  read-selected           value 3.
           88  write-selected          value 4.
           88  delete-selected         value 5.
           88  rewrite-selected        value 6.
           88  start-1-selected        value 7.
           88  start-2-selected        value 8.
           88  start-3-selected        value 9.
           88  open-inp-selected       value 10.
           88  open-out-selected       value 11.
           88  open-io-selected        value 12.
           88  close-selected          value 13.
           88  end-selected            value 14.
       01 error-status.
              05 error-status-1           pic x(1).
              05 error-status-2           pic x.
              05 error-status-3           pic 9(3).
      *
       01  result-msg                 pic x(20) value space.
       01  kakunin                    pic x.
       77  fixed-font                 handle of font fixed-font.
       77  traditional-font           handle of font traditional-font.
       77  default-font               handle of font default-font.
       77  small-font                 handle of font small-font.
       77  medium-font                handle of font medium-font.
       77  large-font                 handle of font large-font.
       01  main-handle    usage handle.

       screen section.
       01  record-screen.
           03  screen-head.
               05 label "FTEST - GUI" size 25 line 1 col 5.
           03  primary-screen.
               05  label "FTEST RECORD"   size 15   line 3   column 2.
               05  label "Primary: "      size  9   line 5   column 5.
               05  entry-field            size  4   line 5   column 20
                                          using ftest-key  pic x(4)  .
           03  alt1-screen.
               05  label "Alt1: "         size  6   line 6   column 5.
               05  entry-field            size 10   line 6   column 20
                                          using ftest-altkey1 pic x(10).
           03  alt2-screen.
               05  label "Alt2: "         size  6   line 7   column 5.
               05  entry-field            size 10   line 7   column 20
                                          using ftest-altkey2 pic x(10).
           03  info-screen.
               05  label "Info Field: "   size 12  line 8   column 5.
               05  entry-field            size 10  line 8   column 20
                                          using ftest-info    pic x(10).
           03  number-screen.
               05  label "number Field: " size 12  line 9 column 5.
               05  entry-field            size  9  line 9 column 20
                                        using ftest-number pic ----9.99.
       01  menu-screen.
           03  label "OPTIONS"           size 12    line 12 column 2.
           03  label "1. Next"           size 12    line 13 column 5.
           03  label "2. Previous"       size 12    line 14 column 5.
           03  label "3. Read"           size 12    line 15 column 5.
           03  label "4. Write"          size 12    line 16 column 5.
           03  label "5. Delete"         size 12    line 17 column 5.
           03  label "6. Rewrite"        size 12    line 18 column 5.
           03  label "7. Start 1"        size 12    line 19 column 5.
       
           03  label "8. Start 2"        size 12    line 13 column 25.
           03  label "9. Start 3"        size 12    line 14 column 25.
           03  label "10. Open Input"    size 15    line 15 column 24.
           03  label "11. Open Output"   size 15    line 16 column 24.
           03  label "12. Open IO"       size 12    line 17 column 24.
           03  label "13. Close"         size 12    line 18 column 24.
           03  label "14. End"           size 12    line 19 column 24.
       01  options-screen.
           03  label "Enter option:"     size 12    line 21 column 5. 
           03  entry-field               size 2 pic z9 blank when zero 
                           using menu-option line 21 column 16.
       
       01  error-msg.
           03 label "ERROR file status:" size 12    line 23 column 40.
           03 label         pic x(5)     size  5    line 23 column 55
                                         from error-status.
           03 label " Press <RETURN>"    size 15    line 23 column 15.
       01  result-screen.
           03 label                      size 20    line 23 column 60
                            pic x(20)      from result-msg. 
       01  omit-wk.
           03 entry-field                size 1     line 23 column 79
                             pic x         using kakunin.
       
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
           destroy result-screen.
           display error-msg.
           display omit-wk.
           accept  omit-wk.
           destroy error-msg omit-wk.
       end declaratives.
       
       level-1 section.
       main-1.
      *
 isc      display floating window erase screen
 isc               background-color 7
 isc               title  "FTEST-GUI"
 isc               cell size is entry-field font 
 isc               size 80
 isc               lines 24
 isc               label-offset 10
 isc               control font small-font
                   handle main-handle.
      *
           display screen-head.
           initialize ftest-record.
           display record-screen.
           display menu-screen.
           display result-screen.
           perform get-option with test after until end-selected.
           close window main-handle.
           goback.
           *>stop run.
       
       get-option.
           move space to menu-option.
           display options-screen.
           accept  options-screen.

           evaluate true
             when next-selected
                  perform do-next
             when previous-selected
                  perform do-previous
             when read-selected
                  perform do-read
             when write-selected
                  perform do-write
             when delete-selected
                  perform do-delete
             when rewrite-selected
                  perform do-rewrite
             when start-1-selected
                  perform do-start-1
             when start-2-selected
                  perform do-start-2
             when start-3-selected
                  perform do-start-3
             when open-inp-selected
                  open input ftest-file
                  if ftest-status = "00"
                     move "open successful" to result-msg
                     display result-screen
                  end-if
                  move 0 to menu-option
             when open-out-selected
                  open output ftest-file
                  if ftest-status = "00"
                     move "open successful" to result-msg
                     display result-screen
                  end-if
                  move 0 to menu-option
             when open-io-selected
                  open i-o ftest-file
                  if ftest-status = "00"
                     move "open successful" to result-msg
                     display result-screen
                  end-if
                  move 0 to menu-option
             when close-selected
                  close ftest-file
                  if ftest-status = "00"
                     move "close successful" to result-msg
                     display result-screen
                  end-if
                  move 0 to menu-option
             when end-selected
                  continue
           end-evaluate.
       
      *file-operations.
       do-next.
           read ftest-file next record.
           if ftest-status = "00"
               move "next successful" to result-msg
               display result-screen
           end-if.
           display record-screen.
       
       do-previous.
           read ftest-file previous record.
           if ftest-status = "00"
               move "previous successful" to result-msg
               display result-screen 
           end-if.
           display record-screen.
       
       do-read.
           accept primary-screen.
           read ftest-file record.
           if ftest-status = "00"
               move "read successful" to result-msg
               display result-screen
           end-if.
           display record-screen.
       
       do-write.
           accept record-screen.
           write ftest-record.
           if ftest-status = "00"
               move "write successful" to result-msg
               display result-screen
           end-if.
       
       do-delete.
           accept primary-screen.
           delete ftest-file record.
           if ftest-status = "00"
               move  "delete successful" to result-msg
               display result-screen
           end-if.
       
       do-rewrite.
           accept record-screen.
           rewrite ftest-record.
           if ftest-status = "00"
               move "rewrite successful" to result-msg
               display result-screen
           end-if.
       
       do-start-1.
           move spaces to ftest-record.
           accept primary-screen.
           start ftest-file key not less ftest-key.
           if ftest-status = "00"
               move "start primary successful" to result-msg
               display result-screen
           end-if.
       
       do-start-2.
           move spaces to ftest-record.
           accept alt1-screen.
           start ftest-file key not less ftest-altkey1.
           if ftest-status = "00"
               move "start first alt successful" to result-msg
               display result-screen
           end-if.
       
       do-start-3.
           move spaces to ftest-record.
           accept alt2-screen.
           start ftest-file key not less ftest-altkey2.
           if ftest-status = "00"
               move "start second alt successful" to result-msg
               display result-screen
           end-if.

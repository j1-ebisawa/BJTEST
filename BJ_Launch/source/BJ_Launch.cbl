      *begin {iscobol}compiler-directives
      *end {iscobol}compiler-directives
      *begin {iscobol}prog-comment
      *BJ_Launch.cbl
      *BJ_Launch.cbl is generated from C:\BJTEST\BJ_Launch\screen\BJ_Launch.isp
      *end {iscobol}prog-comment
       identification division.
      *begin {iscobol}progid
       program-id. BJ_Launch.
       author. user.
       remarks.
      *end {iscobol}progid
       environment division.
       configuration section.
       special-names.
      *begin {iscobol}activex-def
      *end {iscobol}activex-def
      *begin {iscobol}alphabet
      *end {iscobol}alphabet
      *begin {iscobol}decimal-point
      *end {iscobol}decimal-point
       repository.
      *begin {iscobol}repository
      *end {iscobol}repository
       input-output section.
       file-control.
      *begin {iscobol}file-control
      *end {iscobol}file-control
       data division.
       file section.
      *begin {iscobol}file-section
      *end {iscobol}file-section
       working-storage section.
      *begin {iscobol}is-def
       copy "isgui.def".
       copy "iscobol.def".
       copy "iscrt.def".
       copy "isfonts.def".
       copy "isresize.def".
       copy "ismsg.def".
      *end {iscobol}is-def
      *begin {iscobol}copy-working
       77 key-status is special-names crt status pic 9(4) value 0.
          88 exit-pushed value 27.
          88 message-received value 95.
          88 event-occurred value 96.
          88 screen-no-input-field value 97.
          88 screen-time-out value 99.
       77 quit-mode-flag pic s9(5) comp-4 value 0.
       77 window-handle handle of window.
       77 screen-1-ef-1-val pic x(60).
       77 screen-1-ef-6-val pic x(60).
       77 screen-1-ef-2-val pic x(20).
       77 screen-1-ef-3-val pic x(20).
       77 screen-1-ef-4-val pic x(20).
       77 screen-1-ef-5-val pic x(60).
       77 screen-1-ef-7-val pic x(60).
      *start working-storage editor code
       COPY "isopensave.def".
       77 opensave-status pic S9.
       77 my-cur-dir        pic x(128).
       77 my-editor-path    pic x(128).
       77 my-selected-fpath pic x(128).
       77 my-selected-fname pic x(128).
       77 my-selected-dir   pic x(128).
       77 my-log-file       pic x(128).
       77 my-default-cfg    pic x(128).
       77 my-additional-cfg pic x(128). 
       77 my-wk-fname       pic x(256).
       77 w-dummy           pic x(50).  
       01 my-row            pic 999.
       01 my-cnt            pic 999.  
       01 cmd-line          pic x(512). 
       01 flags             pic x(2) comp-x.
       01 exit-status       pic x(2) comp-x.
       01 KEY-PRESSED       pic X.
       01 SELECTED          pic 9(3).
       01 listdirHandle     usage handle. 
      *end working-storage editor code
      *end {iscobol}copy-working
      *begin {iscobol}external-definitions
      *end {iscobol}external-definitions
      *begin {iscobol}copy-local
      *end {iscobol}copy-local
       linkage section.
      *begin {iscobol}copy-linkage
      *end {iscobol}copy-linkage
       screen section.
      *begin {iscobol}copy-screen
       01 screen-1
       .
          03 screen-1-la-1 Label
             line 8.2
             column 2.2
             size 22.2 cells 
             lines 2.9 cells 
             id 1
             title "Current Working directory"
             .
          03 screen-1-ef-1 Entry-Field
             line 8.2
             column 27.3
             size 48.8 cells 
             lines 3.0 cells 
             id 2
             3-d
             read-only
             value screen-1-ef-1-val
             .
          03 screen-1-gr-1 Grid
             line 21.2
             column 2.4
             size 22.2 cells 
             lines 41.5 cells 
             id 3
             event-list ( msg-goto-cell-mouse )
             event procedure screen-1-gr-1-evt-proc
             boxed
             column-headings
             vscroll
             row-dividers 1
             heading-background-color rgb x#f3c0a7 
             heading-foreground-color rgb x#000000
             cursor-frame-width 3
             num-col-headings 1
             num-rows 15
             selection-mode 9
             row-selected-background-color rgb x#9cf145
             .
          03 screen-1-la-2 Label
             line 26.5
             column 27.5
             size 17.3 cells 
             lines 2.7 cells 
             id 4
             title "Selected filename"
             .
          03 screen-1-ef-2 Entry-Field
             line 26.5
             column 47.2
             size 28.4 cells 
             lines 2.8 cells 
             id 5
             3-d
             read-only
             value screen-1-ef-2-val
             .
          03 screen-1-la-3 Label
             line 32.6
             column 27.6
             size 16.1 cells 
             lines 2.9 cells 
             id 6
             title "Default config"
             .
          03 screen-1-ef-3 Entry-Field
             line 32.6
             column 47.3
             size 28.4 cells 
             lines 2.8 cells 
             id 7
             3-d
             value screen-1-ef-3-val
             .
          03 screen-1-la-4 Label
             line 38.4
             column 27.6
             size 19.2 cells 
             lines 2.4 cells 
             id 8
             title "Additional config"
             .
          03 screen-1-ef-4 Entry-Field
             line 38.4
             column 47.3
             size 28.4 cells 
             lines 2.8 cells 
             id 9
             3-d
             value screen-1-ef-4-val
             .
          03 screen-1-la-5 Label
             line 45.4
             column 27.8
             size 16.4 cells 
             lines 2.4 cells 
             id 10
             title "Execution log file"
             .
          03 screen-1-ef-5 Entry-Field
             line 45.4
             column 47.5
             size 28.4 cells 
             lines 2.8 cells 
             id 11
             3-d
             read-only
             value screen-1-ef-5-val
             .
          03 screen-1-pb-1 Push-Button
             exception-value 1
             line 19.8
             column 27.7
             size 25.5 cells 
             lines 2.9 cells 
             id 12
             title "SetJCLs by C$OpenSB"
             .
          03 screen-1-pb-2 Push-Button
             exception-value 5
             line 26.5
             column 77.7
             size 6.8 cells 
             lines 3.1 cells 
             id 13
             title "View"
             .
          03 screen-1-pb-3 Push-Button
             exception-value 6
             line 32.6
             column 77.8
             size 6.8 cells 
             lines 3.1 cells 
             id 14
             title "View"
             .
          03 screen-1-pb-4 Push-Button
             exception-value 7
             line 38.4
             column 77.8
             size 6.8 cells 
             lines 3.1 cells 
             id 15
             title "View"
             .
          03 screen-1-pb-5 Push-Button
             exception-value 8
             line 45.4
             column 78.0
             size 6.8 cells 
             lines 3.1 cells 
             id 16
             title "View"
             .
          03 screen-1-pb-6 Push-Button
             exception-value 3
             line 52.9
             column 39.5
             size 10.4 cells 
             lines 2.9 cells 
             id 17
             title "Run JCL"
             .
          03 screen-1-pb-7 Push-Button
             exception-value 27
             line 53.1
             column 66.6
             size 10.4 cells 
             lines 2.9 cells 
             id 18
             title "Exit"
             .
          03 screen-1-la-6 Label
             line 59.1
             column 27.5
             size 10.1 cells 
             lines 2.5 cells 
             id 19
             title "End status"
             .
          03 screen-1-pb-8 Push-Button
             line 1.8
             column 24.4
             size 44.5 cells 
             lines 4.6 cells 
             id 21
             title "BJ LAUNCHER"
             .
          03 screen-1-la-8 Label
             line 13.8
             column 2.4
             size 20.0 cells 
             lines 3.4 cells 
             id 22
             title "Current JCL folder"
             .
          03 screen-1-ef-6 Entry-Field
             line 13.8
             column 27.3
             size 48.8 cells 
             lines 3.0 cells 
             id 23
             3-d
             read-only
             value screen-1-ef-6-val
             .
          03 screen-1-ef-7 Entry-Field
             line 59.1
             column 40.4
             size 38.7 cells 
             lines 2.5 cells 
             id 20
             3-d
             read-only
             value screen-1-ef-7-val
             .
          03 screen-1-pb-9 Push-Button
             exception-value 2
             line 19.8
             column 56.3
             size 23.4 cells 
             lines 2.9 cells 
             id 24
             title "Set JCLs by C$LIST"
             .
          03 screen-1-pb-10 Push-Button
             exception-value 17
             line 38.7
             column 86.5
             size 5.9 cells 
             lines 2.5 cells 
             id 25
             title "Set"
             .
      *end {iscobol}copy-screen
      *begin {iscobol}procedure-using
       procedure division.
      *end {iscobol}procedure-using
      *begin {iscobol}declarative
      *end {iscobol}declarative
       main-logic.
      *begin {iscobol}entry-bef-prog
      *end {iscobol}entry-bef-prog
      *begin {iscobol}initial-routines
           perform is-initial-routine
      *end {iscobol}initial-routines
      *begin {iscobol}run-main-screen
           perform is-screen-1-routine
      *end {iscobol}run-main-screen
      *begin {iscobol}exit-routines
           perform is-exit-rtn.
      *end {iscobol}exit-routines
      *begin {iscobol}copy-procedure
       copy "ismsg.cpy".
       is-initial-routine.
           accept system-information from system-info.
           accept terminal-abilities from terminal-info.
       is-exit-rtn.
           exit program.
           stop run.
       is-screen-1-routine.
           perform is-screen-1-scrn
           perform is-screen-1-proc.
       is-screen-1-scrn.
           perform is-screen-1-create
           perform is-screen-1-init-data.
       is-screen-1-create.
           display standard window background-low
              screen line 41
              screen column 91
              size 95.0
              lines 64.3
              cell width 10
              cell height 10
              label-offset 20
              color 257
              modeless
              title-bar
              no wrap
              title "Screen"
              event procedure screen-1-gr-1-evt-proc
              handle window-handle
           .
           display screen-1.
       is-screen-1-init-data.
           perform is-screen-1-gr-1-content.
           perform screen-1-aft-init-data.
       is-screen-1-gr-1-content.
           modify screen-1-gr-1
              column-dividers ( 1 1 )
              data-columns ( 1 4 )
              display-columns ( 1 6 )
              separation ( 5 5 )
              alignment ( "U" "U" )
              data-types ( "9" "X" )
           .
           modify screen-1-gr-1 x = 1
              column-protection 1
           .
           modify screen-1-gr-1 x = 2
              column-protection 1
           .
       is-screen-1-proc.
           perform until exit-pushed
              accept screen-1 on exception 
                 perform is-screen-1-evaluate-func
              end-accept
           end-perform.
           destroy window-handle.
           initialize key-status.
       is-screen-1-evaluate-func.
           evaluate true
           when exit-pushed
              perform is-screen-1-exit
           when event-occurred
              if event-type = msg-close
                 perform is-screen-1-exit
              end-if
           when key-status = 1
              perform screen-1-pb-1-link-to
           when key-status = 5
              perform screen-1-pb-2-link-to
           when key-status = 6
              perform screen-1-pb-3-link-to
           when key-status = 7
              perform screen-1-pb-4-link-to
           when key-status = 8
              perform screen-1-pb-5-link-to
           when key-status = 3
              perform screen-1-pb-6-link-to
           when key-status = 2
              perform screen-1-pb-9-link-to
           when key-status = 17
              perform screen-1-pb-10-link-to
           end-evaluate.
           move 1 to accept-control.
       is-screen-1-exit.
           set exit-pushed to true.
       is-screen-1-event-extra.
           evaluate event-type
           when msg-close
              perform is-screen-1-msg-close
           end-evaluate.
       is-screen-1-msg-close.
           accept quit-mode-flag from environment "quit_mode".
           if quit-mode-flag = 0
              perform is-screen-1-exit
              perform is-exit-rtn
           end-if.
       screen-1-gr-1-evt-proc.
           evaluate event-control-id
           when 3
              evaluate event-type
              when msg-goto-cell-mouse
                 perform screen-1-gr-1-evt-msg-goto-cell-mouse
              when other
              end-evaluate
              exit paragraph
           end-evaluate
           perform is-screen-1-event-extra.
           evaluate event-type
           when other

           .
      *start event editor code
       screen-1-aft-init-data.
           accept system-information from system-info.
           CALL "C$OPENSAVEBOX" USING OPENSAVE-SUPPORTED
                               GIVING opensave-status
                               .
           accept terminal-abilities from terminal-info.
           move space to my-cur-dir
           call "C$CHDIR" using my-cur-dir.
           modify screen-1-ef-1 value my-cur-dir
      *     
           move space to my-selected-dir
           string my-cur-dir    delimited by space
                  "\JCL"        delimited by size
                  into my-selected-dir
           modify screen-1-ef-6 value my-selected-dir
      *     
           move space to my-default-cfg
           string "CONFIG\usercfg.txt"  delimited by size
                  into my-default-cfg
           modify screen-1-ef-3 value my-default-cfg
      *    
           move space to my-editor-path
           accept my-editor-path from configuration "BJ_LAUNCH_EDITOR".
      *     
           modify screen-1-gr-1 x = 1, Y= 1, cell-data = "No"
           modify screen-1-gr-1 x = 2, Y= 1, cell-data = "fname"
                       
           .
       screen-1-pb-1-link-to.
           initialize opensave-data
           move "Choose a file" to opnsav-title
           move "c:\BJTEST\" to opnsav-default-dir
           move "JCL files (*.jcl)|*.jcl"
                                to opnsav-filters

           call "C$OPENSAVEBOX" using opensave-open-box-multi, 
                                      opensave-data
                               giving opensave-status

           if opensave-status > 0
              move opnsav-filename to my-selected-fpath
              perform varying my-row from 2 by 1 
                      until opensave-status = -1
                 unstring opnsav-filename delimited by 
                                                      "\JCL\" or "\jcl\"
                      into w-dummy my-selected-fname
                 compute my-cnt = my-row - 1
                 modify screen-1-gr-1 x = 1, y = my-row 
                        cell-data = my-cnt
                 modify screen-1-gr-1 x = 2, y = my-row
                        cell-data = my-selected-fname
                 initialize opensave-data
                 call "C$OPENSAVEBOX" using opensave-next
                                            opensave-data
                                      giving opensave-status
              end-perform
           end-if
           .
            
           .
       screen-1-pb-6-link-to.
           move space to cmd-line.
           string "jcl\"                  delimited by size
                  my-selected-fname       delimited by space
                  into cmd-line.
           call   "BJ_JCL" using cmd-line.
           cancel "BJ_JCL".
           SET CONFIGURATION "BJ_JCL_BTACH"   TO SPACE.
           SET CONFIGURATION "BJ_JOBID"       TO SPACE
           SET CONFIGURATION "BJ_JOBLG_FNAME" TO SPACE 
            
           .
       screen-1-pb-2-link-to.
           move space to cmd-line.
           string my-editor-path       delimited by space
                  " jcl\"              delimited by size
                   my-selected-fname   delimited by space
                   into cmd-line 
           move H"0006" to FLAGS 
           call "BJ_CSYS" using cmd-line FLAGS EXIT-STATUS
                   
           .
       screen-1-pb-3-link-to.
           move space to cmd-line.
           string  my-editor-path      delimited by space
                   " "                 delimited by size
                   my-default-cfg      delimited by space
                   into cmd-line 
           move H"0006" to FLAGS 
           call "BJ_CSYS" using cmd-line FLAGS EXIT-STATUS
            
           .
       screen-1-pb-4-link-to.
           inquire screen-1-ef-4 value my-additional-cfg
           move space to cmd-line.
           string my-editor-path        delimited by space
                  " "                   delimited by size
                  my-additional-cfg     delimited by space
                   into cmd-line 
           move H"0006" to FLAGS 
           call "BJ_CSYS" using cmd-line FLAGS EXIT-STATUS
            
           .
       screen-1-pb-5-link-to.
           move space to cmd-line.
           string my-editor-path   delimited by space
                  " "              delimited by size
                  my-log-file      delimited by space
                   into cmd-line 
           move H"0006" to FLAGS 
           call "BJ_CSYS" using cmd-line FLAGS EXIT-STATUS
           .

       screen-1-gr-1-evt-msg-goto-cell-mouse.
           inquire screen-1-gr-1 entry-reason key-pressed
           if key-pressed = grer-enter or
              key-pressed = grer-dblclick
              move event-data-2 to selected
           end-if
           if selected > 0
              inquire screen-1-gr-1(selected, 2) 
                      cell-data my-selected-fname
           end-if
           modify screen-1-ef-2 value my-selected-fname
           move 1 to screen-control
           move space to my-log-file
           string "LOG\"               delimited by size
                  my-selected-fname    delimited by space
                  into my-log-file
           inspect my-log-file replacing all ".jcl" by ".log".
           modify screen-1-ef-5 value my-log-file
           
            
           .
       screen-1-pb-9-link-to.
           CALL "C$LIST-DIRECTORY" using  LISTDIR-OPEN, 
                                          my-selected-dir, "*"
                                   giving listdirHandle
           if listdirHandle not = 0
              move 0 to my-cnt
              perform until exit
                 CALL "C$LIST-DIRECTORY" using LISTDIR-NEXT
                                               listdirHandle
                                               my-selected-fname
                                               listdir-file-information
                 if my-selected-fname = spaces
                    exit perform
                 end-if  
                 if listdir-file-type not = "D"
                    add 1 to my-cnt
                    compute my-row = my-cnt + 1
                    modify screen-1-gr-1 x = 1, y = my-row 
                        cell-data = my-cnt
                    modify screen-1-gr-1 x = 2, y = my-row
                        cell-data = my-selected-fname                    
                 end-if                 
              end-perform
              CALL "C$LIST-DIRECTORY" using LISTDIR-CLOSE, listdirHandle
           end-if            
           .
       screen-1-pb-10-link-to.
           inquire screen-1-ef-4 value my-additional-cfg
           call "BJ_CFGSET" using  my-additional-cfg, w-dummy.
           if return-code = -1
              modify screen-1-ef-7 value w-dummy 
           end-if.
           .
      *end event editor code
      *end {iscobol}copy-procedure
       report-composer section.
      *begin {iscobol}external-copyfiles
      *end {iscobol}external-copyfiles

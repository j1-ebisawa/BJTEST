identification division.
program-id. UQ_PANAL.
environment              division.
configuration            section.
special-names.
/
input-output             section.
file-control.
      select     param-file    assign  to    param-filenm
                               organization  is  line sequential
                               access  mode  is  sequential
                               file  status  is  param-file-status.
/
data                         division.
file                         section.
fd  param-file.
01  param-rec                pic x(200).

********************************************************************************
working-storage              section.
copy "SYSTEMINFO.DEF".
copy "BJ_FC78.CPY".
01  WK-BATCH-CONV            PIC X VALUE "Y".
    88 BATCH-MODE                  VALUE "Y".
    88 CONV-MODE                   VALUE " ".
01  WK-AJ-FUTIL-DIR          pic x(80).
01  WK-FL-DEL                pic x.
01  param-filenm             pic x(256).
01  param-file-status        pic x(02).
01  work-filenm              pic x(256).
01  work-filenm2             pic x(256).
01  end-sw                   pic 9.
01  INF-VAR-FLG              PIC 9. 
01  CONFIG-VAR-RDW           PIC X. 
01  CFG-OFRECL-INHERIT-IF    PIC X. 

01  string-filenm-sw         pic 999.
01  pre-read                 pic 9.
01  para-end                 pic 9.
01  wk-param.
    03  wk-para1             pic x(256).  
    03  wk-para30            pic x(9743).  
78  wk-param-l-max           value 9998.   
01  wk-param-l               pic s9(4) comp.
01  wk-literal-spos          pic s9(4) comp.
***
01  wk-col                   pic s9(4) comp.
01  wk-col-save              pic s9(4) comp.
01  wk-i                     pic s9(4) comp.
01  wk-k                     pic s9(4) comp.
01  wk-ll                    pic s9(4) comp.
01  wk-pp                    pic s9(4) comp.
01  wk-qq                    pic s9(4) comp.
01  wk-ss                    pic s9(4) comp.
01  wk-num                   pic s9(18) comp.
01  wk-sign                  pic s9(4) comp.
01  wk-tally                 pic 999.  
01  wk-tally-save            pic 999.  
01  WK-SEDAI                 pic 99.   
01  wk-char                  pic x(18). 
01  wk-char80                pic x(80).      
01  wk-num-sign              pic x.
01  wk-del                   pic x.
01  wk-redeifne.
    03  wk-x                 pic x.
    03  wk-n redefines       wk-x pic 9.
01  left-brct-nest           pic 9.
*
01  WK-CNT                   PIC 9(03). 
01  wk-inf-ctr               pic 9999.
01  wk-aj-logsup             pic x(6).   
01  WK-JCLNAME               PIC X(50).   
01  WK-JCL-SCAN              PIC X VALUE " ".   
01  WK-RECL-ZERO             PIC X VALUE " ".   
01  wk-select-omit           pic x. 
*
01  wk-cnt-flchk             pic 9(03).      
01  WK-MAX-IN-RECL           pic x(02) comp-x.
01  SV-RETURN-CODE           PIC S9(9) COMP-5.
01  sort-utility             pic x(8). 
01  WK-DEFAULT-TEXT-RECL     pic x(02) comp-x. 
01  WK-PAN3-OLD-CONTINUE     PIC X. 
01  wk-mod-opt.
    03  wk-dlt-in            pic 9(01).
    03  wk-lck-in            pic 9(01).
*----エラーコード領域
 01    FL--STS-IN.
   03  FL--STS-I1      PIC X(1).
   03  FL--STS-I2      PIC X COMP-X.
 01    FL--STS-OT.
   03  FL--STS-O1      PIC X(1).
   03  FL--STS-FL      PIC X(1) VALUE "/".
   03  FL--STS-O2      PIC 999.
01  MSG-OUT-NO          PIC 9(3).
01  MSG-OUT-SAVE        PIC 9(3).
01  MSG-EDIT            PIC X(256).
01  MSG-EDIT-FNAME      PIC X(256).
01  MSG-EDIT-L          PIC XX COMP-X. 
01  MSG-COL             PIC S9(4) COMP.
*********LOG-PARAM************************  
01    log-param.       
    05 f-code           pic x.    
    05 log-txt          pic x(200). 
 01    WK-AJ-JCLSCAN   PIC X.   
 01    WK-AJ-FILECHK   PIC X.   
 01    WK-AJ-DEBUG     PIC X.   
linkage section.
    copy "BJ_FINFO.CPY" replacing =='BJf'== by ==bjf-f1==.
    copy "BJ_FINFO.CPY" replacing =='BJf'== by ==bjf-f2==.
*
    copy "BJ_FINFO.CPY" replacing =='BJf'== by ==bjf-fn==.

/
procedure  division  using     bjf-f1-file-info
                               bjf-f2-file-info.  
declaratives.
param-file-err section.
           use after standard error procedure on param-file.
           move param-file-status to FL--STS-IN.    
           perform FL-STS-CONV.  
           string  "パラメタファイルエラー："   delimited by size
                   FL--STS-OT                   delimited by size
                   " "                          delimited by size
                   param-filenm                 delimited by space
                   into MSG-EDIT                 
           move 402 to MSG-OUT-NO. 
           perform MESSAGE-OUT-SUB.
           move -1 to return-code.
           exit program.
end declaratives.
house-keep section.
prog-start.
     perform init-prc.
     perform anal-prc.
     perform end-proc.
prog-end.
     exit program.
***********************
init-prc section.
***********************
init-prc-01.
     move 303 to MSG-OUT-NO.  *>303:パラメタ構文エラー 
     move space to wk-aj-logsup. 
     DISPLAY "BJ_JCL_LOGSUP" UPON ENVIRONMENT-NAME
     ACCEPT wk-aj-logsup     FROM ENVIRONMENT-VALUE .
*
*
     move space to WK-PAN3-OLD-CONTINUE.
     display "BJF_PAN3_OLD_CONTINUE"     upon environment-name. 
     accept   WK-PAN3-OLD-CONTINUE       from environment-value. 
*
    ACCEPT  SYSTEM-INFORMATION  FROM SYSTEM-INFO.
    IF OS-IS-UNIX
           MOVE "/" TO WK-FL-DEL
       ELSE
           MOVE "\" TO WK-FL-DEL
    END-IF.
    ACCEPT WK-AJ-FUTIL-DIR FROM ENVIRONMENT "BJ_FUTIL_DIR".
*
    MOVE SPACE TO WK-AJ-JCLSCAN   
    DISPLAY "BJ_JCL_JCLSCAN"  UPON ENVIRONMENT-NAME.  
    ACCEPT  WK-AJ-JCLSCAN     FROM ENVIRONMENT-VALUE. 
    IF WK-AJ-JCLSCAN = "y"            
        MOVE "Y" TO WK-AJ-JCLSCAN     
    END-IF.                           
*
    accept work-filenm from environment "BJ_JCL_PARAM"
    if     work-filenm = space
           go to param-file-missing-err
    end-if
    move work-filenm to param-filenm
    open input param-file
*
    move 0    to end-sw.
    move 0    to pre-read.
    move 0    to para-end.
*
   initialize wk-mod-opt. 
***********************
end-proc section.
***********************
end-prc-01.
    close param-file.
***********************
anal-prc section.
***********************
anal-prc-01.
    perform  param-read.
    perform  until end-sw = 1
       perform param-anal
       perform param-read
    end-perform.

***********************
param-read section.
***********************
param-read-01.
param-read-01-1.
    if   para-end = 1
         move param-rec  to wk-param
         move 1          to end-sw
         go to param-read-exit.
    if   pre-read = 1
         move param-rec  to wk-param
         move 0          to pre-read
         go to param-read-02.
*   First READ
    move space  to param-rec.
    read param-file
         at end
                  move 1  to para-end
                  move 1  to end-sw
                  go to param-read-exit.
    move param-rec   to wk-param.
param-read-02.
    perform varying wk-qq from wk-param-l-max by -1         
            until wk-qq < 2 or wk-param(wk-qq:1) not = " "  
    end-perform.         
*   NEXT READ
param-read-02-0.
    move space  to param-rec.
    read param-file
         at end
                  move 1  to para-end
                  go to param-read-exit.
param-read-02-1.
    if WK-PAN3-OLD-CONTINUE = "Y"                              
       if param-rec(1:4) not = space    go to param-read-02-2  
       end-if                                                  
    else                                                       
       if wk-param(wk-qq:1) not = ","   go to param-read-02-2  
       end-if                                                  
    end-if.                                                    
    add   1  to    wk-qq 
    compute wk-ll = wk-param-l-max - wk-qq + 1      
    if wk-ll < 1   move 329 to MSG-OUT-NO           
                   go to param-anal-err             
    end-if.                                         
    perform varying wk-ss from 1 by 1                          
                until wk-ss > 200 or param-rec(wk-ss:1) not = " "  
    end-perform                                                
    if wk-ss > 200 go to param-anal-err                        
    end-if                                                     
    perform varying wk-pp from 200 by -1                       
            until wk-pp < 1 or  param-rec(wk-pp:1) not = space 
    end-perform                                      
    compute wk-pp = wk-pp - wk-ss + 1               
    if wk-pp > wk-ll move 329 to MSG-OUT-NO        
                     go to param-anal-err           
    end-if                                          
    move param-rec(wk-ss:wk-pp) to wk-param(wk-qq:wk-ll)  
    go to param-read-02.
    
param-read-02-2.
    move  1   to pre-read.
param-read-exit.
    exit.
**************************************
*  parameter analize                 *
**************************************
param-anal section.
anal-01.
    move  wk-param-l-max      to wk-param-l.  
    perform   varying wk-i    from 1    by 1
              until   wk-i > wk-param-l-max        or 
                      wk-param(wk-param-l:1) not = space
         subtract  1  from wk-param-l
         if  wk-param-l < 1  go to param-anal-err 
         end-if
    end-perform.
    perform   varying wk-qq from 1 by 1     
              until   wk-qq > wk-param-l or 
                      wk-param(wk-qq:1) not = " "
    end-perform.
anal-02.
    evaluate true
       when  wk-param(wk-qq:3) = "F1="  or "f1=" 
             set address of bjf-fn-file-info to address of bjf-f1-file-info
             perform fn-param-anal
       when  wk-param(wk-qq:3) = "F2="  or "f2=" 
             set address of bjf-fn-file-info to address of bjf-f2-file-info
             perform fn-param-anal
       when  other
             move 302 TO MSG-OUT-NO    *>302:キーワードパラメタ誤り
             go to param-anal-err      
     end-evaluate.
anal-exit.
     exit.

**************************************
fn-param-anal section.
**************************************
fn-anal-01.
*
         move  all X"00" to    bjf-fn-file-info.
         move     0      to    bjf-fn-file-org.
         move     0      to    bjf-fn-file-opmode.
         move     0      to    bjf-fn-file-disp-lock.  
         move     0      to    bjf-fn-file-disp-addrep.
         move     0      to    bjf-fn-file-disp-dlt.   
         move     0      to    bjf-fn-file-disp-rotate.
         move     "00"   to    bjf-fn-file-sts.
         move     0      to    bjf-fn-max-rec-size.
         move     0      to    bjf-fn-min-rec-size.
         move     space  to    bjf-fn-file-name.

         compute wk-col = wk-qq + 3.
         move  zero  to wk-dlt-in.  
         move  zero  to wk-lck-in.  
fn-anal-02.
         unstring wk-param delimited by "(" or " " 
                  into         wk-char
                  delimiter in wk-del
                  with pointer wk-col.
         if wk-del not = "("         go to param-anal-err. 
         if wk-char not = space      go to param-anal-err.  
fn-anal-03.
*  Fn=filename
         unstring wk-param delimited by "=" or " "
                  into wk-char
                  delimiter in wk-del
                  with pointer wk-col.
         if wk-del not = "="         go to param-anal-err.
         if wk-char    = "FN" or "fn"  next sentence
                  else               go to param-anal-err.

         unstring wk-param delimited by "," or ")" or " " 
                  into work-filenm
                  delimiter in wk-del
                  with pointer wk-col.
         if wk-del  = "," or ")"      next sentence
                  else                go to param-anal-err.                                       
*
         perform file-name-check
         if  string-filenm-sw = 1
               move    work-filenm to bjf-fn-file-name
             else
               string  wk-aj-futil-dir delimited by " "
                       wk-fl-del       delimited by size
                       work-filenm     delimited by " "
                       into bjf-fn-file-name
         end-if.
         move bjf-file-org-seq  to bjf-fn-file-org
         if wk-del = ")"              go to fn-anal-05.
fn-anal-04.
*  next option
         unstring wk-param delimited by "=" or " " 
                  into wk-char
                  delimiter in wk-del
                  with pointer wk-col.
         if wk-del not = "="            go to param-anal-err.

         if wk-char = "ORG"  or "org"   go to fn-anal-org.
         if wk-char = "RECL" or "recl"  go to fn-anal-recl.
         if wk-char = "MOD"  or "mod"   go to fn-anal-mod. 
         go to param-anal-err.
fn-anal-org.
*  ORG={Seq*>Txt*>Rel*>Idx}
         unstring wk-param delimited by "," or ")" or " " 
                  into wk-char
                  delimiter in wk-del
                  with pointer wk-col.
         if wk-del  = "," or ")"      next sentence
                  else                go to param-anal-err.
         call "CBL_TOUPPER" using wk-char value 10.
         evaluate true
            when  wk-char = "S" or "SEQ"
                     move bjf-file-org-seq   to bjf-fn-file-org
            when  wk-char = "T" or "TXT"
                     move bjf-file-org-txt  to  bjf-fn-file-org
            when  wk-char = "R" or "REL"
                     move bjf-file-org-rel  to  bjf-fn-file-org
            when  wk-char = "I" or "IDX"
                     move bjf-file-org-idx  to  bjf-fn-file-org
            when  other
                     go to param-anal-err
         end-evaluate.
         if wk-del = ")"              go to fn-anal-05.
         go to fn-anal-04.
fn-anal-recl.
* RECL=l1[,l2]
         unstring wk-param delimited by "," or ")" or " " 
                  into wk-char
                  delimiter in wk-del
                  with pointer wk-col.
         if wk-del  = "," or ")"      next sentence
                  else                go to param-anal-err.
         if wk-char = space move 0 to wk-num    
         else         perform char-num-conv.    
         move  wk-num  to bjf-fn-max-rec-size.
         move  wk-num  to bjf-fn-min-rec-size.
         if wk-del = ")"              go to fn-anal-05.

         move wk-col to wk-col-save.       
         unstring wk-param delimited by "," or ")" or " " 
                  into wk-char
                  delimiter in wk-del
                  with pointer wk-col.
         if wk-del  = "," or ")"      next sentence
                  else                go to param-anal-err.
         if wk-char(1:4) = "MOD="        
            move wk-col-save to wk-col   
            go to fn-anal-04              
         end-if.           
         perform char-num-conv.
         if wk-num < bjf-fn-min-rec-size                    
                 go to param-anal-err                       
         end-if.                                            
         move  wk-num  to bjf-fn-max-rec-size.
         if bjf-fn-max-rec-size not = bjf-fn-min-rec-size
            move 1 to INF-VAR-FLG                
         end-if.                     
         if wk-del not = ")"          go to fn-anal-04.
         go to fn-anal-05.          
fn-anal-mod.                                               
* MOD=LOCK,DLT                                             
         perform until 1 = 0                               
           unstring wk-param delimited by "," or ")" or " "  
                  into wk-char                             
                  delimiter in wk-del                      
                  with pointer wk-col                      
           if wk-del  = "," or ")"      continue  
                  else                go to param-anal-err 
           end-if                                          
           call "CBL_TOUPPER" using wk-char value 10         
           evaluate true                                   
              when  wk-char = "LOCK"                       
                    move 1 to bjf-fn-file-disp-lock        
                    if wk-lck-in not = 0       
                        go to param-anal-err   
                    end-if                     
                    move 1 to wk-lck-in        
              when  wk-char = "SHR"            
                    if wk-lck-in not = 0       
                        go to param-anal-err   
                    end-if                     
                    move 1 to wk-lck-in        
              when  wk-char = "DLT"                        
                    if wk-dlt-in  not = 0      
                        go to param-anal-err   
                    end-if                     
                    move 1 to bjf-fn-file-disp-dlt         
                    move 1 to wk-dlt-in   
              when  wk-char = "DLTN"       
                    if wk-dlt-in  not = 0      
                        go to param-anal-err   
                    end-if                     
                    move 2 to bjf-fn-file-disp-dlt  
                    move 1 to wk-dlt-in     
              when  wk-char = "DLTA"       
                    if wk-dlt-in  not = 0      
                        go to param-anal-err   
                    end-if                     
                    move 3 to bjf-fn-file-disp-dlt 
                    move 1 to wk-dlt-in  
              when other                                   
                    go to param-anal-err                   
           end-evaluate                                    
           if wk-del = ")"                                 
              exit perform                                 
           end-if                                          
         end-perform.                                      
fn-anal-05.
         if bjf-fn-min-rec-size = 0 and                   
            bjf-fn-max-rec-size = 0 and                   
            bjf-fn-file-org = bjf-file-org-txt            
            move WK-DEFAULT-TEXT-RECL to                
                 bjf-fn-max-rec-size                    
         end-if.                                        
         if bjf-fn-min-rec-size = 0 and                 
            bjf-fn-max-rec-size = 0                     
            evaluate true                               
              when bjf-fn-file-org =  bjf-file-org-idx  
                   continue                             
              when WK-RECL-ZERO = "Y"                   
                   continue                             
              when other                                
                   move 314 to MSG-OUT-NO               
                   go to param-anal-err            *>レコードサイズがゼロ
            end-evaluate                                
         end-if.                                        
         if wk-col <= wk-param-l and              
            wk-param(wk-col:) not = space            
                                go to param-anal-err 
         end-if.    
fn-anal-exit.
         exit.
         
***************************************************
file-name-check section.
***************************************************
file-name-check-01.
         move 0 to string-filenm-sw.
         inspect work-filenm tallying
                             string-filenm-sw for all ":".
         if      string-filenm-sw not = 0
                       move 1    to  string-filenm-sw 
                       go to file-name-check-exit.
         if work-filenm(1:1) = "." and
            work-filenm(2:1) = wk-fl-del
                       move 1    to  string-filenm-sw
                       go to file-name-check-exit.
         if work-filenm(1:1) = "." and               
            work-filenm(2:1) = "." and               
            work-filenm(3:1) = wk-fl-del             
                       move 1    to  string-filenm-sw
                       go to file-name-check-exit.   
         if      wk-aj-futil-dir = space
                       move 1    to  string-filenm-sw
                       go to file-name-check-exit.
         if      work-filenm(1:1) = wk-fl-del or "$" 
                 move  1    to  string-filenm-sw.
         
file-name-check-exit.
         exit.
****************************************************
misc-subroutine section.
****************************************************
***********************
 char-num-conv.
***********************
          if wk-char = space go to param-anal-err  
          end-if.                                  
          move 0 to wk-num.
          move 1 to wk-sign.          
          evaluate wk-char(1:1)       
            when  "-"  move -1 to wk-sign   
                       move 2  to wk-i
            when  "+"  move 2  to wk-i
            when other move 1  to wk-i
          end-evaluate.               
          perform until (wk-char(wk-i:1) = space or
                          wk-i > 18)          
             move wk-char(wk-i:1) to wk-x
             if wk-x > "9" or wk-x < "0"
                  go to param-anal-err
             end-if
             compute wk-num = wk-num * 10 + wk-n
             add 1 to wk-i
          end-perform.
          compute wk-num = wk-num * wk-sign.       
**************************************************
error-handling  section.
**************************************************
FL-STS-CONV.
     evaluate FL--STS-I1
       when "9"
            move FL--STS-I1 to FL--STS-O1
            move "/"        to FL--STS-FL
            move FL--STS-I2 to FL--STS-O2
       when other
            move FL--STS-IN to FL--STS-OT
     end-evaluate.
************************
param-file-missing-err.
************************
         move 401 to MSG-OUT-NO.  *>401 parameter file missing 
         string "パラメタファイルなし：" delimited by size
                 param-filenm            delimited by space
                 into MSG-EDIT.
         PERFORM MESSAGE-OUT-SUB    
         move -1 to return-code.
         go to exit-pgm.
************************
param-anal-err.
************************
         PERFORM MESSAGE-OUT-RTN
         move -1 to return-code
         go to exit-pgm.
*
**************************
cancel-exit.
**************************
         move -1 to return-code.
**************************
exit-pgm.
**************************
         perform end-proc.
         move -1 to return-code. 
         exit program.
**************************
abort-error section.
**************************
abort-err.
         move -1 to return-code.
abort-goback.
         goback.
**************************
 MESSAGE-OUT-RTN.
**************************
           if   wk-col > wk-param-l
                    move wk-param-l to msg-col
           else     move wk-col     to msg-col
           end-if.
           string "QU_PAN3_"             delimited by size
                  WK-PARAM(1:wk-param-l) delimited by size
                  into MSG-EDIT
           PERFORM MESSAGE-OUT-SUB
           MOVE "QU_PAN3_" TO MSG-EDIT     
           MOVE "↑"  TO MSG-EDIT(msg-col : 2)
           PERFORM MESSAGE-OUT-SUB
*
           MOVE SPACE TO MSG-EDIT.
           EVALUATE MSG-OUT-NO
               WHEN 302
                    move "QU_PAN3_キーワードが誤っています"       to MSG-EDIT
               WHEN 303
                    move "QU_PAN3_パラメタ指定の構文誤り"         to MSG-EDIT
               WHEN 314
                    move "QU_PAN3_レコードサイズの指定が必要です" to MSG-EDIT
               WHEN 329
                    MOVE "QU_PAN3_パラメタ行の継続が長すぎます"   TO MSG-EDIT
           END-EVALUATE.
           PERFORM MESSAGE-OUT-SUB.
**************************
 MESSAGE-OUT-SUB.
**************************
*
           PERFORM VARYING MSG-EDIT-L FROM 256 BY -1
              UNTIL MSG-EDIT-L < 1 OR MSG-EDIT(MSG-EDIT-L:1) NOT = " "
           END-PERFORM.

           MOVE  return-code to SV-RETURN-CODE.
           CALL "BJ_MESSAGE" USING MSG-EDIT(1:MSG-EDIT-L).
           MOVE  SV-RETURN-CODE to return-code.

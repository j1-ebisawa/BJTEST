identification division.
program-id. QU_FCOMP.
environment              division.
configuration            section.
/
data                     division.
/
working-storage          section.
copy "BJ_fc78.cpy".

copy "BJ_finfo.cpy" replacing =='BJf'== by ==bjf-f1==.
copy "BJ_finfo.cpy" replacing =='BJf'== by ==bjf-f2==.
copy "BJ_frec.cpy"  replacing =='BJf'== by ==bjf-f1==.
copy "BJ_frec.cpy"  replacing =='BJf'== by ==bjf-f2==.
 01  bjf-f1-file-handle              pointer.
 01  bjf-f2-file-handle              pointer.
 01  bjf-f1-record-ptr               pointer.
 01  bjf-f2-record-ptr               pointer.
 01  bjf-io-function                 pic 9(02) comp-x.
copy "QUTESTID.lks".
********* WORK-DATA **********
01  check-result             pic X(5).
01  f1-cnt                   pic 9(10).
01  f2-cnt                   pic 9(10).
01  wk-L                     pic 9(06).  
*********disp-message************************
01    disp-msg               pic x(256).  
01    disp-msg-l             pic 999.
*----エラーコード領域              
 01    FL--STS      PIC X(7).      
 01    FL--STS-R.                  
   03  FL--STS-N    PIC X(2).      
   03  FL--STS-E    PIC X(5).      
*----エラーメッセージ領域          
 01    FL--TEXT     PIC X(80).     
LINKAGE SECTION.
copy "BJ_finfo.cpy" replacing =='BJf'== by ==bjf-wk==.
/
procedure  division.
prog-start.
     perform init-prc.
     perform compare-prc.
     perform end-proc.
prog-end.
     goback.

***********************
init-prc section.
***********************
init-prc-01.
     move space to disp-msg.
     move space to check-result. 
     set bjf-f1-file-handle to address of bjf-f1-file-info.
     set bjf-f2-file-handle to address of bjf-f2-file-info.
     set bjf-f1-record-ptr  to address of bjf-f1-record-info..
     set bjf-f2-record-ptr  to address of bjf-f2-record-info..

*
     call "QU_PAN3" using BJf-f1-file-info
                          BJf-f2-file-info
     
     if return-code = -1   go to abort-goback.
           move space to QUL-PARAM-ID.
     display "QUTESTID"      upon environment-name.
     accept QUL-PARAM-ID     from environment-value.

***********************
end-proc section.
***********************
end-prc-01.
    if check-result = space
       move "OK!!" to check-result
       move "OK"   to QUL-RES
    else
       move "NG"   to QUL-RES
    end-if.
    move 1 to disp-msg-l.
    string "QU_FCOMP : "   delimited by size
           check-result    delimited by space
           into disp-msg with pointer disp-msg-l.
    call "BJ_DISPLAY" using disp-msg(1:disp-msg-l). 
**
    CALL "QUTESTID" USING "INT"
    CALL "QUTESTID" USING "WRT" 
             QUL-PARAM-ID QUL-RES QUL-COMM1 QUL-RETURNCD.
    CALL "QUTESTID" USING "TRM".

***********************
compare-prc section.
***********************
     perform f1-file-open-prc
     perform f2-file-open-prc.
     
     perform f1-read-prc.
     perform f2-read-prc.
     perform until bjf-f1-file-sts = "10" and
                   bjf-f2-file-sts = "10"
        if   bjf-f1-file-sts not = "00" or
             bjf-f2-file-sts not = "00"
                perform disp-unmatch1
                exit perform
        end-if
        if  bjf-f1-record-size not = bjf-f2-record-size
                perform disp-unmatch3
                exit perform
        end-if
        if  bjf-f1-record-buffer(1:bjf-f1-record-size) not =
            bjf-f2-record-buffer(1:bjf-f2-record-size)
                perform disp-unmatch2
                exit perform
        end-if
        perform f1-read-prc
        perform f2-read-prc
     end-perform
     perform f1-file-close-prc
     perform f2-file-close-prc.
***********************
f1-file-open-prc section.
***********************
     move bjf-open-func   to    bjf-io-function.
     move bjf-file-input  to    bjf-f1-file-opmode.
     call "BJF_IO"        using bjf-io-function
                                bjf-f1-file-handle
                                bjf-f1-record-ptr.
     if   return-code = -1   go to abort-goback.  
     if   bjf-f1-file-sts not = "00"
          perform disp-f1-error
     end-if.
     move 0 to f1-cnt.
***********************
f2-file-open-prc section.
***********************
     move bjf-open-func   to    bjf-io-function
     move bjf-file-input  to    bjf-f2-file-opmode.
     call "BJF_IO"        using bjf-io-function
                                bjf-f2-file-handle
                                bjf-f2-record-ptr
     if   return-code = -1   go to abort-goback.
     if   bjf-f2-file-sts not = "00"
            perform disp-f2-error
     end-if.
     move 0 to f2-cnt.
***********************
f1-read-prc section.
***********************
    move 0     to        bjf-f1-record-size.
    move space to        bjf-f1-record-buffer.
    move bjf-next-func   to    bjf-io-function.
    call "BJF_IO"        using bjf-io-function
                               bjf-f1-file-handle
                               bjf-f1-record-ptr.
    if   return-code = -1   go to abort-goback.
    evaluate bjf-f1-file-sts
     when "00"
        add 1 to f1-cnt
     when "10"
        continue
     when other
        perform disp-f1-error
    end-evaluate.

***********************
f2-read-prc section.
***********************
    move bjf-next-func   to    bjf-io-function
    call "BJF_IO"   using bjf-io-function
                          bjf-f2-file-handle
                          bjf-f2-record-ptr.
    if   return-code = -1   go to abort-goback.
    evaluate bjf-f2-file-sts
     when "00"
        add 1 to f2-cnt
     when "10"
        continue
     when other
        perform disp-f2-error
    end-evaluate.

***********************
f1-file-close-prc section.
***********************
     move bjf-close-func    to    bjf-io-function.
     call "BJF_IO"          using bjf-io-function
                                  bjf-f1-file-handle
                                  bjf-f1-record-ptr.
***********************
f2-file-close-prc section.
***********************
     move bjf-close-func    to    bjf-io-function
     call "BJF_IO"          using bjf-io-function
                                  bjf-f2-file-handle
                                  bjf-f2-record-ptr.

**************************
error-proc section.
**************************
disp-f1-error.
     CALL "C$RERR" USING   FL--STS, FL--TEXT , 1 .  
     if  fl--sts   = "0000"                         
         move   bjf-f1-file-sts    to  FL--STS(1:2) 
     end-if                                         
     move space to disp-msg 
     move 1 to disp-msg-l.                                                            
     string "F1-file-ERROR : "        delimited by size   
           bjf-f1-file-sts            delimited by size   
           " "                        delimited by size   
           bjf-f1-file-name           delimited by space  
           into disp-msg with pointer disp-msg-l.            
     call "BJ_DISPLAY" using disp-msg(1:disp-msg-l). 
     go to abort-goback.                    
     
disp-f2-error.
     CALL "C$RERR" USING   FL--STS, FL--TEXT , 1 .  
     if  fl--sts   = "0000"                         
         move   bjf-f2-file-sts    to  FL--STS(1:2) 
     end-if
     move space to disp-msg .
     move 1 to disp-msg-l.                         
     string "F2-FILE-ERROR : "        delimited by size 
           bjf-f2-file-sts            delimited by size 
           bjf-f2-file-name           delimited by space 
           into disp-msg with pointer disp-msg-l.
     call "BJ_DISPLAY" using disp-msg(1:disp-msg-l).
     go to abort-goback.
 disp-unmatch1.
    move 1 to disp-msg-l.
    string "レコード数不一致："             delimited by size
           "f1-cnt="                   delimited by size
            f1-cnt                     delimited by size
           "  f2-cnt="                 delimited by size
            f2-cnt                     delimited by size
           into disp-msg with pointer disp-msg-l.
    call "BJ_DISPLAY"  using disp-msg(1:disp-msg-l).
    MOVE "NG!!"    to check-result.
 
 disp-unmatch2.
    string "レコード内容不一致："      delimited by size
           into disp-msg.
    call "BJ_DISPLAY"  using disp-msg(1:20).
    move 1 to disp-msg-l.       
    string "f1="                       delimited by size
            bjf-f1-record-buffer(1:bjf-f1-record-size)
                                       delimited by size
            into disp-msg with pointer disp-msg-l.
    call "BJ_DISPLAY"  using disp-msg(1:disp-msg-l).
    move 1 to disp-msg-l.        
    string "f2="                       delimited by size
            bjf-f2-record-buffer(1:bjf-f2-record-size)
                                       delimited by size
           into disp-msg with pointer disp-msg-l.
    call "BJ_DISPLAY"  using disp-msg(1:disp-msg-l).
    move "NG!!"    to check-result.
 disp-unmatch3.
    string "レコード長不一致："      delimited by size
           into disp-msg.
    call "BJ_DISPLAY"  using disp-msg(1:20).
    move bjf-f1-record-size to wk-L.
    move 1 to disp-msg-l.       
    string "f1-recl="                  delimited by size
           wk-L                        delimited by size
           into disp-msg with pointer disp-msg-l.
    call "BJ_DISPLAY"  using disp-msg(1:disp-msg-l).
    move 1 to disp-msg-l.
    string "f1-rec="                   delimited by size       
            bjf-f1-record-buffer(1:bjf-f1-record-size)
                                       delimited by size
            into disp-msg with pointer disp-msg-l.
    call "BJ_DISPLAY"  using disp-msg(1:disp-msg-l).
    move bjf-f2-record-size to wk-L.
    move 1 to disp-msg-l.       
    string "f2-recl="                  delimited by size
           wk-L                        delimited by size
           into disp-msg with pointer disp-msg-l.
    call "BJ_DISPLAY"  using disp-msg(1:disp-msg-l).
    move 1 to disp-msg-l.        
    string "f2-rec="                   delimited by size
            bjf-f2-record-buffer(1:bjf-f2-record-size)
                                       delimited by size
           into disp-msg with pointer disp-msg-l.
    call "BJ_DISPLAY"  using disp-msg(1:disp-msg-l).
    move "NG!!"    to check-result.
     
abort-goback.
     move -1 to return-code,
     goback.

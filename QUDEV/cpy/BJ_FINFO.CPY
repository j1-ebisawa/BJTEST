*--  isTECH Japan File Utility   --------------------------------------*
*       File information area                                          *
*--------------------------------------------------------  22.03.03  --*
 01  'BJf'-file-info.
     03 'BJf'-file-org                  pic 9.
     03 'BJf'-file-disp-lock            pic 9. 
     03 'BJf'-file-disp-addrep          pic 9.    *>1:add 2:rep
     03 'BJf'-file-disp-dlt             pic 9.   
     03 'BJf'-file-disp-rotate          pic 9.
     03 'BJf'-file-name-rdb             pic 9.
     03 'BJf'-file-inf-filler           pic x(2).
     03 'BJf'-file-opmode               pic x(02) comp-x.
     03 'BJf'-file-sts                  pic x(02).
     03 'BJf'-max-rec-size              pic x(02) comp-x.
     03 'BJf'-min-rec-size              pic x(02) comp-x.
     03 'BJf'-key-info-ptr              pointer.  
     03 'BJf'-rel-key                   pic x(04) comp-x.
     03 'BJf'-file-name                 pic x(256). 
     03 'BJf'-index-file-handle         handle.  

*--  End of File information area  ------------------------------------*

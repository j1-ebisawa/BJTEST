*--   isTECH Japan File Utility  --------------------------------------*
*       Record information area                                        *
*--------------------------------------------------------  22.03.03  --*
 01  'BJf'-record-info.
     03 'BJf'-record-size               pic x(02) comp-x.
     03 'BJf'-record-buffer             pic x(BJf-max-rec-buf-size).

*--  End of Record information area  ----------------------------------*

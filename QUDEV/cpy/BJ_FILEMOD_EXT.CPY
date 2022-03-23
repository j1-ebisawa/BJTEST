       78  BJ-FMOD-MAX        VALUE 255.    
       01  BJ-FILEMOD-TABLE             EXTERNAL.   *> BJ_JCL <-> BJ_Fmodxxx
           05  BJ-FMOD-DUMMYNAME        PIC X(30).  *> ダミーファイル名
           05  BJ-FMOD-CNT              PIC 999.    *> table entry number
           05  BJ-FMOD-TBL              OCCURS BJ-FMOD-MAX.
               10  BJ-FMOD-LFLNM        PIC X(30).        *> 論理ファイル名
               10  BJ-FMOD-PFLNM        PIC X ANY LENGTH. *> 物理ファイル名
               10  BJ-FMOD-ADD          PIC X.      *> "Y":MOD=ADD指定有り
               10  BJ-FMOD-LOCK         PIC X.      *> "Y":MOD=LOCK,"N":MOD=SHR
               10  BJ-FMOD-DEL          PIC X.      *> "D":DLT,"N":DLTN,"A":DLTA
               10  BJ-FMOD-ROTATE       PIC X.      *> "Y":世代指定有り

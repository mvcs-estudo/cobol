//INSTRPR  JOB (123),'CURSO',CLASS=A,MSGLEVEL=(1,1),
//             NOTIFY=&SYSUID
//*********************************************************************
//* DOC: PROCEDURE IN-STREAM
//*********************************************************************
//STPPROC  PROC
//STEP10   EXEC PGM=IEBCOPY
//SYSPRINT DD SYSOUT=*
//SYSOUT   DD SYSOUT=*
//SYSDUMP  DD SYSOUT=*
//SYSUT1   DD DSN=MARCUS.CURSO.SOURCE,DISP=SHR
//SYSUT2   DD DSN=MARCUS.CURSO.PDSOUT,
//            DISP=(NEW,CATLG,DELETE),
//            SPACE=(TRK,(10,10,10),RLSE),
//            UNIT=SYSDA,
//            DCB=(DSORG=PS,RECFM=FB,LRECL=80,BLKSIZE=800)
//SYSIN    DD *
     COPY INDD=SYSUT1,OUTDD=SYSUT2
/*
//*
//   PEND
//*
//STEP100  EXEC PROC=STPPROC
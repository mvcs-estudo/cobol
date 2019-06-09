//CRTGENER JOB (345),'CURSO',CLASS=A,MSGCLASS=A,MSGLEVEL=(1,1),
//             NOTIFY=&SYSUID
//*********************************************************************
//* DOC: Usa o Dataset com GDG para ser usado com CRTGDG
//*********************************************************************
//STEP10   EXEC PGM=IEFBR14
//SYSPRINT DD SYSOUT=*
//SYSOUT   DD SYSOUT=*
//SYSDUMP  DD SYSOUT=*
//DD1      DD DSN=MARCUS.CURSO.WEEK(+1),
//            DISP=(NEW,CATLG,DELETE),
//            SPACE=(TRK,(1,1),RLSE),
//            UNIT=SYSDA,
//            DCB=(DSORG=PS,RECFM=FB,LRECL=80,BLKSIZE=800)
//*
//***************************************************
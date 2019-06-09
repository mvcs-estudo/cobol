//GDGPURGE JOB (345),'CURSO',CLASS=A,MSGCLASS=A,MSGLEVEL=(1,1),
//             NOTIFY=&SYSUID
//*
//*********************************************************************
//* DOC: Expurga o DATASET  que ainda não atingiu a expiração(RETP)
//*********************************************************************
//STEP10   EXEC PGM=IDCAMS
//SYSPRINT DD SYSOUT=*
//SYSOUT   DD SYSOUT=*
//SYSIN    DD *
  DELETE (MARCUS.CURSO.WEEK) GDG PURGE
  /*
//GDGPURGE JOB (345),'CURSO',CLASS=A,MSGCLASS=A,MSGLEVEL=(1,1),
//             NOTIFY=&SYSUID
//*
//*********************************************************************
//* DOC: Expurga todas as gerações
//*********************************************************************
//STEP10   EXEC PGM=IDCAMS
//SYSPRINT DD SYSOUT=*
//SYSOUT   DD SYSOUT=*
//SYSIN    DD *
  DELETE (MARCUS.CURSO.WEEK) GDG FORCE
  /*

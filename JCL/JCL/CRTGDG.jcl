//CRTGDG  JOB (345),'CURSO',CLASS=A,MSGCLASS=A,MSGLEVEL=(1,1),
//             NOTIFY=&SYSUID
//*
//*********************************************************************
//* DOC: Define o Dataset com GDG para ser usado com CRTGENER
//* Pode ser usado DEFINE, ALTER
//*********************************************************************
//STEP10   EXEC PGM=IDCAMS
//SYSPRINT DD SYSOUT=*
//SYSOUT   DD SYSOUT=*
//SYSIN    DD *
  DEFINE GDG ( NAME(MARCUS.CURSO.WEEK) -
         LIMIT(3)            -
         NOEMPTY             -
         NOSCRATCH )
/*
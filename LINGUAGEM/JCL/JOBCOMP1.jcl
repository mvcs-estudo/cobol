//JOBCOMP1 JOB (CCMP1), 'COMPILACAO',CLASS=A,MSGCLASS=T,MSGLEVEL=(1,1),
//             REGION=8M,TIME=1440
//JOBLIB   DD DISP=SHR,DSN=MARCUS.CURSO.PROCLIB
//COMPILA  EXEC CCMP1,
//         PROG='PGM00001',
//         BIBF='MARCUS.CURSO.SOURCE',
//         BIBC='MARCUS.CURSO.LOAD'
/*
//
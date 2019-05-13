//JDPGM002 JOB (PROG0100),'MS190405',CLASS=A,MSGCLASS=T,MSGLEVEL=(1,1),
//             REGION=8M,TIME=1440
//*********************************************************************
//* JOBDOC: EXECUTA PROGRAMAS DE EXEMPLO
//*********************************************************************
//JOBLIB   DD DISP=SHR,DSN=MARCUS.CURSO.LOAD
//*********************************************************************
//* DOC: VERIFICA SE O ARQUIVO HERC01.CURSO.REPORTE EXISTE ANTES DE EXE
//*      CUTAR O PROGRAMA DE DELEÇAO
//* FILE NOT EXISTING :  RC = 12
//* EMPTY FILE        :  RC = 04
//* DATA FILE         :  RC = 00
//*********************************************************************
//CHK001   EXEC PGM=IDCAMS
//SYSPRINT DD SYSOUT=*
//SYSOUT   DD SYSOUT=*
//SYSTSPRT DD SYSOUT=*
//SYSUDUMP DD SYSOUT=*
//SYSDBOUT DD SYSOUT=*
//SYSABOUT DD SYSOUT=*
//SYSIN    DD *
  PRINT IDS('MARCUS.CURSO.REPORTE') -
      CHARACTER COUNT(1)
//*********************************************************************
//* DOC: APAGA O ARQUIVO HERC01.CURSO.REPORTE SE O STEP CHK001 RETORNAR
//*      DIFERENT DE 12
//*********************************************************************
//*IFCHK001 IF CHK001.RC ¬ 12 THEN
//DEL001   EXEC PGM=IEFBR14,COND=(12,EQ,CHK001)
//SYSPRINT DD SYSOUT=*
//SYSOUT   DD SYSOUT=*
//SYSTSPRT DD SYSOUT=*
//SYSUDUMP DD SYSOUT=*
//SYSDBOUT DD SYSOUT=*
//SYSABOUT DD SYSOUT=*
//DELETE01 DD DISP=(MOD,DELETE),UNIT=SYSALLDA,SPACE=(TRK,(5,5)),
//         DSN=MARCUS.CURSO.REPORTE
//*IFCHK001 ENDIF
//*********************************************************************
//* DOC: EXECUTA O PROGRAMA PROG0100 ORIGINAL DO CURSO
//*      PARM: DATA DE GERAÇÃO DO RELATÓRIO
//*********************************************************************
//PROG0100 EXEC PGM=PGM00001,PARM='01072019'
//SYSPRINT DD SYSOUT=*
//SYSOUT   DD SYSOUT=*
//SYSTSPRT DD SYSOUT=*
//SYSUDUMP DD SYSOUT=*
//SYSDBOUT DD SYSOUT=*
//SYSABOUT DD SYSOUT=*
//EMPREGA DD DSN=MARCUS.CURSO.EMPREGA,DISP=OLD
//RELATOR  DD SYSOUT=*
//*********************************************************************
//* DOC: EXECUTA O PROGRAMA PGM00001 CÓPIA DO CURSO. GERANDO O ARQUIVO
//*      HERC01.CURSO.REPORTE
//*      PARM: DATA DE GERAÇÃO DO RELATÓRIO
//*********************************************************************
//PGM00001 EXEC PGM=PGM00001,PARM='01072019'
//EMPREGA  DD DSN=MARCUS.CURSO.EMPREGA,DISP=OLD
//SYSPRINT DD SYSOUT=*
//SYSOUT   DD SYSOUT=*
//SYSTSPRT DD SYSOUT=*
//SYSUDUMP DD SYSOUT=*
//SYSDBOUT DD SYSOUT=*
//SYSABOUT DD SYSOUT=*
//RELATOR  DD DSN=MARCUS.CURSO.REPORTE,
//            UNIT=SYSDA,
//            DISP=(,CATLG,DELETE),
//            SPACE=(CYL,(5,2),RLSE),
//            DCB=(LRECL=80,BLKSIZE=19040,RECFM=FB,BUFNO=2)
//

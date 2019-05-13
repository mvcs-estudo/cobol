//JOBSTR01 JOB (CREATEPS),'CURSO',CLASS=A,MSGCLASS=T,MSGLEVEL=(1,1),
//             REGION=8M,TIME=(10,20),PRTY=0
//*                    NOTIFY=&SYSUID
//*********************************************************************
//* DOC: VERIFICA SE O ARQUIVO MARCUS.CURSO.EMPREGA EXISTE ANTES DE EXE
//*      CUTAR O PROGRAMA DE DELEÃ‡AO
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
  PRINT IDS('MARCUS.CURSO.EMPREGA') -
      CHARACTER COUNT(1)
//*********************************************************************
//* DOC: APAGA O ARQUIVO MARCUS.CURSO.EMPREGA SE O STEP CHK001 RETORNAR
//*      DIFERENT DE 12
//*********************************************************************
//*IFCHK001 IF CHK001.RC Â¬ 12 THEN
//DEL001   EXEC PGM=IEFBR14,COND=(12,EQ,CHK001)
//SYSPRINT DD SYSOUT=*
//SYSOUT   DD SYSOUT=*
//SYSTSPRT DD SYSOUT=*
//SYSUDUMP DD SYSOUT=*
//SYSDBOUT DD SYSOUT=*
//SYSABOUT DD SYSOUT=*
//DELETE01 DD DISP=(MOD,DELETE),UNIT=SYSALLDA,SPACE=(TRK,(5,5)),
//         DSN=MARCUS.CURSO.EMPREGA
//********************************************************************//
//*               CRIACAO DE DS PARA DADOS EMPREGADO                 *//
//********************************************************************//
//STEP001  EXEC PGM=IEFBR14
//CRTDS    DD DSN=MARCUS.CURSO.EMPREGA,DISP=(NEW,CATLG,CATLG),
//            SPACE=(TRK,(2,3),RLSE),UNIT=SYSDA,
//            DCB=(DSORG=PS,RECFM=FB,LRECL=50,BLKSIZE=19040)
//SYSPRINT DD SYSOUT=*
//SYSOUT   DD SYSOUT=*
//SYSDUMP  DD SYSOUT=*
//SYSIN    DD DATA
/*
//********************************************************************//
//*                CRIACAO DE PDS PARA FONTES COBOL                  *//
//********************************************************************//
//STEP002  EXEC PGM=IEFBR14
//CRTPDS   DD DSN=MARCUS.CURSO.SOURCE,DISP=(NEW,CATLG,CATLG),
//            UNIT=SYSALLDA,VOL=SER=PUB000,SPACE=(CYL,(10,5,5)),
//            DCB=(RECFM=FB,LRECL=80,BLKSIZE=19040)
//SYSPRINT DD SYSOUT=*
//SYSOUT   DD SYSOUT=*
//SYSDUMP  DD SYSOUT=*
/*
//********************************************************************//
//*                 CRIACAO DE PDS PARA PROCS COBOL                  *//
//********************************************************************//
//STEP003  EXEC PGM=IEFBR14
//CRTPDS   DD DSN=MARCUS.CURSO.PROCLIB,DISP=(NEW,CATLG,CATLG),
//            UNIT=SYSALLDA,VOL=SER=PUB000,SPACE=(CYL,(10,5,5)),
//            DCB=(RECFM=FB,LRECL=80,BLKSIZE=19040)
//SYSPRINT DD SYSOUT=*
//SYSOUT   DD SYSOUT=*
//SYSDUMP  DD SYSOUT=*
/*
//********************************************************************//
//*                  CRIACAO DE PDS PARA LOAD COBOL                  *//
//********************************************************************//
//STEP004  EXEC PGM=IEFBR14
//CRTPDS   DD DSN=MARCUS.CURSO.LOAD,DISP=(NEW,CATLG,CATLG),
//            UNIT=SYSALLDA,VOL=SER=PUB000,SPACE=(CYL,(10,5,5)),
//            DCB=(RECFM=U,LRECL=0,BLKSIZE=19069)
//SYSPRINT DD SYSOUT=*
//SYSOUT   DD SYSOUT=*
//SYSDUMP  DD SYSOUT=*
/*
//********************************************************************//
//*                CRIACAO DE PDS PARA FONTES COBOL                  *//
//********************************************************************//
//STEP005  EXEC PGM=IEFBR14
//CRTPDS   DD DSN=MARCUS.CURSO.JCLLIB,DISP=(NEW,CATLG,CATLG),
//            UNIT=SYSALLDA,VOL=SER=PUB000,SPACE=(CYL,(10,5,5)),
//            DCB=(RECFM=FB,LRECL=80,BLKSIZE=19040)
//SYSPRINT DD SYSOUT=*
//SYSOUT   DD SYSOUT=*
//SYSDUMP  DD SYSOUT=*
/*
//********************************************************************//
//*        CRIACAO DE PDS PARA JCL COBOL COM MEBRO EXEMPLO           *//
//********************************************************************//
//STEP006  EXEC PGM=IEBUPDTE,PARM=NEW
//SYSPRINT DD SYSOUT=*
//SYSOUT   DD SYSOUT=*
//SYSUT1   DD DUMMY
//SYSUT2   DD DSN=MARCUS.CURSO.JOBLIB,DISP=(NEW,CATLG),
//            UNIT=SYSALLDA,VOL=SER=PUB000,SPACE=(CYL,(10,5,5)),
//            DCB=(RECFM=FB,LRECL=80,BLKSIZE=19040)
//SYSIN      DD DATA
./ ADD   NAME=COMPJCL,LEVEL=00,SOURCE=0,LIST=ALL
teste
./ ENDUP
/*
//
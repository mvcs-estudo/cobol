//COBOL    PROC SOUT='*'
//*********************************************************************
//* PROCDOC: COMPILAR PROGRAMAS COBOL
//*********************************************************************
//*********************************************************************
//* DOC: GERAR OBJETO EXE
//*      PARM: PROG - NOME DO PROGRAMA A COMPILAR
//*      PARM: BIBF - BIBLIOTECA FOTE ONDE SE ENCONTRA O PROGRAMA
//*      PARM: BIBC - BIBLIOTECA OBJETO ONDE SE ALOJARA O PROGRAMA
//*********************************************************************
//IKFCBL01 EXEC  PGM=IKFCBL00,
//           PARM='FLAGW,LOAD,SUPMAP,SIZE=2048K,BUF=1024K'
//SYSPRINT DD SYSOUT=&SOUT
//SYSPUNCH DD SYSOUT=*
//SYSUT1   DD UNIT=SYSDA,SPACE=(460,(700,100))
//SYSUT2   DD UNIT=SYSDA,SPACE=(460,(700,100))
//SYSUT3   DD UNIT=SYSDA,SPACE=(460,(700,100))
//SYSUT4   DD UNIT=SYSDA,SPACE=(460,(700,100))
//SYSIN    DD DSNAME=&BIBF(&PROG),DISP=SHR
//SYSLIN   DD DSNAME=&LOADSET,DISP=(MOD,PASS),UNIT=SYSDA,
//            SPACE=(80,(500,100))
//SYSLIB   DD DSNAME=SYS1.COBLIB,DISP=SHR
//*********************************************************************
//* DOC: COPIAR OBJETO PARA LOAD
//*********************************************************************
//LKED     EXEC PGM=IEWL,PARM='LIST,XREF,LET',COND=(5,LT,IKFCBL01)
//SYSLIN   DD DSNAME=&LOADSET,DISP=(OLD,DELETE)
//         DD DDNAME=SYSIN
//SYSPUNCH DD SYSOUT=*
//SYSLMOD  DD DSNAME=&BIBC(&PROG),DISP=SHR
//SYSLIB   DD DSNAME=SYS1.COBLIB,DISP=SHR
//SYSUT1   DD UNIT=(SYSDA,SEP=(SYSLIN,SYSLMOD)),SPACE=(1024,(50,20))
//SYSPRINT DD SYSOUT=&SOUT
//
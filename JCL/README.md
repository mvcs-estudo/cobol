# Básico para JCL


### PS e PDS Files

* PS - Physical Sequential(File)
* PDS - Partitioned Data Set(Directory)
* Space Units
	* BLKS
	* TRKS
	* CYLS
	* KB
	* MB

Cálculos básicos pois os valores dependem do DASD(Direct-Access Storage Device):

1 TRKS ~192KB ou 48 Kb ou 56 KB (Depende do DASD)

1 CYL = 15 TRKS(1TRK tem no mínimo 6 BLKS)

Um PDS possui 16 extends
um PDSE possui  123 extends

* Unidades de espaço alocado:
	* Primary Quantity
	* Secondary Quantity

Total de extends = 16 por volume

Unidades totais = Primary +15 * secondary

Para saber quantos TRKS serão ocupados por um PDS em um volume:
* 10 Primary e 5 secondary: SPACE=(TRK,(10,5)) = (10)+(15*5) = máximo de 85 tracks


* Directory blocks(Data Set)
	* *ISPF statistics : 6*
	* *Sem ISPF Statistics: 21*

* Tipos de Record Format
	* F - Fixed Lenght
	* FB - Fixed Blocks
	* V - Variable Length records
	* VB - Variable Length  blocks
	* U - Undefined format records

* Record Lenght
	* Em bytes para os registros do data set

* Block Size:
	* Qtde de bytes de dados usado em cada bloco. Baseado no record length
	* Se o record length é 80 e o block size é 3120 = 3120/80 = 39 records em cada block

* Tipos de DATASE^:
	* LIBRARY= PDSE
	* PDS
	* LARGE
	* PU: Binários

#### Criando um JCL

* Declaração

``` jcl
//CREATEPS JOB S12345,SALES,     //*ACCCOUNTING INFORMATION
//             CLASS=A,          //*ASSIGN INPUT CLASS ACCOUNTING
//             MSGCLASS=A,       //*PROVIDE FORMAT OF OUTPUT MSGS
//             MSGLEVEL=(1,1),   //*MSGS THAT NEEDS TO BE PRINTED
//             TYPRUN=SCAN,      //*USED AS SCAN OR HOLD
//             TIME=(10,20),     //*AMOUNT OF MAXIMUM CPU TIME (Min,Sec)
//             PRTY=10,          //*IMPORTANCE OF JOB IN CLASS  0 a 15
//             REGION=4096K,     //*AMOUNT OF STORAGE REQUIRED FOR JOB
//             NOTIFY=&SYSUID    //*TO NOTIFY THE STATUS OF THE JOB
```

* EXEC Statement

``` jcl
//STEPCRPS EXEC PGM=IEFBR14,        //*PGM OR PROC OR PROCEDURE IS CODED
//             REGION=2048K,        //*AMOUNT OF STORAGE FOR THIS STEP
//             TIME=(5,2),          //*MAX CPU TIME FOR THIS STEP
//             ACCT=(123,SLS)       //*ACCOUNTING INFO FOR THIS STEP
//*            PARM=(1234),         //*WAY TO PASS DATA TO PGM FROM JCL
```

* DD Statements

``` jcl
//*OUTDD1  DD DUMMY,DCB=(BLKSIZE=800,RECFM=FB,LRECL=80)
//DD1      DD DSN=MATEKS.TEST.FILE,   //*PHYSICAL DATASET NAME
//            DISP=(NEW,CATLG,CATLG), //*DEFIND CS,ND AND AD
//            SPACE=(TRK,(2,3),RLSE), //*SPACE DETAILS ARE DEFINED
//            UNIT=SYSDA,             //*LOCATION OF DATASET(DEVICE)
//            VOL=SER=(123,456),      //*VOLUME SERIAL NUMBER
//            DCB=(DSORG=PS,RECFM=FB,LRECL=80,BLKSIZE=800)
//*DATA CONTROL BLOCK IS DEFINED IN THE ABOVE LINE
//SYSPRINT DD SYSOUT=*               //*PRINT OUTPUT MSGS IN SPOOL
//SYSOUT   DD SYSOUT=*               //*DISPLAYS OUTPUT MSGS IN SPOOL
//SYSDUMP  DD SYSOUT=*               //*DISPLAY DUMPS IN SPOOL AREA
```

* Valores do Parâmetro DISP Parameter: ````DISP=(CS,ND,AD)````
	* CS - Status Atual:
		1) NEW - Criar um novo arquivo
		2) OLD - Sobrescrever o conteúdo do arquivo, caso ele exista
		3) SHR - Apenas Leitura
		4) MOD - Adicionar conteúdo ao fim do arquivo, caso ele exista
	* ND - Disposição Normal
		1) CATLG - O DATASET será catalogado. Cria uma nova entrada na master Catalog table.
		2) KEEP - Assume que o DATASET está catalogado. Geralmente declarado ```DISP=(OLD,KEEP)```
		3) DELETE - Àpaga o DATASET após o JOB executar normalmente
		4) UNCATLG - Não apaga o DATASET. Remove a entrada na master Catalog table.
		5) PASS - Cria um DATASET temporário a ser lido pelos próximos STEP's
subsequent steps.
	* AD - Abnormal Disposition
		1) CATLG - O DATASET será catalogado. Cria uma nova entrada na master Catalog table.
		2) KEEP - Assume que o DATASET está catalogado. Geralmente declarado ```DISP=(OLD,KEEP)```
		3) DELETE - Àpaga o DATASET após o JOB executar normalmente
		4) UNCATLG - Não apaga o DATASET. Remove a entrada na master Catalog table.

* Parâmetros úteis
	* SYSIN - PASSAR DADOS DO JCL PARA O PROGRAMA
	* SYSUT1 - USADO PARA PASSAR ALGUM ARQUIVO DE INPUT PARA ALGUNS UTILITARIOS
	* SYSUT2 USADO PARA PROVER ALGUM ARQUIVO DE SAIDA PARA ALGUNS UTILTARIOS


#### Retorno para um JCL

* MAXCC é o máximo Condition CODE retornado pelos STEPs
	* JCL Return Code=0(Program Executed successfully) – Informational messagesTérmino normal do JOB
	* JCL Return Code=4(Program Executed successfully but with warnings)
	* JCL Return Code=8(Error)
	* JCL Return Code=12(Severe Error)
	* JCL Return Code=16(Fatal Error)

* SPOOL
	* JESMSGLG: Log de Console como starting time, end time
	* JESYSMSG: SYSLOG do ambiente como messagens relacionadas a alocação de datasets ou condition code para cada STEP
	* JESJCL: Descrição detalhada do JCL. Forma expandida
# Básico para JCL

### MIPS

Million Instruction Per Sec


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
//             MSGCLASS=A,       //*PROVIDE FORMAT OF OUTPUT MSGS(SYSOUT) Classes especiais = A,X(72hrs) ou Y(1hr)
//             MSGLEVEL=(1,1),   //*MSGS THAT NEEDS TO BE PRINTED. (JCL[0-2],MSG[0,1])
//             TYPRUN=SCAN,      //*USED AS SCAN OR HOLD
//             TIME=(10,20),     //*AMOUNT OF MAXIMUM CPU TIME (Min,Sec). Affects MIPS
//             PRTY=10,          //*IMPORTANCE OF JOB IN CLASS  0 a 15
//             REGION=4096K,     //*AMOUNT OF STORAGE REQUIRED FOR JOB
//             NOTIFY=&SYSUID    //*TO NOTIFY THE STATUS OF THE JOB
//             RESTART=STEP.PROC //*TO RESTART FROM PARTICULAR STEP
```

* MSG LEVEL: Qual mensagem estará na SYSOUT(JCL[0-2],MSG[0,1])

	* JCL:

		1) 0-JOB related statements

		2) 1-All JCL with PROC

		3) 2-Only Input

	* MSG:

		1) 0-Abnormal Ending

		2) 1-All messages

* EXEC Statement

``` jcl
//STEPCRPS EXEC PGM=IEFBR14,        //*PGM OR PROC OR PROCEDURE IS CODED
//             COND=(4,NE)          //*CONDITION PARAMETER
//             REGION=2048K,        //*AMOUNT OF STORAGE FOR THIS STEP(Virtual Storage[K/M/0]bytes) Abend S422 ou S822
//             TIME=(5,2),          //*MAX CPU TIME FOR THIS STEP. Abend S322
//             ACCT=(123,SLS)       //*ACCOUNTING INFO FOR THIS STEP
//*            PARM=(1234),         //*WAY TO PASS DATA TO PGM FROM JCL. FOR PROCS CAN DEFINE
```

* DD Statements

``` jcl
//*OUTDD1  DD DUMMY,DCB=(BLKSIZE=800,RECFM=FB,LRECL=80)
//DD1      DD DSN=MATEKS.TEST.FILE,   //*PHYSICAL DATASET NAME. 45 Characters and temporary Datasets starts with &&
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

* Valores do Parâmetro DISP: ````DISP=(CS,ND,AD)````
	* CS - Status Atual:
		1) NEW - Criar um novo arquivo
		2) OLD - Sobrescrever o conteúdo do arquivo, caso ele exista
		3) SHR - Apenas Leitura
		4) MOD - Adicionar conteúdo ao fim do arquivo, caso ele exista. Se existir necessário declarar VOL=SER ou VOL=REF
	* ND - Disposição Normal
		1) CATLG - O DATASET será catalogado. Cria uma nova entrada na master Catalog table.
		2) KEEP - Assume que o DATASET está catalogado. Geralmente declarado ```DISP=(OLD,KEEP)```
		3) DELETE - Àpaga o DATASET após o JOB executar normalmente
		4) UNCATLG - Não apaga o DATASET. Remove a entrada na master Catalog table.
		5) PASS - Cria um DATASET temporário a ser lido pelos próximos STEP's
	* AD - Abnormal Disposition
		1) CATLG - O DATASET será catalogado. Cria uma nova entrada na master Catalog table.
		2) KEEP - Assume que o DATASET está catalogado. Geralmente declarado /```DISP=(OLD,KEEP)```
		3) DELETE - Àpaga o DATASET após o JOB executar normalmente
		4) UNCATLG - Não apaga o DATASET. Remove a entrada na master Catalog table.

* Valores do Parâmetro SPACE: ````SPACE=(ALOCATION TYPE(PRIMARY QNTY, SECONDARY QNTY,DIRECTORY)[,RLSE][,CONTIG][,MXIG][,ROUND])````
	* ALOCATION TYPE:
		1)TRK
		2)CYL
		3)BLKLGTH
		4)RECLGTH
	* DIRECTORY: Em caso de PS file é igual a zero
	* QNTY: Abend SB37(PS) e Abend SE37(PDS) ou S013/S014
	* RLSE: Libera memória quando o Dataset é fechado
	* CONTIG: Aloca memória continuamente
	* MXIG: Aloca muito mais memória continuamente
	* ROUND: Usado quando se é necessário extrapolar o tamanho do bloco, alocando um CYL inteiro

* Valores do Parâmetro UNIT: ```UNIT=(DEVICE_NAME,[COUNT])```
	* SYSDA:DASD(Direct-Access Storage Device)
	* [0-9]{n}: Tape Device

* Valores do Parâmetro VOLUME: ```VOL=([P,][R,][VS,]SER)```
	* P: PRIVATE
	* R: RETAIN
	* VS: VOLUME SERIAL NUMBER
	* VC:VOLUME COUNT
	* SER: SERIAL NUMBER

* Valores do Parâmetro DCB: Informação sobre o DATASET no Data Control Block
	* RECFM: Record Format
		1) F  - Fixed Lenght
		2) FB - Fixed Blocks
		3) V  - Variable Length records
		4) VB - Variable Length  blocks
		5) U  - Undefined format records
LRECL: Logical REcord Length
BLKSIZE: Tamanho do Block. Deve ser múltiplo de LRECL(RC=12)
DSORG: Organization  do DATASET
        * PS,PDS ou Library
BUFNO: Buffer number
BUFSIZE: Buffer Size

* Valores para o Parâmetro COND: ```COND=(RC,OP,STEPNAME) ou COND=EVEN ou COND=ONLY```
	* RC: Return CODE
	* OP: EQ, NE,LE, LT, GE, GT

|     COND    |                              RESULTADO                             |
|:-----------:|:------------------------------------------------------------------:|
| COND=(0,EQ) | Se o resultado do step anterior for diferente de 0, executa o step |
| COND=EVEN   | Se o resultado do step anterior for abend, executa o step          |
| COND=ONLY   | Executa o step apenas se o anterior abendar                        |


* Valores para o Parâmetro ADDRSPC: Define se utilizará storage real ou virtual. JOB ou EXEC(Necessita do REGION)
	* REAL
	* VIRTUAL/VIRT(Padrão)


* Parâmetros úteis:
	* SYSIN  - PASSAR DADOS DO JCL PARA O PROGRAMA(ACCEPT no Programa). PARM sobrescreve o SYSIN

``` jcl
//SYSIN DD *
VALORES...
//SYSIN DD DATA
VALORES...
```
* Utilitários
	* SYSUT1 - USADO PARA PASSAR ALGUM ARQUIVO DE INPUT PARA ALGUNS UTILITARIOS
	* SYSUT2 - USADO PARA PROVER ALGUM ARQUIVO DE SAIDA PARA ALGUNS UTILTARIOS

* Cartão Storage Dump:
	* SYSABEND: Quando ocorre abend
	* SYSMDUMP: SYSTEM AREA ou ADDRESS SPACE
	* SYSUDUMP: USER AREAS
			1) //SYSABEND DD DSNNAME=PDS.NAME,DISP=(OLD,DELETE,KEEP)
			2) //SYSUDUMP DD SYSOUT=*


#### Parâmetros de um JCL


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


### PROCEDURE

Usado para tarefas repetitivas com o máximo de 255 steps. Não possui JOB statement e não pode ter NULL statement

Pode ser de dois tipos:
* In-stream: Definida no JCL. Inicia por PROC e termina com PEND
* Cataloged: Como membro. PEND não requerido

* Parâmetro SYMBOLIC
		* Na PROCEDURE declarar no DSN o Parâmetro. No JOB utilizar VARIAVEL=VALOR

### GDG - GENERATION DATA GROUP

GDG - GENERATION DATA GROUP: Grupo de DS similares que se encontram relacionados em ordem cronológica
* Formato: ABC.PQR.XYZ.GnnnnVmm
	* G: Número Gerado 0000 a 9999
	* V: Versão Gerada 00 a 99
* Gerado com IDCAMS e usa IEFBR14 para criar os DATASETS
* Parâmetros:
	* NAME
	* LIMIT
	* EMPTY/NOEMPTY: Uncatalog todos/antigas gerações quando o limite é atingido
	* SCRATCH/NOSCRATCH: Deletar/Ñ deletar quando as gerações são deletadas
* Para deletar pode ser usado:
	* DELETE PURGE: Após o período de retenção ou data de expiração
	* DELETE FORCE: Todas as gerações



## Bibliotecas Privadas

* JOBLIB:
	* Utilizada no nível do JOB
	* Após a declaração de JOB e antes da declarção EXEC
	* STEPLIB possui maior prioridade
	* Sintaxe: ```JOBLIB   DD DSN=MARCUS.CURSO.LOADLIB,DISP=SHR```
* STEPLIB:
	* Utilizada no nível do STEP
	* Após a declaração de STEP
	* Sintaxe: ```STEPLIBDD DSN=MARCUS.CURSO.LOADLIB,DISP=SHR```
* JCLLIB:
	* Apenas uma é permitida no JCL
	* Após a declaração de JOB e antes da declarção EXEC
	* STEPLIB possui maior prioridade
	* Sintaxe: ```JCLLIB JCLLIB ORDER=(LIB,LIB1,LIB3)```

* COPYLIB:
	* Utilizada para reusar uma lista de dados, variáveis ou códigos
	* Após a declaração de EXEC
	* Sintaxe:
``` jcl
COPYLIB=MARCUS.CURSO.LOADLIB,
SRCLIB= MARCUS.CURSO.SOURCE,
MEMBER=MEMBRO
```

# COBOL

> Repositório para estudo de desenvolvimento COBOL, JCL e DB2

## Cursos relacionados

1. **LINGUAGEM**:[COBOL curso completo: Empieza a programar ¡Ya!](https://www.udemy.com/lenguaje-de-programacion-cobol/)


### 1. LINGUAGEM

* Realizar o Download do [Hércules](http://wotho.ethz.ch/tk4-/)
* Inicializar o MVS TK4 com os seguintes parâmetros:
    * TZOFFSET  +0400: Ajusta para o timezone américa do sul
    * Ligar FTP: /start ftpd,srvport=2100: Inicializa o FTP na Porta 2100
    * Verifica serviços MVS em ecexução: /d a,l
* Submissão de jobs com FTP: ```put HELLO AAINTRDR```
    * Alguns comandos não são aceitos

##### Usuários do HERCULES:

* HERC01/CUL8TR
* IBMUSER/IBMPASS


##### Jobs padrão do ambiente:

* sys2.jcllib


##### Criar PDS:

* MARCUS.CURSO.OPERA: FB/80/19040///T/300/5/5

##### Executar JOB:

* JCL\JCL\JOBSTR01


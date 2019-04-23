USE SENAI_SPMEDICALGROUP_MANHA;

--- INDICES

CREATE NONCLUSTERED INDEX IDX_PRONTUARIOS_CPF
	ON PRONTUARIOS (CPF);
GO

CREATE NONCLUSTERED INDEX IDX_USUARIOS_EMAIL
	ON USUARIOS (EMAIL);
GO

CREATE NONCLUSTERED INDEX IDX_MEDICOS_CRM
	ON MEDICOS (CRM);
GO

CREATE NONCLUSTERED INDEX IDX_CONS_ID_PRONT
	ON CONSULTAS (ID_PRONTUARIO);
GO

CREATE NONCLUSTERED INDEX IDX_CONS_ID_MEDICO
	ON CONSULTAS (ID_MEDICO);
GO

CREATE NONCLUSTERED INDEX IDX_CONS_DATA
	ON CONSULTAS (DATA_AGENDADA);
GO 

select CPF from CONSULTAS IDX_CONS_ID_MEDICO

--- SELECT INNER JOIN

SELECT * FROM PRONTUARIOS AS PRON INNER JOIN CONSULTAS AS CONS ON PRON.ID = CONS.ID_PRONTUARIO;

SELECT * FROM PRONTUARIOS AS PRON INNER JOIN USUARIOS AS USUA ON PRON.ID_USUARIO = USUA.ID;

SELECT * FROM USUARIOS AS USUA INNER JOIN TIPOS_USUARIOS AS TIPO ON USUA.ID_TIPO_USUARIO = TIPO.ID;

SELECT * FROM MEDICOS AS MEDI INNER JOIN ESPECIALIDADES AS ESPE ON MEDI.ID_ESPECIALIDADE = ESPE.ID;

SELECT * FROM MEDICOS AS MEDI INNER JOIN CLINICAS AS CLIN ON MEDI.ID_CLINICA = CLIN.ID;

SELECT * FROM MEDICOS AS MEDI INNER JOIN USUARIOS AS USUA ON MEDI.ID_USUARIO = USUA.ID;

SELECT * FROM MEDICOS AS MEDI INNER JOIN ESPECIALIDADES AS ESPE ON MEDI.ID_ESPECIALIDADE = ESPE.ID INNER JOIN CLINICAS AS CLIN ON MEDI.ID_CLINICA = CLIN.ID INNER JOIN USUARIOS AS USUA ON MEDI.ID_USUARIO = USUA.ID;

--- QUANTIDADE DE CADASTROS EM UMA TABELA

SELECT COUNT(ID) AS QUANT_PRONTS FROM PRONTUARIOS;

SELECT COUNT(ID) AS QUANT_MEDICOS FROM MEDICOS;

SELECT COUNT(ID) AS QUANT_CONSULTAS FROM CONSULTAS;

--- CONVERTER DATA PARA 00/00/0000

SELECT CONVERT(VARCHAR, DATA_AGENDADA, 101) AS DATA_CONVETIDA, CONSULTAS. *  FROM CONSULTAS;

--- CALCULA A IDADE

SELECT DATEDIFF(MONTH, DATA_NASCIMENTO, GETDATE())/12 AS IDADE, PRONTUARIOS. * FROM PRONTUARIOS;

--- FUNCTIONS

--- RETORNA A QUANTIDADE DE MEDICOS QUE TEM AQUELA ESPECIALIDADE
CREATE FUNCTION dbo.QUANT_MED_ESP(@ESPECI int)
RETURNS TABLE
AS
RETURN
	SELECT COUNT(ID) AS QUANT_MEDI_ESPECI FROM MEDICOS AS MEDI WHERE MEDI.ID_ESPECIALIDADE = @ESPECI;

SELECT * from dbo.QUANT_MED_ESP(12);

--- RETORNA OS MEDICOS COM TEM AQUELA ESPECIALIDADE
CREATE FUNCTION MED_ESP(@ESPECI INT)
RETURNS TABLE
AS
RETURN
	SELECT * FROM MEDICOS WHERE ID_ESPECIALIDADE = @ESPECI;

SELECT * FROM MED_ESP(17); 

--- PROCEDURE

--- CALCULA A IDADE DE UM PACIENTE USANDO PROCEDURE
CREATE PROCEDURE IDADE_DATA_NASC
@DATA_NASC DATE
AS 
SELECT DATEDIFF(MONTH, @DATA_NASC, GETDATE())/12 AS IDADE;

EXECUTE IDADE_DATA_NASC '09-12-2002';

--- TESTE TRIGGER

--CREATE TRIGGER VALIDAR_EMAIL_TESTE
--ON USUARIOS
--FOR  INSERT
--AS BEGIN 
--	DECLARE @EMAIL VARCHAR(250)
--	SELECT @EMAIL = EMAIL FROM INSERTED
--	IF @EMAIL LIKE '%@%'
--		SELECT * FROM USUARIOS
--		ELSE INSERT INTO USUARIOS (EMAIL, SENHA, ID_TIPO_USUARIO) VALUES ('DEU_CERTO@GMAIL.COM', 'CERTO132', 2);
--END
--GO

--INSERT INTO USUARIOS (EMAIL, SENHA, ID_TIPO_USUARIO)
--VALUES ('TESTE', 'TESTE132', 3);

--SELECT * FROM USUARIOS;


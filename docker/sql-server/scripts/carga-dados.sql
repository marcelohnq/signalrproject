USE PoCSignalR

SET NOCOUNT ON;

-- C - CREATE

DECLARE @NUM_REGISTROS AS INT

SELECT 
	@NUM_REGISTROS = SUM(NumRegistro)
FROM
(
	SELECT COUNT(1) AS NumRegistro FROM Estado
	UNION ALL
	SELECT COUNT(1) FROM Cidade
	UNION ALL
	SELECT COUNT(1) FROM Estado
	UNION ALL
	SELECT COUNT(1) FROM Departamento
	UNION ALL
	SELECT COUNT(1) FROM Pessoa
) AS TB


IF (@NUM_REGISTROS > 0)
BEGIN
	DBCC CHECKIDENT ('dbo.Pessoa', RESEED, 0);
	DBCC CHECKIDENT ('dbo.Departamento', RESEED, 0);
	DBCC CHECKIDENT ('dbo.Cidade', RESEED, 0);
	DBCC CHECKIDENT ('dbo.Estado', RESEED, 0);
END


-- D - DELETE

DELETE Pessoa
DELETE Departamento
DELETE Cidade
DELETE Estado

-- Inserção de Estados
INSERT INTO dbo.Estado (Nome) VALUES 
('Acre'), ('Alagoas'), ('Amapá'), ('Amazonas'), ('Bahia'),
('Ceará'), ('Distrito Federal'), ('Espírito Santo'), ('Goiás'),
('Maranhão'), ('Mato Grosso'), ('Mato Grosso do Sul'),
('Minas Gerais'), ('Pará'), ('Paraíba'), ('Paraná'), ('Pernambuco'),
('Piauí'), ('Rio de Janeiro'), ('Rio Grande do Norte'),
('Rio Grande do Sul'), ('Rondônia'), ('Roraima'), ('Santa Catarina'),
('São Paulo'), ('Sergipe'), ('Tocantins');

-- Inserção de Cidades
INSERT INTO dbo.Cidade (Nome, Populacao, IdEstado) VALUES
('São Paulo', 12325232, 26),
('Rio de Janeiro', 6718903, 19),
('Salvador', 2886698, 5),
('Brasília', 3015268, 7),
('Fortaleza', 2686612, 6),
('Manaus', 2182763, 3),
('Curitiba', 1963212, 16),
('Recife', 1645727, 17),
('Goiânia', 1516113, 8),
('Belém', 1492745, 14);

-- Inserção de Departamentos
INSERT INTO dbo.Departamento (Nome, IdCidade) VALUES
('RH', 1),
('Financeiro', 2),
('TI', 3),
('Vendas', 4),
('Marketing', 5),
('Logística', 6),
('Produção', 7),
('Qualidade', 8),
('Atendimento ao Cliente', 9),
('Administração', 10);

-- Nomes das Pessoas
DECLARE @Nomes TABLE (
    Id INT IDENTITY PRIMARY KEY,
    Nome VARCHAR(50) NOT NULL,
    IdDepartamento INT NOT NULL
);

INSERT INTO @Nomes (Nome, IdDepartamento) VALUES
('Maria da Silva', 1),
('João Oliveira', 2),
('Ana Santos', 3),
('Pedro Martins', 4),
('Mariana Pereira', 5),
('Luís Ferreira', 6),
('Sofia Rodrigues', 7),
('Carlos Costa', 8),
('Beatriz Sousa', 9),
('Tiago Almeida', 10),
('Rita Carvalho', 1),
('Miguel Gonçalves', 2),
('Catarina Fernandes', 3),
('André Ramos', 4),
('Inês Gomes', 5),
('Francisco Santos', 6),
('Diana Silva', 7),
('Bruno Oliveira', 8),
('Carolina Martins', 9),
('Ricardo Pereira', 10),
('Patrícia Alves', 1),
('Daniel Rodrigues', 2),
('Vanessa Costa', 3),
('Rafael Sousa', 4),
('Marta Pereira', 5),
('Paulo Fernandes', 6),
('Ingrid Almeida', 7),
('Diogo Silva', 8),
('Isabel Santos', 9),
('Tiago Pereira', 10),
('Helena Gonçalves', 1),
('José Carvalho', 2),
('Débora Martins', 3),
('Lucas Rodrigues', 4),
('Carla Ferreira', 5),
('André Costa', 6),
('Renata Oliveira', 7),
('Nuno Sousa', 8),
('Marisa Ramos', 9),
('Gonçalo Gomes', 10),
('Adriana Silva', 1),
('Hélder Oliveira', 2),
('Susana Costa', 3),
('Bruno Martins', 4),
('Débora Pereira', 5),
('Fábio Rodrigues', 6),
('Patrícia Costa', 7),
('Lucas Almeida', 8),
('Ana Rita Santos', 9);

-- Inserção de Pessoas
INSERT INTO dbo.Pessoa (Nome, IdDepartamento)
SELECT 
    Nome,
    IdDepartamento
FROM @Nomes;

SET NOCOUNT OFF;
CREATE DATABASE locadora4
GO
USE locadora4
GO
CREATE TABLE estrela
(
	id_estrela				INT				NOT NULL,
	nome					VARCHAR(50)		NOT NULL
	PRIMARY KEY(id_estrela)
)
GO
CREATE TABLE filme
(
	id_filme				INT				NOT NULL,
	titulo					VARCHAR(40)		NOT NULL,
	ano						INT				NULL	 CHECK(ano <= 2021)
	PRIMARY KEY(id_filme)
)
GO
CREATE TABLE filme_estrela
(
	id_filme				INT				NOT NULL,
	id_estrela				INT				NOT NULL
	PRIMARY KEY(id_filme, id_estrela)
	FOREIGN KEY(id_filme) REFERENCES filme(id_filme),
	FOREIGN KEY(id_estrela) REFERENCES estrela(id_estrela)
)
GO
CREATE TABLE cliente
(
	num_cad_cliente			INT				NOT NULL,
	nome					VARCHAR(70)		NOT NULL,
	logradouro_end			VARCHAR(150)	NOT NULL,
	num_end					INT				NOT NULL CHECK(num_end >= 0),
	cep_end					CHAR(8)			NULL	 CHECK(LEN(cep_end) = 8)
	PRIMARY KEY(num_cad_cliente)
)
GO
CREATE TABLE dvd
(
	num_dvd					INT				NOT NULL,
	data_fabr				DATE			NOT NULL CHECK(data_fabr < GETDATE()),
	id_filme				INT				NOT NULL
	PRIMARY KEY(num_dvd)
	FOREIGN KEY(id_filme) REFERENCES filme(id_filme)
)
GO
CREATE TABLE locacao
(
	num_dvd					INT				NOT NULL,
	num_cad_cliente			INT				NOT NULL,
	data_locacao			DATE			NOT NULL DEFAULT GETDATE(),
	data_devolucao			DATE			NOT NULL,
	valor					DECIMAL(7, 2)	NOT NULL CHECK(valor >= 0)
	PRIMARY KEY(num_dvd, num_cad_cliente, data_locacao)
	FOREIGN KEY(num_dvd) REFERENCES dvd(num_dvd),
	FOREIGN KEY(num_cad_cliente) REFERENCES cliente(num_cad_cliente),
	CONSTRAINT chk_dtl_dtd CHECK(data_locacao < data_devolucao)
)
GO
ALTER TABLE estrela 
ADD nome_real VARCHAR(50) NULL
GO
ALTER TABLE filme 
ALTER COLUMN titulo VARCHAR(80)
GO
INSERT INTO filme (id_filme, titulo, ano)
VALUES
(1001, 'Whiplash', 2015),
(1002, 'Birdman', 2015),
(1003, 'Interestelar', 2014), --Um ótimo filme inclusive
(1004, 'A Culpa É das Estreças', 2014),
(1005, 'Alexandre e o Dia Terrível, Horrível, Espantoso e Horroroso', 2014), --Não to acreditando que esse filme existe
(1006, 'Sing', 2016)
GO
INSERT INTO estrela (id_estrela, nome, nome_real)
VALUES
(9901, 'Michael Keaton', 'Michael John Douglas'),
(9902, 'Emma Stone', 'Emily Jean Stone'),
(9903, 'Miles Teller', NULL),
(9904, 'Steve Carell', 'Steven John Carell'),
(9905, 'Jennifer Garner', 'Jennifer Anne Garner')
GO
INSERT INTO filme_estrela (id_filme, id_estrela)
VALUES
(1002, 9901),
(1002, 9902),
(1001, 9903),
(1005, 9904),
(1005, 9905)
GO
INSERT INTO dvd (num_dvd, data_fabr, id_filme)
VALUES
(10001, '2020-12-02', 1001),
(10002, '2019-10-18', 1002),
(10003, '2020-04-03', 1003),
(10004, '2020-12-02', 1001),
(10005, '2019-10-18', 1004),
(10006, '2020-04-03', 1002),
(10007, '2020-12-02', 1005),
(10008, '2019-10-18', 1002),
(10009, '2020-04-03', 1003)
GO
INSERT INTO cliente (num_cad_cliente, nome, logradouro_end, num_end, cep_end)
VALUES
(5501, 'Matilde Luz', 'Rua Síria', 150, '03086040'),
(5502, 'Carlos Carreiro', 'Rua Bartolomeu Aires', 1250, '04419110'),
(5503, 'Daniel Ramalho', 'Rua Itajutiba', 169, NULL),
(5504, 'Roberta Bento', 'Rua Jayme Von Rosenburg', 36, NULL),
(5505, 'Rosa Cerqueira', 'Rua Arnaldo Simões Pinto', 235, '02917110')
GO
INSERT INTO locacao (num_dvd, num_cad_cliente, data_locacao, data_devolucao, valor)
VALUES
(10001, 5502, '2021-02-18', '2021-02-21', 3.50),
(10009, 5502, '2021-02-18', '2021-02-21', 3.50),
(10002, 5503, '2021-02-18', '2021-02-19', 3.50),
(10002, 5505, '2021-02-20', '2021-02-23', 3.00),
(10004, 5505, '2021-02-20', '2021-02-23', 3.00),
(10005, 5505, '2021-02-20', '2021-02-23', 3.00),
(10001, 5501, '2021-02-24', '2021-02-26', 3.50),
(10008, 5501, '2021-02-24', '2021-02-26', 3.50)

--update
--cli 1 cep
UPDATE cliente 
SET cep_end = '08411150'
WHERE num_cad_cliente = 5503
--cli 2 cep
UPDATE cliente 
SET cep_end = '02918190'
WHERE num_cad_cliente = 5504

--loc 1 valor
UPDATE locacao 
SET valor = 3.25
WHERE data_locacao = '2021-02-18' AND num_cad_cliente = 5502
--loc 2 valor
UPDATE locacao 
SET valor = 3.10
WHERE data_locacao = '2021-02-24' AND num_cad_cliente = 5501

--dvd 1 data
UPDATE dvd 
SET data_fabr = '2019-07-14'
WHERE num_dvd = 10005

--star 1 nome real
UPDATE estrela 
SET nome_real = 'Miles Alexander Teller'
WHERE nome = 'Miles Teller'

--delete Sing
DELETE filme
WHERE titulo = 'Sing'


----------------------------ExercLocadora3SelectAgregacao-----------------------------

--1)
SELECT c.num_cad_cliente, c.nome, f.titulo, CONVERT(VARCHAR, d.data_fabr, 103) AS data_fabr, l.valor
FROM cliente c, locacao l, dvd d, filme f 
WHERE c.num_cad_cliente = l.num_cad_cliente
	AND l.num_dvd = d.num_dvd 
	AND d.id_filme = f.id_filme 
	AND d.data_fabr IN 
	(
		SELECT MAX(d.data_fabr)
		FROM dvd d
	)

--2)
SELECT c.num_cad_cliente, c.nome, CONVERT(CHAR(10), l.data_locacao, 103) AS data_locacao, COUNT(c.num_cad_cliente) AS qtd
FROM cliente c, locacao l, dvd d 
WHERE c.num_cad_cliente = l.num_cad_cliente
	AND l.num_dvd  = d.num_dvd 
GROUP BY c.num_cad_cliente, c.nome, l.data_locacao 
ORDER BY l.data_locacao 

--3)
SELECT c.num_cad_cliente, c.nome, CONVERT(CHAR(10), l.data_locacao, 103) AS data_locao, SUM(l.valor) AS valor_total
FROM cliente c, locacao l 
WHERE c.num_cad_cliente = l.num_cad_cliente 
GROUP BY c.num_cad_cliente, c.nome, l.data_locacao
ORDER BY l.data_locacao 

--4)
SELECT c.num_cad_cliente, c.nome, c.logradouro_end + ' ' + CAST(c.num_end AS VARCHAR) AS endereco, CONVERT(VARCHAR, l.data_locacao, 103) AS data_locacao
FROM cliente c, locacao l
WHERE c.num_cad_cliente = l.num_cad_cliente 
GROUP BY c.num_cad_cliente, c.nome, l.data_locacao, c.logradouro_end, c.num_end
HAVING COUNT(c.num_cad_cliente) > 2 
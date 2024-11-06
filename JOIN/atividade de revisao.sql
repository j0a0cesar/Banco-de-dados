-- Quanto é o cafezinho?--
-- 2 reais.--
-- E o açúcar?--
-- O açúcar a gente não cobra.--
-- Então pode me ver 2 quilos, por favor.--
-- Exclui o banco de dados "empresa", caso o banco de dados exista
DROP DATABASE IF EXISTS empresa;

-- Cria o banco de dados "empresa"
CREATE DATABASE empresa;
-- Define o banco de dados "empresa" como o banco de dados atual
USE empresa;

-- Cria a tabela "fornecedores" com id_fornecedor (PK), nome_fornecedor, cidade, uf
CREATE TABLE fornecedores (
    id_fornecedor INT NOT NULL PRIMARY KEY,
    nome_fornecedor VARCHAR(40),
    cidade VARCHAR(40),
    uf VARCHAR(2)
);

-- Cria a tabela "unidades" com id_unidade (PK), nome_unidade
CREATE TABLE unidades (
    id_unidade INT NOT NULL PRIMARY KEY,
    nome_unidade VARCHAR(11)
);

-- Cria a tabela "materiais" com id_material (PK), id_fornecedor (FK), nome_material, quantidade_estoque, quantidade_estoque_minima, id_unidade (FK)
CREATE TABLE materiais (
    id_material INT NOT NULL PRIMARY KEY,
    id_fornecedor INT,
    nome_material VARCHAR(40),
    quantidade_estoque INT,
    quantidade_estoque_minima SMALLINT,
    id_unidade INT,
    FOREIGN KEY (id_fornecedor) REFERENCES fornecedores(id_fornecedor),
    FOREIGN KEY (id_unidade) REFERENCES unidades(id_unidade)
);

-- Cria a tabela "pedidos" com id_pedido (PK), data_pedido
CREATE TABLE pedidos (
    id_pedido INT NOT NULL PRIMARY KEY,
    data_pedido DATE
);

-- Cria a tabela "itens_pedido" com id_item_pedido (PK), id_pedido (FK), id_material (FK), quantidade_pedida, valor_unitario
CREATE TABLE itens_pedido (
    id_item_pedido INT NOT NULL PRIMARY KEY,
    id_pedido INT NOT NULL,
    id_material INT NOT NULL,
    quantidade_pedida INT NOT NULL,
    valor_unitario DECIMAL(10, 2),
    FOREIGN KEY (id_pedido) REFERENCES pedidos(id_pedido),
    FOREIGN KEY (id_material) REFERENCES materiais(id_material)
);


/* Insere registros na tabela "Fornecedores" */
INSERT INTO fornecedores
(id_fornecedor, nome_fornecedor, cidade, uf)
VALUES
(1, 'ABC Materiais Elétricos', 'Curitiba', 'PR'),
(2, 'XYZ Materiais de Escritório', 'Rio de Janeiro', 'RJ'),
(3, 'Hidra Materiais Hidraulicos', 'São Paulo', 'SP'),
(4, 'HidraX Materiais Elétricos e Hidraulicos', 'Porto Alegre', 'RS');

/* Mostra os registros da tabela "Fornecedores" */
SELECT *FROM fornecedores;

/* Insere registros na tabela "Unidades" */
INSERT INTO unidades
(id_unidade, nome_unidade)
VALUES
(1, 'Unidades'),
(2, 'Kg'),
(3, 'Litros'),
(4, 'Caixa com 12 unidades'),
(5, 'Caixa com 100 unidades'),
(6, 'Metros');

/* Mostra os registros da tabela "Unidades" */
SELECT * FROM unidades;

/* Insere registros na tabela "Materiais" */
INSERT INTO materiais
(id_material , id_fornecedor, nome_material, quantidade_estoque, quantidade_estoque_minima, id_unidade)
values
(1, 1, 'Tomada elétrica 10A padrão novo', 12, 5, 1),
(2, 1, 'Disjuntor elétrico 25A', 10, 5, 1),
(3, 2, 'Resma papel branco A4', 32, 20, 4),
(4, 2, 'Toner impressora HR5522', 6, 10, 1),
(5, 3, 'Cano PVC 1/2 pol', 6, 10, 6),
(6, 3, 'Cano PVC 3/4 pol', 8, 10, 6),
(7, 3, 'Medidor hidráulico 1/2 pol', 3, 2, 1),
(8, 3, 'Conector Joelho 1/2 pol', 18, 15, 1),
(9, 1, 'Tomada elétrica 20A padrão novo', 8, 5, 1),
(10, 2, 'Caneta esferográfica azul', 80, 120, 1),
(11, 2, 'Grampeador mesa pequeno', 5, 5, 1),
(12, 2, 'Caneta Marca Texto Amarela', 6, 15, 5),
(13, 2, 'Lápis Preto HB', 15, 25, 1);

/* Mostra os registros da tabela "Materiais" */
SELECT * FROM materiais;

/* Insere registros na tabela "Pedidos" */
INSERT INTO pedidos
(id_pedido, data_pedido)
VALUES
(1, '2015-02-25'),
(2, '2014-02-10'),
(3, '2015-03-01');

/* Mostra os registros da tabela "Pedidos" */
SELECT * FROM pedidos;

/* Insere registros na tabela "Itens pedido" */
INSERT INTO itens_pedido
(id_item_pedido, id_pedido, id_material, quantidade_pedida, valor_unitario)
VALUES
(1, 1, 10, 100, 0.50),
(2, 1, 13, 100, 0.25),
(3, 2, 8, 50, 1.30),
(4, 3, 11, 5, 76.00);

/* Mostra os registros da tabela "Itens pedidos" */
SELECT * FROM itens_pedido;

/* 1 - Nome do material e nome da unidade */
SELECT m.nome_material, u.nome_unidade
FROM materiais m
JOIN unidades u ON m.id_unidade = u.id_unidade
ORDER BY m.nome_material;

/* 2 - Nome do material e nome da unidade dos materiais vendidos em unidades */
SELECT m.nome_material, u.nome_unidade
FROM materiais m
JOIN unidades u ON m.id_unidade = u.id_unidade
WHERE u.nome_unidade = 'Unidades'
ORDER BY m.nome_material;

/* 3 - Quantidade de materiais por nome de unidade */
SELECT m.nome_material, u.nome_unidade, m.quantidade_estoque
FROM materiais m
JOIN unidades u ON m.id_unidade = u.id_unidade
ORDER BY u.nome_unidade;

/* 4 - Quantidade de materiais por nome de unidade, incluindo as unidade sem nenhum material relacionado */
SELECT u.nome_unidade, COALESCE(SUM(m.quantidade_estoque)) AS quantidade_total
FROM unidades u
LEFT JOIN materiais m ON m.id_unidade = u.id_unidade
GROUP BY u.nome_unidade
ORDER BY u.nome_unidade;

/* 5 - Nome do material, nome do fornecedor e nome da unidade */
SELECT m.nome_material, u.nome_unidade, f.nome_fornecedor
FROM materiais m
JOIN fornecedores f ON m.id_fornecedor = f.id_fornecedor
JOIN unidades u ON m.id_unidade = u.id_unidade
ORDER BY m.nome_material;

/* 6 - Nome do material e nome da unidade dos materiais vendidos por metro */
SELECT m.nome_material, u.nome_unidade
FROM materiais
JOIN unidades u ON m.id_unidade = u.id_unidade
WHERE u.nome_unidade = 'Metros'
ORDER BY u.nome_unidade;

/* 7 - Nome do material e nome da unidade dos materiais vendidos em caixas com 12 ou com 100 unidades */
SELECT m.nome_material, u.nome_unidade
FROM materiais
JOIN unidades u ON m.id_unidade = u.id_unidade
WHERE u.nome_unidade = 'Caixa com 12 unidades' OR u.nome_unidade = 'Caixa com 100 unidades'
ORDER BY u.nome_unidade;

/* 8 - Nome do material e sua quantidade em estoque */
SELECT nome_material, quantidade_estoque
FROM materiais
ORDER BY quantidade_estoque;

/* 9 - Nome do material e sua quantidade em estoque, apenas para materiais com menos de 10 unidades em estoque */
SELECT nome_material, quantidade_estoque
FROM materiais
WHERE quantidade_estoque < 10
ORDER BY quantidade_estoque;

/* 10 - Nome do material, sua quantidade em estoque e sua quantidade mínima em estoque */
SELECT nome_material, quantidade_estoque,quantidade_estoque_minima
FROM materiais
ORDER BY quantidade_estoque;

/* 11 - Nome do material, sua quantidade em estoque e sua quantidade mínima em estoque,
apenas para materiais onde a quantidade em estoque esteja abaixo da quantidade mínima em estoque */
SELECT nome_material, quantidade_estoque,quantidade_estoque_minima
FROM materiais
WHERE quantidade_estoque < quantidade_estoque_minima
ORDER BY quantidade_estoque;

/* 12 - Nome e cidade dos fornecedores */
SELECT nome_fornecedor, cidade
FROM fornecedores
ORDER BY nome_fornecedor;

/* 13 - Nome e cidade dos fornecedores da cidade de Curitiba */
SELECT nome_fornecedor, cidade
FROM fornecedores
WHERE cidade = 'Curitiba'
ORDER BY nome_fornecedor;

/* 14 - Nome dos fornecedores e seus materiais */
SELECT f.nome_fornecedor, m.nome_material
FROM fornecedores f
JOIN materiais m ON f.id_fornecedor = m.id_fornecedor
ORDER BY f.nome_fornecedor;

/* 15 - Nome dos fornecedores e seus materiais, inluindo os fornecedores sem nenhum material reacionado */
SELECT f.nome_fornecedor, COALESCE(m.nome_material, 'Sem material')
FROM fornecedores f
LEFT JOIN materiais m ON f.id_fornecedor = m.id_fornecedor
ORDER BY f.nome_fornecedor;

/* 16 - Nome dos fornecedores e quantidade de materiais fornecidos pelo mesmo */
SELECT f.nome_fornecedor, m.quantidade_estoque
FROM fornecedores f
JOIN materiais m ON f.id_fornecedor = m.id_fornecedor
ORDER BY f.nome_fornecedor;

/* 17 - Nome dos fornecedores e quantidade de materiais fornecidos pelo mesmo,
incluindo os fornecedores sem nenhum material relacionado */
SELECT f.nome_fornecedor, COALESCE( m.quantidade_estoque, 'Sem material')
FROM fornecedores f
LEFT JOIN materiais m ON f.id_fornecedor = m.id_fornecedor
ORDER BY f.nome_fornecedor;

/* 18 - Nome dos fornecedores e quantidade de materiais fornecidos pelo mesmo,
incluindo os fornecedores sem nenhum material relacionado,
apenas para fornecedores com menos de 5 materiais relacionados */

SELECT f.nome_fornecedor, COALESCE( m.quantidade_estoque) AS quantidade_materiais
FROM fornecedores f
LEFT JOIN materiais m ON f.id_fornecedor = m.id_fornecedor
GROUP BY f.nome_fornecedor, f.id_fornecedor
HAVING COUNT(m.id_material) < 5
ORDER BY f.nome_fornecedor;

/* 19 - Nome dos fornecedores, nome do material e sua quantidade em estoque */
SELECT f.nome_fornecedor, m.nome_material, m.quantidade_estoque
FROM fornecedores f
JOIN materiais m ON f.id_fornecedor = m.id_fornecedor
ORDER BY f.nome_fornecedor;

/* 20 - Nome dos fornecedores, nome do material e sua quantidade em estoque,
apenas para quatidade em estoque entre 10 e 20 */
SELECT f.nome_fornecedor, m.nome_material, m.quantidade_estoque
FROM fornecedores f
JOIN materiais m ON f.id_fornecedor = m.id_fornecedor
WHERE m.quantidade_estoque BETWEEN 10 AND 20
ORDER BY f.nome_fornecedor;

/* 21 - Nome do fornecedor, nome do material e nome da unidade,
apenas para fornecedores de materiais em unidades ou metros */
SELECT f.nome_fornecedor, m.nome_material, u.nome_unidade
FROM fornecedores f
JOIN materiais m ON f.id_fornecedor = m.id_fornecedor
JOIN unidades u ON m.id_unidade = u.id_unidade
WHERE u.nome_unidade = 'Unidades' OR u.nome_unidade = 'Metros'
ORDER BY f.nome_fornecedor;

/* 22 - Pedidos realizados em 2015 */
SELECT data_pedido FROM pedidos
WHERE YEAR(data_pedido) = 2015
ORDER BY data_pedido;

/* 23 - Pedidos realizados em fevereiro de 2015 */
SELECT data_pedido FROM pedidos
WHERE YEAR(data_pedido) = 2015 AND MONTH(data_pedido) = 2
ORDER BY data_pedido;


/* 24 - Número do pedido e o nome dos materiais constantes no pedido */
SELECT i.id_material m.nome_material
FROM itens_pedidos i
JOIN materiais m ON i.id_material = m.id_material
ORDER BY i.id_material;

/* 25 - Materiais que constam nos pedidos */
SELECT m.nome_material
FROM itens_pedidos i
JOIN materiais m ON i.id_material = m.id_material
ORDER BY m.nome_material;

/* 26 - Materiais que não constam nos pedidos */
SELECT COALESCE( m.nome_material, 'Sem material')
FROM itens_pedidos i
JOIN materiais m ON i.id_material = m.id_material
ORDER BY m.nome_material;

/* 27 - Número do pedido e a quantidade de itens em cada pedido */
SELECT id_pedido, SUM(quantidade_pedida) AS quantidade_total 
FROM itens_pedidos 
GROUP BY id_pedido
ORDER BY id_pedido;

/* 28 - Número do pedido e o valor total do pedido */
SELECT i.id_pedido, SUM(i.quantidade_pedida * i.valor_unitario) AS valor_total 
FROM itens_pedidos i
GROUP BY i.id_pedido
ORDER BY i.id_pedido;

/* 29 - Número do pedido e o valor total do pedido, apenas para pedidos com valor total abaixo de 100,00 */
SELECT i.id_pedido, SUM(i.quantidade_pedida * i.valor_unitario) AS valor_total 
FROM itens_pedidos i
GROUP BY i.id_pedido
HAVING SUM(i.quantidade_pedida * i.valor_unitario) < 100
ORDER BY i.id_pedido;
/* 30 - Insira mais um fornecedor no banco de dados */
INSERT INTO fornecedores (id_fornecedor, nome_fornecedor, cidade, uf)
VALUES 

(5, 'Distribuidora de Materiais Curitiba', 'Curitiba', 'PR');

select * from fornecedores;

/* 31 - Insira mais 2 materiais para o fornecedor inserido no item 30 */
INSERT INTO materiais(id_material , id_fornecedor, nome_material, quantidade_estoque, quantidade_estoque_minima, id_unidade)
VALUES
(14, 5, 'Borracha', 100, 10, 1),
(15, 5, 'Apontador', 100, 10, 1);

select * from materiais;

/* 32 - Insira mais um pedido no banco de dados */
INSERT INTO pedidos(id_pedido, data_pedido)

VALUES
(4, '2021-10-21');

SELECT * FROM pedidos;

/* 33 - Insira 2 itens de pedido no banco de dados, utilizando os dados inseridos nos itens 30, 31 e 32 */ 
INSERT INTO itens_pedido(id_item_pedido, id_pedido, id_material, quantidade_pedida, valor_unitario)

VALUES
(5, 4, 14, 100, 0.40),
(6, 4, 15, 100, 0.20);

SELECT * FROM itens_pedido;

/* 34 - Número do pedido e o valor total do pedido inserido no item 32 */
SELECT i.id_pedido, SUM(i.quantidade_pedida * i.valor_unitario) AS valor_total
FROM itens_pedido i
WHERE i.id_pedido = 4
GROUP BY i.id_pedido
ORDER BY i.id_pedido;

/* 35 - Exclua o material "Tomada elétrica 10A padrão novo" do banco de dados */
DELETE FROM materiais
WHERE nome_material = 'Tomada elétrica 10A padrão novo';

SELECT * FROM materiais;

/* 36 - Exclua o material "Lápis Preto HB" do banco de dados */
DELETE FROM materiais
WHERE nome_material = 'Lápis Preto HB';

SELECT * FROM itens_pedido;


SELECT * FROM materiais;

/* 37 - Exclua o fornecedor "HidraX Materiais Elétricos e Hidraulicos" do banco de dados */
DELETE FROM fornecedores
WHERE nome_fornecedor = 'HidraX Materiais Elétricos e Hidraulicos';

SELECT * FROM fornecedores;

/* 38 - Exclua o fornecedor "XYZ Materiais de Escritório" do banco de dados */
DELETE FROM fornecedores
WHERE nome_fornecedor = 'XYZ Materiais de Escritório';
SELECT * FROM materiais;


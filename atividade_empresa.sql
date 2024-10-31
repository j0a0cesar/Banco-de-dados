/* Exclui o banco de dados "empresa", caso o banco de dados exista */
drop database if exists empresa;

/* Cria o banco de dados empresa */
create database empresa;

/* Define o banco de dados "empresa" como o banco de dados atual */
use empresa;

/* Cria a tabela "categorias" */
create table categorias(
	id_categoria int not null,
    nome_categoria varchar (40) not null,
	primary key (id_categoria)
);

/* Cria a tabela "produtos" */
create table produtos(
	id_produto int not null,
    nome_produto varchar (40) not null,
	quantidade int,
    preco decimal(5,2),
    id_categoria int not null,
	primary key (id_produto),
    foreign key (id_categoria) references categorias(id_categoria)
);

/* Insere os registros na tabela "categorias" */
insert into categorias
(id_categoria, nome_categoria)
values
('1', 'Madeira'),
('2', 'Luxo'),
('3', 'Vintage'),
('4', 'Moderno'),
('5', 'Super luxo');

/* Mostra os registros da tabela "categorias" */
select * from categorias;

/* Insere os registros na tabela "produtos" */
insert into produtos
(id_produto, nome_produto, quantidade, preco, id_categoria)
values
('1', 'Guarda-roupa de duas portas', '100', '800', '1'),
('2', 'Mesa de jantar', '1000', '560', '3'),
('3', 'Porta toalha', '10000', '25.50', '4'),
('4', 'Mesa de computador', '350', '320.50', '2'),
('5', 'Cadeira', '3000', '210.65', '4'),
('6', 'Cama de solteiro', '750', '460', '1');

/* Mostra os registros da tabela "produtos" */
select * from produtos;

/* Mostra o nome e categoria dos produtos sem join*/
select nome_produto, (select nome_categoria from categorias where id_categoria = p.id_categoria) as nome_categoria from produtos p;

/* Mostra o nome e categoria dos produtos utilizando join*/
select p.nome_produto, c.nome_categoria
from produtos p
join categorias c on p.id_categoria = c.id_categoria;

/* Mostra o nome e quantidade de produtos por categoria utilizando join*/
select p.nome_produto, p.quantidade
from produtos p
join categorias c on p.id_categoria = c.id_categoria;

/* Mostra o nome e quantidade de produtos por categoria, inclusive das categorias sem produtos utilizando join*/  
select p.nome_produto,c.nome_categoria, coalesce(p.quantidade, 0) as quantidade
from categorias c
left join produtos p on p.id_categoria = c.id_categoria;

/* Mostra o nome e preço médio dos produtos por categoria utilizando join*/
select c.nome_categoria, avg(p.preco) as preco_medio
from categorias c
join produtos p on c.id_categoria = p.id_categoria
group by c.nome_categoria;

/* Mostra o nome e preço médio dos produtos por categoria utilizando join.
O comando "round" mostra apenas 2 casas decimais, com arredondamento*/
select c.nome_categoria, round(avg(p.preco),2) as preco_medio
from categorias c
join produtos p on c.id_categoria = p.id_categoria
group by c.nome_categoria;

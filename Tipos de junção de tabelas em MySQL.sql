/* Exclui o banco de dados "tipos_juncao", caso o banco de dados exista */
drop database if exists tipos_juncao;

/* Cria o banco de dados "tipos_juncao" */
create database tipos_juncao;

/* Define o banco de dados "tipos_juncao" como o banco de dados atual */
use tipos_juncao;

/* Cria a tabela "tabelaA" */
create table tabelaA(
	nome varchar(40)
);

/* Cria a tabela "tabelaB" */
create table tabelaB(
	nome varchar(40)
);

/* Insere registros na "tabelaA" */
insert into tabelaA
(nome)
values
('Fernanda'),
('José'),
('Luiz'),
('Fernando');

/* Mostra os registros da "tabelaA" */
select * from tabelaA;

/* Insere registros na "tabelaB" */
insert into tabelaB
(nome)
values
('Carlos'),
('Manoel'),
('Luiz'),
('Fernando');

/* Mostra os registros da "tabelaB" */
select * from tabelaB;

/* JOIN (ou INNER JOIN): é o método de junção mais conhecido e retorna os registros que são comuns às duas tabelas */
select tabelaA.nome, tabelaB.nome
from tabelaA join tabelaB
on tabelaA.nome = tabelaB.nome;

/* Uso de apelidos para as tabelas */
select a.nome, b.nome
from tabelaA as a join tabelaB as B
on a.nome = b.nome;

/* Caso o nome do campo de ligação tenha o mesmo nome em ambas as tabelas, poderá ser usado a cláscula USING
no lugar da cláusla ON */
select a.nome, b.nome
from tabelaA as a join tabelaB as B
using(nome);

/* LEFT JOIN: retorna todos os registros que estão na tabela A (mesmo que não estejam na tabela B)
e os registros da tabela B que são comuns à tabela A */
select tabelaA.nome, tabelaB.nome
from tabelaA left join tabelaB
on tabelaA.nome = tabelaB.nome;

/* RIGHT JOIN: retorna todos os registros que estão na tabela B (mesmo que não estejam na tabela A)
e os registros da tabela A que são comuns à tabela B */
select tabelaA.nome, tabelaB.nome
from tabelaA right join tabelaB
on tabelaA.nome = tabelaB.nome;

/* LEFT EXCLUDING JOIN: retorna todos os registros que estão na tabela A e que não estejam na tabela B */
select tabelaA.nome, tabelaB.nome
from tabelaA left join tabelaB
on tabelaA.nome = tabelaB.nome
where tabelaB.nome is null;

/* RIGHT EXCLUDING JOIN: retorna todos os registros que estão na tabela B e que não estejam na tabela A */
select tabelaA.nome, tabelaB.nome
from tabelaA right join tabelaB
on tabelaA.nome = tabelaB.nome
where tabelaA.nome is null;

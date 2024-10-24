/* Exclui o banco de dados "um_para_muitos", caso o banco de dados exista */
drop database if exists um_para_muitos;

/* Cria o banco de dados "um_para_muitos" */
create database um_para_muitos;

/* Define o banco de dados "um_para_muitos" como o banco de dados atual */
use um_para_muitos;

/* Cria a tabela "funcionarios" */
create table funcionarios(
	id_funcionario int not null,
    nome_funcionario varchar (40) not null,
	cargo varchar(20), 
	primary key (id_funcionario)
);

/* Cria a tabela "dependentes" */
create table dependentes(
	id_dependente int not null,
    id_funcionario int not null,
    nome_dependente varchar (40) not null,
	parentesco enum('Filho', 'Filha', 'Cônjuge'), 
	primary key (id_dependente),
    foreign key (id_funcionario) references funcionarios(id_funcionario)
);

/* Insere registros na tabela "funcionarios" */
insert into funcionarios
(id_funcionario, nome_funcionario, cargo)
values
('1', 'Marcelo', 'Auxiliar'),
('2', 'Antonio', 'Gerente'),
('3', 'Pedro', 'Técnico');

/* Mostra os registros da tabela "funcionarios" */
select * from funcionarios;

/* Insere registros na tabela "dependentes" */
insert into dependentes
(id_dependente, id_funcionario, nome_dependente, parentesco)
values
('1', '1', 'Sonia', 'Cônjuge'),
('2', '1', 'Ana', 'Filha'),
('3', '1', 'Pedro', 'Filho'),
('4', '2', 'Beatriz', 'Cônjuge');

/* Mostra os registros da tabela "dependentes" */
select * from dependentes;

/* Mostra os funcionarios e seus dependentes */
select funcionarios.nome_funcionario, funcionarios.cargo, dependentes.nome_dependente, dependentes.parentesco
from funcionarios, dependentes
where funcionarios.id_funcionario = dependentes.id_funcionario;

/* Mostra os funcionarios e seus dependentes */
select funcionarios.nome_funcionario, funcionarios.cargo, dependentes.nome_dependente, dependentes.parentesco
from funcionarios join dependentes
on funcionarios.id_funcionario = dependentes.id_funcionario;

/* Mostra os funcionarios e seus dependentes. Uso de apelidos para as tabelas */
select f.nome_funcionario, f.cargo, d.nome_dependente, d.parentesco
from funcionarios as f join dependentes as d
on f.id_funcionario = d.id_funcionario;

/* Mostra os funcionarios e seus dependentes. Mostra também os funcionários sem dependentes */
select funcionarios.nome_funcionario, funcionarios.cargo, dependentes.nome_dependente, dependentes.parentesco
from funcionarios left outer join dependentes
on funcionarios.id_funcionario = dependentes.id_funcionario;

/* Mostra a quantidade de dependentes por funcionário */
select funcionarios.nome_funcionario, count(dependentes.id_dependente) as num_dependentes
from funcionarios join dependentes
on funcionarios.id_funcionario = dependentes.id_funcionario
group by funcionarios.nome_funcionario;

/* Mostra a quantidade de dependentes por funcionário, inclusive pra os funcionários sem dependentes */
select funcionarios.nome_funcionario, count(dependentes.id_dependente) as num_dependentes
from funcionarios left outer join dependentes
on funcionarios.id_funcionario = dependentes.id_funcionario
group by funcionarios.nome_funcionario;

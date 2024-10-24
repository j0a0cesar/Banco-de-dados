/* Exclui o banco de dados "um_para_um", caso o banco de dados exista */
drop database if exists um_para_um;

/* Cria o banco de dados "um_para_um" */
create database um_para_um;

/* Define o banco de dados "um_para_um" como o banco de dados atual */
use um_para_um;

/* Cria a tabela "maridos" */
create table maridos(
	id_marido int not null,
    nome_marido varchar (40) not null,
	data_nascimento date, 
	primary key (id_marido)
);

/* Cria a tabela "esposas" */
create table esposas(
	id_esposa int not null,
    id_marido int not null unique,
    nome_esposa varchar (40) not null,
	data_nascimento date, 
	primary key (id_esposa),
    foreign key (id_marido) references maridos(id_marido)
);

/* Insere registros na tabela "maridos" */
insert into maridos
(id_marido, nome_marido, data_nascimento)
values
('1', 'Marcelo', '1969-03-02'),
('2', 'Antonio', '1977-12-30'),
('3', 'Pedro', '1992-06-25');

/* Mostra os registros da tabela "maridos" */
select * from maridos;

/* Insere registros na tabela "esposas" */
insert into esposas
(id_esposa, id_marido, nome_esposa, data_nascimento)
values
('1', '1', 'Sonia', '1973-03-28'),
('2', '2', 'Ana', '1981-11-15');

/* Mostra os registros da tabela "esposas" */
select * from esposas;

/* Mostra os maridos juntamente com suas esposas */
select maridos.nome_marido, esposas.nome_esposa
from maridos, esposas
where maridos.id_marido = esposas.id_marido;

/* Mostra os maridos juntamente com suas esposas. Mariidos sem esposa não aparecem na listagem.
Pode também ser usado "inner join" com o mesmo efeito.
O "join" relaciona as tabelas e o "on" liga a chave primária à chave estrangeira das tabelas */
select maridos.nome_marido, esposas.nome_esposa
from maridos join esposas
on maridos.id_marido = esposas.id_marido;

/* Usando order by */
select maridos.nome_marido, esposas.nome_esposa
from maridos join esposas
on maridos.id_marido = esposas.id_marido
order by maridos.nome_marido;

/* Uso de apelidos para as tabelas */
select m.nome_marido, e.nome_esposa
from maridos as m join esposas as e
on m.id_marido = e.id_marido
order by m.nome_marido;

/* Mostra todos os maridos, inclusive os maridos sem esposa. O comando "outer join* considera 
todos os registros, inclusive os que não possuam nenhum relação. O comando "left outer join"
considera todos os registros a esquerda do "join" e o comando "right outer join" considera todos
os registros a direita do "join" */
select m.nome_marido, e.nome_esposa
from maridos as m left outer join esposas as e
on m.id_marido = e.id_marido
order by m.nome_marido;

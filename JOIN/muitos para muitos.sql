/* Exclui o banco de dados "muitos_para_muitos", caso o banco de dados exista */
drop database if exists muitos_para_muitos;

/* Cria o banco de dados "muitos_para_muitos" */
create database muitos_para_muitos;

/* Define o banco de dados "muitos_para_muitos" como o banco de dados atual */
use muitos_para_muitos;

/* Cria a tabela "estudantes" */
create table estudantes(
	id_estudante int not null,
    nome_estudante varchar (40) not null,
	primary key (id_estudante)
);

/* Cria a tabela "disciplinas" */
create table disciplinas(
	id_disciplina int not null,
    nome_disciplina varchar (40) not null,
	primary key (id_disciplina)
);

/* Cria a tabela "notas" */
create table notas(
	id_estudante_nota int not null,
    id_estudante int not null,
    id_disciplina int not null,
    nota decimal(3,1),
    primary key(id_estudante_nota),
	foreign key (id_estudante) references estudantes(id_estudante),
    foreign key (id_disciplina) references disciplinas(id_disciplina)
);

/* Insere registros na tabela "estudantes" */
insert into estudantes
(id_estudante, nome_estudante)
values
('1', 'André'),
('2', 'Bernardo'),
('3', 'Carolina');

/* Mostra os registros da tabela "estudantes" */
select * from estudantes;

/* Insere registros na tabela "disciplinas" */
insert into disciplinas
(id_disciplina, nome_disciplina)
values
('1', 'Banco de dados'),
('2', 'Algoritmos de programação'),
('3', 'Programação de computadores');

/* Mostra os registros da tabela "disciplinas" */
select * from disciplinas;

/* Insere registros na tabela "estudante_notas" */
insert into notas
(id_estudante_nota, id_estudante, id_disciplina, nota)
values
('1', '1', '1', '10'),
('2', '1', '2', '9.5'),
('3', '2', '1', '6.5'),
('4', '2', '2', '8');

/* Mostra os registros da tabela "notas" */
select * from notas;

/* Mostra o nome do estudante e sua nota */
select estudantes.nome_estudante, notas.nota
from estudantes, notas
where estudantes.id_estudante = notas.id_estudante;

/* Mostra o nome do estudante e sua nota */
select estudantes.nome_estudante, notas.nota
from estudantes  join notas
on estudantes.id_estudante = notas.id_estudante;

/* Mostra o nome da disciplina, o nome do estudante e a sua nota */
select estudantes.nome_estudante, disciplinas.nome_disciplina, notas.nota
from estudantes, disciplinas, notas
where estudantes.id_estudante = notas.id_estudante and disciplinas.id_disciplina = notas.id_disciplina;

/* Mostra o nome do estudante, o nome da disciplina e a sua nota */
select estudantes.nome_estudante, disciplinas.nome_disciplina, notas.nota
from estudantes join notas
on estudantes.id_estudante = notas.id_estudante
join disciplinas
on disciplinas.id_disciplina = notas.id_disciplina;

/* Mostra o nome do estudante, o nome da disciplina e a sua nota. Uso de apelidos para as tabelas */
select e.nome_estudante, d.nome_disciplina, n.nota
from estudantes as e join notas as n
on e.id_estudante = n.id_estudante
join disciplinas as d
on d.id_disciplina = n.id_disciplina;

/* Mostra a média dos estudantes nas disciplinas */
select estudantes.nome_estudante, avg(notas.nota) as media
from estudantes join notas
on estudantes.id_estudante = notas.id_estudante
group by estudantes.nome_estudante;

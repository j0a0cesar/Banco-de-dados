create database aula_views;

use aula_views;

create table departamento(
deptoID varchar(10) primary key,
depto varchar(30)
);

create table item(
itemID varchar(10) primary key,
item varchar(30)
);

create table requisicoes(
reqID varchar(10) primary key,
deptoID varchar(10),
itemID varchar(10),
qtd int,
precounit float(6,2),
foreign key (deptoID) references departamento(deptoID),
foreign key (itemID) references item(itemID)
);

insert into departamento values
('D001','RH'), 
('D002','Financeiro'), 
('D003','Producao'),
('D004','TI');

insert into item values
('I001','Papel'),
('I002','Caneta'),
('I003','NoteBook'),
('I004','Impressora');

insert into requisicoes values
('Q001','D002', 'I001',500,0.3),
('Q002','D004', 'I002',40,2.5),
('Q003','D001', 'I003',5,0.3),
('Q004','D001', 'I004',2,650);

Create view vwRequisicoes
as
Select 
    r.reqID,
    d.deptoID,
    d.depto,
    i.itemID,
    i.item,
    r.qtd,
    r.precounit,
    (r.qtd * r.precounit) as total
from requisicoes r
inner join departamento d on r.deptoID = d.deptoID
inner join item i on i.itemID = r.itemID;

SELECT * FROM aula_views.vwrequisicoes;

/* Crie uma view que mostre as descrições dos departamentos e dos produtos, 
bem como a quantidade e preço unitário dos produtos requisitados */

create view vwDescdepart
as
select
d.depto,
i.item,
r.qtd,
r.precounit
from requisicoes r
inner join departamento d on r.deptoID = d.deptoID
inner join item i on i.itemID = r.itemID;
SELECT * FROM aula_views.vwDescdepart;

/* Crie uma view que mostre o total de produtos (qtd e preço) comprados por departamento */


create view vwCompras
as
select
d.depto,
(r.qtd*r.precounit) as total
from requisicoes r
inner join departamento d on r.deptoID = d.deptoID
inner join item i on i.itemID = r.itemID;

SELECT * FROM aula_views.vwCompras;










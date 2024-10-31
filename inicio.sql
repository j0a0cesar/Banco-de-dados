/* Exclui o banco de dados "empresa", caso o banco de dados exista */
drop database if exists empresa;

/* Cria o banco de dados "empresa" */
create database empresa;
/* Define o banco de dados "empresa" como o banco de dados atual */
use empresa;
/* Cria a tabela "fornecedores" id_fornecedor (pk), nome_fornecedor, cidade, uf.*/
create table fornecedores(
 id_fornecedores int not null primary key,
 nome_fornecedor varchar(40),
 cidade varchar(40),
 uf varchar(2),
 foreign key (id_fornecedor) references materias(id_fornecedor)
);
/* Cria a tabela "unidades" id_unidade (pk), nome_unidade*/
create table unidades(
 id_unidades int not null primary key,
 nome_unidade varchar(11),
 foreign key (id_unidades) references materias(id_unidades)
);
/* Cria a tabela "materiais" id_material (pk), id_fornecedor (fk), nome_material, quantidade_estoque, quantidade_estoque_minima, id_unidade (fk)*/
create table materias(
id_materias int not null primary key,
id_fornecedor varchar(11),
nome_material varchar(40),
quantidade_estoque int,
quantidade_estoque_minima smallint,
id_unidades varchar(11),
foreign key (id_pedido) references itens_pedidos(id_pedido)
);

/* Cria a tabela "pedidos" id_pedido (pk), data_pedido;*/
create table pedidos(
id_pedido int not null primary key,
data_pedido varchar(8),
foreign key (id_pedido) references itens_pedidos(id_pedido)
);
/* Cria a tabela "itens_pedido"  id_item_pedido (pk), id_pedido (fk), id_material (fk), quantidade_pedida, valor_unitario */
create table intens_pedido(
id_item_pedido int not null primary key,
id_pedido int not null,
id_material
quamtidade_pedida
valor
);

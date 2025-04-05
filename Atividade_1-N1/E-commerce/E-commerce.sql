create table Clientes(
    id_cliente serial not null primary key,
    nome varchar(50) not null,
    email varchar(50) not null,
    data_cadastro date not null
);

create table Produtos(
    id_produto serial not null primary key,
    nome varchar(50) not null,
    preco numeric(10, 2) not null, 
    categoria varchar(50) not null
);

create table Pedidos(
    id_pedido serial not null primary key,
    id_cliente int not null,
    constraint fk_idcliente_pedidos foreign key (id_cliente) references Clientes(id_cliente),
    data_pedido date not null
);

create table Itens_pedido(
    id_itenspedido serial not null primary key,
    id_pedido int not null,
    constraint fk_idpedido_itens foreign key (id_pedido) references Pedidos(id_pedido),
    id_produto int not null,
    constraint fk_idproduto_itens foreign key (id_produto) references Produtos(id_produto),
    qtd int not null,
    preco_unitario numeric(10, 2) not null  
);

insert into Clientes (nome, email, data_cadastro) values
('João Silva', 'joao.silva@gmail.com', '2024-01-15'),
('Maria Oliveira', 'maria.oliveira@gmail.com', '2024-02-20'),
('Carlos Souza', 'carlos.souza@gmail.com', '2024-03-25'),
('Ana Costa', 'ana.costa@gmail.com', '2024-04-10'),
('Pedro Santos', 'pedro.santos@gmail.com', '2024-05-05');

insert into Produtos (nome, preco, categoria) values
('Notebook', 3500.00, 'Eletronico'),
('Smartphone', 2000.00, 'Eletronico'),
('Geladeira', 2500.00, 'Eletrodomestico'),
('Fogão', 1500.00, 'Eletrodomestico'),
('Micro-ondas', 800.00, 'Eletrodomestico');

insert into Pedidos (id_cliente, data_pedido) values
(1, '2024-06-15'),
(2, '2024-07-20'),
(3, '2024-08-25'),
(4, '2024-09-10'),
(5, '2024-10-05');

insert into Itens_pedido (id_pedido, id_produto, qtd, preco_unitario) values
(1, 1, 1, 3500.00),
(1, 2, 2, 2000.00),
(2, 3, 1, 2500.00),
(3, 4, 1, 1500.00),
(3, 5, 1, 800.00),
(4, 1, 1, 3500.00),
(5, 2, 1, 2000.00),
(5, 3, 1, 2500.00);

select nome, email from Clientes;

select nome from Produtos where categoria = 'Eletronico';

select id_pedido, id_cliente, data_pedido from Pedidos order by data_pedido desc;

select id_pedido, sum(qtd * preco_unitario) as total_pedido 
from Itens_pedido 
where id_pedido = 1 
group by id_pedido;

select c.id_cliente, c.nome, count(p.id_pedido) as total_pedidos 
from Clientes c
left join Pedidos p on c.id_cliente = p.id_cliente
group by c.id_cliente, c.nome
order by total_pedidos desc;

select c.id_cliente, c.nome, count(p.id_pedido) as total_pedidos
from Clientes c
join Pedidos p on c.id_cliente = p.id_cliente
group by c.id_cliente, c.nome
having count(p.id_pedido) > 1
order by total_pedidos desc;
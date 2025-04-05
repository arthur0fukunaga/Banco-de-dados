create table Atletas (
    id_atleta serial primary key,
    nome varchar(50) not null,
    data_nascimento date not null,
    pais varchar(50)
);

create table Competicoes (
    id_competicao serial primary key,
    nome varchar(50) not null,
    data_competicao date not null,
    local_competicao varchar(50) not null
);

create table Resultados (
    id_resultado serial primary key,
    id_atleta int not null,
    constraint fk_idatleta_resultados foreign key (id_atleta) references Atletas(id_atleta),
    id_competicao int not null,
    constraint fk_idcompeticao_resultados foreign key (id_competicao) references Competicoes(id_competicao),
    tempo interval not null,  
    posicao int not null
);

insert into Atletas(nome, data_nascimento, pais) values
('João Silva', '1990-05-15', 'Brasil'),
('Maria Oliveira', '1988-08-22', 'Portugal'),
('Carlos Souza', '1992-03-10', 'Brasil'),
('Pedro Santos', '1985-12-05', 'Argentina'),
('Ana Costa', '1986-10-10', 'Argentina');

insert into Competicoes(nome, data_competicao, local_competicao) values
('Competição A', '1990-05-15', 'Rio de Janeiro'),
('Competição B', '1988-08-22', 'Lisboa'),
('Competição C', '1992-03-10', 'Madri');

insert into Resultados(id_atleta, id_competicao, tempo, posicao) values
(1, 1, '02:15:30', 1),
(2, 1, '02:20:45', 2),
(3, 1, '02:25:50', 3),
(4, 2, '02:30:00', 1),
(5, 2, '02:35:15', 2),
(1, 3, '02:40:20', 1),
(2, 3, '02:45:25', 2),
(3, 3, '02:50:30', 3);

select pais from Atletas;

select nome from Atletas where pais = 'Brasil';

select * from Resultados where id_competicao = 1;

select avg(tempo) from Resultados;

select r.id_atleta, a.nome, count(r.id_competicao) as total_competicoes
from Resultados r
join Atletas a on r.id_atleta = a.id_atleta
group by r.id_atleta, a.nome;

select r.id_atleta, a.nome, count(r.id_competicao) as total_competicoes
from Resultados r
join Atletas a on r.id_atleta = a.id_atleta
group by r.id_atleta, a.nome
having count(r.id_competicao) > 1;


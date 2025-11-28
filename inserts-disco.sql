-------------------------------------------------------- \\ 

-- inserts para popular as tabelas

insert into endereco 
(id_endereco, rua, cidade, cep, estado, telefone_residencial)
values
(1, 'rua 123, 10', 'blumenau', '0000-001', 'sc', '999999999999'),
(2, 'rua 321, 9', 'chapecó', '0000-002', 'sc', '88888888888888'),
(3, 'rua 231, 8', 'indaial', '0000-003', 'sc', '77777777777'),
(4, 'rua 312, 7', 'timbo', '0000-004', 'sc', '89898198998'),
(5, 'rua 311, 6', 'brusque', '0000-005', 'sc', '99999999119');


insert into musico 
(numero_bi, nome, telefone, id_endereco) 
values
('33333333333','adele','900000001',1),
('44444444444','britney spears','900000002',2),
('55555555555','madonna','900000003',2),
('22222222222','dj juninho','900000010',1);

insert into musico 
(numero_bi, nome, id_endereco) 
values
('11111111111','alice in chains',1);

insert into instrumentos 
(id_instrumento, nome) 
values
(1, 'guitarra'),
(2, 'bateria'),
(3, 'baixo');

-- aumentar o tamanho do nome da gravadora que coloquei só 10 antes
insert into gravadora 
(id_gravadora, nome) 
values
(1, 'blumenau'),
(2, 'sony'),
(3, 'eletrohits');

insert into artista
(id_artista, nome, id_gravadora)
values
(1, 'adele', 1),
(2, 'britney spears', 2),
(3, 'dj juninho', 3);

insert into genero 
(id_genero, nome)
values
(1, 'pop'),
(2, 'rock'),
(3, 'indie');

insert into participacao 
(id_musica, numero_bi, funcao) 
values
(1, '33333333333', 'guitarra'),
(2, '33333333333', 'baixo'),
(3, '44444444444', 'bateria'),
(4, '44444444444', 'dança'),
(5, '55555555555', 'voz');

insert into plano 
(id_plano, nome, limite_downloads, valor) 
values
(1, 'basico', 10, 7.00000),
(2, 'premium', 100, 14.00000),
(3, 'ilimitado', 200, 28.00000);


insert into cliente 
(id_cliente, id_plano, nome, cliente_telefone)
values
(1, 1, 'alice', '912000001'),
(2, 2, 'mae dj juninho', '912000002'),
(3, 1, 'lorena', '912000003'),
(4, 3, 'matheus jr', '912000004');

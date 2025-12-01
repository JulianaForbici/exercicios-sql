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
('22222222222','selena','900000010',1);


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

insert into gravadora 
(id_gravadora, nome) 
values
(1, 'blumenau'),
(2, 'sony'),
(3, 'eletrohits');

insert into gravadora 
(id_gravadora, nome) 
values
(5, 'universal music');

insert into gravadora 
(id_gravadora, nome) 
values
(4, 'gravadora nova');

insert into genero 
(id_genero, nome)
values
(1, 'pop'),
(2, 'rock'),
(3, 'indie');

insert into plano 
(id_plano, nome, limite_downloads, valor) 
values
(1, 'basico', 10, 7.00),
(2, 'premium', 100, 14.00),
(3, 'ilimitado', 200, 28.00);

insert into plano 
(id_plano, nome, limite_downloads, valor) 
values
(4, 'gratis', 1, 0.00);

insert into cliente
(id_cliente, id_plano, nome, cliente_telefone)
values
(1, 1, 'alice', '912000001'),
(2, 2, 'cliente1', '912000002'),
(3, 1, 'lorena', '912000003'),
(4, 3, 'matheus jr', '912000004');


insert into disco 
(id_disco, titulo, data, formato, id_musico, id_gravadora)
values
(1, 'adele',  '2015-11-20', 'CD', '33333333333', 1),
(2, 'britney','2000-05-16', 'CD', '44444444444', 2),
(3, 'madonna','2005-03-15', 'K7', '55555555555', 3),
(4, 'selena', '2020-10-20', 'MC', '22222222222', 1);

insert into disco 
(id_disco, titulo, data, formato, id_musico, id_gravadora)
values
(5, 'adele','2020-03-15', 'K7', '55555555555', 5);

insert into disco 
(id_disco, titulo, data, formato, id_musico, id_gravadora)
values
(6, 'alice in chains - musica', '2013-10-22', 'MC', '11111111111', 5);


insert into musica 
(id_musica, titulo, autor, id_disco, id_genero, numero_bi) 
values
(1, 'hello','adele',1, 1, '33333333333'),
(2, 'goodbye','adele', 1, 1, '33333333333'),
(3, 'toxic','britney spears',  2, 1, '44444444444'),
(4, 'oops','britney spears', 2, 1, '44444444444'),
(5, 'hung up','madonna', 3, 1, '55555555555');

insert into musica 
(id_musica, titulo, autor, id_disco, id_genero, numero_bi) 
values
(6, 'universal','adele',5, 1, '33333333333');

insert into musica
(id_musica, titulo, autor, id_disco, id_genero, numero_bi)
values
(7, 'musica do album', 'alice in chains', 6, 2, '11111111111');


insert into musico_instrumento (numero_bi, id_instrumento)
values
('33333333333', 1),
('33333333333', 3),
('44444444444', 2),
('55555555555', 1),
('22222222222', 1),
('11111111111', 2);


insert into download 
(id_download, id_cliente, id_musica) 
values
(1, 1, 1),
(2, 1, 2),
(3, 1, 5),
(4, 3, 1),
(5, 3, 3),
(6, 2, 3),
(7, 2, 4),
(8, 2, 5),
(9, 4, 1),
(10, 4, 2),
(11, 4, 3),
(12, 4, 4),
(13, 4, 5);

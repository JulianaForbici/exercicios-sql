--  o endereço existe independentemente e pode ser compartilhado por vários músicos;
create table endereco(
id_endereco int not null,
rua varchar(255) not null,
cidade varchar(50) not null,
cep varchar(8), 
estado varchar(30),
telefone_residencial varchar(20),
primary key (id_endereco));

-- o numero_bi identifica o musico, ja o id_endereco relaciona o musico a um endereço (opcional)
create table musico(
numero_bi varchar(11) not null,
nome varchar(255) not null,
telefone varchar(20),
id_endereco int references endereco(id_endereco),  
primary key (numero_bi),
foreign key (id_endereco) references endereco (id_endereco)); 

-- uma gravadora publica varios discos, mas cada disco pertence a 1 gravadora
create table gravadora(
id_gravadora int not null,
nome varchar(155),
primary key (id_gravadora));

create table instrumentos(
id_instrumento int not null,
nome varchar(100) not null,
primary key (id_instrumento));

-- um músico pode tocar vários instrumentos, mas um instrumento pode ser tocado por vários músicos
-- associação: Musico <> Instrumento
create table musico_instrumento(
numero_bi varchar(11) not null,
id_instrumento int not null,
primary key (numero_bi, id_instrumento),
foreign key (numero_bi) references musico(numero_bi),
foreign key (id_instrumento) references instrumentos (id_instrumento));

-- disco aponta para o músico produtor e para a gravadora que o publica
create table disco(
id_disco int not null,
titulo varchar(255) not null,
data date not null,
formato varchar(2) not null,
id_musico varchar(11) not null,
id_gravadora int not null,
foreign key (id_musico) references musico (numero_bi),
foreign key (id_gravadora) references gravadora(id_gravadora),
primary key (id_disco));

-- genero classifica músicas, ele existe independentemente das músicas
create table genero(
id_genero int not null,
nome varchar(155),
primary key (id_genero));

-- a musica é parte de um disco, tem genero e musico/autor registrados
create table musica(
id_musica int not null,
titulo varchar(255) not null,
autor varchar(255) not null, 
id_disco int not null,
id_genero int not null,
numero_bi varchar(11) not null,    
primary key (id_musica),
foreign key (id_genero) references genero (id_genero),
foreign key (id_disco) references disco (id_disco),
foreign key (numero_bi) references musico (numero_bi));

-- registra quais músicos participaram de cada música e qual função desempenharam
create table participacao(
id_musica int not null,
numero_bi varchar(11) not null,
funcao varchar(155) not null,
primary key (id_musica, numero_bi),
foreign key (id_musica) references musica(id_musica),
foreign key (numero_bi) references musico(numero_bi));

-- planos de assinatura (limite e preço)
create table plano(
id_plano int not null,
nome varchar(155) not null,
limite_downloads int not null,
valor decimal (8,2),
primary key (id_plano));

-- cliente está inscrito em um plano mas um plano pode ter vários clientes
create table cliente(
id_cliente int not null,
id_plano int not null,
nome varchar(155) not null,
cliente_telefone varchar(20),
primary key(id_cliente),
foreign key (id_plano) references plano(id_plano));

-- download registra qual cliente baixou qual musica
create table download(
id_download int not null,
id_cliente int not null,
id_musica int not null,
primary key (id_download),
foreign key (id_cliente) references cliente(id_cliente),
foreign key (id_musica) references musica(id_musica));

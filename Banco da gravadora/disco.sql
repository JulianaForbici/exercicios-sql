-- Endereço existe de forma independente e pode ser compartilhado por varios musicos
-- é uma entidade própria, não dependente do musico
create table endereco(
    id_endereco int not null,
    rua varchar(255) not null,
    cidade varchar(50) not null,
    cep varchar(8), 
    estado varchar(30),
    telefone_residencial varchar(20),
    primary key (id_endereco)
);

-- Relacionamento MÚSICO -> ENDEREÇO é uma ASSOCIAÇÃO 1:N:
--  - um endereço pode ser usado por vários músicos
--  - o endereço não depende do músico para existir
--  - id_endereco é opcional (músico pode não ter endereço cadastrado)
create table musico(
    numero_bi varchar(11) not null,     -- identificador do músico
    nome varchar(255) not null,
    telefone varchar(20),
    id_endereco int references endereco(id_endereco),  -- FK de associação (1 endereço pode ser de vários músicos)
    primary key (numero_bi),
    foreign key (id_endereco) references endereco (id_endereco)
); 


-- Gravadora é uma entidade independente.
create table gravadora(
    id_gravadora int not null,
    nome varchar(155),
    primary key (id_gravadora)
);

-- Instrumento também é entidade independente.
create table instrumentos(
    id_instrumento int not null,
    nome varchar(100) not null,
    primary key (id_instrumento)
);

-- Um músico pode tocar vários instrumentos e um instrumento pode ser tocado por vários músicos.
-- RELACIONAMENTO N:N (ASSOCIAÇÃO) entre MUSICO e INSTRUMENTO.
-- Esta tabela é uma TABELA ASSOCIATIVA pura (não representa algo “do mundo real”, mas sim a relação).
create table musico_instrumento(
    numero_bi varchar(11) not null,
    id_instrumento int not null,
    primary key (numero_bi, id_instrumento), -- PK composta típica de relação N:N
    foreign key (numero_bi) references musico(numero_bi),
    foreign key (id_instrumento) references instrumentos (id_instrumento)
);

-- Disco aponta para:
--  - o músico produtor (ASSOCIAÇÃO 1:N: um músico pode produzir vários discos)
--  - a gravadora que publica o disco (ASSOCIAÇÃO 1:N: uma gravadora publica vários discos)
create table disco(
    id_disco int not null,
    titulo varchar(255) not null,
    data date not null,
    formato varchar(2) not null,
    id_musico varchar(11) not null,      -- produtor do disco (associação)
    id_gravadora int not null,           -- gravadora que publica o disco (associação)
    foreign key (id_musico) references musico (numero_bi),
    foreign key (id_gravadora) references gravadora(id_gravadora),
    primary key (id_disco)
);

-- Gênero é entidade independente que CLASSIFICA músicas.
-- Conceitualmente: associação 1:N (um gênero para várias músicas).
create table genero(
    id_genero int not null,
    nome varchar(155),
    primary key (id_genero)
);

create table musica(
    id_musica int not null,
    titulo varchar(255) not null,
    autor varchar(255) not null, 
    id_disco int not null,              -- composição/agregação forte: música é parte de um disco
    id_genero int not null,             -- associação 1:N com genero
    numero_bi varchar(11) not null,     -- autor da música (associação com musico)
    primary key (id_musica),
    foreign key (id_genero) references genero (id_genero),
    foreign key (id_disco) references disco (id_disco),
    foreign key (numero_bi) references musico (numero_bi)
);

-- Registra quais músicos participaram de cada música e a função.
-- Conceitualmente: RELACIONAMENTO N:N entre MUSICA e MUSICO com ATRIBUTO (funcao).
-- É uma TABELA ASSOCIATIVA com atributo próprio.
create table participacao(
    id_musica int not null,
    numero_bi varchar(11) not null,
    funcao varchar(155) not null,       -- atributo do relacionamento (ex: vocal, guitarra, etc.)
    primary key (id_musica, numero_bi), -- PK composta típica de N:N
    foreign key (id_musica) references musica(id_musica),
    foreign key (numero_bi) references musico(numero_bi)
);

-- Planos de assinatura são entidades independentes.
create table plano(
    id_plano int not null,
    nome varchar(155) not null,
    limite_downloads int not null,
    valor decimal (8,2),
    primary key (id_plano)
);

-- CLIENTE -> PLANO: associação 1:N.
--  - Um plano pode ter vários clientes inscritos.
--  - O plano existe independentemente dos clientes (não é composição).
create table cliente(
    id_cliente int not null,
    id_plano int not null,
    nome varchar(155) not null,
    cliente_telefone varchar(20),
    primary key(id_cliente),
    foreign key (id_plano) references plano(id_plano)
);

-- DOWNLOAD registra o evento “cliente baixou música”.
-- Conceitualmente pode ser visto como:
--  - Associação N:N entre CLIENTE e MUSICA, materializada por esta entidade
--  - DOWNLOAD é uma entidade fraca/evento dependente de CLIENTE e MUSICA,
--    mas no modelo relacional ainda é uma associação via FKs.
create table download(
    id_download int not null,           -- identificador do evento de download
    id_cliente int not null,            -- FK para o cliente que fez o download
    id_musica int not null,             -- FK para a música baixada
    primary key (id_download),
    foreign key (id_cliente) references cliente(id_cliente),
    foreign key (id_musica) references musica(id_musica)
);

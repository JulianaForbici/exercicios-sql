create table atividade(
id_atividade int not null,
nome varchar(50),
primary key (id_atividade));
 
create table instrutor(
id_instrutor int not null,
nome varchar(255) not null,
rg varchar(15),
dt_nascimento date not null,
primary key (id_instrutor));
 
create table turma(
id_turma int not null,
horario time not null,
duracao int,
dt_inicio date,
id_atividade int not null,
id_instrutor int,
primary key (id_turma),
foreign key (id_atividade) references atividade (id_atividade),
foreign key (id_instrutor) references instrutor (id_instrutor));
 
create table aluno(
id_aluno int not null,
nome varchar(255) not null,
telefone varchar(15) not null,
dt_nascimento date,
rua varchar(255) not null,
numero int,
altura int,
peso float,
primary key (id_aluno));
 
create table matricula(
id_aluno int not null,
dt_matricula date not null,
id_turma int not null,
primary key (id_aluno, id_turma),
foreign key (id_aluno) references aluno(id_aluno),
foreign key (id_turma) references turma(id_turma));
                    
create table frequencia(
id_frequencia int not null,
dt_frequencia timestamp,
presente boolean not null,
id_aluno int not null,
id_turma int not null,
primary key (id_frequencia),
foreign key (id_aluno, id_turma) references matricula (id_aluno, id_turma));

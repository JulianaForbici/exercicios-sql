select * from atividade order by id_atividade;
select * from aluno order by id_aluno;
select * from instrutor order by id_instrutor;
select * from turma order by id_turma;
select * from matricula order by id_aluno;
select * from matricula order by id_turma;
select * from frequencia order by id_aluno;

------------------------------------------ //

-- ATIVIDADES DE SELECT, UPDATE E DELETE 

-- 1 
select id_aluno, * from aluno where nome ='Rafael Souza';
update aluno set peso = '89.0' where id_aluno = 4;

-- 2
select id_instrutor, * from instrutor where nome like '%Bernardo%';
update instrutor set dt_nascimento = '1999-10-12' where id_instrutor = 2;

select id_aluno, * from aluno where nome ='Julio Augusto';

-- 3
delete from frequencia where id_aluno = 8;
delete from matricula where id_aluno = 8;
delete from aluno where id_aluno = 8;

------------------------------------------ //

-- ATIVIDADES DE JOIN
 
-- 1

select id_atividade, * from atividade where nome like '%Musculação%';
select id_atividade, * from atividade where nome like '%Bike indoor%';

select a.nome as atividade, t.horario, t.duracao 
from turma t 
inner join atividade a on t.id_atividade = a.id_atividade 
where a.id_atividade in (10, 1);
 
-- 2

select id_atividade, * from atividade where nome like '%Ginástica%';
select id_atividade, * from atividade where nome like '%Circo%';

select a.nome as atividade,
t.horario, t.duracao, i.nome as instrutor
from turma t 
left join instrutor i on t.id_instrutor = i.id_instrutor 
join atividade a on t.id_atividade = a.id_atividade 
where a.id_atividade in (2, 6)
order by t.horario;
 
-- 3  

select a.nome as atividade,
t.horario, t.duracao, i.nome as instrutor
from turma t
left join instrutor i on t.id_instrutor = i.id_instrutor
join atividade a on t.id_atividade = a.id_atividade
where t.horario between time '12:00' and time '18:00'
order by t.horario;

-- 4

select t.horario, i.nome as instrutor,t.duracao
from turma t
join instrutor i on t.id_instrutor = i.id_instrutor
where i.nome like '%Bernardo%'
order by t.horario;

-- 5

select a.nome, m.dt_matricula
from matricula m
join aluno a on m.id_aluno = a.id_aluno 
order by m.dt_matricula desc
limit 5;

-- 6

select distinct a.nome
from aluno a
join matricula m on a.id_aluno = m.id_aluno;
 
-- 7

select a.nome 
from aluno a 
left join matricula m on a.id_aluno = m.id_aluno 
where m.id_aluno is null;
 
-- 8

select a.nome as atividade,
t.horario, t.duracao
from turma t
join atividade a on t.id_atividade = a.id_atividade 
where t.id_instrutor is null
order by t.horario;
 
-- 9

select i.nome as instrutor,
a.nome as atividade, t.horario, t.duracao
from turma t
join instrutor i on t.id_instrutor = i.id_instrutor
join atividade a on t.id_atividade = a.id_atividade 
order by i.nome;
 
-- 10

select i.nome as instrutor,
a.nome as atividade, t.horario, t.duracao
from turma t
left join instrutor i on t.id_instrutor = i.id_instrutor
join atividade a on t.id_atividade = a.id_atividade 
order by i.nome;
 
-- 11

select nome,
extract(day from dt_nascimento) as dia,
extract(month from dt_nascimento) as mes,
extract(year from dt_nascimento) as ano
from aluno
where extract(month from dt_nascimento) between 7 and 12;
 
------------------------------------------ //

-- ATIVIDADES DML PARTE 2

-- 1

select count(*) as total_alunos from aluno;

-- 2 

select count(*) as total_instrutores from instrutor;

-- 3

select a.nome as atividade,
count(distinct t.id_instrutor) as qtd_instrutores
from atividade a
left join turma t on t.id_atividade = a.id_atividade
group by a.nome
order by qtd_instrutores desc, a.nome;

-- 4

select a.nome as atividade,
count(t.id_turma) as qtd_turmas,
count(distinct t.id_instrutor) as qtd_instrutores
from atividade a
left join turma t on t.id_atividade = a.id_atividade
group by a.nome
order by qtd_turmas desc, a.nome;

-- 5

select distinct i.id_instrutor, i.nome
from instrutor i
join turma t on t.id_instrutor = i.id_instrutor
order by i.nome;

-- 6

select i.id_instrutor, i.nome
from instrutor i
left join turma t on t.id_instrutor = i.id_instrutor
where t.id_turma is null
order by i.nome;

-- 7

select a.nome as atividade,
count(t.id_turma) as qtd_turmas
from atividade a
left join turma t on t.id_atividade = a.id_atividade
group by a.nome
order by qtd_turmas desc, a.nome;

-- 8

select a.id_aluno, a.nome,
count(m.id_turma) as qtd_turmas
from aluno a
join matricula m on m.id_aluno = a.id_aluno
group by a.id_aluno, a.nome
having count(m.id_turma) >= 2
order by qtd_turmas desc, a.nome;

-- 9

select act.nome as atividade,
t.id_turma,
t.horario,
t.duracao,
t.dt_inicio,
count(m.id_aluno) as qtd_alunos
from turma t
join atividade act on t.id_atividade = act.id_atividade
left join matricula m on m.id_turma = t.id_turma
group by t.id_turma, act.nome
order by act.nome, t.horario;

-- 10 

select act.nome as atividade,
count(m.id_aluno) as total_alunos
from atividade act
join turma t on t.id_atividade = act.id_atividade
left join matricula m on m.id_turma = t.id_turma
group by act.nome
order by total_alunos desc
limit 1;

-- 11 

select a.id_aluno, a.nome,
count(f.id_frequencia) as total_presencas
from aluno a
join frequencia f on f.id_aluno = a.id_aluno
where f.presente = true
group by a.id_aluno, a.nome
order by total_presencas desc
limit 1;

-- 12 

select a.id_aluno, a.nome,
count(f.id_frequencia) as total_presencas
from aluno a
join frequencia f on f.id_aluno = a.id_aluno
where f.presente = true
group by a.id_aluno, a.nome
having count(f.id_frequencia) >= 3
order by total_presencas desc, a.nome;

-------------------------------------------------------- \\ 

-- Exercícios dos SELECTs


-- 1 Quantos clientes estão cadastrados?
select count(*) as total_clientes from cliente; 

-- 2 Quantos clientes estão cadastrados em cada plano?
-- usei o group by pq quero uma linha por plano com a contagem dos clientes
select p.nome as plano, count(c.id_cliente) as quantidade_clientes
from plano p 
left join cliente c on c.id_plano = p.id_plano
group by p.id_plano, p.nome;

-- 3 Quais os artistas que estão no sistema?
select numero_bi, nome from musico order by numero_bi;

-- 4 Quais são os planos, valores e limites de downloads?
select id_plano, nome, valor, limite_downloads from plano;

-- 5 Quantos artistas tem cada gravadora?
-- LEFT JOIN para incluir gravadoras sem discos e o COUNT(DISTINCT) pra evitar infos duplicadas
select g.nome as gravadora,
count(distinct d.id_musico) as quantidade_artistas
from gravadora g
left join disco d on d.id_gravadora = g.id_gravadora
group by g.nome;

-- 6  Qual gravadora tem mais artistas?
-- mesma lógica do exercicio anterior
select g.nome as gravadora,
count(distinct d.id_musico) as quantidade_artistas
from gravadora g
left join disco d on d.id_gravadora = g.id_gravadora
group by g.nome
order by quantidade_artistas desc
limit 1;

-- 7 Quais são as músicas da “Adele”? 
select titulo from musica where numero_bi = '33333333333';

-- 8 Quais são as músicas da gravadora Universal Music?
-- join entre musica e disco, filtrando por id_gravadora
select m.titulo
from musica m
join disco d on d.id_disco = m.id_disco
where d.id_gravadora = '5'
order by m.titulo;

-- 9 Quantas músicas cada gênero possui?
-- número de músicas por gênero, também inclui gêneros sem músicas pelo left join
select g.nome as genero,
count(m.id_musica) as qtde_musicas
from genero g
left join musica m on m.id_genero = g.id_genero
group by g.nome;

-- 10 Quantas músicas cada cliente baixou?
-- 
select c.nome as cliente,
count(d.id_download) as quantidade_download
from cliente c
left join download d on d.id_cliente = c.id_cliente
group by c.nome;

-- 11 Qual o gênero mais baixado pelos clientes do Básico?

-- usei essa quantidade de join por conta do encadeamento 
-- genero > musica > download > cliente > plano
select g.nome as genero,
count(*) as total_download
from genero g 
join musica m on m.id_genero = g.id_genero 
join download d on d.id_musica = m.id_musica 
join cliente c on c.id_cliente = d.id_cliente 
join plano p on p.id_plano = c.id_plano 
where p.id_plano = '1'
group by g.id_genero
order by total_download desc
limit 1;


-- 12 Quais são os artistas e respectivas gravadoras com mais músicas baixadas no Basico?
-- junta download > musica > musico > disco > gravadora e conta downloads por (artista, gravadora)
select m.nome as artista,
g.nome as gravadora,
count(d.id_download) as quantidade_download
from download d
join cliente c on c.id_cliente = d.id_cliente
join plano p on p.id_plano = c.id_plano
join musica m2 on m2.id_musica = d.id_musica
join musico m on m.numero_bi = m2.numero_bi
join disco di on di.id_disco = m2.id_disco
join gravadora g on g.id_gravadora = di.id_gravadora
where p.id_plano  = '1'
group by m.nome, g.nome
order by quantidade_download desc;

-- 13 Quanto vou receber desses clientes que estão cadastrados em cada plano? Nome plano, quantidade de clientes, valor
-- retorna para cada plano, quantidade de clientes, valor do plano e receita estimada (clientes * valor)
-- usei o left join para incluir planos sem clientes e COALESCE evita multiplicar por null
select p.nome as plano,
count(c.id_cliente) as quantidade_clientes,
p.valor as valor_plano,
count(c.id_cliente) * coalesce(p.valor, 0) as total_receber -- retorna p.valor se não for vazio, caso contrário retorna 0
from plano p
left join cliente c on c.id_plano = p.id_plano 
group by p.id_plano, p.nome, p.valor
order by total_receber desc;

-- 14 Qual o faturamento da minha empresa?
-- vai retornar a soma dos valores dos planos dos clientes  
select sum(p.valor) as faturamento from cliente c 
join plano p on p.id_plano = c.id_plano;

-- 15 Quantidade de músicas por gravadora
-- vai retornar para cada gravadora, quantas músicas estão associadas via discos
-- usei o left join para incluir gravadoras sem música, ele vai contar músicas por gravadora
select g.nome as gravadora,
count(m.id_musica) as qtde_musicas from gravadora g
left join disco d on d.id_gravadora = g.id_gravadora
left join musica m on m.id_disco= d.id_disco
group by g.nome;

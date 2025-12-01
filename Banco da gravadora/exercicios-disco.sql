-------------------------------------------------------- \\ 

-- Exercícios dos SELECTs


-- 1
select count(*) as clientes from cliente;

-- 2
select p.nome as plano, count(c.id_cliente) as quantidade
from plano p
left join cliente c on c.id_plano = p.id_plano
group by p.id_plano, p.nome
order by p.nome;

-- 3
select a.id_artista, a.nome as artista, g.nome as gravadora
from artista a
left join gravadora g on a.id_gravadora = g.id_gravadora
order by a.nome;

-- 4
select id_plano, nome, mensalidade, limite_downloads
from plano
order by id_plano;

-- 5
select g.nome as gravadora, count(a.id_artista) as qtd_artistas
from gravadora g
left join artista a on a.id_gravadora = g.id_gravadora
group by g.id_gravadora, g.nome
order by qtd_artistas desc, g.nome;

-- 6
with contagem as (
  select g.id_gravadora, g.nome as gravadora, count(a.id_artista) as qtd
  from gravadora g
  left join artista a on a.id_gravadora = g.id_gravadora
  group by g.id_gravadora, g.nome
)
select gravadora, qtd
from contagem
where qtd = (select max(qtd) from contagem);

-- 7
select m.id_musica, m.titulo, gen.nome as genero, d.titulo as disco
from musica m
left join artista art on m.id_artista = art.id_artista
left join genero gen on m.id_genero = gen.id_genero
left join disco d on m.id_disco = d.id_disco
where art.nome = 'Adele'
order by m.titulo;

-- 8
select m.id_musica, m.titulo, art.nome as artista, gen.nome as genero
from musica m
join artista art on m.id_artista = art.id_artista
join gravadora gr on art.id_gravadora = gr.id_gravadora
left join genero gen on m.id_genero = gen.id_genero
where gr.nome = 'Universal Music'
order by art.nome, m.titulo;

-- 9
select gen.nome as genero, count(m.id_musica) as qtd_musicas
from genero gen
left join musica m on m.id_genero = gen.id_genero
group by gen.id_genero, gen.nome
order by qtd_musicas desc, gen.nome;

-- 10
select c.id_cliente, c.nome as cliente, count(d.id_download) as total_baixados
from cliente c
left join download d on d.id_cliente = c.id_cliente
group by c.id_cliente, c.nome
order by total_baixados desc, c.nome;

-- 11
select gen.nome as genero, count(dn.id_download) as total_downloads
from download dn
join cliente cl on dn.id_cliente = cl.id_cliente
join plano p on cl.id_plano = p.id_plano
join musica m on dn.id_musica = m.id_musica
join genero gen on m.id_genero = gen.id_genero
where p.nome = 'Básico'
group by gen.nome
order by total_downloads desc
limit 1;

-- 12
select art.nome as artista, gr.nome as gravadora, count(dn.id_download) as total_downloads
from download dn
join cliente cl on dn.id_cliente = cl.id_cliente
join plano p on cl.id_plano = p.id_plano
join musica m on dn.id_musica = m.id_musica
join artista art on m.id_artista = art.id_artista
left join gravadora gr on art.id_gravadora = gr.id_gravadora
where p.nome = 'Básico'
group by art.id_artista, art.nome, gr.nome
order by total_downloads desc, art.nome;

-- 13
select p.nome as plano,
       count(c.id_cliente) as qtd_clientes,
       p.mensalidade,
       count(c.id_cliente) * p.mensalidade as receita_mensal
from plano p
left join cliente c on c.id_plano = p.id_plano
group by p.id_plano, p.nome, p.mensalidade
order by p.nome;

-- 14
select coalesce(sum(sub.cnt * sub.mensalidade), 0) as faturamento_mensal
from (
  select p.id_plano, p.mensalidade, count(c.id_cliente) as cnt
  from plano p
  left join cliente c on c.id_plano = p.id_plano
  group by p.id_plano, p.mensalidade
) sub;

-- 15
select gr.nome as gravadora, count(m.id_musica) as qtd_musicas
from gravadora gr
left join artista a on a.id_gravadora = gr.id_gravadora
left join musica m on m.id_artista = a.id_artista
group by gr.id_gravadora, gr.nome
order by qtd_musicas desc, gr.nome;

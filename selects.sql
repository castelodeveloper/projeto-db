/* /////////////////////////////////////////////////////////////////////////////
************************** SELECTS ************************* 
//////////////////////////////////////////////////////////////////////////////// */



SELECT numero = codigo_vendedor
nome = nome_vendedor,
rendimentos = salario_fixo,
comissao = faixa_comissao
FROM vendedor

-- alterar o rótulo das colunas 

SELECT codigo_vendedor AS Número,
nome_vendedor AS Nome,
salario_fixo AS Rendimentos,
faixa_comissao AS Comissão
FROM vendedor


SELECT descricao_produto, unidade, val_unit 
FROM produto 


SELECT cgc, nome_cliente, endereco
FROM cliente

SELECT nome_vendedor, (salario_fixo * 2) AS salario_fixo 
FROM vendedor


SELECT num_pedido, codigo_produto, quantidade
FROM item_do_pedido
WHERE quantidade = 35


SELECT nome_cliente
FROM cliente
WHERE cidade = 'Niterói'


SELECT descricao_produto
FROM produto
WHERE unidade = 'M' AND val_unit = 1.05


SELECT nome_cliente, endereco, cep, cidade
FROM cliente
WHERE cidade = 'são paulo' OR cep >= '30077000' AND cep <= '30079000';


SELECT nome_cliente, endereco, cep, cidade
FROM cliente
WHERE (cep >= '30077000' AND cep <= '30079000') OR cidade = 'são paulo'

-- //////// consultas /////////
SELECT * FROM vendas.produto LIMIT 1;
SELECT * FROM vendas.produto ORDER BY produto.unidade ASC LIMIT 10;


SELECT pedido.num_pedido 
FROM pedido 
WHERE pedido.prazo_entrega <> 15;



SELECT pedido.num_pedido 
FROM pedido 
WHERE NOT (pedido.prazo_entrega = 15);

SELECT produto.codigo_produto, produto.descricao_produto
FROM produto
WHERE produto.val_unit BETWEEN 0.32 AND 2;

SELECT codigo_produto, descricao_produto
FROM produto
WHERE val_unit >= 0.32 AND val_unit <= 2;


-- //////////////////////////////////////////////////////////
-- Listar todos os produtos que tenham o nome começando por Q.
SELECT produto.codigo_produto, produto.descricao_produto
FROM produto
WHERE descricao_produto LIKE 'Q%'


SELECT vendedor.nome_vendedor
FROM vendedor
WHERE nome_vendedor NOT LIKE 'Jo%'

-- //////////////////////////////////////////////////////////
-- Listar os vendedores que são da faixa de comissão A e B.

SELECT vendedor.nome_vendedor
FROM vendedor
WHERE vendedor.faixa_comissao IN ('A', 'B')


SELECT *
FROM cliente 
WHERE IE IS NULL


-- //////////////////////////////////////////////////////////
-- Mostrar em ordem alfabética a lista de vendedores e seus 
-- respectivos salários fixos.

SELECT nome_vendedor, salario_fixo
FROM vendedor
ORDER BY nome_vendedor


-- //////////////////////////////////////////////////////////
-- Listar os nomes, cidades e estados de todos os clientes,
-- ordenados por estado e cidade de forma descendente.


SELECT nome_cliente, cidade, uf 
FROM cliente
ORDER BY UF DESC, cidade DESC


-- //////////////////////////////////////////////////////////
-- Mostrar a descrição e o valor unitário de todos os produtos 
-- que tenham a unidade 'M', em ordem de valor unitário ascendente.


SELECT descricao_produto, val_unit
FROM produto 
WHERE unidade = 'M'
ORDER BY 2 ASC


-- //////////////////////////////////////////////////////////
-- Mostrar o novo salário fixo dos vendedores, de faixa de comissão 'C',
-- calculado com base no reajuste de 75% acrescido de R$ 120,00 de 
-- bonificação. Ordenar pelo nome do vendedor.

SELECT nome_vendedor, salario_fixo, (salario_fixo * 1.75 + 120) as novo_salario
FROM vendedor
WHERE faixa_comissao = 'C'
ORDER BY nome_vendedor


-- //////////////////////////////////////////////////////////
-- Mostrar o menor e o maior salário da tabela vendedor

SELECT MIN(salario_fixo), MAX(salario_fixo)
FROM vendedor


SELECT SUM(quantidade) 
FROM item_do_pedido
WHERE codigo_produto = 78


SELECT AVG(salario_fixo)
FROM vendedor


SELECT COUNT(nome_vendedor) FROM vendedor
WHERE salario_fixo > 2500


SELECT COUNT(*) FROM vendedor
WHERE salario_fixo > 2500


SELECT  nome_vendedor, salario_fixo
FROM vendedor
WHERE (salario_fixo > 2500)


SELECT DISTINCT unidade
FROM produto


-- //////////////////////////////////////////////////////////
-- Listar o número de produtos que cada pedido contém.

SELECT num_pedido, COUNT(*) AS total_produtos
FROM item_do_pedido
GROUP BY num_pedido


-- //////////////////////////////////////////////////////////
-- listar os pedidos que têm mais de três produtos.

SELECT num_pedido, COUNT(*) AS total_produtos
FROM item_do_pedido
GROUP BY num_pedido
HAVING COUNT(*) > 3


-- //////////////////////////////////////////////////////////
-- Ver os pedidos de cada cliente.

SELECT cliente.nome_cliente, pedido.codigo_cliente, pedido.num_pedido
FROM cliente INNER JOIN pedido
ON cliente.codigo_cliente = pedido.codigo_cliente
ORDER BY nome_cliente;

-- Sintaxe Microsoft SQL SERVER

SELECT cliente.nome_cliente, pedido.codigo_cliente, pedido.num_pedido
FROM cliente, pedido
WHERE cliente.codigo_cliente = pedido.codigo_cliente;


-- //////////////////////////////////////////////////////////
-- Juntar clientes com pedidos.


SELECT cliente.nome_cliente, pedido.codigo_cliente, pedido.num_pedido
FROM cliente CROSS JOIN pedido
ORDER BY nome_cliente;


-- //////////////////////////////////////////////////////////
-- Quais são os clientes que têm pedido e os que não têm pedido.

SELECT cliente.nome_cliente, pedido.codigo_cliente, pedido.num_pedido
FROM cliente LEFT OUTER JOIN pedido
ON cliente.codigo_cliente = pedido.codigo_cliente;


SELECT cliente.nome_cliente, cliente.cidade, pedido.prazo_entrega ,pedido.codigo_cliente, pedido.num_pedido 
FROM cliente INNER JOIN pedido
ON cliente.codigo_cliente = pedido.codigo_cliente
WHERE UF IN ('RJ', 'SP') 
AND pedido.prazo_entrega > 15
GROUP BY nome_cliente
-- AND (cliente.UF = 'SP' OR cliente.UF='rj');


SELECT cliente.nome_cliente, pedido.prazo_entrega
FROM cliente INNER JOIN pedido
ON pedido.codigo_cliente = cliente.codigo_cliente
ORDER BY nome_cliente DESC;


-- //////////////////////////////////////////////////////////
-- Apresentar os vendedores (ordenados) que emitiram pedidos 
-- com prazos de entrega superiores a 15 dias e tenham salários 
-- fixos iguais ou superiores a R$ 1.000,00.



SELECT nome_vendedor, prazo_entrega, salario_fixo
FROM pedido p INNER JOIN vendedor v
ON p.codigo_vendedor = v.codigo_vendedor
WHERE v.salario_fixo > 1.000 AND p.prazo_entrega > 15
ORDER BY v.nome_vendedor;

-- sintaxe SQL Server.

SELECT nome_vendedor, prazo_entrega, salario_fixo
FROM pedido p, vendedor v
WHERE v.salario_fixo >= 1.000 AND p.prazo_entrega > 15
AND p.codigo_vendedor = v.codigo_vendedor
ORDER BY v.nome_vendedor;



-- //////////////////////////////////////////////////////////
-- Mostre os clientes (ordenados) que têm prazo de entrega maior
-- que 15 dias para o produto 'QUEIJO' e seja do Rio de Janeiro.

-- minha solução:

SELECT c.nome_cliente, c.UF, p.prazo_entrega, pr.descricao_produto
FROM cliente c INNER JOIN pedido p  INNER JOIN item_do_pedido i INNER JOIN produto pr
ON c.codigo_cliente = p.codigo_cliente AND p.num_pedido = i.num_pedido AND pr.codigo_produto = i.codigo_produto
WHERE p.prazo_entrega > 15 AND pr.descricao_produto = 'queijo' AND c.UF = 'rj' 
ORDER BY c.nome_cliente;

-- solução do livro: 

SELECT c.nome_cliente, c.UF, p.prazo_entrega, pr.descricao_produto
FROM cliente c INNER JOIN pedido p
ON c.codigo_cliente = p.codigo_cliente 
INNER JOIN item_do_pedido i
ON i.num_pedido = p.num_pedido
INNER JOIN produto pr 
ON pr.codigo_produto = i.codigo_produto
WHERE p.prazo_entrega > 15 AND pr.descricao_produto = 'queijo' AND c.UF = 'rj' 
ORDER BY c.nome_cliente;

-- sintaxe SQl Server:

SELECT c.nome_cliente, c.UF, p.prazo_entrega, pr.descricao_produto
FROM cliente c, pedido p, item_do_pedido i, produto pr
WHERE c.codigo_cliente = p.codigo_cliente 
AND p.num_pedido = i.num_pedido 
AND i.codigo_produto = pr.codigo_produto
AND p.prazo_entrega > 15 
AND pr.descricao_produto = 'queijo'
AND c.UF = 'rj';


-- //////////////////////////////////////////////////////////
-- Mostre os vendedores que venderam chocolate em quantidade superior a 10 Kg.

SELECT nome_vendedor, pr.descricao_produto
FROM vendedor v INNER JOIN pedido  p INNER JOIN item_do_pedido i INNER JOIN produto pr
ON v.codigo_vendedor = p.codigo_vendedor AND p.num_pedido = i.num_pedido AND i.codigo_produto = pr.codigo_produto
WHERE pr.descricao_produto = 'chocolate' AND i.quantidade > 10;


SELECT nome_vendedor, pr.descricao_produto
FROM vendedor v INNER JOIN pedido p
ON v.codigo_vendedor = p.codigo_vendedor
INNER JOIN item_do_pedido i 
ON i.num_pedido = p.num_pedido
INNER JOIN produto pr
ON pr.codigo_produto = i.codigo_produto
WHERE pr.descricao_produto = 'chocolate' 
AND i.quantidade > 10 ;



-- //////////////////////////////////////////////////////////
-- Quantos clientes fizeram pedido com o vendedor João?

SELECT COUNT(p.codigo_cliente) 
FROM vendedor v INNER JOIN pedido p INNER JOIN cliente c
ON v.codigo_vendedor = p.codigo_vendedor AND p.codigo_cliente = c.codigo_cliente
WHERE v.nome_vendedor = 'joão'


SELECT p.num_pedido, v.nome_vendedor, c.nome_cliente
FROM vendedor v INNER JOIN pedido p INNER JOIN cliente c
ON v.codigo_vendedor = p.codigo_vendedor AND p.codigo_cliente = c.codigo_cliente
WHERE v.nome_vendedor = 'joão'
GROUP BY c.nome_cliente

-- sintaxe SQL Server

SELECT DISTINCT c.nome_cliente
FROM cliente c, pedido p, vendedor v
WHERE c.codigo_cliente = p.codigo_cliente
AND p.codigo_vendedor = v.codigo_vendedor
AND v.nome_vendedor = 'joão';


-- //////////////////////////////////////////////////////////
-- Quantos clientes da cidade do Rio de Janeiro e de Niterói
-- tiveram seus pedidos tirados com o vendedor João?


SELECT COUNT(c.codigo_cliente)
FROM cliente c INNER JOIN pedido p INNER JOIN vendedor v
ON c.codigo_cliente = p.codigo_cliente AND v.codigo_vendedor = p.codigo_vendedor
WHERE c.cidade IN ('niteroi', 'rio de janeiro') AND v.nome_vendedor = 'joão'


SELECT c.codigo_cliente, c.nome_cliente, c.cidade, p.num_pedido, p.codigo_vendedor, v.nome_vendedor
FROM cliente c INNER JOIN pedido p INNER JOIN vendedor v
ON c.codigo_cliente = p.codigo_cliente AND v.codigo_vendedor = p.codigo_vendedor
WHERE c.cidade IN ('niteroi', 'rio de janeiro') AND v.nome_vendedor = 'joão'
GROUP BY c.nome_cliente;

-- sintaxe SQL server

SELECT cidade, COUNT(nome_cliente) AS Número
FROM cliente c , pedido p , vendedor v
WHERE nome_vendedor = 'joão' AND cidade IN ('niteroi', 'rio de janeiro')
AND v.codigo_vendedor = p.codigo_vendedor AND p.codigo_cliente = c.codigo_cliente
GROUP BY cidade


SELECT c.codigo_cliente, c.nome_cliente, c.cidade
FROM cliente c
WHERE c.cidade = 'niteroi' OR c.cidade = 'rio de janeiro';


-- //////////////////////////////////////////////////////////
-- Que produtos participam de qualquer pedido cuja quantidade seja 10?

SELECT DISTINCT  i.quantidade, i.codigo_produto, p.descricao_produto
FROM item_do_pedido i INNER JOIN produto p
ON i.codigo_produto = p.codigo_produto
WHERE i.quantidade = 10;

SELECT descricao_produto
FROM produto p
WHERE p.codigo_produto IN 
(SELECT i.codigo_produto FROM item_do_pedido i
	WHERE i.quantidade = 10);



SELECT descricao_produto
FROM produto p
WHERE p.codigo_produto IN (78, 25, 22);


SELECT i.codigo_produto FROM item_do_pedido i
	WHERE i.quantidade = 10;


-- //////////////////////////////////////////////////////////
-- Quais vendedores ganharam um salário mínimo abaixo da média?

SELECT v.nome_vendedor, v.salario_fixo
FROM vendedor v
WHERE v.salario_fixo < (SELECT AVG(salario_fixo) FROM vendedor)


-- Quais os produtos que não estão presentes em nenhum pedido?

SELECT p.codigo_produto, p.descricao_produto FROM produto p
WHERE p.codigo_produto NOT IN (SELECT i.codigo_produto FROM item_do_pedido i);


SELECT p.codigo_produto, p.descricao_produto, i.num_pedido
FROM item_do_pedido i RIGHT OUTER JOIN produto p
ON i.codigo_produto = p.codigo_produto;


-- //////////////////////////////////////////////////////////
-- Quais os vendedores que só vendeream produtos por grama 'G'?
-- solução do livro está errada!

SELECT DISTINCT v.codigo_vendedor, v.nome_vendedor 
FROM vendedor v
WHERE unidade ALL = ('G')
SELECT p.unidade
FROM pedido pe, item_do_pedido i, produto p
WHERE pe.num_pedido = i.num_pedido 
AND i.codigo_produto = p.codigo_produto



-- usando somente subqueries: 

SELECT v.codigo_vendedor, v.nome_vendedor
FROM vendedor v
WHERE v.codigo_vendedor IN 
(
SELECT  pe.codigo_vendedor FROM pedido pe
WHERE pe.num_pedido IN 
	(
		SELECT i.num_pedido FROM item_do_pedido i
		WHERE i.codigo_produto IN 
			(
				SELECT p.codigo_produto FROM produto p
			  	WHERE p.unidade = 'g'
			)
	)
);


-- consulta meia boca:

SELECT v.codigo_vendedor, v.nome_vendedor
FROM vendedor v
WHERE v.codigo_vendedor IN 
(
SELECT  pe.codigo_vendedor
FROM produto p INNER JOIN item_do_pedido i INNER JOIN pedido pe
ON p.codigo_produto = i.codigo_produto AND pe.num_pedido = i.num_pedido
WHERE p.unidade = 'g'
);

-- usando somente inner join:

SELECT v.codigo_vendedor, v.nome_vendedor, i.num_pedido, p.unidade, p.descricao_produto
FROM produto p INNER JOIN item_do_pedido i INNER JOIN pedido pe INNER JOIN vendedor v
ON p.codigo_produto = i.codigo_produto AND pe.num_pedido = i.num_pedido AND v.codigo_vendedor = pe.codigo_vendedor
WHERE p.unidade = 'g';



-- //////////////////////////////////////////////////////////
-- Quais clientes estão presentes em mais de três pedidos?

SELECT c.nome_cliente
FROM cliente c
WHERE EXISTS
(SELECT COUNT(*) FROM pedido pe
WHERE pe.codigo_cliente = c.codigo_cliente
HAVING COUNT(*) > 3);


-- //////////////////////////////////////////////////////////
-- Cadastrar os vendedores que emitiram mais de 50 pedidos.
-- Usar para código de cliente o mesmo código de vendedor.

SELECT v.codigo_vendedor, v.nome_vendedor
FROM vendedor v, pedido pe
WHERE v.codigo_vendedor = pe.codigo_vendedor
HAVING COUNT(*) > 50;


-- //////////////////////////////////////////////////////////
-- Altere o valor unitário do produto 'parafuso' de R$ 1,25 para R$ 1.62.

INSERT INTO produto VALUES (108, 'Kg', 'Parafuso', 1.25);

SELECT * FROM produto p 
WHERE p.descricao_produto = 'parafuso'

UPDATE produto p SET p.val_unit = 1.62
WHERE p.codigo_produto = 108;


-- //////////////////////////////////////////////////////////
-- Atualizar o salário fixo de todos os vendedores em 27% mais
-- uma bonificação de R$ 100,00.

UPDATE vendedor v SET v.salario_fixo = v.salario_fixo * 1.27 + 100;

SELECT * FROM vendedor

-- //////////////////////////////////////////////////////////
-- Criar uma VIEW que contenha só os produtos cuja medida seja metro.

CREATE VIEW Produto_por_Metro (cod_PR_metro, Descricao, Unidade) AS 
SELECT p.codigo_produto, p.descricao_produto, p.unidade FROM  produto p
WHERE p.unidade = 'm'

SELECT * FROM produto_por_metro;


-- //////////////////////////////////////////////////////////
-- Criar uma VIEW contendo o código do vendedor, o seu nome 
-- e o salário fixo médio no ano.

CREATE VIEW view_salario_medio (cod_vendedor, nome_vendedor, salario_medio) AS 
SELECT v.codigo_vendedor, v.nome_vendedor, v.salario_fixo/12 FROM vendedor v;

SELECT * FROM  view_salario_medio;

-- //////////////////////////////////////////////////////////
-- Criar uma VIEW contendo os vendedores, seus pedidos efetuados
-- e os respectivos produtos.

CREATE VIEW view_lista_pedidos AS 
SELECT v.nome_vendedor, pe.num_pedido, p.descricao_produto
FROM vendedor v INNER JOIN pedido pe INNER JOIN item_do_pedido i INNER JOIN produto p
ON v.codigo_vendedor = pe.codigo_vendedor 
AND i.num_pedido = pe.num_pedido 
AND p.codigo_produto = i.codigo_produto;

SELECT * FROM view_lista_pedidos;


-- //////////////////////////////////////////////////////////
-- Com base na VEIW SALARIO_MEDIO, mostrar os vendedores que
-- possuem média salarial superior a R$ 2.000

SELECT s.nome_vendedor, s.salario_medio
FROM view_salario_medio s
WHERE s.salario_medio > 1000



-- //////////////////////////////////////////////////////////
-- Inserir o registro: 110, Linha_10, M; na VIEW PR_METRO

INSERT INTO view_produto_por_metro VALUES (110, 'Linha_10', 'M');

SELECT * FROM  view_produto_por_metro;


-- //////////////////////////////////////////////////////////
-- Altear a descrição de 'Linha_10' para 'Linha_20' no código 110 
-- da VIEW PR_METRO.

UPDATE view_produto_por_metro SET descricao_produto = 'Linha_20'
WHERE codigo_produto = 110;

SELECT * FROM  view_produto_por_metro;

-- //////////////////////////////////////////////////////////
-- Apagar da VIEW SALARIO_MEDIO o registro de código do vendedor igual a 240.

DELETE FROM view_salario_medio 
WHERE cod_vendedor = 240

SELECT * FROM view_salario_medio;

-- //////////////////////////////////////////////////////////
-- Elimine a VIEW SALÁRIO_MÉDIO.

DROP VIEW view_salario_medio;


-- //////////////////////////////////////////////////////////
-- *************** GERENCIAMENTO DE USUÁRIOS ****************
-- //////////////////////////////////////////////////////////

CREATE USER joao@localhost IDENTIFIED BY '123456';

SHOW GRANTS FOR joao@localhost;



-- //////////////////////////////////////////////////////////
-- Disponibilizar para seleção, a VIEW SALARIO_MEDIO a todos os usuários.

SELECT * FROM view_salario_medio;



GRANT SELECT ON view_salario_medio TO joao@localhost;


GRANT SELECT ON view_salario_medio TO public;

-- //////////////////////////////////////////////////////////

GRANT SELECT (codigo_vendedor, nome_vendedor)
ON vendedor
TO joao@localhost;

SELECT * FROM vendedor

-- //////////////////////////////////////////////////////////

GRANT ALL 
ON pedido
TO Felipe
WITH GRANT OPTION 

-- //////////////////////////////////////////////////////////
EXPLAIN SELECT * FROM produto 
WHERE descricao_produto = 'cano';

-- criar um index:
CREATE INDEX index_nome_pro
ON produto (descricao_produto);


-- exibir um index:
SHOW INDEX FROM produto;


-- excluir um index:
DROP INDEX nome_pro ON produto;


SELECT * FROM produto



-- //////////////////////////////////////////////////////////

EXPLAIN SELECT * FROM produto 
WHERE descricao_produto = 'cano';


-- //////////////////////////////////////////////////////////
SELECT * FROM item_do_pedido


CREATE INDEX ped_pro
ON item_do_pedido (num_pedido, codigo_produto);


-- //////////////////////////////////////////////////////////
SHOW INDEX FROM item_do_pedido;


DROP INDEX ped_pro ON item_do_pedido;



-- //////////////////////////////////////////////////////////
-- ******************** UNION *******************************
-- //////////////////////////////////////////////////////////



SELECT c.codigo_cliente AS codigo, c.nome_cliente AS nome
FROM cliente c
UNION 
SELECT v.codigo_vendedor, v.nome_vendedor
FROM vendedor v
WHERE v.salario_fixo > 1000

-- //////////////////////////////////////////////////////////

SELECT * FROM pedido 
SELECT * FROM vendedor LIMIT 1

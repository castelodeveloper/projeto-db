
/* /////////////////////////////////////////////////////////////////////////////
********************** BD VENDAS ************************* 
//////////////////////////////////////////////////////////////////////////////// */

CREATE DATABASE vendas;

USE vendas;




/* /////////////////////////////////////////////////////////////////////////////
************************ CREATES ************************* 
//////////////////////////////////////////////////////////////////////////////// */


-- //////////////// CLIENTE //////////////////////

CREATE TABLE cliente 
(
	codigo_cliente SMALLINT NOT NULL UNIQUE,
	nome_cliente 	CHAR(20),
	endereco			CHAR(30),
	cidade			CHAR(15),
	CEP				CHAR(8),
	UF					CHAR(2),
	CGC				CHAR(20),
	IE					CHAR(20)	
);

DROP TABLE cliente


-- //////////////// VENDEDOR //////////////////////

CREATE TABLE vendedor
(
	codigo_vendedor	SMALLINT	NOT NULL,
	nome_vendedor		CHAR(20),
	salario_fixo		DECIMAL(10,2),
	faixa_comissao		CHAR(1),
	
	PRIMARY KEY (codigo_vendedor) 
);


DROP TABLE vendedor


-- //////////////// PRODUTO //////////////////////


CREATE TABLE produto 
(
	codigo_produto		SMALLINT NOT NULL UNIQUE,
	unidade				CHAR(3),
	descricao_produto	CHAR(30),
	val_unit				DECIMAL(10,2)
);

DROP TABLE produto


-- //////////////// PEDIDO //////////////////////

-- exemplo do livro

CREATE TABLE pedido
(
	num_pedido			INT not null UNIQUE,
	prazo_entrega		SMALLINT NOT NULL,
	codigo_cliente		SMALLINT NOT NULL,
	codigo_vendedor	SMALLINT NOT NULL,
	
	FOREIGN KEY (codigo_cliente) REFERENCES cliente (codigo_cliente),
   FOREIGN KEY (codigo_vendedor) REFERENCES vendedor (codigo_vendedor)
);

-- usando constraint

CREATE TABLE pedido
(
	num_pedido			INT not null UNIQUE,
	prazo_entrega		SMALLINT NOT NULL,
	codigo_cliente		SMALLINT NOT NULL,
	codigo_vendedor	SMALLINT NOT NULL,
	
	CONSTRAINT FK_CDCLIENTE FOREIGN KEY (codigo_cliente) REFERENCES cliente (codigo_cliente),
   CONSTRAINT FK_CDVENDEDOR FOREIGN KEY (codigo_vendedor) REFERENCES vendedor (codigo_vendedor)
);

DROP TABLE pedido


-- //////////////// ITEM_DO_PEDIDO //////////////////////

-- conferir se o exemplo do livro está errado!

-- CREATE TABLE item_do_pedido
-- (
-- 	num_pedido INT NOT NULL UNIQUE,
-- 	codigo_produto SMALLINT NOT NULL UNIQUE,
-- 	quantidade DECIMAL, CONSTRAINT FK_NUM_PEDIDO FOREIGN KEY (num_pedido) REFERENCES pedido (num_pedido),
-- 	 CONSTRAINT FK_CD_PRODUTO FOREIGN KEY (codigo_produto) REFERENCES produto (codigo_produto)
-- );


DROP TABLE item_do_pedido


CREATE TABLE item_do_pedido
(
	num_pedido		INT NOT NULL,
	codigo_produto SMALLINT NOT NULL,
	quantidade 		DECIMAL,


  CONSTRAINT FK_NUM_PEDIDO	FOREIGN KEY (num_pedido) REFERENCES pedido (num_pedido),
  CONSTRAINT FK_CD_PRODUTO	FOREIGN KEY (codigo_produto) REFERENCES produto (codigo_produto),
  CONSTRAINT UQ_PEDIDO_PRODUTO UNIQUE (num_pedido, codigo_produto)
);



-- ALTER TABLE item_do_pedido ADD
--   CONSTRAINT UQ_PEDIDO_PRODUTO UNIQUE (num_pedido, codigo_produto); 	 



SELECT * FROM item_do_pedido

SELECT * FROM pedido

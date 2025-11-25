/* ============================================================
   DDL – CRIAÇÃO DO BANCO E DAS TABELAS
============================================================ */

CREATE DATABASE IF NOT EXISTS gl_moto_pecas
  DEFAULT CHARACTER SET utf8mb4
  DEFAULT COLLATE utf8mb4_unicode_ci;

USE gl_moto_pecas;

-- TABELA: TB_CLIENTE
CREATE TABLE TB_CLIENTE (
    PK_cpfCliente       CHAR(11)      NOT NULL,
    nomeCliente         VARCHAR(100)  NOT NULL,
    email               VARCHAR(100),
    telefone            VARCHAR(20),
    endereco            VARCHAR(200),
    PRIMARY KEY (PK_cpfCliente)
) ENGINE=InnoDB;

-- TABELA: TB_FUNCIONARIO
CREATE TABLE TB_FUNCIONARIO (
    PK_cpfFuncionario           CHAR(11)      NOT NULL,
    nomeFuncionario             VARCHAR(100)  NOT NULL,
    enderecoFuncionario         VARCHAR(200),
    cargoFuncionario            VARCHAR(50),
    dataAdmissaoFuncionario     DATE,
    contatoFuncionario          VARCHAR(50),
    PRIMARY KEY (PK_cpfFuncionario)
) ENGINE=InnoDB;

-- TABELA: TB_PRODUTO
CREATE TABLE TB_PRODUTO (
    PK_codigoProduto    INT           NOT NULL AUTO_INCREMENT,
    nomeProduto         VARCHAR(100)  NOT NULL,
    categoria           VARCHAR(50),
    garatiaProduto      VARCHAR(50),
    marcaProduto        VARCHAR(50),
    precoProduto        DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (PK_codigoProduto)
) ENGINE=InnoDB;

-- TABELA: TB_PAGAMENTO
CREATE TABLE TB_PAGAMENTO (
    PK_codigoPagamento      INT           NOT NULL AUTO_INCREMENT,
    vencimentoPagamento     DATE,
    statusPagamento         VARCHAR(20),
    tipoPagamento           VARCHAR(30),
    parcelasPagamento       INT,
    jurosPagamento          DECIMAL(5,2),
    valorPagamento          DECIMAL(10,2),
    PRIMARY KEY (PK_codigoPagamento)
) ENGINE=InnoDB;

-- TABELA: TB_FORNECEDORES
CREATE TABLE TB_FORNECEDORES (
    PK_CNPJ             CHAR(14)      NOT NULL,
    razaoSocial         VARCHAR(150)  NOT NULL,
    enderecoFornecedor  VARCHAR(200),
    telefoneFornecedor  VARCHAR(20),
    PRIMARY KEY (PK_CNPJ)
) ENGINE=InnoDB;

-- TABELA: TB_DEPOSITO
CREATE TABLE TB_DEPOSITO (
    PK_codigoDeposito   INT           NOT NULL AUTO_INCREMENT,
    enderecoDeposito    VARCHAR(200),
    PRIMARY KEY (PK_codigoDeposito)
) ENGINE=InnoDB;

-- TABELA: TB_VENDA
CREATE TABLE TB_VENDA (
    PK_idVenda          INT           NOT NULL AUTO_INCREMENT,
    valorTotal          DECIMAL(10,2) NOT NULL,
    FK_cpfCliente       CHAR(11)      NOT NULL,
    FK_cpfFuncionario   CHAR(11)      NOT NULL,
    FK_codigoProduto    INT,
    FK_codigoPagamento  INT           NOT NULL,
    dataVenda           DATE          NOT NULL,
    PRIMARY KEY (PK_idVenda),
    FOREIGN KEY (FK_cpfCliente) REFERENCES TB_CLIENTE (PK_cpfCliente),
    FOREIGN KEY (FK_cpfFuncionario) REFERENCES TB_FUNCIONARIO (PK_cpfFuncionario),
    FOREIGN KEY (FK_codigoProduto) REFERENCES TB_PRODUTO (PK_codigoProduto) ON DELETE SET NULL,
    FOREIGN KEY (FK_codigoPagamento) REFERENCES TB_PAGAMENTO (PK_codigoPagamento)
) ENGINE=InnoDB;

-- TABELA: TB_ITEMVENDA
CREATE TABLE TB_ITEMVENDA (
    PK_IdItemVenda      INT           NOT NULL AUTO_INCREMENT,
    FK_IdVenda          INT           NOT NULL,
    FK_codigoProduto    INT           NOT NULL,
    quantidade          INT           NOT NULL,
    valorUnitario       DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (PK_IdItemVenda),
    FOREIGN KEY (FK_IdVenda) REFERENCES TB_VENDA (PK_idVenda) ON DELETE CASCADE,
    FOREIGN KEY (FK_codigoProduto) REFERENCES TB_PRODUTO (PK_codigoProduto)
) ENGINE=InnoDB;

-- TABELA: TB_PRODUTO_FORNECEDOR
CREATE TABLE TB_PRODUTO_FORNECEDOR (
    FK_PK_CNPJ          CHAR(14)  NOT NULL,
    FK_PK_codigoProduto INT       NOT NULL,
    PRIMARY KEY (FK_PK_CNPJ, FK_PK_codigoProduto),
    FOREIGN KEY (FK_PK_CNPJ) REFERENCES TB_FORNECEDORES (PK_CNPJ),
    FOREIGN KEY (FK_PK_codigoProduto) REFERENCES TB_PRODUTO (PK_codigoProduto)
) ENGINE=InnoDB;

-- TABELA: ESTOQUE
CREATE TABLE ESTOQUE (
    numero              INT   NOT NULL AUTO_INCREMENT,
    FK_codigoProduto    INT   NOT NULL,
    FK_codigoDeposito   INT   NOT NULL,
    Quantidade          INT   NOT NULL DEFAULT 0,
    PRIMARY KEY (numero),
    UNIQUE KEY uk_estoque_prod_dep (FK_codigoProduto, FK_codigoDeposito),
    FOREIGN KEY (FK_codigoProduto) REFERENCES TB_PRODUTO (PK_codigoProduto),
    FOREIGN KEY (FK_codigoDeposito) REFERENCES TB_DEPOSITO (PK_codigoDeposito)
) ENGINE=InnoDB;

/* ============================================================
   LIMPEZA COMPLETA DO BANCO + RESET AUTO_INCREMENT
============================================================ */

DELETE FROM TB_ITEMVENDA;
DELETE FROM TB_VENDA;
DELETE FROM TB_PAGAMENTO;
DELETE FROM TB_PRODUTO_FORNECEDOR;
DELETE FROM ESTOQUE;
DELETE FROM TB_DEPOSITO;
DELETE FROM TB_PRODUTO;
DELETE FROM TB_FORNECEDORES;
DELETE FROM TB_FUNCIONARIO;
DELETE FROM TB_CLIENTE;

ALTER TABLE TB_PRODUTO AUTO_INCREMENT = 1;
ALTER TABLE TB_PAGAMENTO AUTO_INCREMENT = 1;
ALTER TABLE TB_DEPOSITO AUTO_INCREMENT = 1;
ALTER TABLE TB_ITEMVENDA AUTO_INCREMENT = 1;
ALTER TABLE TB_VENDA AUTO_INCREMENT = 1;

/* ============================================================
   DML – INSERÇÃO DOS DADOS
============================================================ */

-- CLIENTES
INSERT INTO TB_CLIENTE VALUES
('11111111111','João Silva','joao.silva@gmail.com','21999990001','Rua A, 100'),
('22222222222','Maria Souza','maria.souza@gmail.com','21999990002','Rua B, 200'),
('33333333333','Carlos Lima','carlos.lima@gmail.com','21999990003','Rua C, 300');

-- FUNCIONÁRIOS
INSERT INTO TB_FUNCIONARIO VALUES
('99999999999','Ana Vendedora','Rua D, 400','Vendedor','2023-01-10','21988880001'),
('88888888888','Bruno Gerente','Rua E, 500','Gerente','2022-05-15','21988880002');

-- PRODUTOS
INSERT INTO TB_PRODUTO (nomeProduto,categoria,garatiaProduto,marcaProduto,precoProduto) VALUES
('Bateria 12V 8Ah','Moto','6 meses','Moura',450.00),
('Pneu 120/70-17 Esportivo','Moto','1 ano','Pirelli',520.00),
('Kit Filtro de Óleo 1.6','Carro','3 meses','Fram',100.00),
('Pastilha de Freio Dianteira','Carro','6 meses','Cobreq',120.00);

-- FORNECEDORES
INSERT INTO TB_FORNECEDORES VALUES
('11111111000100','Peças Brasil Ltda','Av. das Indústrias, 1000','21333330001'),
('22222222000100','AutoMoto Importações','Rod. Dutra, km 200','21333330002');

-- DEPÓSITOS
INSERT INTO TB_DEPOSITO (enderecoDeposito) VALUES
('Depósito Matriz - Centro'),
('Depósito Filial - Barra');

-- PAGAMENTOS
INSERT INTO TB_PAGAMENTO (vencimentoPagamento,statusPagamento,tipoPagamento,parcelasPagamento,jurosPagamento,valorPagamento)
VALUES
('2025-11-10','Pago','PIX',1,0.00,610.00),
('2025-11-15','Pendente','CartaoCredito',2,5.00,640.00),
('2025-11-20','Pendente','Boleto',1,0.00,200.00),
('2025-11-25','Pago','Dinheiro',1,0.00,450.00);

-- PRODUTO X FORNECEDOR
INSERT INTO TB_PRODUTO_FORNECEDOR VALUES
('11111111000100',1),
('11111111000100',3),
('22222222000100',2),
('22222222000100',4);

-- ESTOQUE
INSERT INTO ESTOQUE (FK_codigoProduto,FK_codigoDeposito,Quantidade) VALUES
(1,1,20),(2,1,15),(3,1,30),(4,1,10),
(1,2, 5),(2,2, 8),(3,2,12),(4,2, 4);

-- VENDAS
INSERT INTO TB_VENDA (valorTotal,FK_cpfCliente,FK_cpfFuncionario,FK_codigoProduto,FK_codigoPagamento,dataVenda) VALUES
(610.00,'11111111111','99999999999',1,1,'2025-11-01'),
(640.00,'22222222222','88888888888',2,2,'2025-11-02'),
(200.00,'11111111111','99999999999',3,3,'2025-11-03'),
(450.00,'33333333333','88888888888',1,4,'2025-11-04');

-- ITENS DE VENDA
INSERT INTO TB_ITEMVENDA (FK_IdVenda,FK_codigoProduto,quantidade,valorUnitario) VALUES
(1,1,1,450.00),
(1,3,2,100.00),
(2,2,1,520.00),
(2,4,1,120.00),
(3,3,2,100.00),
(4,1,1,450.00);

/* ============================================================
   DML – ATUALIZAÇÕES E REMOÇÕES
============================================================ */

-- ATUALIZAÇÃO 1
UPDATE TB_CLIENTE
SET telefone='21999990099'
WHERE PK_cpfCliente='11111111111';

-- ATUALIZAÇÃO 2
UPDATE TB_PRODUTO
SET precoProduto = precoProduto * 1.05
WHERE PK_codigoProduto IN (
    SELECT codigo
    FROM (
        SELECT PK_codigoProduto AS codigo
        FROM TB_PRODUTO
        WHERE categoria = 'Moto'
    ) AS temp
);

-- ATUALIZAÇÃO 3
UPDATE TB_PAGAMENTO
SET statusPagamento='Pago', jurosPagamento=0
WHERE PK_codigoPagamento=2;

-- ATUALIZAÇÃO ENVOLVENDO MAIS DE UMA TABELA
UPDATE TB_PAGAMENTO pg
SET statusPagamento='Em cobrança'
WHERE pg.PK_codigoPagamento IN (
  SELECT v.FK_codigoPagamento
  FROM TB_VENDA v
  WHERE v.FK_cpfCliente='22222222222'
);

-- REMOÇÃO 1
DELETE FROM TB_ITEMVENDA
WHERE FK_IdVenda=3 AND FK_codigoProduto=3;

-- REMOÇÃO ENVOLVENDO MAIS DE UMA TABELA
DELETE FROM TB_DEPOSITO
WHERE PK_codigoDeposito=2
AND NOT EXISTS (SELECT 1 FROM ESTOQUE e WHERE e.FK_codigoDeposito = 2);

/* ============================================================
   DQL – CONSULTAS
============================================================ */

-- CONSULTA 1 – Relatório de vendas
SELECT v.PK_idVenda, v.dataVenda, c.nomeCliente, f.nomeFuncionario, v.valorTotal
FROM TB_VENDA v
JOIN TB_CLIENTE c ON v.FK_cpfCliente = c.PK_cpfCliente
JOIN TB_FUNCIONARIO f ON v.FK_cpfFuncionario = f.PK_cpfFuncionario;

-- CONSULTA 2 – Relatório de estoque
SELECT p.nomeProduto, d.enderecoDeposito, e.Quantidade
FROM ESTOQUE e
JOIN TB_PRODUTO p ON e.FK_codigoProduto = p.PK_codigoProduto
JOIN TB_DEPOSITO d ON e.FK_codigoDeposito = d.PK_codigoDeposito;

-- CONSULTA 3 – Cliente por CPF
SELECT * FROM TB_CLIENTE WHERE PK_cpfCliente='11111111111';

-- CONSULTA 4 – Detalhes da venda 1
SELECT * FROM TB_ITEMVENDA WHERE FK_IdVenda=1;

-- CONSULTA 5 – Produtos por fornecedor
SELECT f.razaoSocial, p.nomeProduto
FROM TB_FORNECEDORES f
JOIN TB_PRODUTO_FORNECEDOR pf ON pf.FK_PK_CNPJ=f.PK_CNPJ
JOIN TB_PRODUTO p ON p.PK_codigoProduto=pf.FK_PK_codigoProduto;

-- CONSULTA 6 – Vendas por funcionário
SELECT f.nomeFuncionario, v.PK_idVenda, v.valorTotal
FROM TB_FUNCIONARIO f
JOIN TB_VENDA v ON v.FK_cpfFuncionario=f.PK_cpfFuncionario;
-- DDL

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
    CONSTRAINT fk_venda_cliente
        FOREIGN KEY (FK_cpfCliente)
        REFERENCES TB_CLIENTE (PK_cpfCliente)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    CONSTRAINT fk_venda_funcionario
        FOREIGN KEY (FK_cpfFuncionario)
        REFERENCES TB_FUNCIONARIO (PK_cpfFuncionario)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    CONSTRAINT fk_venda_produto
        FOREIGN KEY (FK_codigoProduto)
        REFERENCES TB_PRODUTO (PK_codigoProduto)
        ON UPDATE CASCADE
        ON DELETE SET NULL,
    CONSTRAINT fk_venda_pagamento
        FOREIGN KEY (FK_codigoPagamento)
        REFERENCES TB_PAGAMENTO (PK_codigoPagamento)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
) ENGINE=InnoDB;

-- TABELA: TB_ITEMVENDA
CREATE TABLE TB_ITEMVENDA (
    PK_IdItemVenda      INT           NOT NULL AUTO_INCREMENT,
    FK_IdVenda          INT           NOT NULL,
    FK_codigoProduto    INT           NOT NULL,
    quantidade          INT           NOT NULL,
    valorUnitario       DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (PK_IdItemVenda),
    CONSTRAINT fk_itemvenda_venda
        FOREIGN KEY (FK_IdVenda)
        REFERENCES TB_VENDA (PK_idVenda)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT fk_itemvenda_produto
        FOREIGN KEY (FK_codigoProduto)
        REFERENCES TB_PRODUTO (PK_codigoProduto)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
) ENGINE=InnoDB;

-- TABELA DE ASSOCIAÇÃO: TB_PRODUTO_FORNECEDOR
-- (no diagrama está "TB_PRODUTO+FORNECEDOR")

CREATE TABLE TB_PRODUTO_FORNECEDOR (
    FK_PK_CNPJ          CHAR(14)  NOT NULL,
    FK_PK_codigoProduto INT       NOT NULL,
    PRIMARY KEY (FK_PK_CNPJ, FK_PK_codigoProduto),
    CONSTRAINT fk_pf_fornecedor
        FOREIGN KEY (FK_PK_CNPJ)
        REFERENCES TB_FORNECEDORES (PK_CNPJ)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT fk_pf_produto
        FOREIGN KEY (FK_PK_codigoProduto)
        REFERENCES TB_PRODUTO (PK_codigoProduto)
        ON UPDATE CASCADE
        ON DELETE CASCADE
) ENGINE=InnoDB;

-- TABELA: ESTOQUE
CREATE TABLE ESTOQUE (
    numero              INT   NOT NULL AUTO_INCREMENT,
    FK_codigoProduto    INT   NOT NULL,
    FK_codigoDeposito   INT   NOT NULL,
    Quantidade          INT   NOT NULL DEFAULT 0,
    PRIMARY KEY (numero),
    -- garante que um produto tenha no máximo um registro por depósito
    UNIQUE KEY uk_estoque_prod_dep (FK_codigoProduto, FK_codigoDeposito),
    CONSTRAINT fk_estoque_produto
        FOREIGN KEY (FK_codigoProduto)
        REFERENCES TB_PRODUTO (PK_codigoProduto)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    CONSTRAINT fk_estoque_deposito
        FOREIGN KEY (FK_codigoDeposito)
        REFERENCES TB_DEPOSITO (PK_codigoDeposito)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
) ENGINE=InnoDB;

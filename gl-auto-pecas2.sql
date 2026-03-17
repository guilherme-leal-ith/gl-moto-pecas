-- DROP (cuidado em produção)
DROP DATABASE IF EXISTS gl_moto_pecas;

CREATE DATABASE gl_moto_pecas
DEFAULT CHARACTER SET utf8mb4
DEFAULT COLLATE utf8mb4_unicode_ci;

USE gl_moto_pecas;

-- CLIENTE
CREATE TABLE TB_CLIENTE (
    cpf CHAR(11) NOT NULL,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    telefone VARCHAR(20) NOT NULL,
    endereco VARCHAR(200) NOT NULL,
    PRIMARY KEY (cpf)
) ENGINE=InnoDB;

-- FUNCIONARIO
CREATE TABLE TB_FUNCIONARIO (
    cpf CHAR(11) NOT NULL,
    nome VARCHAR(100) NOT NULL,
    endereco VARCHAR(200),
    cargo VARCHAR(50) NOT NULL,
    dataAdmissao DATE NOT NULL,
    contato VARCHAR(50),
    PRIMARY KEY (cpf)
) ENGINE=InnoDB;

-- PRODUTO
CREATE TABLE TB_PRODUTO (
    id INT AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    categoria VARCHAR(50) NOT NULL,
    garantia VARCHAR(50),
    marca VARCHAR(50),
    preco DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (id)
) ENGINE=InnoDB;

-- PAGAMENTO
CREATE TABLE TB_PAGAMENTO (
    id INT AUTO_INCREMENT,
    vencimento DATE NOT NULL,
    status ENUM('Pendente','Pago','Em cobrança') NOT NULL,
    tipo ENUM('PIX','CartaoCredito','Boleto','Dinheiro') NOT NULL,
    parcelas INT DEFAULT 1,
    juros DECIMAL(5,2) DEFAULT 0,
    valor DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (id)
) ENGINE=InnoDB;

-- FORNECEDOR
CREATE TABLE TB_FORNECEDOR (
    cnpj CHAR(14) NOT NULL,
    razaoSocial VARCHAR(150) NOT NULL,
    endereco VARCHAR(200),
    telefone VARCHAR(20),
    PRIMARY KEY (cnpj)
) ENGINE=InnoDB;

-- DEPOSITO
CREATE TABLE TB_DEPOSITO (
    id INT AUTO_INCREMENT,
    endereco VARCHAR(200) NOT NULL,
    PRIMARY KEY (id)
) ENGINE=InnoDB;

-- VENDA (corrigido)
CREATE TABLE TB_VENDA (
    id INT AUTO_INCREMENT,
    valorTotal DECIMAL(10,2) NOT NULL,
    cpfCliente CHAR(11) NOT NULL,
    cpfFuncionario CHAR(11) NOT NULL,
    pagamentoId INT NOT NULL,
    dataVenda DATE NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (cpfCliente) REFERENCES TB_CLIENTE(cpf),
    FOREIGN KEY (cpfFuncionario) REFERENCES TB_FUNCIONARIO(cpf),
    FOREIGN KEY (pagamentoId) REFERENCES TB_PAGAMENTO(id)
) ENGINE=InnoDB;

-- ITEM VENDA
CREATE TABLE TB_ITEMVENDA (
    id INT AUTO_INCREMENT,
    vendaId INT NOT NULL,
    produtoId INT NOT NULL,
    quantidade INT NOT NULL,
    valorUnitario DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (vendaId) REFERENCES TB_VENDA(id) ON DELETE CASCADE,
    FOREIGN KEY (produtoId) REFERENCES TB_PRODUTO(id)
) ENGINE=InnoDB;

-- PRODUTO X FORNECEDOR
CREATE TABLE TB_PRODUTO_FORNECEDOR (
    cnpj CHAR(14),
    produtoId INT,
    PRIMARY KEY (cnpj, produtoId),
    FOREIGN KEY (cnpj) REFERENCES TB_FORNECEDOR(cnpj),
    FOREIGN KEY (produtoId) REFERENCES TB_PRODUTO(id)
) ENGINE=InnoDB;

-- ESTOQUE
CREATE TABLE TB_ESTOQUE (
    id INT AUTO_INCREMENT,
    produtoId INT NOT NULL,
    depositoId INT NOT NULL,
    quantidade INT NOT NULL DEFAULT 0,
    PRIMARY KEY (id),
    UNIQUE (produtoId, depositoId),
    FOREIGN KEY (produtoId) REFERENCES TB_PRODUTO(id),
    FOREIGN KEY (depositoId) REFERENCES TB_DEPOSITO(id)
) ENGINE=InnoDB;

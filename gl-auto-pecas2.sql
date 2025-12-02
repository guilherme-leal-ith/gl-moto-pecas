-- deletar BD
DROP DATABASE IF EXISTS gl_moto_pecas;

--   DDL – CRIAÇÃO DO BANCO E DAS TABELAS

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

-- DML – INSERÇÃO DOS DADOS
-- clientes
INSERT INTO TB_CLIENTE VALUES
('00000000001','João Silva','joao.silva@gmail.com','21990000001','Rua A, 100'),
('00000000002','Maria Silva','maria.silva@gmail.com','21990000002','Rua B, 101'),
('00000000003','Carlos Silva','carlos.silva@gmail.com','21990000003','Rua C, 102'),
('00000000004','Ana Silva','ana.silva@gmail.com','21990000004','Rua D, 103'),
('00000000005','Bruno Silva','bruno.silva@gmail.com','21990000005','Rua E, 104'),
('00000000006','Paula Silva','paula.silva@gmail.com','21990000006','Rua F, 105'),
('00000000007','Ricardo Silva','ricardo.silva@gmail.com','21990000007','Rua G, 106'),
('00000000008','Luana Silva','luana.silva@gmail.com','21990000008','Rua H, 107'),
('00000000009','Felipe Silva','felipe.silva@gmail.com','21990000009','Rua I, 108'),
('00000000010','Juliana Silva','juliana.silva@gmail.com','21990000010','Rua J, 109'),
('00000000011','João Souza','joao.souza@gmail.com','21990000011','Rua K, 110'),
('00000000012','Maria Souza','maria.souza@gmail.com','21990000012','Rua L, 111'),
('00000000013','Carlos Souza','carlos.souza@gmail.com','21990000013','Rua M, 112'),
('00000000014','Ana Souza','ana.souza@gmail.com','21990000014','Rua N, 113'),
('00000000015','Bruno Souza','bruno.souza@gmail.com','21990000015','Rua O, 114'),
('00000000016','Paula Souza','paula.souza@gmail.com','21990000016','Rua P, 115'),
('00000000017','Ricardo Souza','ricardo.souza@gmail.com','21990000017','Rua Q, 116'),
('00000000018','Luana Souza','luana.souza@gmail.com','21990000018','Rua R, 117'),
('00000000019','Felipe Souza','felipe.souza@gmail.com','21990000019','Rua S, 118'),
('00000000020','Juliana Souza','juliana.souza@gmail.com','21990000020','Rua T, 119'),
('00000000021','João Lima','joao.lima@gmail.com','21990000021','Rua U, 120'),
('00000000022','Maria Lima','maria.lima@gmail.com','21990000022','Rua V, 121'),
('00000000023','Carlos Lima','carlos.lima@gmail.com','21990000023','Rua W, 122'),
('00000000024','Ana Lima','ana.lima@gmail.com','21990000024','Rua X, 123'),
('00000000025','Bruno Lima','bruno.lima@gmail.com','21990000025','Rua Y, 124'),
('00000000026','Paula Lima','paula.lima@gmail.com','21990000026','Rua Z, 125'),
('00000000027','Ricardo Lima','ricardo.lima@gmail.com','21990000027','Rua A, 126'),
('00000000028','Luana Lima','luana.lima@gmail.com','21990000028','Rua B, 127'),
('00000000029','Felipe Lima','felipe.lima@gmail.com','21990000029','Rua C, 128'),
('00000000030','Juliana Lima','juliana.lima@gmail.com','21990000030','Rua D, 129'),
('00000000031','João Oliveira','joao.oliveira@gmail.com','21990000031','Rua E, 130'),
('00000000032','Maria Oliveira','maria.oliveira@gmail.com','21990000032','Rua F, 131'),
('00000000033','Carlos Oliveira','carlos.oliveira@gmail.com','21990000033','Rua G, 132'),
('00000000034','Ana Oliveira','ana.oliveira@gmail.com','21990000034','Rua H, 133'),
('00000000035','Bruno Oliveira','bruno.oliveira@gmail.com','21990000035','Rua I, 134'),
('00000000036','Paula Oliveira','paula.oliveira@gmail.com','21990000036','Rua J, 135'),
('00000000037','Ricardo Oliveira','ricardo.oliveira@gmail.com','21990000037','Rua K, 136'),
('00000000038','Luana Oliveira','luana.oliveira@gmail.com','21990000038','Rua L, 137'),
('00000000039','Felipe Oliveira','felipe.oliveira@gmail.com','21990000039','Rua M, 138'),
('00000000040','Juliana Oliveira','juliana.oliveira@gmail.com','21990000040','Rua N, 139'),
('00000000041','João Costa','joao.costa@gmail.com','21990000041','Rua O, 140'),
('00000000042','Maria Costa','maria.costa@gmail.com','21990000042','Rua P, 141'),
('00000000043','Carlos Costa','carlos.costa@gmail.com','21990000043','Rua Q, 142'),
('00000000044','Ana Costa','ana.costa@gmail.com','21990000044','Rua R, 143'),
('00000000045','Bruno Costa','bruno.costa@gmail.com','21990000045','Rua S, 144'),
('00000000046','Paula Costa','paula.costa@gmail.com','21990000046','Rua T, 145'),
('00000000047','Ricardo Costa','ricardo.costa@gmail.com','21990000047','Rua U, 146'),
('00000000048','Luana Costa','luana.costa@gmail.com','21990000048','Rua V, 147'),
('00000000049','Felipe Costa','felipe.costa@gmail.com','21990000049','Rua W, 148'),
('00000000050','Juliana Costa','juliana.costa@gmail.com','21990000050','Rua X, 149');

-- funcionarios
INSERT INTO TB_FUNCIONARIO VALUES
('90000000001','Func01 Silva','Avenida A Centro, 200','Vendedor','2024-10-04','21980000001'),
('90000000002','Func02 Souza','Avenida B Centro, 201','Gerente','2023-03-21','21980000002'),
('90000000003','Func03 Lima','Avenida C Centro, 202','Mecânico','2023-09-09','21980000003'),
('90000000004','Func04 Oliveira','Avenida D Centro, 203','Caixa','2020-08-11','21980000004'),
('90000000005','Func05 Costa','Avenida E Centro, 204','Supervisor','2022-02-07','21980000005'),
('90000000006','Func06 Almeida','Avenida F Centro, 205','Vendedor','2023-01-09','21980000006'),
('90000000007','Func07 Ferreira','Avenida G Centro, 206','Gerente','2020-10-15','21980000007'),
('90000000008','Func08 Gomes','Avenida H Centro, 207','Mecânico','2021-02-09','21980000008'),
('90000000009','Func09 Ribeiro','Avenida I Centro, 208','Caixa','2023-04-13','21980000009'),
('90000000010','Func10 Martins','Avenida J Centro, 209','Supervisor','2022-04-10','21980000010'),
('90000000011','Func11 Silva','Avenida K Centro, 210','Vendedor','2021-05-24','21980000011'),
('90000000012','Func12 Souza','Avenida L Centro, 211','Gerente','2020-02-29','21980000012'),
('90000000013','Func13 Lima','Avenida M Centro, 212','Mecânico','2021-02-08','21980000013'),
('90000000014','Func14 Oliveira','Avenida N Centro, 213','Caixa','2024-05-25','21980000014'),
('90000000015','Func15 Costa','Avenida O Centro, 214','Supervisor','2022-09-24','21980000015'),
('90000000016','Func16 Almeida','Avenida P Centro, 215','Vendedor','2021-12-21','21980000016'),
('90000000017','Func17 Ferreira','Avenida Q Centro, 216','Gerente','2023-04-03','21980000017'),
('90000000018','Func18 Gomes','Avenida R Centro, 217','Mecânico','2020-02-05','21980000018'),
('90000000019','Func19 Ribeiro','Avenida S Centro, 218','Caixa','2020-01-26','21980000019'),
('90000000020','Func20 Martins','Avenida T Centro, 219','Supervisor','2020-06-08','21980000020'),
('90000000021','Func21 Silva','Avenida U Centro, 220','Vendedor','2022-06-12','21980000021'),
('90000000022','Func22 Souza','Avenida V Centro, 221','Gerente','2024-10-10','21980000022'),
('90000000023','Func23 Lima','Avenida W Centro, 222','Mecânico','2022-02-28','21980000023'),
('90000000024','Func24 Oliveira','Avenida X Centro, 223','Caixa','2020-09-28','21980000024'),
('90000000025','Func25 Costa','Avenida Y Centro, 224','Supervisor','2023-03-22','21980000025'),
('90000000026','Func26 Almeida','Avenida Z Centro, 225','Vendedor','2020-12-19','21980000026'),
('90000000027','Func27 Ferreira','Avenida A Centro, 226','Gerente','2024-02-13','21980000027'),
('90000000028','Func28 Gomes','Avenida B Centro, 227','Mecânico','2022-11-02','21980000028'),
('90000000029','Func29 Ribeiro','Avenida C Centro, 228','Caixa','2023-02-21','21980000029'),
('90000000030','Func30 Martins','Avenida D Centro, 229','Supervisor','2023-11-18','21980000030'),
('90000000031','Func31 Silva','Avenida E Centro, 230','Vendedor','2022-03-24','21980000031'),
('90000000032','Func32 Souza','Avenida F Centro, 231','Gerente','2020-04-10','21980000032'),
('90000000033','Func33 Lima','Avenida G Centro, 232','Mecânico','2022-07-30','21980000033'),
('90000000034','Func34 Oliveira','Avenida H Centro, 233','Caixa','2023-10-13','21980000034'),
('90000000035','Func35 Costa','Avenida I Centro, 234','Supervisor','2021-06-26','21980000035'),
('90000000036','Func36 Almeida','Avenida J Centro, 235','Vendedor','2024-04-20','21980000036'),
('90000000037','Func37 Ferreira','Avenida K Centro, 236','Gerente','2024-01-11','21980000037'),
('90000000038','Func38 Gomes','Avenida L Centro, 237','Mecânico','2023-02-18','21980000038'),
('90000000039','Func39 Ribeiro','Avenida M Centro, 238','Caixa','2020-11-13','21980000039'),
('90000000040','Func40 Martins','Avenida N Centro, 239','Supervisor','2021-10-15','21980000040'),
('90000000041','Func41 Silva','Avenida O Centro, 240','Vendedor','2022-01-09','21980000041'),
('90000000042','Func42 Souza','Avenida P Centro, 241','Gerente','2021-01-20','21980000042'),
('90000000043','Func43 Lima','Avenida Q Centro, 242','Mecânico','2023-08-22','21980000043'),
('90000000044','Func44 Oliveira','Avenida R Centro, 243','Caixa','2022-01-08','21980000044'),
('90000000045','Func45 Costa','Avenida S Centro, 244','Supervisor','2022-09-14','21980000045'),
('90000000046','Func46 Almeida','Avenida T Centro, 245','Vendedor','2021-07-14','21980000046'),
('90000000047','Func47 Ferreira','Avenida U Centro, 246','Gerente','2020-02-23','21980000047'),
('90000000048','Func48 Gomes','Avenida V Centro, 247','Mecânico','2024-09-09','21980000048'),
('90000000049','Func49 Ribeiro','Avenida W Centro, 248','Caixa','2022-06-26','21980000049'),
('90000000050','Func50 Martins','Avenida X Centro, 249','Supervisor','2024-10-12','21980000050');


-- produtos
INSERT INTO TB_PRODUTO (nomeProduto,categoria,garatiaProduto,marcaProduto,precoProduto) VALUES
('Produto 01','Moto','3 meses','Moura','228.82'),
('Produto 02','Carro','6 meses','Pirelli','575.80'),
('Produto 03','Moto','1 ano','Fram','389.93'),
('Produto 04','Carro','3 meses','Cobreq','702.13'),
('Produto 05','Moto','6 meses','Bosch','660.89'),
('Produto 06','Carro','1 ano','NGK','464.45'),
('Produto 07','Moto','3 meses','Moura','559.24'),
('Produto 08','Carro','6 meses','Pirelli','90.06'),
('Produto 09','Moto','1 ano','Fram','501.39'),
('Produto 10','Carro','3 meses','Cobreq','594.68'),
('Produto 11','Moto','6 meses','Bosch','624.04'),
('Produto 12','Carro','1 ano','NGK','199.92'),
('Produto 13','Moto','3 meses','Moura','116.43'),
('Produto 14','Carro','6 meses','Pirelli','264.03'),
('Produto 15','Moto','1 ano','Fram','292.59'),
('Produto 16','Carro','3 meses','Cobreq','389.00'),
('Produto 17','Moto','6 meses','Bosch','536.63'),
('Produto 18','Carro','1 ano','NGK','226.08'),
('Produto 19','Moto','3 meses','Moura','724.58'),
('Produto 20','Carro','6 meses','Pirelli','813.75'),
('Produto 21','Moto','1 ano','Fram','201.16'),
('Produto 22','Carro','3 meses','Cobreq','549.45'),
('Produto 23','Moto','6 meses','Bosch','576.78'),
('Produto 24','Carro','1 ano','NGK','598.18'),
('Produto 25','Moto','3 meses','Moura','528.66'),
('Produto 26','Carro','6 meses','Pirelli','886.27'),
('Produto 27','Moto','1 ano','Fram','546.27'),
('Produto 28','Carro','3 meses','Cobreq','614.65'),
('Produto 29','Moto','6 meses','Bosch','679.18'),
('Produto 30','Carro','1 ano','NGK','754.72'),
('Produto 31','Moto','3 meses','Moura','780.71'),
('Produto 32','Carro','6 meses','Pirelli','796.34'),
('Produto 33','Moto','1 ano','Fram','888.66'),
('Produto 34','Carro','3 meses','Cobreq','264.73'),
('Produto 35','Moto','6 meses','Bosch','785.56'),
('Produto 36','Carro','1 ano','NGK','785.85'),
('Produto 37','Moto','3 meses','Moura','986.50'),
('Produto 38','Carro','6 meses','Pirelli','670.73'),
('Produto 39','Moto','1 ano','Fram','307.76'),
('Produto 40','Carro','3 meses','Cobreq','533.75'),
('Produto 41','Moto','6 meses','Bosch','912.36'),
('Produto 42','Carro','1 ano','NGK','631.09'),
('Produto 43','Moto','3 meses','Moura','168.10'),
('Produto 44','Carro','6 meses','Pirelli','513.54'),
('Produto 45','Moto','1 ano','Fram','512.63'),
('Produto 46','Carro','3 meses','Cobreq','857.48'),
('Produto 47','Moto','6 meses','Bosch','292.17'),
('Produto 48','Carro','1 ano','NGK','101.13'),
('Produto 49','Moto','3 meses','Moura','219.04'),
('Produto 50','Carro','6 meses','Pirelli','350.18');


-- fornecedores
INSERT INTO TB_FORNECEDORES VALUES
('00000000000001','Fornecedor 01 Ltda','Rua Industrial 1, Bairro A','21330000001'),
('00000000000002','Fornecedor 02 Ltda','Rua Industrial 2, Bairro B','21330000002'),
('00000000000003','Fornecedor 03 Ltda','Rua Industrial 3, Bairro C','21330000003'),
('00000000000004','Fornecedor 04 Ltda','Rua Industrial 4, Bairro D','21330000004'),
('00000000000005','Fornecedor 05 Ltda','Rua Industrial 5, Bairro E','21330000005'),
('00000000000006','Fornecedor 06 Ltda','Rua Industrial 6, Bairro F','21330000006'),
('00000000000007','Fornecedor 07 Ltda','Rua Industrial 7, Bairro G','21330000007'),
('00000000000008','Fornecedor 08 Ltda','Rua Industrial 8, Bairro H','21330000008'),
('00000000000009','Fornecedor 09 Ltda','Rua Industrial 9, Bairro I','21330000009'),
('00000000000010','Fornecedor 10 Ltda','Rua Industrial 10, Bairro J','21330000010'),
('00000000000011','Fornecedor 11 Ltda','Rua Industrial 11, Bairro K','21330000011'),
('00000000000012','Fornecedor 12 Ltda','Rua Industrial 12, Bairro L','21330000012'),
('00000000000013','Fornecedor 13 Ltda','Rua Industrial 13, Bairro M','21330000013'),
('00000000000014','Fornecedor 14 Ltda','Rua Industrial 14, Bairro N','21330000014'),
('00000000000015','Fornecedor 15 Ltda','Rua Industrial 15, Bairro O','21330000015'),
('00000000000016','Fornecedor 16 Ltda','Rua Industrial 16, Bairro P','21330000016'),
('00000000000017','Fornecedor 17 Ltda','Rua Industrial 17, Bairro Q','21330000017'),
('00000000000018','Fornecedor 18 Ltda','Rua Industrial 18, Bairro R','21330000018'),
('00000000000019','Fornecedor 19 Ltda','Rua Industrial 19, Bairro S','21330000019'),
('00000000000020','Fornecedor 20 Ltda','Rua Industrial 20, Bairro T','21330000020'),
('00000000000021','Fornecedor 21 Ltda','Rua Industrial 21, Bairro U','21330000021'),
('00000000000022','Fornecedor 22 Ltda','Rua Industrial 22, Bairro V','21330000022'),
('00000000000023','Fornecedor 23 Ltda','Rua Industrial 23, Bairro W','21330000023'),
('00000000000024','Fornecedor 24 Ltda','Rua Industrial 24, Bairro X','21330000024'),
('00000000000025','Fornecedor 25 Ltda','Rua Industrial 25, Bairro Y','21330000025'),
('00000000000026','Fornecedor 26 Ltda','Rua Industrial 26, Bairro Z','21330000026'),
('00000000000027','Fornecedor 27 Ltda','Rua Industrial 27, Bairro A','21330000027'),
('00000000000028','Fornecedor 28 Ltda','Rua Industrial 28, Bairro B','21330000028'),
('00000000000029','Fornecedor 29 Ltda','Rua Industrial 29, Bairro C','21330000029'),
('00000000000030','Fornecedor 30 Ltda','Rua Industrial 30, Bairro D','21330000030'),
('00000000000031','Fornecedor 31 Ltda','Rua Industrial 31, Bairro E','21330000031'),
('00000000000032','Fornecedor 32 Ltda','Rua Industrial 32, Bairro F','21330000032'),
('00000000000033','Fornecedor 33 Ltda','Rua Industrial 33, Bairro G','21330000033'),
('00000000000034','Fornecedor 34 Ltda','Rua Industrial 34, Bairro H','21330000034'),
('00000000000035','Fornecedor 35 Ltda','Rua Industrial 35, Bairro I','21330000035'),
('00000000000036','Fornecedor 36 Ltda','Rua Industrial 36, Bairro J','21330000036'),
('00000000000037','Fornecedor 37 Ltda','Rua Industrial 37, Bairro K','21330000037'),
('00000000000038','Fornecedor 38 Ltda','Rua Industrial 38, Bairro L','21330000038'),
('00000000000039','Fornecedor 39 Ltda','Rua Industrial 39, Bairro M','21330000039'),
('00000000000040','Fornecedor 40 Ltda','Rua Industrial 40, Bairro N','21330000040'),
('00000000000041','Fornecedor 41 Ltda','Rua Industrial 41, Bairro O','21330000041'),
('00000000000042','Fornecedor 42 Ltda','Rua Industrial 42, Bairro P','21330000042'),
('00000000000043','Fornecedor 43 Ltda','Rua Industrial 43, Bairro Q','21330000043'),
('00000000000044','Fornecedor 44 Ltda','Rua Industrial 44, Bairro R','21330000044'),
('00000000000045','Fornecedor 45 Ltda','Rua Industrial 45, Bairro S','21330000045'),
('00000000000046','Fornecedor 46 Ltda','Rua Industrial 46, Bairro T','21330000046'),
('00000000000047','Fornecedor 47 Ltda','Rua Industrial 47, Bairro U','21330000047'),
('00000000000048','Fornecedor 48 Ltda','Rua Industrial 48, Bairro V','21330000048'),
('00000000000049','Fornecedor 49 Ltda','Rua Industrial 49, Bairro W','21330000049'),
('00000000000050','Fornecedor 50 Ltda','Rua Industrial 50, Bairro X','21330000050');


-- depositos
INSERT INTO TB_DEPOSITO (enderecoDeposito) VALUES
('Depósito 01 - Setor A'),
('Depósito 02 - Setor B'),
('Depósito 03 - Setor C'),
('Depósito 04 - Setor D'),
('Depósito 05 - Setor E'),
('Depósito 06 - Setor F'),
('Depósito 07 - Setor G'),
('Depósito 08 - Setor H'),
('Depósito 09 - Setor I'),
('Depósito 10 - Setor J'),
('Depósito 11 - Setor K'),
('Depósito 12 - Setor L'),
('Depósito 13 - Setor M'),
('Depósito 14 - Setor N'),
('Depósito 15 - Setor O'),
('Depósito 16 - Setor P'),
('Depósito 17 - Setor Q'),
('Depósito 18 - Setor R'),
('Depósito 19 - Setor S'),
('Depósito 20 - Setor T'),
('Depósito 21 - Setor U'),
('Depósito 22 - Setor V'),
('Depósito 23 - Setor W'),
('Depósito 24 - Setor X'),
('Depósito 25 - Setor Y'),
('Depósito 26 - Setor Z'),
('Depósito 27 - Setor A'),
('Depósito 28 - Setor B'),
('Depósito 29 - Setor C'),
('Depósito 30 - Setor D'),
('Depósito 31 - Setor E'),
('Depósito 32 - Setor F'),
('Depósito 33 - Setor G'),
('Depósito 34 - Setor H'),
('Depósito 35 - Setor I'),
('Depósito 36 - Setor J'),
('Depósito 37 - Setor K'),
('Depósito 38 - Setor L'),
('Depósito 39 - Setor M'),
('Depósito 40 - Setor N'),
('Depósito 41 - Setor O'),
('Depósito 42 - Setor P'),
('Depósito 43 - Setor Q'),
('Depósito 44 - Setor R'),
('Depósito 45 - Setor S'),
('Depósito 46 - Setor T'),
('Depósito 47 - Setor U'),
('Depósito 48 - Setor V'),
('Depósito 49 - Setor W'),
('Depósito 50 - Setor X');


-- pagamentos
INSERT INTO TB_PAGAMENTO (vencimentoPagamento,statusPagamento,tipoPagamento,parcelasPagamento,jurosPagamento,valorPagamento)
VALUES
('2025-11-01','Pago','PIX',4,'0.00','546.23'),
('2025-11-02','Pendente','CartaoCredito',1,'7.50','958.75'),
('2025-11-03','Pago','Boleto',5,'0.00','1669.45'),
('2025-11-04','Pendente','Dinheiro',1,'2.50','638.89'),
('2025-11-05','Pago','PIX',1,'7.50','846.57'),
('2025-11-06','Pendente','CartaoCredito',3,'0.00','1496.66'),
('2025-11-07','Pago','Boleto',4,'5.00','1300.22'),
('2025-11-08','Pendente','Dinheiro',1,'7.50','1723.52'),
('2025-11-09','Pago','PIX',1,'2.50','1815.96'),
('2025-11-10','Pendente','CartaoCredito',6,'0.00','1628.55'),
('2025-11-11','Pago','Boleto',1,'5.00','1007.53'),
('2025-11-12','Pendente','Dinheiro',2,'7.50','791.29'),
('2025-11-13','Pago','PIX',3,'0.00','764.18'),
('2025-11-14','Pendente','CartaoCredito',4,'5.00','1269.47'),
('2025-11-15','Pago','Boleto',5,'7.50','1269.77'),
('2025-11-16','Pendente','Dinheiro',6,'0.00','1865.23'),
('2025-11-17','Pago','PIX',1,'2.50','1981.43'),
('2025-11-18','Pendente','CartaoCredito',2,'0.00','1543.22'),
('2025-11-19','Pago','Boleto',3,'5.00','1620.37'),
('2025-11-20','Pendente','Dinheiro',4,'7.50','834.67'),
('2025-11-21','Pago','PIX',5,'0.00','1406.93'),
('2025-11-22','Pendente','CartaoCredito',6,'5.00','1853.56'),
('2025-11-23','Pago','Boleto',1,'7.50','990.63'),
('2025-11-24','Pendente','Dinheiro',2,'0.00','755.08'),
('2025-11-25','Pago','PIX',3,'5.00','1774.96'),
('2025-11-26','Pendente','CartaoCredito',4,'7.50','1429.35'),
('2025-11-27','Pago','Boleto',5,'0.00','1204.20'),
('2025-11-28','Pendente','Dinheiro',6,'2.50','1470.93'),
('2025-11-29','Pago','PIX',1,'0.00','1716.04'),
('2025-11-30','Pendente','CartaoCredito',2,'5.00','1209.61'),
('2025-12-01','Pago','Boleto',3,'7.50','1832.94'),
('2025-12-02','Pendente','Dinheiro',4,'0.00','1888.89'),
('2025-12-03','Pago','PIX',5,'5.00','1436.02'),
('2025-12-04','Pendente','CartaoCredito',6,'7.50','1032.44'),
('2025-12-05','Pago','Boleto',1,'0.00','1843.61'),
('2025-12-06','Pendente','Dinheiro',2,'5.00','1913.52'),
('2025-12-07','Pago','PIX',3,'7.50','1373.31'),
('2025-12-08','Pendente','CartaoCredito',4,'0.00','1334.52'),
('2025-12-09','Pago','Boleto',5,'5.00','1899.80'),
('2025-12-10','Pendente','Dinheiro',6,'7.50','1654.37'),
('2025-12-11','Pago','PIX',1,'0.00','1917.51'),
('2025-12-12','Pendente','CartaoCredito',2,'5.00','1652.19'),
('2025-12-13','Pago','Boleto',3,'7.50','1635.44'),
('2025-12-14','Pendente','Dinheiro',4,'0.00','1513.08'),
('2025-12-15','Pago','PIX',5,'5.00','1450.16'),
('2025-12-16','Pendente','CartaoCredito',6,'7.50','1614.26'),
('2025-12-17','Pago','Boleto',1,'0.00','1943.60'),
('2025-12-18','Pendente','Dinheiro',2,'5.00','1091.47'),
('2025-12-19','Pago','PIX',3,'7.50','1314.68'),
('2025-12-20','Pendente','CartaoCredito',4,'0.00','626.63');

-- PRODUTO X FORNECEDOR
INSERT INTO TB_PRODUTO_FORNECEDOR VALUES
('00000000000001','1'),
('00000000000001','27'),
('00000000000001','46'),
('00000000000002','7'),
('00000000000002','11'),
('00000000000002','42'),
('00000000000003','17'),
('00000000000003','33'),
('00000000000004','27'),
('00000000000004','45'),
('00000000000005','12'),
('00000000000005','36'),
('00000000000006','3'),
('00000000000006','9'),
('00000000000006','14'),
('00000000000007','5'),
('00000000000007','35'),
('00000000000008','14'),
('00000000000008','25'),
('00000000000008','37'),
('00000000000009','2'),
('00000000000009','10'),
('00000000000009','33'),
('00000000000010','15'),
('00000000000010','31'),
('00000000000011','11'),
('00000000000011','40'),
('00000000000012','5'),
('00000000000012','41'),
('00000000000013','14'),
('00000000000013','38'),
('00000000000013','47'),
('00000000000014','1'),
('00000000000014','8'),
('00000000000014','26'),
('00000000000015','4'),
('00000000000015','19'),
('00000000000016','13'),
('00000000000016','16'),
('00000000000016','29'),
('00000000000017','22'),
('00000000000017','25'),
('00000000000017','48'),
('00000000000018','7'),
('00000000000018','49'),
('00000000000019','18'),
('00000000000019','30'),
('00000000000019','43'),
('00000000000020','20'),
('00000000000020','36'),
('00000000000020','50'),
('00000000000021','6'),
('00000000000021','30'),
('00000000000022','9'),
('00000000000022','17'),
('00000000000023','6'),
('00000000000023','13'),
('00000000000024','2'),
('00000000000024','22'),
('00000000000024','39'),
('00000000000025','18'),
('00000000000025','24'),
('00000000000025','29'),
('00000000000026','3'),
('00000000000026','41'),
('00000000000027','10'),
('00000000000027','21'),
('00000000000027','23'),
('00000000000028','12'),
('00000000000028','37'),
('00000000000029','15'),
('00000000000029','26'),
('00000000000029','34'),
('00000000000030','16'),
('00000000000030','44'),
('00000000000031','19'),
('00000000000031','28'),
('00000000000032','20'),
('00000000000032','32'),
('00000000000032','45'),
('00000000000033','23'),
('00000000000033','38'),
('00000000000034','4'),
('00000000000034','24'),
('00000000000035','8'),
('00000000000035','28'),
('00000000000035','47'),
('00000000000036','25'),
('00000000000036','31'),
('00000000000037','1'),
('00000000000037','42'),
('00000000000038','11'),
('00000000000038','43'),
('00000000000039','21'),
('00000000000039','32'),
('00000000000040','10'),
('00000000000040','27'),
('00000000000041','7'),
('00000000000041','39'),
('00000000000042','29'),
('00000000000042','46'),
('00000000000043','17'),
('00000000000043','40'),
('00000000000044','9'),
('00000000000044','35'),
('00000000000044','49'),
('00000000000045','2'),
('00000000000045','33'),
('00000000000046','5'),
('00000000000046','48'),
('00000000000046','50'),
('00000000000047','6'),
('00000000000047','18'),
('00000000000048','3'),
('00000000000048','44'),
('00000000000049','12'),
('00000000000049','19'),
('00000000000049','30'),
('00000000000050','4'),
('00000000000050','24');


-- estoque - 2 depositos para cada produto
INSERT INTO ESTOQUE (FK_codigoProduto,FK_codigoDeposito,Quantidade) VALUES
(1,48,19),
(1,36,34),
(2,19,26),
(2,39,91),
(3,22,87),
(3,6,40),
(4,14,100),
(4,10,97),
(5,49,73),
(5,46,20),
(6,18,10),
(6,8,55),
(7,1,23),
(7,50,97),
(8,19,82),
(8,16,73),
(9,5,23),
(9,11,66),
(10,35,55),
(10,37,19),
(11,38,11),
(11,32,50),
(12,26,14),
(12,34,22),
(13,1,22),
(13,14,22),
(14,46,44),
(14,34,64),
(15,38,83),
(15,49,71),
(16,39,57),
(16,40,6),
(17,17,11),
(17,42,50),
(18,17,31),
(18,37,26),
(19,41,55),
(19,10,22),
(20,20,9),
(20,31,51),
(21,13,24),
(21,35,5),
(22,46,18),
(22,4,24),
(23,10,31),
(23,2,91),
(24,41,10),
(24,20,54),
(25,44,32),
(25,33,72),
(26,40,61),
(26,25,87),
(27,14,28),
(27,27,46),
(28,11,29),
(28,16,72),
(29,34,37),
(29,45,34),
(30,20,4),
(30,46,33),
(31,20,13),
(31,13,60),
(32,1,34),
(32,17,84),
(33,20,23),
(33,49,85),
(34,33,36),
(34,41,51),
(35,24,45),
(35,11,93),
(36,17,4),
(36,15,92),
(37,32,84),
(37,8,68),
(38,12,37),
(38,50,70),
(39,20,12),
(39,7,38),
(40,34,19),
(40,44,2),
(41,29,38),
(41,32,31),
(42,22,70),
(42,45,32),
(43,2,7),
(43,24,98),
(44,36,75),
(44,12,54),
(45,30,64),
(45,17,5),
(46,38,44),
(46,23,3),
(47,40,87),
(47,7,15),
(48,41,21),
(48,21,30),
(49,10,31),
(49,4,82),
(50,23,25),
(50,12,7);


-- VENDAS
INSERT INTO TB_VENDA (valorTotal,FK_cpfCliente,FK_cpfFuncionario,FK_codigoProduto,FK_codigoPagamento,dataVenda) VALUES
('1171.45','00000000001','90000000001','8','1','2025-11-01'),
('101.13','00000000002','90000000002','48','2','2025-11-02'),
('3248.50','00000000003','90000000003','48','3','2025-11-03'),
('1901.12','00000000004','90000000004','34','4','2025-11-04'),
('3929.76','00000000005','90000000005','19','5','2025-11-05'),
('616.70','00000000006','90000000006','41','6','2025-11-06'),
('2251.90','00000000007','90000000007','12','7','2025-11-07'),
('1633.57','00000000008','90000000008','31','8','2025-11-08'),
('1471.05','00000000009','90000000009','20','9','2025-11-09'),
('2459.59','00000000010','90000000010','3','10','2025-11-10'),
('1818.55','00000000011','90000000011','30','11','2025-11-11'),
('752.35','00000000012','90000000012','10','12','2025-11-12'),
('2364.58','00000000013','90000000013','32','13','2025-11-13'),
('2217.60','00000000014','90000000014','46','14','2025-11-14'),
('1052.04','00000000015','90000000015','19','15','2025-11-15'),
('886.01','00000000016','90000000016','10','16','2025-11-16'),
('2397.39','00000000017','90000000017','17','17','2025-11-17'),
('3550.01','00000000018','90000000018','25','18','2025-11-18'),
('1709.45','00000000019','90000000019','32','19','2025-11-19'),
('3332.95','00000000020','90000000020','41','20','2025-11-20'),
('2419.04','00000000021','90000000021','16','21','2025-11-21'),
('1546.73','00000000022','90000000022','37','22','2025-11-22'),
('1345.47','00000000023','90000000023','34','23','2025-11-23'),
('4445.15','00000000024','90000000024','39','24','2025-11-24'),
('2813.54','00000000025','90000000025','48','25','2025-11-25'),
('2948.67','00000000026','90000000026','7','26','2025-11-26'),
('1356.43','00000000027','90000000027','3','27','2025-11-27'),
('3266.68','00000000028','90000000028','5','28','2025-11-28'),
('3076.38','00000000029','90000000029','24','29','2025-11-29'),
('1843.19','00000000030','90000000030','38','30','2025-11-30'),
('1530.16','00000000031','90000000031','39','31','2025-12-01'),
('551.06','00000000032','90000000032','25','32','2025-12-02'),
('2257.37','00000000033','90000000033','32','33','2025-12-03'),
('2463.18','00000000034','90000000034','46','34','2025-12-04'),
('2430.00','00000000035','90000000035','28','35','2025-12-05'),
('1470.32','00000000036','90000000036','6','36','2025-12-06'),
('2643.83','00000000037','90000000037','9','37','2025-12-07'),
('1496.75','00000000038','90000000038','21','38','2025-12-08'),
('3430.26','00000000039','90000000039','20','39','2025-12-09'),
('1322.69','00000000040','90000000040','18','40','2025-12-10'),
('2747.34','00000000041','90000000041','22','41','2025-12-11'),
('2627.46','00000000042','90000000042','44','42','2025-12-12'),
('1499.06','00000000043','90000000043','13','43','2025-12-13'),
('1585.92','00000000044','90000000044','49','44','2025-12-14'),
('2316.98','00000000045','90000000045','10','45','2025-12-15'),
('2652.71','00000000046','90000000046','6','46','2025-12-16'),
('2928.17','00000000047','90000000047','34','47','2025-12-17'),
('1030.17','00000000048','90000000048','50','48','2025-12-18'),
('1221.09','00000000049','90000000049','33','49','2025-12-19'),
('793.48','00000000050','90000000050','7','50','2025-12-20');


-- ITENS DE VENDA
INSERT INTO TB_ITEMVENDA (FK_IdVenda,FK_codigoProduto,quantidade,valorUnitario) VALUES
(1,8,1,'90.06'),
(1,48,3,'101.13'),
(1,16,2,'389.00'),
(2,48,1,'101.13'),
(3,48,1,'101.13'),
(3,5,2,'660.89'),
(3,22,4,'549.45'),
(4,34,1,'264.73'),
(4,20,2,'813.75'),
(4,49,2,'219.04'),
(5,19,3,'724.58'),
(5,31,3,'780.71'),
(5,11,1,'624.04'),
(6,41,2,'912.36'),
(6,10,1,'594.68'),
(7,12,1,'199.92'),
(7,21,3,'201.16'),
(7,32,3,'796.34'),
(8,31,2,'780.71'),
(8,4,1,'702.13'),
(9,20,1,'813.75'),
(9,6,2,'464.45'),
(10,3,2,'389.93'),
(10,46,2,'857.48'),
(10,26,1,'886.27'),
(11,30,2,'754.72'),
(11,27,1,'546.27'),
(11,29,1,'679.18'),
(11,7,1,'559.24'),
(12,10,1,'594.68'),
(12,24,1,'598.18'),
(13,32,2,'796.34'),
(13,15,2,'292.59'),
(13,50,3,'350.18'),
(14,46,1,'857.48'),
(14,33,2,'888.66'),
(14,2,1,'575.80'),
(15,19,1,'724.58'),
(15,13,2,'116.43'),
(15,40,2,'533.75'),
(16,10,1,'594.68'),
(16,1,1,'228.82'),
(16,45,1,'512.63'),
(17,17,1,'536.63'),
(17,42,2,'631.09'),
(17,39,3,'307.76'),
(18,25,3,'528.66'),
(18,32,3,'796.34'),
(18,6,1,'464.45'),
(19,32,1,'796.34'),
(19,1,2,'228.82'),
(19,44,1,'513.54'),
(20,41,3,'912.36'),
(20,18,1,'226.08'),
(20,47,1,'292.17'),
(21,16,3,'389.00'),
(21,30,2,'754.72'),
(21,19,1,'724.58'),
(22,37,1,'986.50'),
(22,8,2,'90.06'),
(22,11,1,'624.04'),
(23,34,2,'264.73'),
(23,28,1,'614.65'),
(23,9,1,'501.39'),
(24,39,3,'307.76'),
(24,5,2,'660.89'),
(24,41,2,'912.36'),
(25,48,4,'101.13'),
(25,32,1,'796.34'),
(26,7,3,'559.24'),
(26,4,1,'702.13'),
(27,3,2,'389.93'),
(27,43,1,'168.10'),
(27,22,1,'549.45'),
(28,5,2,'660.89'),
(28,29,2,'679.18'),
(28,35,1,'785.56'),
(29,24,3,'598.18'),
(29,33,1,'888.66'),
(29,2,1,'575.80'),
(30,38,2,'670.73'),
(30,36,1,'785.85'),
(30,23,1,'576.78'),
(31,39,2,'307.76'),
(31,11,3,'624.04'),
(31,3,1,'389.93'),
(32,25,1,'528.66'),
(32,14,1,'264.03'),
(32,49,1,'219.04'),
(33,32,2,'796.34'),
(33,21,1,'201.16'),
(33,26,1,'886.27'),
(34,46,2,'857.48'),
(34,30,1,'754.72'),
(34,17,1,'536.63'),
(35,28,3,'614.65'),
(35,12,2,'199.92'),
(36,6,2,'464.45'),
(36,50,1,'350.18'),
(37,9,2,'501.39'),
(37,18,2,'226.08'),
(37,27,1,'546.27'),
(38,21,2,'201.16'),
(38,44,2,'513.54'),
(39,20,3,'813.75'),
(39,7,1,'559.24'),
(39,3,1,'389.93'),
(40,18,2,'226.08'),
(40,31,2,'780.71'),
(41,22,2,'549.45'),
(41,4,2,'702.13'),
(41,37,1,'986.50'),
(42,44,3,'513.54'),
(42,8,1,'90.06'),
(43,13,3,'116.43'),
(43,36,1,'785.85'),
(44,49,2,'219.04'),
(44,15,2,'292.59'),
(45,10,2,'594.68'),
(45,41,1,'912.36'),
(45,16,1,'389.00'),
(46,6,3,'464.45'),
(46,24,1,'598.18'),
(47,34,2,'264.73'),
(47,33,2,'888.66'),
(48,50,2,'350.18'),
(48,14,1,'264.03'),
(49,33,1,'888.66'),
(49,2,1,'575.80'),
(49,1,1,'228.82'),
(50,7,1,'559.24'),
(50,23,1,'576.78'),
(50,45,1,'512.63');



--   DML – ATUALIZAÇÕES E REMOÇÕES

-- ATUALIZAÇÃO 1
-- criterio: WHERE por CPF
UPDATE TB_CLIENTE
SET telefone='21999990099'
WHERE PK_cpfCliente='00000000001';
-- Conferir o telefone do cliente de CPF 00000000001
SELECT PK_cpfCliente,
       nomeCliente,
       telefone
FROM TB_CLIENTE
WHERE PK_cpfCliente = '00000000001';

-- ATUALIZAÇÃO 2
-- criterio: só categoria Moto, com subconsulta
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
-- Conferir os preços de todos os produtos da categoria 'Moto'
SELECT PK_codigoProduto,
       nomeProduto,
       categoria,
       precoProduto
FROM TB_PRODUTO
WHERE categoria = 'Moto'
ORDER BY PK_codigoProduto
LIMIT 10;

-- ATUALIZAÇÃO 3
-- criterio: por PK
UPDATE TB_PAGAMENTO
SET statusPagamento='Pago', jurosPagamento=0
WHERE PK_codigoPagamento=2;
-- Conferir o pagamento de código 2
SELECT PK_codigoPagamento,
       vencimentoPagamento,
       statusPagamento,
       tipoPagamento,
       parcelasPagamento,
       jurosPagamento,
       valorPagamento
FROM TB_PAGAMENTO
WHERE PK_codigoPagamento = 2;

-- ATUALIZAÇÃO ENVOLVENDO MAIS DE UMA TABELA
UPDATE TB_PAGAMENTO pg
SET statusPagamento='Em cobrança'
WHERE pg.PK_codigoPagamento IN (
  SELECT v.FK_codigoPagamento
  FROM TB_VENDA v
  WHERE v.FK_cpfCliente='00000000022'
);
-- Conferir os pagamentos ligados ao cliente de CPF 00000000022
SELECT pg.PK_codigoPagamento,
       pg.statusPagamento,
       pg.vencimentoPagamento,
       pg.tipoPagamento,
       pg.parcelasPagamento,
       pg.jurosPagamento,
       pg.valorPagamento
FROM TB_PAGAMENTO pg
JOIN TB_VENDA v
  ON v.FK_codigoPagamento = pg.PK_codigoPagamento
WHERE v.FK_cpfCliente = '00000000022';

-- REMOÇÃO 1
-- criterio: uso de FK com critério bem definido, sendo: venda 3, produto 3
DELETE FROM TB_ITEMVENDA
WHERE FK_IdVenda=3 AND FK_codigoProduto=5;
-- Conferir os itens da venda 3 (o item do produto 5 deve ter sumido)
SELECT PK_IdItemVenda,
       FK_IdVenda,
       FK_codigoProduto,
       quantidade,
       valorUnitario
FROM TB_ITEMVENDA
WHERE FK_IdVenda = 3;

-- REMOÇÃO 2
-- criterio: remover o vínculo entre o fornecedor 00000000000050 e o produto 24
DELETE FROM TB_PRODUTO_FORNECEDOR
WHERE FK_PK_CNPJ = '00000000000050'
  AND FK_PK_codigoProduto = 24;
-- Conferir os produtos ainda associados ao fornecedor 00000000000050
SELECT FK_PK_CNPJ,
       FK_PK_codigoProduto
FROM TB_PRODUTO_FORNECEDOR
WHERE FK_PK_CNPJ = '00000000000050';

-- REMOÇÃO ENVOLVENDO MAIS DE UMA TABELA
-- criterio: depende da tabela ESTOQUE (exclui se não tiver estoque para esse deposito)
DELETE FROM TB_DEPOSITO
WHERE PK_codigoDeposito=28
AND NOT EXISTS (SELECT 1 FROM ESTOQUE e WHERE e.FK_codigoDeposito = 28);
-- Conferir se o depósito 28 ainda existe
SELECT PK_codigoDeposito,
       enderecoDeposito
FROM TB_DEPOSITO
WHERE PK_codigoDeposito = 28;


--   DQL – CONSULTAS

-- CONSULTA 1 - vendas dentre um período determinado de tempo
SELECT v.PK_idVenda, v.dataVenda, c.nomeCliente, f.nomeFuncionario, v.valorTotal
FROM TB_VENDA v
JOIN TB_CLIENTE c ON v.FK_cpfCliente = c.PK_cpfCliente
JOIN TB_FUNCIONARIO f ON v.FK_cpfFuncionario = f.PK_cpfFuncionario
WHERE v.dataVenda BETWEEN '2025-11-01' AND '2025-11-03'
ORDER BY v.dataVenda, v.PK_idVenda;

-- CONSULTA 2 – relatório de estoque
SELECT p.nomeProduto, d.enderecoDeposito, e.Quantidade
FROM ESTOQUE e
JOIN TB_PRODUTO p ON e.FK_codigoProduto = p.PK_codigoProduto
JOIN TB_DEPOSITO d ON e.FK_codigoDeposito = d.PK_codigoDeposito
LIMIT 10;

-- CONSULTA 3 – cliente por CPF / consulta individual
SELECT * FROM TB_CLIENTE WHERE PK_cpfCliente='00000000001';

-- CONSULTA 4 – detalhes da venda 1 / consulta individual (itens de venda especifica)
SELECT * FROM TB_ITEMVENDA WHERE FK_IdVenda=1;

-- CONSULTA 5 – produtos por fornecedor
SELECT f.razaoSocial, p.nomeProduto
FROM TB_FORNECEDORES f
JOIN TB_PRODUTO_FORNECEDOR pf ON pf.FK_PK_CNPJ=f.PK_CNPJ
JOIN TB_PRODUTO p ON p.PK_codigoProduto=pf.FK_PK_codigoProduto
LIMIT 10;

-- CONSULTA 6 – vendas por funcionário
SELECT f.nomeFuncionario, v.PK_idVenda, v.valorTotal
FROM TB_FUNCIONARIO f
JOIN TB_VENDA v ON v.FK_cpfFuncionario=f.PK_cpfFuncionario
LIMIT 10;

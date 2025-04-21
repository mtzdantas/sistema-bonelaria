CREATE TABLE endereco (
    id_endereco SERIAL PRIMARY KEY,
    rua VARCHAR(100),
    bairro VARCHAR(100),
    numero INT,
    complemento VARCHAR(100)
);

CREATE TABLE funcao (
    id_funcao SERIAL PRIMARY KEY,
    nome VARCHAR(100)
);

CREATE TABLE funcionario (
    id_funcionario SERIAL PRIMARY KEY,
    nome VARCHAR(100),
    id_endereco INT REFERENCES endereco(id_endereco),
    cpf VARCHAR(14),
    telefone VARCHAR(20),
    email VARCHAR(100),
    piso_salarial DOUBLE PRECISION,
    salario DOUBLE PRECISION,
    id_funcao INT REFERENCES funcao(id_funcao)
);

CREATE TABLE pedido (
    id_pedido SERIAL PRIMARY KEY,
    id_costureira INT REFERENCES funcionario(id_funcionario),
    status_pedido VARCHAR(50),
    data DATE
);

CREATE TABLE produto (
    id_produto SERIAL PRIMARY KEY,
    nome VARCHAR(100),
    categoria VARCHAR(50),
    descricao VARCHAR(255),
    quantidade_estoque INT
);

CREATE TABLE produto_pedido (
    id_produto_pedido SERIAL PRIMARY KEY,
    id_pedido INT REFERENCES pedido(id_pedido),
    id_produto INT REFERENCES produto(id_produto),
    quantidade_produto INT,
    valor_produto DOUBLE PRECISION
);

CREATE TABLE insumos (
    id_insumo SERIAL PRIMARY KEY,
    nome VARCHAR(100),
    quantidade_estoque INT,
    tipo_de_insumo VARCHAR(50)
);

CREATE TABLE produto_insumo (
    id_produto_insumo SERIAL PRIMARY KEY,
    id_produto INT REFERENCES produto(id_produto),
    id_insumo INT REFERENCES insumos(id_insumo),
    quantia_insumo INT
);

CREATE TABLE pagamento (
    id_pagamento SERIAL PRIMARY KEY,
    valor_pagamento DOUBLE PRECISION,
    forma_pagamento VARCHAR(50)
);

CREATE TABLE conta_a_pagar (
    id_conta_a_pagar SERIAL PRIMARY KEY,
    id_pedido INT REFERENCES pedido(id_pedido),
    id_pagamento INT REFERENCES pagamento(id_pagamento),
    valor DOUBLE PRECISION,
    data_vencimento DATE,
    status_pagamento VARCHAR(50)
);

-- Criação da extensão (necessária apenas se usar UUIDs futuramente)
-- CREATE EXTENSION IF NOT EXISTS "pgcrypto";
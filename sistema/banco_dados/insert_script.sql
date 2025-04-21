-- População de dados para a tabela FUNCÃO
INSERT INTO funcao (id_funcao, nome) VALUES
(1, 'Gerente'),
(2, 'Costureira');

-- População de dados para a tabela ENDEREÇO
INSERT INTO endereco (id_endereco, rua, bairro, numero, complemento) VALUES
(1, 'Rua Otávio Lamartine', 'Centro', 45, 'Casa'),
(2, 'Rua Renato Dantas', 'Paraíba', 133, 'Casa'),
(3, 'Avenida Seridó', 'Centro', 234, 'Próximo à praça'),
(4, 'Rua Ruy Mariz', 'Penedo', 87, 'Casa amarela'),
(5, 'Rua Joaquim Gorgônio', 'Maynard', 98, 'Fundos'),
(6, 'Rua Francisco Raimundo', 'Boa Passagem', 76, 'Casa 2'),
(7, 'Rua Pedro Velho', 'Barra Nova', 65, 'Perto do colégio'),
(8, 'Rua Zeco Diniz', 'Vila Altiva', 121, 'Esquina'),
(9, 'Rua José Evaristo', 'Nova Descoberta', 59, 'Sem complemento'),
(10, 'Rua Marinheiro Manoel Inácio', 'Samanaú', 41, 'Ao lado do mercado');

-- População de dados para a tabela FUNCIONÁRIO
INSERT INTO funcionario (id_funcionario, nome, id_endereco, cpf, telefone, email, piso_salarial, salario, id_funcao) VALUES
(1, 'Joacir Dantas', 1, '39734817040', '84998765432', 'bonelariamilitar@gmail.com', 1320.00, 3200.00, 1),
(2, 'Maria Clara', 2, '20717924007', '84996661234', 'maria.clara@bonelaria.com', 1320.00, 1800.00, 2),
(3, 'Ana Paula', 3, '36178525063', '84996543210', 'ana.paula@bonelaria.com', 1320.00, 1700.00, 2),
(4, 'Carla Fernanda', 4, '69088756018', '84996119876', 'carla@bonelaria.com', 1320.00, 1650.00, 2),
(5, 'Beatriz Souza', 5, '70237811036', '84999223344', 'beatriz@bonelaria.com', 1320.00, 1600.00, 2),
(6, 'Patrícia Gomes', 6, '15218949000', '84998877665', 'patricia@bonelaria.com', 1320.00, 1750.00, 2),
(7, 'Sabrina Silva', 7, '60113748043', '84997766554', 'sabrina@bonelaria.com', 1320.00, 1580.00, 2),
(8, 'Juliana Melo', 8, '11138130000', '84996677889', 'juliana@bonelaria.com', 1320.00, 1620.00, 2),
(9, 'Camila Rocha', 9, '47823567070', '84994433221', 'camila@bonelaria.com', 1320.00, 1680.00, 2),
(10, 'Lorena Dias', 10, '07551729043', '84991112233', 'lorena@bonelaria.com', 1320.00, 1690.00, 2);

-- População de dados para a tabela PRODUTO
INSERT INTO produto (id_produto, nome, categoria, descricao, quantidade_estoque) VALUES
(1, 'Boné Tático Verde', 'Boné', 'Boné camuflado verde com proteção UV', 50),
(2, 'Boné Tático Bege', 'Boné', 'Boné padrão militar cor bege', 60),
(3, 'Chapéu Boonie Verde', 'Chapéu', 'Chapéu militar largo com ajuste', 30),
(4, 'Boné Preto SWAT', 'Boné', 'Boné preto estilo SWAT', 70),
(5, 'Boné Caatinga', 'Boné', 'Boné camuflado para o sertão nordestino', 45),
(6, 'Calção Camuflado', 'Calção', 'Calção de treino padrão militar', 40),
(7, 'Touca Militar', 'Touca', 'Touca térmica preta militar', 80),
(8, 'Boné Azul Marinho', 'Boné', 'Boné padrão marinha do Brasil', 55),
(9, 'Boina Vermelha', 'Boina', 'Boina militar para uso cerimonial', 25),
(10, 'Boné Camuflagem Digital', 'Boné', 'Boné com estampa digital pixelada', 65);

-- População de dados para a tabela INSUMOS
INSERT INTO insumos (id_insumo, nome, quantidade_estoque, tipo_de_insumo) VALUES
(1, 'Tecido Ripstop Verde', 200, 'Tecido'),
(2, 'Tecido Ripstop Bege', 180, 'Tecido'),
(3, 'Linha de Costura Preta', 1000, 'Linha'),
(4, 'Linha de Costura Verde', 950, 'Linha'),
(5, 'Elástico Militar', 600, 'Elástico'),
(6, 'Botão Camuflado', 400, 'Botão'),
(7, 'Tecido Dry Fit Preto', 300, 'Tecido'),
(8, 'Velcro de Fixação', 350, 'Velcro'),
(9, 'Etiqueta Bordada', 250, 'Etiqueta'),
(10, 'Fivela de Nylon', 150, 'Fivela');

-- População de dados para a tabela PEDIDO
INSERT INTO pedido (id_pedido, id_costureira, status_pedido, data) VALUES
(1, 2, 'Em produção', '2025-04-21'),
(2, 3, 'Finalizado', '2025-04-20'),
(3, 4, 'Em produção', '2025-04-19'),
(4, 5, 'Finalizado', '2025-04-18'),
(5, 6, 'Em produção', '2025-04-17'),
(6, 7, 'Pendente', '2025-04-16'),
(7, 8, 'Finalizado', '2025-04-15'),
(8, 9, 'Em produção', '2025-04-14'),
(9, 10, 'Pendente', '2025-04-13'),
(10, 2, 'Finalizado', '2025-04-12');

-- População de dados para a tabela PRODUTO_PEDIDO
INSERT INTO produto_pedido (id_produto_pedido, id_pedido, id_produto, quantidade_produto, valor_produto) VALUES
(1, 1, 1, 2, 50.00),
(2, 2, 3, 1, 30.00),
(3, 3, 2, 3, 60.00),
(4, 4, 4, 1, 80.00),
(5, 5, 5, 2, 40.00),
(6, 6, 6, 5, 20.00),
(7, 7, 7, 3, 15.00),
(8, 8, 8, 2, 45.00),
(9, 9, 9, 4, 20.00),
(10, 10, 10, 2, 65.00);

-- População de dados para a tabela PRODUTO_INSUMO
INSERT INTO produto_insumo (id_produto_insumo, id_produto, id_insumo, quantia_insumo) VALUES
(1, 1, 1, 10),
(2, 2, 3, 20),
(3, 3, 2, 15),
(4, 4, 4, 25),
(5, 5, 5, 30),
(6, 6, 6, 12),
(7, 7, 7, 18),
(8, 8, 8, 10),
(9, 9, 9, 22),
(10, 10, 10, 14);

-- População de dados para a tabela PAGAMENTO
INSERT INTO pagamento (id_pagamento, valor_pagamento, forma_pagamento) VALUES
(1, 2000.00, 'Transferência'),
(2, 1500.00, 'Pix'),
(3, 1200.00, 'Dinheiro'),
(4, 2500.00, 'Cartão de Crédito'),
(5, 800.00, 'Boleto'),
(6, 3500.00, 'Transferência'),
(7, 2200.00, 'Pix'),
(8, 1800.00, 'Dinheiro'),
(9, 2700.00, 'Cartão de Crédito'),
(10, 950.00, 'Boleto');

-- População de dados para a tabela CONTA_A_PAGAR
INSERT INTO conta_a_pagar (id_conta_a_pagar, id_pedido, id_pagamento, valor, data_vencimento, status_pagamento) VALUES
(1, 1, 1, 1000.00, '2025-05-01', 'Pago'),
(2, 2, 2, 500.00, '2025-05-02', 'Pendente'),
(3, 3, 3, 800.00, '2025-05-03', 'Pendente'),
(4, 4, 4, 1200.00, '2025-05-04', 'Pago'),
(5, 5, 5, 1500.00, '2025-05-05', 'Pago'),
(6, 6, 6, 700.00, '2025-05-06', 'Pendente'),
(7, 7, 7, 1300.00, '2025-05-07', 'Pago'),
(8, 8, 8, 1100.00, '2025-05-08', 'Pendente'),
(9, 9, 9, 950.00, '2025-05-09', 'Pago'),
(10, 10, 10, 2000.00, '2025-05-10', 'Pendente');

-- Relatório das contas a pagar
-- Descrição: Essa consulta retorna uma lista de todas as contas a pagar, inclusive o nome do funcionário responsavel pelo pedido. Por acaso o pedido não tenha um funcionário relacionado a ele, o nome será exibido como "NULL"
SELECT 
	cp.id_conta_a_pagar,
    cp.id_pedido,
    cp.id_pagamento,
    cp.valor,
    cp.data_vencimento,
    cp.status_pagamento,
    f.nome
FROM 
	conta_a_pagar cp
JOIN pedido p ON cp.id_pedido = p.id_pedido
LEFT JOIN funcionario f ON p.id_costureira = f.id_funcionario
ORDER BY cp.data_vencimento
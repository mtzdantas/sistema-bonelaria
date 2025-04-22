--  Lista de costureiras com pedidos pendentes
-- Descrição: Ajuda no acompanhamento do andamento da produção.

SELECT f.nome, COUNT(p.id_pedido) AS pedidos_pendentes
FROM funcionario f
JOIN pedido p ON f.id_funcionario = p.id_costureira
WHERE p.status_pedido != 'Finalizado'
GROUP BY f.nome;
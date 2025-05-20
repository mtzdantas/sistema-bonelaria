-- Relatório de pedidos
-- Descrição: Essa consulta lista todos os pedidos, incluindo o nome da costureira responsável, nome e quantidade de cada produto.
SELECT
    p.id_pedido,
    p.data,
    p.status_pedido,
    f.nome AS nome_costureira,
    STRING_AGG(pr.nome || ' (' || pp.quantidade_produto || ')', ', ') AS produtos
FROM pedido p
LEFT JOIN funcionario f ON p.id_costureira = f.id_funcionario
LEFT JOIN produto_pedido pp ON p.id_pedido = pp.id_pedido
LEFT JOIN produto pr ON pp.id_produto = pr.id_produto
GROUP BY p.id_pedido, p.data, p.status_pedido, f.nome
ORDER BY p.data;

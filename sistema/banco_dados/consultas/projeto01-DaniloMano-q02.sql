-- Consulta de Valor de Cada Pedido Finalizado por Costureira
-- Descrição: Mostra o ID da costureira, nome da costureira, ID do pedido e o valor total a ser pago por cada pedido finalizado.
-- nessa query podemos transformar ela (ou só a cte) numa view para ser reutilizada para querys mais resumidas

WITH pedidos_concluidos AS (
    SELECT 
        p.id_pedido,
        p.id_costureira,
        p.status_pedido,
        SUM(pp.quantidade_produto * pp.valor_produto) AS total_pedido
    FROM pedido p
    INNER JOIN produto_pedido pp ON p.id_pedido = pp.id_pedido
    WHERE p.status_pedido = 'Finalizado'
    GROUP BY p.id_pedido, p.id_costureira
)
SELECT 
    f.id_funcionario AS id_costureira,
    f.nome AS costureira,
    pc.id_pedido,
    pc.total_pedido AS valor_a_pagar
FROM pedidos_concluidos pc
INNER JOIN funcionario f ON f.id_funcionario = pc.id_costureira
ORDER BY f.nome, pc.id_pedido;

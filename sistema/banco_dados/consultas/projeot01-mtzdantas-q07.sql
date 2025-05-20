-- Produção por mês
-- Descrição: Mostra a produção do mês e permite montar gráfico de produção mensal.

SELECT TO_CHAR(p.data, 'YYYY-MM') AS mes, COUNT(p.id_pedido) AS total_pedidos
FROM pedido p
GROUP BY mes
ORDER BY mes;
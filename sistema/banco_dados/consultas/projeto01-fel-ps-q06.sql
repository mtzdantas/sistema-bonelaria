-- Relatório de pedidos específicos
-- Descrição: Essa consulta lista todos os pedidos, incluindo o nome da costureira responsável, nome e quantidade de cada produto.
-- OBS: Neste relatório o administrador pode escolher o mês e o ano específico para buscar os pedidos da referente data.
SELECT
    p.id_pedido,
    p.data,
    p.status_pedido,
    f.nome AS nome_costureira,
    STRING_AGG(pr.nome || ' (' || pp.quantidade_produto || ')', ', ') AS produtos
FROM pedido p
JOIN funcionario f ON p.id_costureira = f.id_funcionario
JOIN produto_pedido pp ON p.id_pedido = pp.id_pedido
JOIN produto pr ON pp.id_produto = pr.id_produto
WHERE EXTRACT(MONTH FROM p.data) = 4  -- mês (ex: abril)
  AND EXTRACT(YEAR FROM p.data) = 2025  -- ano (ex: 2025)
GROUP BY p.id_pedido, p.data, p.status_pedido, f.nome
ORDER BY p.data DESC;



-- PEGAR PEDIDOS DO MÊS ATUAL 
-- WHERE date_trunc('month', p.data) = date_trunc('month', CURRENT_DATE)
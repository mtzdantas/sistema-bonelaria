-- Relatório de Insumos usados por Produto
-- Descrição: Mostra quais insumos estão sendo usados em cada produto e em que quantidade.
-- Se tiver alguma coluna de insumo ou quantia_insumo sem dado válido é pq o cadastro está incompleto

SELECT pr.nome AS produto, i.nome AS insumo, pi.quantia_insumo
FROM produto pr
LEFT JOIN produto_insumo pi ON pr.id_produto = pi.id_produto
LEFT JOIN insumos i ON i.id_insumo = pi.id_insumo
ORDER BY pr.nome;
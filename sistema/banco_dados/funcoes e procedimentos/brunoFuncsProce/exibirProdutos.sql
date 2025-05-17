CREATE OR REPLACE FUNCTION get_produtos_com_insumos()
RETURNS TABLE (
    id_produto        INTEGER,
    produto_nome      TEXT,
    categoria         TEXT,
    id_insumo         INTEGER,
    insumo_nome       TEXT,
    tipo_de_insumo    TEXT,
    quantia_insumo    NUMERIC
) AS $$
BEGIN
    RETURN QUERY
    SELECT
        p.id_produto,
        p.nome AS produto_nome,
        p.categoria,
        i.id_insumo,
        i.nome AS insumo_nome,
        i.tipo_de_insumo,
        pi.quantia_insumo
    FROM produto p
    JOIN produto_insumo pi ON pi.id_produto = p.id_produto
    JOIN insumos i         ON i.id_insumo = pi.id_insumo
    ORDER BY p.nome, i.nome;
END;
$$ LANGUAGE plpgsql STABLE;
```

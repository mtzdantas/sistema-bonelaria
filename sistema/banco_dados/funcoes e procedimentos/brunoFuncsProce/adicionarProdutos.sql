CREATE OR REPLACE FUNCTION adicionar_produto_com_insumo(
  nome_produto TEXT,
  categoria TEXT,
  descricao TEXT,
  quantidade_estoque INTEGER,
  id_insumo INTEGER,
  quantia_insumo NUMERIC
)
RETURNS VOID AS $$
DECLARE
  novo_id_produto INTEGER;
BEGIN
  -- Inserir o produto
  INSERT INTO produto (nome, categoria, descricao, quantidade_estoque)
  VALUES (nome_produto, categoria, descricao, quantidade_estoque)
  RETURNING id_produto INTO novo_id_produto;

  -- Inserir o vínculo com o insumo
  INSERT INTO produto_insumo (id_produto, id_insumo, quantia_insumo)
  VALUES (novo_id_produto, id_insumo, quantia_insumo);
END;
$$ LANGUAGE plpgsql;

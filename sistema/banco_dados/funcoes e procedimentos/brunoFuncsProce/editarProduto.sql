CREATE OR REPLACE PROCEDURE editar_produto_proc(
  p_id_produto INTEGER,
  p_nome TEXT,
  p_categoria TEXT,
  p_descricao TEXT,
  p_quantidade_estoque INTEGER
)
LANGUAGE plpgsql
AS $$
BEGIN
  UPDATE produto
  SET nome = p_nome,
      categoria = p_categoria,
      descricao = p_descricao,
      quantidade_estoque = p_quantidade_estoque
  WHERE id_produto = p_id_produto;
END;
$$;

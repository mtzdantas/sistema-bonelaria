CREATE OR REPLACE PROCEDURE editar_insumo_proc(
  p_id_insumo INTEGER,
  p_nome VARCHAR,
  p_quantidade_estoque INTEGER,
  p_tipo_de_insumo VARCHAR
)
LANGUAGE plpgsql
AS $$
BEGIN
  UPDATE insumos
  SET nome = p_nome,
      quantidade_estoque = p_quantidade_estoque,
      tipo_de_insumo = p_tipo_de_insumo
  WHERE id_insumo = p_id_insumo;
END;
$$;

-- Relatório de quantidades restantes de insumos
-- Descrição: Essa consulta lista todos os insumos que estão com a quantidade abaixo da quantidade inserida e ordena do menor para o maior. Serve para o administrador ter ideia da quantidade de insumo restante e se há necessidade de restoque.

SELECT nome AS "Nome do Insumo", 
  tipo_de_insumo AS "Tipo", 
  quantidade_estoque AS "Quantidade"
FROM insumos
WHERE quantidade_estoque < 500 -- quantidade (ex: 200)
ORDER BY quantidade_estoque ASC;

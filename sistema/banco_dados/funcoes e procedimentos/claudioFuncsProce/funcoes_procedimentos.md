
# Tarefa 02 - Funções e Procedimentos

**Matrícula:** 20230030699    
**Nome:** Cláudio Pereira Teixeira de Araújo   
**Email:** claudio.pereira.710@ufrn.edu.br 

---

## Funções

### 1. Função: calcular_total_pedido(p_id_pedido INT)

Esta função calcula o valor total de um pedido somando o produto da quantidade pelo valor de cada produto associado ao pedido. É útil para obter rapidamente o custo total de um pedido, facilitando processos de faturamento e conferência.

```sql
CREATE OR REPLACE FUNCTION calcular_total_pedido(p_id_pedido INT)
RETURNS DOUBLE PRECISION
LANGUAGE sql
AS $$
    SELECT SUM(quantidade_produto * valor_produto)
    FROM produto_pedido
    WHERE id_pedido = p_id_pedido;
$$;
```

---

### 2. Função: insumos_do_produto(id_produto_input INT)

Esta função retorna uma tabela contendo os insumos utilizados na fabricação de um produto específico, incluindo o nome do insumo e a quantidade utilizada. Essa função é útil para controle de materiais e planejamento da produção.

```sql
CREATE OR REPLACE FUNCTION insumos_do_produto(id_produto_input INT)
RETURNS TABLE (
    nome_insumo VARCHAR,
    quantia_usada INT
) AS $$
BEGIN
    RETURN QUERY
    SELECT i.nome, pi.quantia_insumo
    FROM insumos i
    JOIN produto_insumo pi ON i.id_insumo = pi.id_insumo
    WHERE pi.id_produto = id_produto_input;
END;
$$ LANGUAGE plpgsql;
```

---

## Procedimentos

### 1. Procedimento: registrar_pagamento_pedido( p_id_pedido INT, p_valor NUMERIC,  p_forma_pagamento VARCHAR, p_data_vencimento DATE, p_status_pagamento VARCHAR )

Este procedimento insere um novo pagamento relacionado a um pedido específico, registrando o valor, forma de pagamento, data de vencimento e status do pagamento. Ele gerencia a criação do pagamento e vincula-o à conta a pagar correspondente ao pedido.

```sql
CREATE OR REPLACE PROCEDURE registrar_pagamento_pedido(
    p_id_pedido INT,
    p_valor NUMERIC,
    p_forma_pagamento VARCHAR,
    p_data_vencimento DATE,
    p_status_pagamento VARCHAR
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_id_pagamento INT;
BEGIN
    INSERT INTO pagamento (valor_pagamento, forma_pagamento)
    VALUES (p_valor, p_forma_pagamento)
    RETURNING id_pagamento INTO v_id_pagamento;

    INSERT INTO conta_a_pagar (id_pedido, id_pagamento, valor, data_vencimento, status_pagamento)
    VALUES (p_id_pedido, v_id_pagamento, p_valor, p_data_vencimento, p_status_pagamento);
END;
$$;
```

---

### 2. Procedimento: atualizar_status_pedido(p_id_pedido INT, p_novo_status VARCHAR)

Este procedimento atualiza o status de um pedido específico, permitindo alterar seu estado, como por exemplo, de "Em andamento" para "Finalizado". Facilita o controle do fluxo dos pedidos na produção.

```sql
CREATE OR REPLACE PROCEDURE atualizar_status_pedido(
    p_id_pedido INT,
    p_novo_status VARCHAR
)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE pedido
    SET status_pedido = p_novo_status
    WHERE id_pedido = p_id_pedido;
END;
$$;
```

---

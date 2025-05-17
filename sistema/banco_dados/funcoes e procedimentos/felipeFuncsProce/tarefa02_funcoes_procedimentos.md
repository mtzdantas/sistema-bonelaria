# Tarefa 02 - Funções e Procedimentos

**Matrícula:** 20230031696  
**Nome:** Felipe Augusto Araújo da Cunha  
**Email:** araujofelipe54@gmail.com  

---

## Funções

### 1. buscar_email_funcionario(id_funcionario INT)

Esta função tem como objetivo obter o endereço de e-mail de um funcionário com base em seu identificador único (id_funcionario). Ela é útil para sistemas que precisam recuperar rapidamente as informações de contato de um funcionário para envio de notificações ou para exibição em interfaces administrativas.

```sql
CREATE OR REPLACE FUNCTION buscar_email_funcionario(id_funcionario INT)
RETURNS VARCHAR AS $$
DECLARE
  email_func VARCHAR;
BEGIN
  SELECT email INTO email_func
  FROM funcionario
  WHERE id_funcionario = buscar_email_funcionario.id_funcionario;

  RETURN email_func;
END;
$$ LANGUAGE plpgsql;
```

---

### 2. Função: contar_pedidos_por_costureira(id_costureira INT)

Esta função retorna o total de pedidos registrados no sistema que estão associados a uma costureira específica. Com isso, é possível mensurar a produtividade de cada costureira e gerar relatórios de desempenho por colaborador.

```sql
CREATE OR REPLACE FUNCTION contar_pedidos_por_costureira(id_costureira INT)
RETURNS INT AS $$
DECLARE
  total_pedidos INT;
BEGIN
  SELECT COUNT(*) INTO total_pedidos
  FROM pedido
  WHERE id_costureira = id_costureira;

  RETURN total_pedidos;
END;
$$ LANGUAGE plpgsql;
```

---

## Procedimentos

### 1. Procedimento: atualizar_status_pagamento(id_conta INT, novo_status TEXT)

Este procedimento tem a função de atualizar o campo status_pagamento de uma conta a pagar no banco de dados, recebendo como parâmetros o ID da conta e o novo status. Ele pode ser utilizado, por exemplo, quando uma conta é quitada e precisa ter seu status alterado de "Pendente" para "Pago".

```sql
CREATE OR REPLACE PROCEDURE atualizar_status_pagamento(id_conta INT, novo_status TEXT)
LANGUAGE plpgsql
AS $$
BEGIN
  UPDATE conta_a_pagar
  SET status_pagamento = novo_status
  WHERE id_conta_a_pagar = id_conta;
END;
$$;
```

---

### 2. Procedimento: relatorio_estoque_insumos()

Este procedimento imprime no console do PostgreSQL um relatório com os nomes dos insumos cadastrados e suas respectivas quantidades em estoque. É útil para consultas rápidas diretamente no terminal ou durante execuções automáticas de rotinas administrativas.

```sql
CREATE OR REPLACE PROCEDURE relatorio_estoque_insumos()
LANGUAGE plpgsql
AS $$
DECLARE
  insumo RECORD;
BEGIN
  RAISE NOTICE 'Relatório de Estoque de Insumos:';
  FOR insumo IN SELECT nome, quantidade_estoque FROM insumos LOOP
    RAISE NOTICE 'Insumo: %, Quantidade: %', insumo.nome, insumo.quantidade_estoque;
  END LOOP;
END;
$$;
```

---


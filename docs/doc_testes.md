# Relatório de Testes de Módulo/Sistema

### Responsabilidade do Testador

---

## Legenda

* **Teste**: Código ou identificação do Teste.
* **Descrição**: Descrição dos passos e detalhes do teste a ser executado.
* **Especificação**: Informações sobre a função testada e se ela está de acordo com a especificação do caso de uso.
* **Resultado**: Resultado do teste, modificações sugeridas ou resultados do teste. No caso de erro ou problema na execução do teste, descrever o erro em detalhes e adicionar prints das telas.

---

## US03 – Manter Produtos

| Teste                     | Descrição                                                                                                                                                                                                                                | Especificação                                                                                        | Resultado                                                                                         |
| ------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------- |
| Teste 01: Incluir Produto | A1.1. O ator preenche os dados;<br> A1.2. O ator seleciona a opção Salvar;<br> A1.3. O sistema salva os dados;<br> A1.4. O sistema exibe uma mensagem de acordo com a \[MSG001];<br> A1.5. Fim do fluxo.                                              | Especificação OK | ok                               |
| Teste 02: Excluir Produto | A2.1. O ator executa o fluxo de Listar Produtos;<br> A2.2. O ator seleciona o Produto;<br> A2.3. O ator clica no botão Excluir Produto;<br> A2.4. O sistema solicita confirmação \[MSG005];<br> A2.5. O ator confirma;<br> A2.6. O sistema exclui e exibe \[MSG003]. | Especificação OK.                                                                                    | OK                                                                                                |
| Teste 03: Alterar Produto | A3.1. O ator acessa o fluxo de Listar Produtos;<br> A3.2. O ator seleciona o Produto e os dados são carregados;<br> A3.3. O ator edita os campos e clica em "Salvar";<br> A3.4. O sistema salva os dados;<br> A3.5. O sistema exibe \[MSG004].           | Especificação Ok   | OK |


## US02 – Enviar Pedido de Confecção

| Teste                    | Descrição                                                                                                                                                                 | Especificação                                   | Resultado |
| ------------------------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------- | --------- |
| Teste 01: Criar Pedido   | B1.1. O ator seleciona produto, costureira e data;<br>  B1.2. O ator confirma e envia o pedido;<br> B1.3. O sistema exibe \[MSG002]. | Especificação OK | OK        |


---

## US01 – Manter Funcionário

| Teste                         | Descrição                                                                                                                                                                                                                                      | Especificação                                                                                      | Resultado |
| ----------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------- | --------- |
| Teste 01: Incluir Funcionário | A1.1. O ator preenche os dados obrigatórios;<br>  A1.3. O ator clica em "Cadastrar";<br> A1.4. O sistema exibe uma mensagem de acordo com \[MSG001] ou \[MSG002];<br> A1.5. Fim do fluxo. | Especificação OK | OK        |


---


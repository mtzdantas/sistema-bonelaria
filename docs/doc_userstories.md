
# Documento Lista de User Stories(precisa editar)

Documento construído a partido do **Modelo BSI - Doc 004 - Lista de User Stories** que pode ser encontrado no
link: https://docs.google.com/document/d/1Ns2J9KTpLgNOpCZjXJXw_RSCSijTJhUx4zgFhYecEJg/edit?usp=sharing

## Descrição

Este documento descreve os User Stories criados a partir da Lista de Requisitos no [Documento 001 - Documento de Visão](doc-visao.md). Este documento também pode ser adaptado para descrever Casos de Uso. Modelo de documento baseado nas características do processo easYProcess (YP).

## Histórico de revisões

| Data       | Versão  | Descrição                          | Autor                          |
| :--------- | :-----: | :--------------------------------: | :----------------------------- |
| 04/12/2024 | 0.0.1   | Documento inicial  | Cláudio Pereira Teixeira de Araújo |


### User Story US01 - Manter Funcionário

|               |                                                                |
| ------------- | :------------------------------------------------------------- |
| **Descrição** | O sistema deve manter um cadastro de funcionário(Gerente, Costureira) que tem acesso ao sistema via login e senha. Um usuário tem os atributos nome, endereço, número de celular, email e senha. O email será o login e ele pode registrar-se diretamente no sistema e aguardar ativação da conta pelo proprietário. |

| **Requisitos envolvidos** |                                                    |
| ------------- | :------------------------------------------------------------- |
| RF01          | Cadastro da Costureira |

|                           |                                     |
| ------------------------- | ----------------------------------- | 
| **Prioridade**            | Essencial                           | 
| **Estimativa**            | 10 h                                | 
| **Tempo Gasto (real):**   |                                     | 
| **Tamanho Funcional**     | 8 PF                                | 
| **Analista**              | Claudio (responsável por especificar/detalhar o US).| 
| **Desenvolvedor**         | Danilo (responsável por implementar e realizar testes de unidade e testes de integração).| 
| **Revisor**               | Felipe (responsável por avaliar a implementação e executar os testes de unidade e testes de integração).| 
| **Testador**              | Bruno (responsável por executar os Testes de Aceitação e fazer o relatório de testes).| 


| Testes de Aceitação (TA) |  |
| ----------- | --------- |
| **Código**      | **Descrição** |
| **TA01.01** | O usuário informa, na tela Registrar, qual ocupação deseja realizar o cadastro (Gerente, Costureira), no qual o Gerente terá de ter uma chave de acesso específica para realizar o cadastro do mesmo, ao clicar em **Salvar** ele é notificado com uma mensagem de sucesso. Mensagem: *Cadastro realizado com sucesso*. |
| **TA01.02** | O usuário informa, na tela Registrar, qual ocupação deseja realizar o cadastro (Gerente, Costureira), no qual a Costureira ao clicar em **Salvar** ele é notificado com uma mensagem de sucesso. Mensagem: *Cadastro realizado com sucesso, aguardando confirmação do Gerente*. |
| **TA01.03** | Tentar fazer o registro com erro, exibir a mensagem de erro: **MSG001**: O campo {nomecampo} é obrigatório. **MSG001**: O campo {nomecampo} foi preenchido incorretamente. |
| **TA01.04** | O usuário informa, na tela Login, os dados para logar corretamente, ao clicar em **Entrar** ele é notificado com uma mensagem de erro. Mensagem: Usuário não ativado, aguardando ativação do Gerente. |
| **TA01.05** | O usuário informa, na tela Login, os dados para logar corretamente, ao clicar em **Entrar** ele é encaminhado para a tela principal do sistema. É exibida a Mensagem: Login realizado com sucesso. |
| **TA01.06** | Tentar fazer o login com erro, exibir a mensagem de erro: **MSG002**: O campo {nomecampo} é obrigatório. **MSG002**: O campo {nomecampo} foi preenchido incorretamente. |
| **TA01.07** | O usuário(Gerente), com acesso exclusivo à tela de alterar, informa o funcionário a ser alterado e então altera o(s) campo(s) {nomecampo} e então é exibida a mensagem: *Funcionário alterado com sucesso.* |
| **TA01.08** | Tentar alterar com erro, exibir a mensagem de erro: **MSG003**: O campo {nomecampo} foi preenchido incorretamente. **MSG003**: O campo {nomecampo} é obrigatório. **MSG003**: Nenhuma alteração foi feita. |
| **TA01.09** | O usuário(Gerente, Costureira), na tela de pesquisar, informa o funcionário a ser pesquisado por meio de {id, nome, email, número ou cpf} e então é exibida a tela atualizada com os funcionários correspondentes. |
| **TA01.10** | Tentar pesquisar não existente, exibir a mensagem de erro: **MSG004**: Nenhum funcionário foi encontrado. |
| **TA01.11** | O usuário(Gerente), com acesso exclusivo à tela de exclusão, informa o funcionário a ser excluído e então após confirmação com senha exclusiva do Gerente é exibida a mensagem: *Funcionário excluído com sucesso.* |
| **TA01.12** | Tentar excluir com erro, exibir a mensagem de erro: **MSG005**: O campo {nomecampo} foi preenchido incorretamente. **MSG005**: O funcionário não existe. |


### User Story US02 - Enviar Pedido de Confecção

|               |                                                                |
| ------------- | :------------------------------------------------------------- |
| **Descrição** | O sistema deve ter a função na qual o funcionário proprietário irá solicitar para uma ou mais funcionárias costureiras um ou mais pedidos de confecção, com base no estoque já estabelecido de matéria prima e de produtos cadastrados no sistema. O usuário encaminha a(s) matéria(s) prima(s) para a costureira. |

| **Requisitos envolvidos** |                                                    |
| ------------- | :------------------------------------------------------------- |
| RF05          | Cadastro de Entradas/Saídas(Calcular valor da comissão) |

|                           |                                     |
| ------------------------- | ----------------------------------- | 
| **Prioridade**            | Essencial                           | 
| **Estimativa**            | 8 h                                 | 
| **Tempo Gasto (real):**   |                                     | 
| **Tamanho Funcional**     |                                     | 
| **Analista**              | Mateus (responsável por especificar/detalhar o US).| 
| **Desenvolvedor**         | Claudio (responsável por implementar e realizar testes de unidade e testes de integração).| 
| **Revisor**               | Bruno (responsável por avaliar a implementação e executar os testes de unidade e testes de integração).| 
| **Testador**              | Danilo (responsável por executar os Testes de Aceitação e fazer o relatório de testes).| 


| Testes de Aceitação (TA) |  |
| ----------- | --------- |
| **Código**      | **Descrição** |
| **TA02.01** | O usuário seleciona o(s) produto(s) e uma respectiva costureira para fazer a confecção e clica em fazer pedido, é exibido as informações do pedido, incluindo a matéria prima necessária para fazer o produto, o usuário clica em confirmar o pedido: **MSG002**:Pedido {id} foi realizado com sucesso, solicitação de confecção para a costureira selecionada enviada. |
| **TA02.02** | Tentar fazer o pedido com erro, exibir a mensagem de erro: **MSG002**: O campo {nomecampo} é obrigatório. **MSG002**: O campo {nomecampo} foi preenchido incorretamente. |
| **TA02.03** | O usuário clica em alterar pedido, em um pedido que ainda não foi aceito pela costureira, altera corretamente os campos, ele clica em alterar pedido: **MSG002**: Alteração realizada. |
| **TA02.04** | O usuário clica em alterar pedido, em um pedido que já foi aceito pela costureira, altera corretamente os campos, ele clica em enviar pedido de alteração e a costureira aceita/recusa o pedido: **MSG002**:Pedido de alteração aceito, modificação realizada. **MSG002**:Pedido de alteração recusado. |
| **TA02.05** | Tentar alterar com erro. **MSG002**: O campo {nomecampo} é obrigatório. **MSG002**: O campo {nomecampo} foi preenchido incorretamente. **MSG002**: Nenhuma alteração foi feita |
| **TA02.06** | O usuário clicar em cancelar pedido, em um pedido que ainda não foi aceito, ele clica em cancelar pedido: **MSG002**: Pedido {id} cancelado. |
| **TA02.07** | O usuário clicar em cancelar pedido, em um pedido que já foi aceito, ele clica em enviar pedido de cancelamento e a costureira aceita/recusa o cancelamento **MSG002**:Pedido de cancelamento aceito. Pedido {id} cancelado **MSG002**:Pedido de cancelamento recusado. |


### User Story US03 - Manter Produtos

|               |                                                                |
| ------------- | :------------------------------------------------------------- |
| **Descrição** | O sistema deve apresentar os mecanismos necessários para gerenciar os produtos (CRUD dos dados dos produtos), com base no nome, material e data de fabricação. Por exemplo, cadastrar um boné no sistema, que usa cerca de 100cm² de tecido usado, para o dono da empresa saber quanto de material seria gasto na confecção do mesmo, além de quando já fabricado as costureiras puderem dar a data de retirada do produto. |

| **Requisitos envolvidos** |                                                    |
| ------------- | :------------------------------------------------------------- |
| RF03          | Cadastro do Produto |

|                           |                                     |
| ------------------------- | ----------------------------------- | 
| **Prioridade**            | Importante                          | 
| **Estimativa**            | 8 h                                 | 
| **Tempo Gasto (real):**   | 10 h                                | 
| **Tamanho Funcional**     |                                     | 
| **Analista**              | Bruno (responsável por especificar/detalhar o US).| 
| **Desenvolvedor**         | Felipe (responsável por implementar e realizar testes de unidade e testes de integração).| 
| **Revisor**               | Claudio (responsável por avaliar a implementação e executar os testes de unidade e testes de integração).| 
| **Testador**              | Mateus (responsável por executar os Testes de Aceitação e fazer o relatório de testes).| 


| Testes de Aceitação (TA) |  |
| ----------- | --------- |
| **Código**      | **Descrição** |
| **TA03.01** | O usuário seleciona o(s) produto(s). O usuário visualiza os produtos com as opções de cadastrar, visualizar, editar ou excluir novos produtos. O usuário clica em um respectivo produto, o usuário visualiza o produto com informações mais detalhadas, como nome, categoria, descrição, quantidade em estoque, insumo necessário para fazer o produto. O usuário clica em cadastrar novo produto: Produto {id} foi cadastrado com sucesso. As entradas de dados são validadas e o produto adicionado ao sistema. |
| **TA03.02** | O usuário clica em cadastrar produto com erro, exibir a mensagem de erro: **MSG003**: O campo {nomecampo} é obrigatório. **MSG003**: O campo {nomecampo} foi preenchido incorretamente. |
| **TA03.03** | O usuário clica em editar o respectivo produto. **MSG002**: Alteração realizada com sucesso. |
| **TA03.04** | Tentar alterar com erro. **MSG002**: O campo {nomecampo} é obrigatório. **MSG002**: O campo {nomecampo} foi preenchido incorretamente. **MSG002**: Nenhuma alteração foi feita |
| **TA03.05** | O usuário clica em editar o respectivo produto, confirma a exclusão do produto: **MSG002**: O produto foi excluído com sucesso |
| **TA03.06** | Tentar excluir com erro, exibir a mensagem de erro: **MSG005**: O campo {nomecampo} foi preenchido incorretamente. **MSG005**: O funcionário não existe |
| **TA03.07** | Tentar pesquisar não existente, exibir a mensagem de erro: **MSG004**: Nenhum produto foi encontrado. |


### User Story US04 - Receber material para confecção

|               |                                                                |
| ------------- | :------------------------------------------------------------- |
| **Descrição** | O sistema deve ter a função na qual o(s) funcionários(costureiras) confirmem a chegada da matéria prima e o pedido de produto para fabricação solicitado, que tem como base o US02 de Enviar Pedido de Confecção que o funcionário(proprietário) deve fornecer o'que for necessário para a confecção, e com esse caso de uso, elas poderão confirmar que receberam tudo necessário para o serviço e enviar notificação da estimativa de tempo em dias para a conclusão serviço para o funcionário(proprietário). |

| **Requisitos envolvidos** |                                                    |
| ------------- | :------------------------------------------------------------- |
| RF05          | Cadastro de Entradas/Saídas(Calcular valor da comissão) |

|                           |                                     |
| ------------------------- | ----------------------------------- | 
| **Prioridade**            | Essencial                           | 
| **Estimativa**            | 8 h                                 | 
| **Tempo Gasto (real):**   |                                     | 
| **Tamanho Funcional**     |                                     | 
| **Analista**              | Felipe (responsável por especificar/detalhar o US).| 
| **Desenvolvedor**         | Mateus (responsável por implementar e realizar testes de unidade e testes de integração).| 
| **Revisor**               | Danilo (responsável por avaliar a implementação e executar os testes de unidade e testes de integração).| 
| **Testador**              | Bruno (responsável por executar os Testes de Aceitação e fazer o relatório de testes).| 


| Testes de Aceitação (TA) |  |
| ----------- | --------- |
| **Código**      | **Descrição** |
| **TA04.01** | O usuário(costureira) seleciona um pedido recebido, insere dados de tempo(em dias) para concluir o pedido, ele clica em confirmar o recebimento do pedido: **MSG004**: O pedido foi recebido com sucesso. |
| **TA04.02** | Tentar aceitar o pedido sem data ou data inválida, exibir a mensagem de erro: **MSG004**: Necessário informar data válida. |
| **TA04.03** | O usuário clica em alterar a estimativa de tempo para a conclusão, insere o novo tempo e clica em alterar. |
| **TA04.04** | O usuário clica em alterar a estimativa de tempo para a conclusão, insere o novo tempo incorretamente e clica em alterar: **MSG004**: Necessário informar data válida |
| **TA04.05** | O usuário recusa o pedido de fabricação,insere o motivo e clicar em recusar. |
| **TA04.06** | O usuário recusa o pedido de fabricação, não insere o motivo e clica em recusar: **MSG004**: O campo inserir o motivo não foi preenchido. |


### User Story US05 - Gerar Relatório

|               |                                                                |
| ------------- | :------------------------------------------------------------- |
| **Descrição** | O sistema deve ser capaz de gerar  e apresentar relatórios detalhados sobre os produtos fabricados, bem como a quantidade de produtos fabricados, a quantidade de material gasto, data de fabricação (em determinada periodicidade) e preços individuais do produto fabricado (da matéria-prima também). |

| **Requisitos envolvidos** |                                                    |
| ------------- | :------------------------------------------------------------- |
| RF04, RF05, RF06          | Gerar Relatórios, Cadastro de Entradas/Saídas(Calcular valor da comissão), Criação de PDFs com base em relatórios |

|                           |                                     |
| ------------------------- | ----------------------------------- | 
| **Prioridade**            | Essencial                           | 
| **Estimativa**            | 8 h                                 | 
| **Tempo Gasto (real):**   |                                     | 
| **Tamanho Funcional**     |                                     | 
| **Analista**              | Claudio (responsável por especificar/detalhar o US).| 
| **Desenvolvedor**         | Danilo (responsável por implementar e realizar testes de unidade e testes de integração).| 
| **Revisor**               | Bruno (responsável por avaliar a implementação e executar os testes de unidade e testes de integração).| 
| **Testador**              | Felipe (responsável por executar os Testes de Aceitação e fazer o relatório de testes).| 


| Testes de Aceitação (TA) |  |
| ----------- | --------- |
| **Código**      | **Descrição** |
| **TA05.01** | O usuário seleciona gerar relatório, escolhe o período do relatório e confirma. O relatório será exibido em tela. |
| **TA05.02** | O usuário seleciona gerar relatório, escolhe um período em que há pedidos pendentes e confirma. Será exibida a mensagem: **MSG005**: Existem pedidos pendentes, deseja emitir relatório mesmo assim? Em caso positivo, será exibido o relatório em tela, no caso negativo será retornado a página anterior. |
| **TA05.03** | Tentar gerar o relatório sem haver nenhuma costureira cadastrada: **MSG005**: Sem costureiras cadastradas, não poderá gerar um relatório. |
| **TA05.04** | Tentar gerar o relatório sem haver nenhum pedido no período informado: **MSG005**: Sem pedidos cadastrados neste período, não poderá gerar um relatório. |


### User Story US06 - Emitir o pedido pronto

|               |                                                                |
| ------------- | :------------------------------------------------------------- |
| **Descrição** | O sistema deve ter a função na qual o(s) funcionários(costureiras) podem emitir ao funcionário(proprietário) os pedidos já finalizados e assim colocarem para pronta entrega, com essa função seria facilitado a notificação para que o produto não dependesse de disponibilidade de email para contato e sim do próprio sistema que vai fazer a notificação para o dono e assim manter um controle maior do que cada produto de cada costureira em específico fez e enviou. |

| **Requisitos envolvidos** |                                                    |
| ------------- | :------------------------------------------------------------- |
| RF05, RF07         | Cadastro de Entradas/Saídas(Calcular valor da comissão), Realização de Pagamento às Costureiras |

|                           |                                     |
| ------------------------- | ----------------------------------- | 
| **Prioridade**            | Essencial                           | 
| **Estimativa**            | 8 h                                 | 
| **Tempo Gasto (real):**   |                                     | 
| **Tamanho Funcional**     |                                     | 
| **Analista**              | Danilo (responsável por especificar/detalhar o US).| 
| **Desenvolvedor**         | Bruno (responsável por implementar e realizar testes de unidade e testes de integração).| 
| **Revisor**               | Felipe (responsável por avaliar a implementação e executar os testes de unidade e testes de integração).| 
| **Testador**              | Claudio (responsável por executar os Testes de Aceitação e fazer o relatório de testes).| 


| Testes de Aceitação (TA) |  |
| ----------- | --------- |
| **Código**      | **Descrição** |
| **TA06.01** | O usuário seleciona o pedido que está pronto. O usuário informa informações adicionais, caso necessário. O usuário clica em notificar a conclusão do pedido. Os dados do pedido são registrados no banco de dados e é gerado uma conta a pagar pelo pedido ao proprietário. |
| **TA06.02** | Tentar emitir o pedido pronto com erro, exibir a mensagem de erro: **MSG006**: O campo {nomecampo} foi preenchido incorretamente. |


### User Story US07 - Realizar pagamento

|               |                                                                |
| ------------- | :------------------------------------------------------------- |
| **Descrição** | O sistema deve dar a confirmação que o pagamento foi redirecionado para cada funcionário(costureira), pois ao calcular a receita de cada uma no relatório, o sistema irá criar a notificação do quanto que o funcionário(proprietário) deve por cada produto feito e entregue. |

| **Requisitos envolvidos** |                                                    |
| ------------- | :------------------------------------------------------------- |
| RF07         | Realização de Pagamento às Costureiras |

|                           |                                     |
| ------------------------- | ----------------------------------- | 
| **Prioridade**            | Essencial                           | 
| **Estimativa**            | 8 h                                 | 
| **Tempo Gasto (real):**   |                                     | 
| **Tamanho Funcional**     |                                     | 
| **Analista**              | Mateus (responsável por especificar/detalhar o US).| 
| **Desenvolvedor**         | Bruno (responsável por implementar e realizar testes de unidade e testes de integração).| 
| **Revisor**               | Claudio (responsável por avaliar a implementação e executar os testes de unidade e testes de integração).| 
| **Testador**              | Mateus (responsável por executar os Testes de Aceitação e fazer o relatório de testes).| 


| Testes de Aceitação (TA) |  |
| ----------- | --------- |
| **Código**      | **Descrição** |
| **TA07.01** | O usuário(gerente) seleciona o funcionário(costureira) com pagamentos pendentes, em seguida, seleciona a opção de pagar todas as contas a pendentes ou selecionar cada conta em específico. É exibido a preferência de pagamento da costureira e o pagamento é finalizado. É  enviado uma notificação para o funcionário(costureira) da realização do pagamento por parte do funcionário(gerente), ela confirma o recebimento do pagamento, a conta a pagar é dada como entregue. |
| **TA07.02** | Não tem conta para pagar, é exibido: MSG007: Não há conta a pagar |
| **TA07.03** | O funcionário(costureira) não confirma o pagamento e é notificado pelo sistema automaticamente, após 24 horas. |

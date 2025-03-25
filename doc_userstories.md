
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

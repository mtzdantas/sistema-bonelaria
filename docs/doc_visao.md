# Documento de Visão

Documento construído a partido do **Modelo BSI - Doc 001 - Documento de Visão** que pode ser encontrado no
link: https://docs.google.com/document/d/1DPBcyGHgflmz5RDsZQ2X8KVBPoEF5PdAz9BBNFyLa6A/edit?usp=sharing

## Descrição do Projeto

O propósito do Sistema da Bonelaria Militar será desenvolver um sistema de informação para uma confecção de artigos militares, no qual será possível cadastrar os produtos fabricados, cadastrar as costureiras, além de cadastrar as saídas/entradas, cada costureira cadastrada receberá notificações de quando determinada matéria prima sair da fábrica para a sua residência, onde será confeccionado o produto (bonés, chapéus, calções entre outros), e a mesma vai poder confirmar que o produto foi recebido. Em cada costureira registrada, terá o relatório da quantidade de produtos já feitos, juntamente com os preços individuais de cada, no qual no final vai poder ser contabilizado o quanto foi o lucro de cada costureira individualmente de acordo com os produtos fabricados, dessa forma, será possível calcular o salário de forma prática além de trazer informações úteis para análise de dados sobre a produção de cada uma.

## Equipe e Definição de Papéis

Membro     |     Papel   |   E-mail   |
---------  | ----------- | ---------- |
Bruno Costa                | Testador                | bruno.costa.099@ufrn.edu.br
Cláudio Pereira            | Analista                | claudio.pereira.710@ufrn.edu.br
Danilo Gabriel             | Desenvolvedor Back-End  | danilo.brito.715@ufrn.edu.br
Felipe Augusto             | Designer                | felipe.augusto.121@ufrn.edu.br
Mateus Dantas              | Desenvolvedor Front-End | mateus.dantas.125@.ufrn.edu.br
Joacir Dantas de Oliveira  | Cliente                 | bonelariamilitar@gmail.com

### Matriz de Competências

Membro     |     Competências   |
---------  | ----------- |
Cláudio    | Desenvolvedor Python, C, Flutter e Web; Experiência na área de Gestão de processos |
Bruno      | Gestão, Geográfa |
Felipe     | Desenvolvedor Python, C, Dart, Flutter, Web. Experiência em Modelagem de Processos. |
Danilo     | Desenvolvedor Python, C, Flutter, Web. |
Mateus     | Python para Análise de Dados, desenvolvimento em C, Flutter e Web, metodologias ágeis (Scrum). |

## Perfis dos Usuários

O sistema poderá ser utilizado por diversos usuários. Temos os seguintes perfis/atores:

Perfil                                 | Descrição   |
---------                              | ----------- |
Dono da empresa | Ator com acesso geral ao sistema, responsável por fornecer, usar e excluir informações. Além de responsável por dar as rédeas do projeto e requisitos de sistemas, além de prover apoio aos desenvolvedores com informações que podem ajudar a concluir o projeto, tendo acesso amplo do sistema, como, cadastrar proprietário, cadastrar costureiras, enviar pedidos de confecção, cadastrar produtos para serem feitos, gerar relatórios e realizar pagamentos às funcionárias.
Costureiras | Ator com acesso reduzido ao sistema, responsável por receber os pedidos de confecção (assim como a matéria-prima para confeccionar os produtos), confeccionar os produtos e cadastrar os dados dos produtos no sistema (tais como quantia, tamanho e modelo), além de enviar o produto final para o Dono da empresa.

## Requisitos Funcionais

### Entidade Costureira - RF01 - Manter Costureira  
Uma costureira tem: nome, endereço, número de celular e e-mail para contato.

| Requisito                     | Descrição                                                                 | Ator        |
|------------------------------|---------------------------------------------------------------------------|-------------|
| RF01.01 - Inserir Costureira  | Insere nova costureira informando: nome, endereço, número de celular e e-mail. | Funcionário |
| RF01.02 - Listar Costureiras  | Listagem de costureiras utilizando filtros nos atributos: nome, endereço, número de celular e e-mail. | Funcionário e Proprietário |
| RF01.03 - Atualizar Costureira| Atualiza uma costureira informando: nome, endereço, número de celular e e-mail. | Funcionário e Proprietário |
| RF01.04 - Deletar Costureira  | Deleta uma costureira informando o nome ou outro identificador.           | Funcionário e Proprietário |

---

### Entidade Proprietário - RF02 - Manter Proprietário  
O proprietário já possui um login pré-configurado no sistema e pode apenas alterar seus dados. Um proprietário tem: nome, endereço, número de celular e e-mail, e possui amplo acesso ao sistema.

| Requisito                        | Descrição                                                                   | Ator        |
|----------------------------------|-----------------------------------------------------------------------------|-------------|
| RF02.01 - Visualizar Dados       | Permite ao proprietário visualizar seus próprios dados.                     | Proprietário |
| RF02.02 - Atualizar Dados        | Permite ao proprietário atualizar seus dados: nome, endereço, número de celular e e-mail. | Proprietário |

---

### Entidade Produto - RF03 - Manter Produto  
Um produto tem: nome, material, metragem do material, data de fabricação e data de retirada.

| Requisito                     | Descrição                                                                                                   | Ator        |
|------------------------------|-------------------------------------------------------------------------------------------------------------|-------------|
| RF03.01 - Inserir Produto     | Insere novo produto informando: nome, material, metragem de material utilizado e data de fabricação.       | Proprietário |
| RF03.02 - Listar Produtos     | Listagem de produtos utilizando filtros nos atributos: nome, material, metragem de material, data de fabricação e data de retirada. | Proprietário |
| RF03.03 - Atualizar Produto   | Atualiza um produto informando: nome, material, metragem, data de fabricação e data de retirada.           | Proprietário |
| RF03.04 - Deletar Produto     | Deleta um produto informando o nome ou outro identificador.                                                | Proprietário |

---

### Entidade Relatório - RF04 - Gerar Relatórios

| Requisito                     | Descrição                                                                                                      | Ator        |
|------------------------------|----------------------------------------------------------------------------------------------------------------|-------------|
| RF04.01 - Gerar Relatórios    | Gera relatórios detalhados com base nos produtos fabricados, informando quantidade produzida, material gasto, data de fabricação e preços. | Funcionário e Proprietário |

---

### Entidade Entrada/Saída - RF05 - Gerenciar Entradas e Saídas  

| Requisito                     | Descrição                                                                                                  | Ator        |
|------------------------------|------------------------------------------------------------------------------------------------------------|-------------|
| RF05.01 - Registrar Entrada/Saída | Registra entrada de materiais e saída de produtos, possibilitando o cálculo automático da comissão das costureiras com base na produção. | Proprietário |

---

### Entidade PDF - RF06 - Gerar Relatórios em PDF  

| Requisito                     | Descrição                                                                                                          | Ator        |
|------------------------------|--------------------------------------------------------------------------------------------------------------------|-------------|
| RF06.01 - Gerar PDF           | Gera arquivos PDF com base nos relatórios do sistema, possibilitando o acesso às informações fora do sistema.     | Funcionário e Proprietário |

---

### Entidade Pagamento - RF07 - Realizar Pagamento às Costureiras  

| Requisito                     | Descrição                                                                                                                                   | Ator        |
|------------------------------|---------------------------------------------------------------------------------------------------------------------------------------------|-------------|
| RF07.01 - Realizar Pagamento  | Realiza pagamento às costureiras com base nas comissões calculadas, permitindo escolha de método de recebimento e confirmação no sistema. | Proprietário |

---

## Lista de Requisitos Não-Funcionais

Requisito                                 | Descrição   |
---------                                 | ----------- |
RNF001 - Interface Acessível para Idosos | O sistema deve possuir um design de interface que facilite o uso para principalmente pessoas idosas de acordo com estudos já feitos sobre essa área e também demonstrar protótipos de como ficaria até a aprovação do cliente, alterando coisas como tamanho de fonte, contraste, simplicidade de navegação, entre outros. |
RNF002 - Ter conexão com Internet | O sistema deve ser capaz de se conectar à internet para se ter a troca de informações entre os usuários, já que o projeto visa facilitar a comunicação entre setores via web, isso inclui suporte para diferentes tipos de conexões, como Wi-Fi e dados móveis. |
RNF003 - Necessidade de Aparelho móvel de sistema operacional Android | O sistema deve ser compatível prioritariamente ao S.O (Sistema Operacional) Android, já que é um sistema mais leve e de fácil obtenção, visando a maior facilidade em conclusão do projeto o necessário é que seja implementado em celulares Android. Além disso, o sistema deve ser otimizado para funcionar de forma eficiente em diferentes versões do Android, garantindo uma experiência consistente para todos os usuários |

## Riscos

Tabela com o mapeamento dos riscos do projeto, as possíveis soluções e os responsáveis.

Data | Risco | Prioridade | Responsável | Status | Providência/Solução |
------ | ------ | ------ | ------ | ------ | ------ |
04/12/2024 | Não aprendizado das ferramentas utilizadas pelos componentes do grupo | Alta | Gerente | Vigente | Reforçar estudos sobre as ferramentas e aulas com a integrante que conhece a ferramenta |
04/12/2024 | Possível falta de comunicação clara entre os colaboradores com o cliente do projeto | Média | Gerente | Vigente | Reforçar um canal claro de comunicação, como whatsapp ou outra rede social com horas marcadas para possíveis reuniões. |

### Referências

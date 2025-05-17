# Descrição das Funções

### Descrição da função de retornar todos os produtos com seus insumos

- Nome: get_produtos_com_insumos

- Retorno: Uma tabela com as colunas:

- id_produto: ID do produto

- produto_nome: nome do produto

- categoria: categoria do produto

- id_insumo: ID do insumo relacionado

- insumo_nome: nome do insumo

- tipo_de_insumo: tipo do insumo (ex: líquido, sólido, etc.)

- quantia_insumo: quantidade do insumo usada no produto

Objetivo: Esta função retorna todos os produtos com os insumos que fazem parte da composição de cada um, incluindo a quantidade usada de cada insumo. Ideal para exibição em relatórios, telas de visualização ou geração de documentos.

[SQL da get_produtos_com_insumos](./exibirProdutos.sql)

### Descrição da função de adicionar um produto com um insumo
- Nome: adicionar_produto_com_insumo

- Parâmetros de entrada:

- nome_produto (TEXT): nome do produto a ser cadastrado

- categoria (TEXT): categoria do produto

- descricao (TEXT): descrição detalhada do produto

- quantidade_estoque (INTEGER): quantidade inicial do produto em estoque

- id_insumo (INTEGER): ID do insumo relacionado ao produto

- quantia_insumo (NUMERIC): quantidade do insumo usada na composição do produto

- Retorno: VOID (sem retorno)

Objetivo
Esta função cadastra um novo produto na tabela produto com os dados fornecidos e vincula um insumo existente a esse produto na tabela produto_insumo, registrando também a quantidade do insumo necessária. É útil para operações rápidas de inserção em sistemas administrativos ou APIs de backend que exigem o vínculo entre um produto e um único insumo no momento do cadastro.

[SQL da adicionar_produto_com_insumo](./adicionarProdutos.sql)


# Descrição dos Procedimentos

### Descrição do procedimento para editar um produto
Nome: editar_produto_proc

Parâmetros de entrada:

p_id_produto (INTEGER): Identificador do produto que será atualizado.

p_nome (TEXT): Novo nome para o produto.

p_categoria (TEXT): Nova categoria do produto.

p_descricao (TEXT): Nova descrição do produto.

p_quantidade_estoque (INTEGER): Novo valor para a quantidade em estoque do produto.

Retorno: Nenhum (procedimento do tipo VOID).

Objetivo
Este procedimento atualiza os dados de um produto existente na tabela produto com base no seu identificador (id_produto). Ele permite alterar o nome, a categoria, a descrição e a quantidade em estoque do produto. É útil para operações de manutenção de cadastro, garantindo que as informações estejam sempre atualizadas.

### Descrição do procedimento para editar um insumo
Nome: editar_insumo_proc

Parâmetros de entrada:

p_id_insumo (INTEGER): Identificador do insumo que será atualizado.

p_nome (VARCHAR): Novo nome do insumo.

p_quantidade_estoque (INTEGER): Nova quantidade em estoque do insumo.

p_tipo_de_insumo (VARCHAR): Novo tipo do insumo (ex: líquido, sólido, etc.).

Retorno: Nenhum (procedimento do tipo VOID).

Objetivo
Este procedimento atualiza as informações de um insumo existente na tabela insumos, identificando-o pelo seu id_insumo. Permite alterar o nome, a quantidade em estoque e o tipo do insumo. É útil para manter os dados do cadastro de insumos atualizados conforme mudanças no estoque ou classificação.
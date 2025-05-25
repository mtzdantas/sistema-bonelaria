class Produto {
  final int idProduto;
  final String nome;
  final String categoria;
  final String descricao;
  final int quantidadeEstoque;

  Produto({
    required this.idProduto,
    required this.nome,
    required this.categoria,
    required this.descricao,
    required this.quantidadeEstoque,
  });

  factory Produto.fromMap(Map<String, dynamic> map) {
    return Produto(
      idProduto: map['id_produto'] ?? 0,
      nome: map['nome'] ?? '',
      categoria: map['categoria'] ?? '',
      descricao: map['descricao'] ?? '',
      quantidadeEstoque: map['quantidade_estoque'] ?? 0,
    );
  }
}

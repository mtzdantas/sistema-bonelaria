class ProdutoPedido {
  final String nomeProduto;
  final int quantidade;
  final double valor;

  ProdutoPedido({
    required this.nomeProduto,
    required this.quantidade,
    required this.valor,
  });

  factory ProdutoPedido.fromMap(Map<String, dynamic> map) {
    return ProdutoPedido(
      nomeProduto: map['produto']['nome'],
      quantidade: map['quantidade_produto'],
      valor: (map['valor_produto'] as num).toDouble(),
    );
  }
}

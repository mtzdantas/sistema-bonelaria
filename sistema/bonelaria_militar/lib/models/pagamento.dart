class Pagamento {
  final int idPagamento;
  final int idContaAPagar;
  final double valorPagamento;
  final String formaPagamento;
  final String? nomeCostureira; // <-- NOVO CAMPO OPCIONAL

  Pagamento({
    required this.idPagamento,
    required this.idContaAPagar,
    required this.valorPagamento,
    required this.formaPagamento,
    this.nomeCostureira,
  });

  factory Pagamento.fromMap(Map<String, dynamic> map) {
    return Pagamento(
      idPagamento: map['id_pagamento'],
      idContaAPagar: map['id_conta_a_pagar'],
      valorPagamento: (map['valor_pagamento'] as num).toDouble(),
      formaPagamento: map['forma_pagamento'],
      nomeCostureira: map['conta_a_pagar']?['funcionario']?['nome'], // <- aqui pega o nome
    );
  }
}

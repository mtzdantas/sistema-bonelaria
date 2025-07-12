class ContaAPagar {
  final int idContaAPagar;
  final double valor;
  final DateTime dataVencimento;
  final String statusPagamento;

  ContaAPagar({
    required this.idContaAPagar,
    required this.valor,
    required this.dataVencimento,
    required this.statusPagamento,
  });

  factory ContaAPagar.fromMap(Map<String, dynamic> map) {
    return ContaAPagar(
      idContaAPagar: map['id_conta_a_pagar'],
      valor: (map['valor'] as num).toDouble(),
      dataVencimento: DateTime.parse(map['data_vencimento']),
      statusPagamento: map['status_pagamento'].toString().trim(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id_conta_a_pagar': idContaAPagar,
      'valor': valor,
      'data_vencimento': dataVencimento.toIso8601String(),
      'status_pagamento': statusPagamento,
    };
  }
}

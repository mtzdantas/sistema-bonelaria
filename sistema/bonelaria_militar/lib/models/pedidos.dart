class Pedido {
  final int id;
  final String costureiraNome;
  final String status;
  final DateTime data;
  final int? idContaAPagar;
  final int idFuncionario; // será id_costureira do banco

  Pedido({
    required this.id,
    required this.costureiraNome,
    required this.status,
    required this.data,
    this.idContaAPagar,
    required this.idFuncionario,
  });

  factory Pedido.fromMap(Map<String, dynamic> map) {
    return Pedido(
      id: map['id_pedido'],
      costureiraNome: map['funcionario']['nome'], // nome via relacionamento
      status: map['status_pedido'],
      data: DateTime.parse(map['data']),
      idContaAPagar: map['id_conta_a_pagar'],
      idFuncionario: map['id_costureira'], // pega direto do map
    );
  }
}

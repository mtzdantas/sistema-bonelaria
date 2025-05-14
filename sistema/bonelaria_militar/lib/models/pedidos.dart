class Pedido {
  final int id;
  final String costureiraNome;
  final String status;
  final DateTime data;

  Pedido({
    required this.id,
    required this.costureiraNome,
    required this.status,
    required this.data,
  });

  factory Pedido.fromMap(Map<String, dynamic> map) {
    return Pedido(
      id: map['id_pedido'],
      costureiraNome: map['funcionario']['nome'],
      status: map['status_pedido'],
      data: DateTime.parse(map['data']),
    );
  }
}

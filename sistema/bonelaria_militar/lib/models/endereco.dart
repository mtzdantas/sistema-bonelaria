class Endereco {
  final int idEndereco;
  final String rua;
  final int numero;
  final String bairro;
  final String complemento;

  Endereco({
    required this.idEndereco,
    required this.rua,
    required this.numero,
    required this.bairro,
    required this.complemento,
  });

  factory Endereco.fromMap(Map<String, dynamic> map) {
    return Endereco(
      idEndereco: map['id_endereco'],
      rua: map['rua'] ?? '',
      numero: map['numero'] ?? '',
      bairro: map['bairro'] ?? '',
      complemento: map['complemento'] ?? '',
    );
  }
}

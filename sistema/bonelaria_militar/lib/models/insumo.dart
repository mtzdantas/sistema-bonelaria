class Insumo {
  final int idInsumo;
  final String nome;
  final int quantidadeEstoque;
  final String tipoDeInsumo;

  Insumo({
    required this.idInsumo,
    required this.nome,
    required this.quantidadeEstoque,
    required this.tipoDeInsumo,
  });

  factory Insumo.fromMap(Map<String, dynamic> map) {
    return Insumo(
      idInsumo: map['id_insumo'],
      nome: map['nome'],
      quantidadeEstoque: map['quantidade_estoque'],
      tipoDeInsumo: map['tipo_de_insumo'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id_insumo': idInsumo,
      'nome': nome,
      'quantidade_estoque': quantidadeEstoque,
      'tipo_de_insumo': tipoDeInsumo,
    };
  }
}

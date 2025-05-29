import 'package:bonelaria_militar/models/insumo.dart';
import 'package:bonelaria_militar/models/produto.dart';

class ProdutoInsumo {
  final int idProdutoInsumo;
  final int idProduto;
  final int idInsumo;
  final int quantiaInsumo;
  final Produto? produto;
  final Insumo? insumo;

  ProdutoInsumo({
    required this.idProdutoInsumo,
    required this.idProduto,
    required this.idInsumo,
    required this.quantiaInsumo,
    this.produto,
    this.insumo,
  });

  factory ProdutoInsumo.fromMapWithRelations(Map<String, dynamic> map) {
    return ProdutoInsumo(
      idProdutoInsumo: map['id_produto_insumo'],
      idProduto: map['id_produto'],
      idInsumo: map['id_insumo'],
      quantiaInsumo: map['quantia_insumo'],
      produto: map['produto'] != null ? Produto.fromMap(map['produto']) : null,
      insumo: map['insumo'] != null ? Insumo.fromMap(map['insumo']) : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id_produto_insumo': idProdutoInsumo,
      'id_produto': idProduto,
      'id_insumo': idInsumo,
      'quantia_insumo': quantiaInsumo,
    };
  }
}

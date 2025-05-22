import 'package:flutter_test/flutter_test.dart';
import 'package:faker/faker.dart';
import 'package:bonelaria_militar/models/produto_insumo.dart';
/*import 'package:bonelaria_militar/models/produto.dart';
import 'package:bonelaria_militar/models/insumo.dart';
*/
void main() {
  final faker = Faker();

  group('ProdutoInsumo', () {
    test('fromMapWithRelations cria instância corretamente com relações', () {
      final produtoMap = {
        'id_produto': faker.randomGenerator.integer(1000),
        'nome': faker.lorem.word(),
        'descricao': faker.lorem.sentence(),
        'preco': faker.randomGenerator.decimal(scale: 100).toDouble(), // garantir que é double
      };

      final insumoMap = {
        'id_insumo': faker.randomGenerator.integer(1000),
        'nome': faker.lorem.word(),
        'quantidade_estoque': faker.randomGenerator.integer(100),
        'tipo_de_insumo': faker.lorem.word(),
      };

      final map = {
        'id_produto_insumo': faker.randomGenerator.integer(1000),
        'id_produto': produtoMap['id_produto'],
        'id_insumo': insumoMap['id_insumo'],
        'quantia_insumo': faker.randomGenerator.integer(50),
        'produto': produtoMap,
        'insumo': insumoMap,
      };

      final produtoInsumo = ProdutoInsumo.fromMapWithRelations(map);

      expect(produtoInsumo.idProdutoInsumo, map['id_produto_insumo']);
      expect(produtoInsumo.idProduto, map['id_produto']);
      expect(produtoInsumo.idInsumo, map['id_insumo']);
      expect(produtoInsumo.quantiaInsumo, map['quantia_insumo']);
      expect(produtoInsumo.produto?.idProduto, produtoMap['id_produto']);
      expect(produtoInsumo.insumo?.idInsumo, insumoMap['id_insumo']);
    });

    test('fromMapWithRelations funciona corretamente sem relações', () {
      final map = {
        'id_produto_insumo': faker.randomGenerator.integer(1000),
        'id_produto': faker.randomGenerator.integer(1000),
        'id_insumo': faker.randomGenerator.integer(1000),
        'quantia_insumo': faker.randomGenerator.integer(50),
        'produto': null,
        'insumo': null,
      };

      final produtoInsumo = ProdutoInsumo.fromMapWithRelations(map);

      expect(produtoInsumo.idProdutoInsumo, map['id_produto_insumo']);
      expect(produtoInsumo.idProduto, map['id_produto']);
      expect(produtoInsumo.idInsumo, map['id_insumo']);
      expect(produtoInsumo.quantiaInsumo, map['quantia_insumo']);
      expect(produtoInsumo.produto, isNull);
      expect(produtoInsumo.insumo, isNull);
    });
  });
}

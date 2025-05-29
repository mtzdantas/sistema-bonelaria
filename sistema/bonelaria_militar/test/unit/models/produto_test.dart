import 'package:bonelaria_militar/models/produto.dart';
import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final faker = Faker();

  group('Produto', () {
    test('fromMap cria instância corretamente', () {
      final map = {
        'id_produto': faker.randomGenerator.integer(1000),
        'nome': faker.lorem.word(),
        'categoria': faker.lorem.word(),
        'descricao': faker.lorem.sentence(),
        'quantidade_estoque': faker.randomGenerator.integer(500),
      };

      final produto = Produto.fromMap(map);

      expect(produto.idProduto, map['id_produto']);
      expect(produto.nome, map['nome']);
      expect(produto.categoria, map['categoria']);
      expect(produto.descricao, map['descricao']);
      expect(produto.quantidadeEstoque, map['quantidade_estoque']);
    });
  });
}

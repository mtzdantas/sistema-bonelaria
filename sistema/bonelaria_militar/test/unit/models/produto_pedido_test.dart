import 'package:flutter_test/flutter_test.dart';
import 'package:faker/faker.dart';
import 'package:bonelaria_militar/models/produto_pedido.dart';

void main() {
  final faker = Faker();

  group('ProdutoPedido', () {
    test('fromMap cria instância corretamente', () {
      final produtoMap = {
        'nome': faker.lorem.word(),
      };

      final map = {
        'produto': produtoMap,
        'quantidade_produto': faker.randomGenerator.integer(100),
        'valor_produto': faker.randomGenerator.decimal(min: 10, scale: 100),
      };

      final produtoPedido = ProdutoPedido.fromMap(map);

      expect(produtoPedido.nomeProduto, produtoMap['nome']);
      expect(produtoPedido.quantidade, map['quantidade_produto'] ?? 0);
      expect(produtoPedido.valor, (map['valor_produto'] as num?)?.toDouble() ?? 0.0);
    });
  });
}

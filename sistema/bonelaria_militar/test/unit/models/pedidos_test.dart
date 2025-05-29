import 'package:bonelaria_militar/models/pedidos.dart';
import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final faker = Faker();

  test('Pedido.fromMap cria um objeto Pedido corretamente', () {
    final dataNow = faker.date.dateTime();

    final map = {
      'id_pedido': faker.randomGenerator.integer(1000),
      'funcionario': {
        'nome': faker.person.name(),
      },
      'status_pedido': faker.lorem.word(),
      'data': dataNow.toIso8601String(),
    };

    final pedido = Pedido.fromMap(map);

    expect(pedido.id, map['id_pedido']);

    expect(map['funcionario'], isNotNull);
    final funcionario = map['funcionario']! as Map<String, dynamic>;

    expect(pedido.costureiraNome, funcionario['nome']);
    expect(pedido.status, map['status_pedido']);
    expect(pedido.data, dataNow);
  });
}

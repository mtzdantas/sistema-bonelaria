import 'package:flutter_test/flutter_test.dart';
import 'package:faker/faker.dart';
import 'package:bonelaria_militar/models/insumo.dart';

void main() {
  final faker = Faker();

  group('Insumo', () {
    test('fromMap cria um objeto Insumo corretamente', () {
      final map = {
        'id_insumo': faker.randomGenerator.integer(1000),
        'nome': faker.food.cuisine(), // nome de comida serve como exemplo
        'quantidade_estoque': faker.randomGenerator.integer(500),
        'tipo_de_insumo': faker.food.dish(), // tipo pode ser prato ou outro texto
      };

      final insumo = Insumo.fromMap(map);

      expect(insumo.idInsumo, map['id_insumo']);
      expect(insumo.nome, map['nome']);
      expect(insumo.quantidadeEstoque, map['quantidade_estoque']);
      expect(insumo.tipoDeInsumo, map['tipo_de_insumo']);
    });

    test('toMap retorna um Map correspondente ao objeto', () {
      final insumo = Insumo(
        idInsumo: faker.randomGenerator.integer(1000),
        nome: faker.food.cuisine(),
        quantidadeEstoque: faker.randomGenerator.integer(500),
        tipoDeInsumo: faker.food.dish(),
      );

      final map = insumo.toMap();

      expect(map['id_insumo'], insumo.idInsumo);
      expect(map['nome'], insumo.nome);
      expect(map['quantidade_estoque'], insumo.quantidadeEstoque);
      expect(map['tipo_de_insumo'], insumo.tipoDeInsumo);
    });
  });
}

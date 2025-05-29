import 'package:bonelaria_militar/models/endereco.dart';
import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final faker = Faker();

  group('Endereco.fromMap', () {
    test('Deve criar Endereco corretamente com todos os campos', () {
      final map = {
        'id_endereco': faker.randomGenerator.integer(1000),
        'rua': faker.address.streetName(),
        'numero': faker.randomGenerator.integer(1000),
        'bairro': faker.address.city(),
        'complemento': faker.lorem.word(),
      };

      final endereco = Endereco.fromMap(map);

      expect(endereco.idEndereco, map['id_endereco']);
      expect(endereco.rua, map['rua']);
      expect(endereco.numero, map['numero']);
      expect(endereco.bairro, map['bairro']);
      expect(endereco.complemento, map['complemento']);
    });

    test('Deve atribuir valores padrão para campos ausentes', () {
      final map = {
        'id_endereco': faker.randomGenerator.integer(1000),
        // rua ausente
        'numero': 0,
        // bairro ausente
        // complemento ausente
      };

      final endereco = Endereco.fromMap(map);

      expect(endereco.idEndereco, map['id_endereco']);
      expect(endereco.rua, '');         // valor padrão
      expect(endereco.numero, 0);
      expect(endereco.bairro, '');      // valor padrão
      expect(endereco.complemento, ''); // valor padrão
    });
  });
}

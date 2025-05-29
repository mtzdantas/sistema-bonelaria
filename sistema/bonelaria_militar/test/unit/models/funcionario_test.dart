//import 'package:bonelaria_militar/models/endereco.dart';
import 'package:bonelaria_militar/models/funcionario.dart';
import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final faker = Faker();

  group('Funcionario.fromMapWithEndereco', () {
    test('deve criar um Funcionario a partir de um Map com endereco', () {
      // Dados fake para Endereco
      final fakeEndereco = {
        'id_endereco': faker.randomGenerator.integer(100),
        'rua': faker.address.streetName(),
        'numero': faker.randomGenerator.integer(999),
        'bairro': faker.address.neighborhood(),
        'complemento': faker.lorem.word(),
      };

      // Dados fake para Funcionario
      final funcionarioMap = {
        'id_funcionario': faker.randomGenerator.integer(1000),
        'nome': faker.person.name(),
        'id_endereco': fakeEndereco['id_endereco'],
        'cpf': faker.randomGenerator.numbers(9, 11).join(),
        'telefone': faker.phoneNumber.us(),
        'email': faker.internet.email(),
        'piso_salarial': faker.randomGenerator.decimal(min: 1200, scale: 2),
        'salario': faker.randomGenerator.decimal(min: 1300, scale: 2),
        'id_funcao': faker.randomGenerator.integer(10),
        'endereco': fakeEndereco,
      };

      final funcionario = Funcionario.fromMapWithEndereco(funcionarioMap);

      expect(funcionario.idFuncionario, funcionarioMap['id_funcionario']);
      expect(funcionario.nome, funcionarioMap['nome']);
      expect(funcionario.idEndereco, funcionarioMap['id_endereco']);
      expect(funcionario.cpf, funcionarioMap['cpf']);
      expect(funcionario.telefone, funcionarioMap['telefone']);
      expect(funcionario.email, funcionarioMap['email']);
      expect(funcionario.pisoSalarial, funcionarioMap['piso_salarial']);
      expect(funcionario.salario, funcionarioMap['salario']);
      expect(funcionario.idFuncao, funcionarioMap['id_funcao']);

      expect(funcionario.endereco, isNotNull);
      expect(funcionario.endereco!.rua, fakeEndereco['rua']);
      expect(funcionario.endereco!.numero, fakeEndereco['numero']);
      expect(funcionario.endereco!.bairro, fakeEndereco['bairro']);
      expect(funcionario.endereco!.complemento, fakeEndereco['complemento']);
    });
  });
}

import 'endereco.dart';

class Funcionario {
  final int idFuncionario;
  final String nome;
  final int idEndereco;
  final String cpf;
  final String telefone;
  final String email;
  final double pisoSalarial;
  final double salario;
  final int idFuncao;
  final Endereco? endereco;

  Funcionario({
    required this.idFuncionario,
    required this.nome,
    required this.idEndereco,
    required this.cpf,
    required this.telefone,
    required this.email,
    required this.pisoSalarial,
    required this.salario,
    required this.idFuncao,
    this.endereco,
  });

  factory Funcionario.fromMapWithEndereco(Map<String, dynamic> map) {
    return Funcionario(
      idFuncionario: map['id_funcionario'],
      nome: map['nome'],
      idEndereco: map['id_endereco'],
      cpf: map['cpf'],
      telefone: map['telefone'],
      email: map['email'],
      pisoSalarial: (map['piso_salarial'] as num).toDouble(),
      salario: (map['salario'] as num).toDouble(),
      idFuncao: map['id_funcao'],
      endereco: map['endereco'] != null
          ? Endereco.fromMap(map['endereco'])
          : null,
    );
  }
}

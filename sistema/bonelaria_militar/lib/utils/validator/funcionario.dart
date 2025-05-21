import 'package:lucid_validation/lucid_validation.dart';
import 'models/validator_funcionario.dart';

class FuncionarioValidator extends LucidValidator<ModelValidatorFunc> {
  FuncionarioValidator() {
    ruleFor((f) => f.nome, key: 'nome')
      .notEmpty(message: 'Nome é obrigatório')
      .minLength(3, message: 'Nome deve ter no mínimo 3 letras');

    ruleFor((f) => f.cpf, key: 'cpf')
      .notEmpty(message: 'CPF é obrigatório')
      .validCPFOrCNPJ(message: 'CPF inválido');

    ruleFor((f) => f.telefone, key: 'telefone')
      .notEmpty(message: 'Telefone é obrigatório')
      .validPhoneBR(message: 'Telefone inválido');

    ruleFor((f) => f.email, key: 'email')
      .notEmpty(message: 'Email é obrigatório')
      .validEmail(message: 'Email inválido');

    // ruleFor((f) => f.endereco, key: 'endereco')
    //   .notNull(message: 'Endereço é obrigatório')
    //   .setValidator(EnderecoValidator());
  }
}
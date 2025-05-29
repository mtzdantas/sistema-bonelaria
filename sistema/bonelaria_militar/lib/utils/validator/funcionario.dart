import 'package:bonelaria_militar/utils/validator/models/validator_funcionario.dart';
import 'package:lucid_validation/lucid_validation.dart';

class FuncionarioValidator extends LucidValidator<ModelValidatorFunc> {
  FuncionarioValidator() {
    ruleFor((f) => f.nome, key: 'nome')
      .notEmpty(message: 'Nome é obrigatório')
      .minLength(3, message: 'Nome deve ter no mínimo 3 letras');

    ruleFor((f) => f.cpf, key: 'cpf')
      .notEmpty(message: 'CPF é obrigatório')
      .validCPFOrCNPJ(message: 'CPF ou CNPJ inválido')
      .matchesPattern(r'^[0-9]+$', message: 'CPF deve conter apenas números');

    ruleFor((f) => f.telefone, key: 'telefone')
      .notEmpty(message: 'Telefone é obrigatório')
      .validPhoneBR(message: 'Telefone inválido');

    ruleFor((f) => f.email, key: 'email')
      .notEmpty(message: 'Email é obrigatório')
      .validEmail(message: 'Email inválido');

    ruleFor((f) => f.senha, key: 'senha')
      .notEmpty(message: 'Senha é obrigatória')
      .minLength(6, message: 'Senha deve ter no mínimo 6 caracteres')
      .maxLength(12, message: 'Senha deve ter no máximo 12 caracteres')
      .mustHaveNumber(message: 'Senha deve conter pelo menos um número');

    ruleFor((f) => f.rua, key: 'rua')
      .notEmpty(message: 'Rua é obrigatório')
      .minLength(5, message: 'Rua deve ter no mínimo 5 letras')
      .maxLength(50, message: 'Rua deve ter no máximo 50 letras');

    ruleFor((f) => f.numero, key: 'numero')
      .notEmpty(message: 'Número é obrigatório')
      .maxLength(10, message: 'Número deve ter no máximo 10 caracteres')
      .mustHaveNumber(message: 'Número deve conter pelo menos um número');
    
    ruleFor((f) => f.bairro, key: 'bairro')
      .notEmpty(message: 'Bairro é obrigatório')
      .minLength(3, message: 'Bairro deve ter no mínimo 3 letras')
      .maxLength(50, message: 'Bairro deve ter no máximo 30 letras')
      .matchesPattern(r'[a-zA-Z]', message: 'O campo deve conter pelo menos uma letra');


    ruleFor((f) => f.complemento, key: 'complemento')
      .maxLength(50, message: 'Complemento deve ter no máximo 50 letras');
  }
}
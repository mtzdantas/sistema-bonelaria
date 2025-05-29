import 'package:bonelaria_militar/auth/data/auth_service.dart';
import 'package:bonelaria_militar/services/endereco_service.dart';
import 'package:bonelaria_militar/services/funcionario_service.dart';
import 'package:flutter/material.dart';

/// Controller responsável por gerenciar o estado e lógica do formulário de cadastro.
class CadastroController {
  /// Controlador do campo de nome.
  final TextEditingController nomeController = TextEditingController();
  /// Controlador do campo de cpf.
  final TextEditingController cpfController = TextEditingController();
  /// Controlador do campo de telefone.
  final TextEditingController telefoneController = TextEditingController();
  /// Controlador do campo de e-mail.
  final TextEditingController emailController = TextEditingController();
  /// Controlador do campo de senha.
  final TextEditingController senhaController = TextEditingController();
  /// Controlador do campo de rua.
  final TextEditingController ruaController = TextEditingController();
  /// Controlador do campo de bairro.
  final TextEditingController bairroController = TextEditingController();
  /// Controlador do campo de numero.
  final TextEditingController numeroController = TextEditingController();
  /// Controlador do campo de complemento.
  final TextEditingController complementoController = TextEditingController();

  void dispose() {
    nomeController.dispose();
    cpfController.dispose();
    telefoneController.dispose();
    emailController.dispose();
    senhaController.dispose();
    ruaController.dispose();
    bairroController.dispose();
    numeroController.dispose();
    complementoController.dispose();
  }

  Future<bool> cadastrarFuncionario() async {
    try {
      final userId = await AuthService.cadastrarUsuario(
        email: emailController.text.trim(),
        senha: senhaController.text.trim(),
      );

      if (userId == null) {
        return false;
      }

      final idEndereco = await EnderecoService.inserirEndereco(
        rua: ruaController.text.trim(),
        bairro: bairroController.text.trim(),
        numero: numeroController.text.trim(),
        complemento: complementoController.text.trim(),
      );

      await FuncionarioService.inserirFuncionario(
        nome: nomeController.text.trim(),
        cpf: cpfController.text.trim(),
        telefone: telefoneController.text.trim(),
        email: emailController.text.trim(),
        idEndereco: idEndereco,
        authUserId: userId,
      );

      return true;
    } on Exception catch (e) {
      debugPrint('Erro ao cadastrar funcionário: $e');
      return false;
    }
  }
}

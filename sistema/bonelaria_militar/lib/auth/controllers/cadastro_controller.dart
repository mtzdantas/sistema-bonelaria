import 'package:flutter/material.dart';
import '../../services/funcionario_service.dart';
import '../../services/endereco_service.dart';
import '../data/auth_service.dart';

class CadastroController {
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController cpfController = TextEditingController();
  final TextEditingController telefoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();
  final TextEditingController ruaController = TextEditingController();
  final TextEditingController bairroController = TextEditingController();
  final TextEditingController numeroController = TextEditingController();
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
      final String? userId = await AuthService.cadastrarUsuario(
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
    } catch (e) {
      print('Erro ao cadastrar funcionário: $e');
      return false;
    }
  }
}
import 'package:flutter/material.dart';
import '../../services/funcionario_service.dart';
import '../../services/endereco_service.dart';
import '../data/auth_service.dart';

class CadastroController {
  final nomeController = TextEditingController();
  final cpfController = TextEditingController();
  final telefoneController = TextEditingController();
  final emailController = TextEditingController();
  final senhaController = TextEditingController();

  final ruaController = TextEditingController();
  final bairroController = TextEditingController();
  final numeroController = TextEditingController();
  final complementoController = TextEditingController();

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

  Future<bool> cadastrarFuncionario(BuildContext context) async {
    try {
      final userId = await AuthService.cadastrarUsuario(
        email: emailController.text.trim(),
        senha: senhaController.text.trim(),
      );

      if (userId == null) {
        throw Exception('Falha ao obter userId após cadastro');
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

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Cadastro realizado com sucesso!')),
        );
        Navigator.pop(context);
      }

      return true;
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao cadastrar: ${e.toString()}')),
        );
      }
    }
    return false;
  }
}

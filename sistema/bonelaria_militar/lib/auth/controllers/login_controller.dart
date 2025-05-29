import 'package:bonelaria_militar/auth/data/auth_service.dart';
import 'package:bonelaria_militar/navigation/main_nav.dart';
import 'package:flutter/material.dart';

class LoginController {
  final emailController = TextEditingController();
  final senhaController = TextEditingController();
  final AuthService _authService = AuthService();

  Future<void> login(BuildContext context) async {
    try {
      final response = await _authService.login(
        emailController.text,
        senhaController.text,
      );

      if (response.user != null && context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Login realizado com sucesso')),
        );

        await Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (final BuildContext context) => const MainNavigation(),
        ),
      );

      } else {
        throw Exception("Usuário nulo");
      }

    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Usuário ou senha inválidos')),
        );
      }
    }
  }
}

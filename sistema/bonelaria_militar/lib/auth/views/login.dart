import 'package:flutter/material.dart';
import '../controllers/login_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final controller = LoginController();
  bool _loading = false;

  Future<void> _signIn() async {
    setState(() => _loading = true);

    await controller.login(context);

    setState(() => _loading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: controller.emailController,
              decoration: InputDecoration(
                labelText: 'E-mail',
              ),
            ),
            TextField(
              controller: controller.senhaController,
              decoration: InputDecoration(
                labelText: 'Senha',
              ),
            ),
            SizedBox(height: 20),
            _loading
                ? CircularProgressIndicator(color: Colors.brown)
                : ElevatedButton(
                    onPressed: _signIn,
                    child: Text('Entrar'),
                  ),
          ],
        ),
      ),
    );
  }
}

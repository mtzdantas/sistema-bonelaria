import 'package:flutter/material.dart';
import '../controllers/cadastro_controller.dart';

class CadastroScreen extends StatefulWidget {
  const CadastroScreen({super.key});

  @override
  State<CadastroScreen> createState() => _CadastroScreenState();
}

class _CadastroScreenState extends State<CadastroScreen> {
  final _formKey = GlobalKey<FormState>();
  final controller = CadastroController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _cadastrarFuncionario() async {
    if (_formKey.currentState!.validate()) {
      final sucesso = await controller.cadastrarFuncionario(context);

      if (sucesso) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Cadastro realizado com sucesso!')),
        );
        Navigator.pushReplacementNamed(context, '/login');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cadastrar Funcionário')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const Text(
                'Dados Pessoais',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              TextFormField(
                controller: controller.nomeController,
                decoration: const InputDecoration(labelText: 'Nome'),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Informe o nome' : null,
              ),
              TextFormField(
                controller: controller.cpfController,
                decoration: const InputDecoration(labelText: 'CPF'),
              ),
              TextFormField(
                controller: controller.telefoneController,
                decoration: const InputDecoration(labelText: 'Telefone'),
              ),
              TextFormField(
                controller: controller.emailController,
                decoration: const InputDecoration(labelText: 'Email'),
              ),
              TextFormField(
                controller: controller.senhaController,
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Senha'),
              ),
              const SizedBox(height: 20),
              const Text(
                'Endereço',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              TextFormField(
                controller: controller.ruaController,
                decoration: const InputDecoration(labelText: 'Rua'),
              ),
              TextFormField(
                controller: controller.numeroController,
                decoration: const InputDecoration(labelText: 'Número'),
              ),
              TextFormField(
                controller: controller.bairroController,
                decoration: const InputDecoration(labelText: 'Bairro'),
              ),
              TextFormField(
                controller: controller.complementoController,
                decoration: const InputDecoration(labelText: 'Complemento'),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _cadastrarFuncionario,
                child: const Text('Cadastrar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

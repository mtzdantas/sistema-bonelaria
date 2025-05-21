import 'package:flutter/material.dart';
import '../controllers/cadastro_controller.dart';
import '../../utils/validator/funcionario.dart';
import '../../utils/validator/models/validator_funcionario.dart';

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

  final credentials = ModelValidatorFunc();
  final validator = FuncionarioValidator();

  bool isValid() {
    final result = validator.validate(credentials);
    return result.isValid;
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
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: controller.nomeController,
                onChanged: credentials.setNome,
                decoration: const InputDecoration(labelText: 'Nome'),
                validator: validator.byField(credentials, 'nome'),
              ),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: controller.cpfController,
                onChanged: credentials.setCpf,
                decoration: const InputDecoration(labelText: 'CPF'),
                validator: validator.byField(credentials, 'cpf'),
              ),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: controller.telefoneController,
                onChanged: credentials.setTelefone,
                decoration: const InputDecoration(labelText: 'Telefone'),
                validator: validator.byField(credentials, 'telefone'),
              ),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: controller.emailController,
                onChanged: credentials.setEmail,
                decoration: const InputDecoration(labelText: 'Email'),
                validator: validator.byField(credentials, 'email'),
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
              ListenableBuilder(
                listenable: credentials,
                builder: (context, child) {
                  return ElevatedButton(
                    onPressed: isValid() ? () {
                      _cadastrarFuncionario();
                    } : null,
                    child: const Text('Cadastrar'),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

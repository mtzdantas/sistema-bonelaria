import 'package:flutter/material.dart';
import '../../supabase/supabase_client.dart';
import '../../models/funcionario.dart';
import '../../utils/app_bar.dart';

class FuncScreen extends StatefulWidget {
  const FuncScreen({super.key});

  @override
  State<FuncScreen> createState() => _FuncScreenState();
}

class _FuncScreenState extends State<FuncScreen> {
  List<Funcionario> funcionarios = [];

  @override
  void initState() {
    super.initState();
    carregarFuncionarios();
  }

  Future<void> carregarFuncionarios() async {
    final response = await SupabaseConfig.client
        .from('funcionario')
        .select();

    setState(() {
      funcionarios = (response as List)
          .map((f) => Funcionario.fromMap(f))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),

      body: ListView.builder(
        itemCount: funcionarios.length,
        itemBuilder: (context, index) {
          final f = funcionarios[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            elevation: 4,
            child: ListTile(
              title: Text(f.nome),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Email: ${f.email}'),
                  Text('Telefone: ${f.telefone}'),
                  Text('Salário: R\$ ${f.salario.toStringAsFixed(2)}'),
                ],
              ),
              isThreeLine: true,
            ),
          );
        },
      ),
    );
  }
}

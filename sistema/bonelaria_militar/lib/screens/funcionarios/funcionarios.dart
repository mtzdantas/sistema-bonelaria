import 'package:flutter/material.dart';
import '../../supabase/supabase_client.dart';
import '../../models/funcionario.dart';
import '../../utils/app_bar.dart';
import '../../auth/views/cadastro.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

class FuncScreen extends StatefulWidget {
  const FuncScreen({super.key});

  @override
  State<FuncScreen> createState() => _FuncScreenState();
}

class _FuncScreenState extends State<FuncScreen> {
  List<Funcionario> funcionarios = [];
  List<Funcionario> funcionariosFiltrados = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    carregarFuncionarios();
    _searchController.addListener(_filtrarFuncionarios);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> carregarFuncionarios() async {
    final response = await SupabaseConfig.client
      .from('funcionario')
      .select('''
        *,
        endereco(*)
      ''');

    setState(() {
      funcionarios = (response as List)
          .map((f) => Funcionario.fromMapWithEndereco(f))
          .toList();

      funcionariosFiltrados = funcionarios;
    });
  }

  void _filtrarFuncionarios() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      funcionariosFiltrados = funcionarios
        .where((f) => f.nome.toLowerCase().contains(query))
        .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),

      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                labelText: 'Pesquisar funcionário',
                prefixIcon: Icon(Symbols.person_search),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Text(
              funcionariosFiltrados.isNotEmpty
                  ? 'Funcionários encontrados (${funcionariosFiltrados.length}):'
                  : 'Nenhum funcionário encontrado',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: funcionariosFiltrados.length,
              itemBuilder: (context, index) {
                final f = funcionariosFiltrados[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  elevation: 3,
                  child: ExpansionTile(
                    title: Text(f.nome, style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Telefone: ${f.telefone}'),
                        Text('Email: ${f.email}'),
                      ],
                    ),
                    children: [
                      ListTile(
                        title: const Text('Endereço:', style: TextStyle(color: Colors.white)),
                        subtitle: Text(
                          '${f.endereco!.rua}, ${f.endereco!.numero} - ${f.endereco!.bairro}, ${f.endereco!.complemento}',
                          style: const TextStyle(color: Colors.white70),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CadastroScreen(),
            ),
          );
        },
        child: const Icon(Symbols.add),
        tooltip: 'Cadastrar novo funcionário',
      ),
    );
  }
}

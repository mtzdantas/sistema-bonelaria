import 'package:flutter/material.dart';
import '../../supabase/supabase_client.dart';
import '../../models/produto.dart';
import '../../utils/app_bar.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

class ProdScreen extends StatefulWidget {
  const ProdScreen({super.key});

  @override
  State<ProdScreen> createState() => _ProdScreenState();
}

class _ProdScreenState extends State<ProdScreen> {
  List<Produto> produtos = [];
  List<Produto> produtosFiltrados = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    carregarProdutos();
    _searchController.addListener(_filtrarProdutos);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> carregarProdutos() async {
    final response = await SupabaseConfig.client
        .from('produto')
        .select('*');

    setState(() {
      produtos = (response as List)
          .map((p) => Produto.fromMap(p))
          .toList();

      produtosFiltrados = produtos;
    });
  }

  void _filtrarProdutos() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      produtosFiltrados = produtos
          .where((p) => p.nome.toLowerCase().contains(query))
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
                labelText: 'Pesquisar produto',
                prefixIcon: Icon(Symbols.search),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Text(
              produtosFiltrados.isNotEmpty
                  ? 'Produtos encontrados (${produtosFiltrados.length}):'
                  : 'Nenhum produto encontrado',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: produtosFiltrados.length,
              itemBuilder: (context, index) {
                final p = produtosFiltrados[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  elevation: 3,
                  child: ExpansionTile(
                    title: Text(p.nome, style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text('Categoria: ${p.categoria}'),
                    children: [
                      ListTile(
                        title: const Text('Descrição'),
                        subtitle: Text(p.descricao),
                      ),
                      ListTile(
                        title: const Text('Quantidade em estoque'),
                        subtitle: Text('${p.quantidadeEstoque} unidades'),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

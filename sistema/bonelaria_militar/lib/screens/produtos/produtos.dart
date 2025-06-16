import 'package:bonelaria_militar/screens/produtos/produto_cadastros_screen.dart';
import 'package:bonelaria_militar/services/produto_insumo_service.dart';
import 'package:bonelaria_militar/utils/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:bonelaria_militar/screens/produtos/components/produto_card.dart';


class ProdScreen extends StatefulWidget {
  const ProdScreen({super.key});

  @override
  State<ProdScreen> createState() => _ProdScreenState();
}

class _ProdScreenState extends State<ProdScreen> {
  List<ProdutoComInsumos> agrupadosList = [];
  List<ProdutoComInsumos> filtradosList = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _init();
    _searchController.addListener(_filtrar);
  }

  Future<void> _init() async {
    await carregarProdutoInsumos();
  }


  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> carregarProdutoInsumos() async {
  final produtos = await carregarProdutosComInsumos();

  setState(() {
    agrupadosList = produtos;
    filtradosList = agrupadosList;
  });
}


  void _filtrar() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      filtradosList = agrupadosList.where((pi) {
        final produtoNome = pi.produto.nome.toLowerCase();
        return produtoNome.contains(query);
      }).toList();
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
              filtradosList.isNotEmpty
                  ? 'Produtos encontrados (${filtradosList.length}):'
                  : 'Nenhum produto encontrado',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filtradosList.length,
              itemBuilder: (context, index) {
                final item = filtradosList[index];
                return ProdutoCard(
                  item: item,
                  onProdutoAlterado: carregarProdutoInsumos,
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Adicionar novo produto',
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ProdutoCadastroScreen()),
          );
          await carregarProdutoInsumos();  // 🔥 Recarrega ao voltar
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

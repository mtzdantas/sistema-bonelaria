import 'package:bonelaria_militar/models/insumo.dart';
import 'package:bonelaria_militar/models/produto.dart';
import 'package:bonelaria_militar/screens/produtos/produto_cadastros_screen.dart';
import 'package:bonelaria_militar/screens/produtos/produto_editar_screen.dart';
import 'package:bonelaria_militar/services/produto_service.dart';
import 'package:bonelaria_militar/supabase/supabase_client.dart';
import 'package:bonelaria_militar/utils/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

// Classe temporaria, ainda vai ser criado um model para ela
class ProdutoComInsumos {
  final Produto produto;
  final List<Map<String, dynamic>> insumosComQuantia;

  ProdutoComInsumos({
    required this.produto,
    required this.insumosComQuantia,
  });
}

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
    carregarProdutoInsumos();
    _searchController.addListener(_filtrar);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> carregarProdutoInsumos() async {
    final response = await SupabaseConfig.client
        .from('produto_insumo')
        .select('''
          *,
          produto(*),
          insumo:insumos(*)
        ''');

    final rawList = response as List;

    final Map<int, ProdutoComInsumos> agrupados = {};

    for (var item in rawList) {
      final produtoMap = item['produto'];
      final insumoMap = item['insumo'];
      final quantia = item['quantia_insumo'];

      final produtoId = produtoMap['id_produto'];
      final insumoComQuantia = {
        'insumo': Insumo.fromMap(insumoMap),
        'quantia': quantia,
      };

      if (agrupados.containsKey(produtoId)) {
        agrupados[produtoId]!.insumosComQuantia.add(insumoComQuantia);
      } else {
        agrupados[produtoId] = ProdutoComInsumos(
          produto: Produto.fromMap(produtoMap),
          insumosComQuantia: [insumoComQuantia],
        );
      }
    }

    setState(() {
      agrupadosList = agrupados.values.toList();
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
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  elevation: 3,
                  child: ExpansionTile(
                    title: Text(
                      item.produto.nome,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text('Categoria: ${item.produto.categoria}'),
                    children: [
                      const Padding(
                        padding: EdgeInsets.fromLTRB(16, 8, 16, 4),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Insumos necessários:',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                      ...item.insumosComQuantia.map((iq) {
                        final insumo = iq['insumo'] as Insumo;
                        final quantia = iq['quantia'];
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: ListTile(
                            dense: true,
                            contentPadding: const EdgeInsets.only(left: 8),
                            title: Text(insumo.nome),
                            subtitle: Text('Tipo: ${insumo.tipoDeInsumo} | Quantia: $quantia'),
                          ),
                        );
                      }),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton.icon(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ProdutoEdicaoScreen(produto: item.produto),
                                  ),
                                ).then((_) => carregarProdutoInsumos()); // Atualiza a lista ao voltar
                              },

                              icon: const Icon(Icons.edit, color: Colors.blue),
                              label: const Text('Editar Produto'),
                            ),
                            const SizedBox(width: 8),
                            TextButton.icon(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              label: const Text('Excluir Produto'),
                              onPressed: () async {
                                final confirma = await showDialog<bool>(
                                  context: context,
                                  builder: (_) => AlertDialog(
                                    title: const Text('Confirmar exclusão'),
                                    content: Text('Excluir o produto "${item.produto.nome}"?'),
                                    actions: [
                                      TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancelar')),
                                      TextButton(onPressed: () => Navigator.pop(context, true), child: const Text('Excluir')),
                                    ],
                                  ),
                                );

                                if (confirma != true) return;

                                final mensagemErro = await deletarProduto(item.produto.idProduto);

                                if (!context.mounted) return;

                                if (mensagemErro != null) {
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(mensagemErro)));
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Produto excluído com sucesso.')));
                                  await carregarProdutoInsumos();
                                }
                              },
                            ),
                          ],
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
        tooltip: 'Adicionar novo produto',
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ProdutoCadastroScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

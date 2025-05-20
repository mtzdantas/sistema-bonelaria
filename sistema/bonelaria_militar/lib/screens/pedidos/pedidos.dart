import 'package:flutter/material.dart';
import '../../utils/app_bar.dart';
import '../../models/pedidos.dart';
import '../../services/pedido_service.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'pedido_detalhes_screen.dart';
import 'pedido_cadastro_screen.dart';


class PedScreen extends StatefulWidget {
  const PedScreen({super.key});

  @override
  State<PedScreen> createState() => _PedScreenState();
}

class _PedScreenState extends State<PedScreen> {
  List<Pedido> pedidos = [];
  List<Pedido> pedidosFiltrados = [];
  final TextEditingController _searchController = TextEditingController();

  // Future<void> _abrirCadastroPedido() async {
  //   final resultado = await Navigator.push(
  //     context,
  //     MaterialPageRoute(builder: (context) => const CadastroPedidoPage()),
  //   );

  //   if (resultado == true) {
  //     await carregarPedidos();
  //   }
  // }


  @override
  void initState() {
    super.initState();
    carregarPedidos();
    _searchController.addListener(_filtrarPedidos);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> carregarPedidos() async {
    final lista = await PedidoService.buscarPedidos();
    setState(() {
      pedidos = lista;
      pedidosFiltrados = lista;
    });
  }

  void _filtrarPedidos() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      pedidosFiltrados = pedidos
          .where((p) => p.costureiraNome.toLowerCase().contains(query))
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
                labelText: 'Pesquisar por costureira',
                prefixIcon: Icon(Symbols.search),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Text(
              pedidosFiltrados.isNotEmpty
                  ? 'Pedidos encontrados (${pedidosFiltrados.length}):'
                  : 'Nenhum pedido encontrado',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: pedidosFiltrados.length,
              itemBuilder: (context, index) {
                final p = pedidosFiltrados[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  elevation: 3,
                  child: ListTile(
                    title: Text('Pedido #${p.id} - ${p.costureiraNome}'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Status: ${p.status}'),
                        Text('Data: ${p.data.day}/${p.data.month}/${p.data.year}'),
                      ],
                    ),
                    leading: const Icon(Symbols.receipt_long),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PedidoDetalhesScreen(idPedido: p.id),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Adicionar novo pedido',
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CadastroPedidoPage()),
          ).then((_) {
            // Recarrega os pedidos ao voltar do cadastro
            carregarPedidos();
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

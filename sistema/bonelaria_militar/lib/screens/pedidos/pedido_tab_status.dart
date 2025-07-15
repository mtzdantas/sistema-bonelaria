import 'package:flutter/material.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:bonelaria_militar/services/pedido_service.dart';
import 'package:bonelaria_militar/models/pedidos.dart';
import 'package:bonelaria_militar/screens/pedidos/pedido_detalhes_screen.dart';

class PedidosTab extends StatefulWidget {
  final List<Pedido> pedidos;
  final String statusDesejado;

  const PedidosTab({
    super.key,
    required this.pedidos,
    required this.statusDesejado,
  });

  @override
  State<PedidosTab> createState() => _PedidosTabState();
}

class _PedidosTabState extends State<PedidosTab> {
  List<Pedido> pedidosFiltrados = [];
  final TextEditingController _searchController = TextEditingController();
  final PedidoService _pedidoService = PedidoService();

  @override
  void initState() {
    super.initState();
    _filtrarPedidos();
    _searchController.addListener(_filtrarPedidos);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filtrarPedidos() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      pedidosFiltrados = widget.pedidos
          .where((p) =>
              p.status.toLowerCase() == widget.statusDesejado.toLowerCase() &&
              (query.isEmpty || p.costureiraNome.toLowerCase().contains(query)))
          .toList();
    });
  }

  void _removerPedidoDaLista(int idPedido) {
    setState(() {
      widget.pedidos.removeWhere((pedido) => pedido.id == idPedido);
      pedidosFiltrados.removeWhere((pedido) => pedido.id == idPedido);
    });
  }


  @override
  Widget build(BuildContext context) {
    return Column(
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
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () async {
                      final confirma = await showDialog<bool>(
                        context: context,
                        builder: (_) => AlertDialog(
                          title: const Text('Confirmar exclusão'),
                          content: Text('Deseja realmente excluir o pedido #${p.id}?'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context, false),
                              child: const Text('Cancelar'),
                            ),
                            TextButton(
                              onPressed: () => Navigator.pop(context, true),
                              child: const Text('Excluir'),
                            ),
                          ],
                        ),
                      );

                      if (confirma != true) return;

                      final mensagemErro = await _pedidoService.deletarPedido(p.id);

                      if (!context.mounted) return;

                      if (mensagemErro != null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(mensagemErro)),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Pedido excluído com sucesso.')),
                        );
                        _removerPedidoDaLista(p.id);
                      }
                    },
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
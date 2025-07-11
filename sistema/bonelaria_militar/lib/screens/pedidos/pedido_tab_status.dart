import 'package:flutter/material.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

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

  @override
  void initState() {
    super.initState();
    _filtrarPorStatus();
    _searchController.addListener(_filtrarPorNome);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filtrarPorStatus() {
    setState(() {
      pedidosFiltrados = widget.pedidos
          .where((p) => p.status.toLowerCase() == widget.statusDesejado.toLowerCase())
          .toList();
    });
  }

  void _filtrarPorNome() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      pedidosFiltrados = widget.pedidos
          .where((p) =>
              p.status.toLowerCase() == widget.statusDesejado.toLowerCase() &&
              p.costureiraNome.toLowerCase().contains(query))
          .toList();
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
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

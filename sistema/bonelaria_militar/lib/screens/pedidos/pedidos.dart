import 'package:bonelaria_militar/models/pedidos.dart';
import 'package:bonelaria_militar/screens/pedidos/pedido_cadastro_screen.dart';
import 'package:bonelaria_militar/services/pedido_service.dart';
import 'package:bonelaria_militar/utils/app_bar.dart';
import 'package:flutter/material.dart';

import 'pedido_tab_status.dart'; // importa a nova aba modular

class PedScreen extends StatefulWidget {
  const PedScreen({super.key});

  @override
  State<PedScreen> createState() => _PedScreenState();
}

class _PedScreenState extends State<PedScreen> {
  List<Pedido> pedidos = [];

  @override
  void initState() {
    super.initState();
    carregarPedidos();
  }

  Future<void> carregarPedidos() async {
    final lista = await PedidoService.buscarPedidos();
    setState(() {
      pedidos = lista;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: const CustomAppBar(), // não vamos tocar aqui
        body: Column(
          children: [
            const TabBar(
              tabs: [
                Tab(text: 'Aberto'),
                Tab(text: 'Pendente'),
                Tab(text: 'Finalizado'),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  PedidosTab(key: ValueKey('aberto_${pedidos.length}'),pedidos: pedidos, statusDesejado: 'Aberto'),
                  PedidosTab(key: ValueKey('pendente_${pedidos.length}'),pedidos: pedidos, statusDesejado: 'Pendente'),
                  PedidosTab(key: ValueKey('finalizado_${pedidos.length}'),pedidos: pedidos, statusDesejado: 'Finalizado'),
                ],
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
              carregarPedidos();
            });
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
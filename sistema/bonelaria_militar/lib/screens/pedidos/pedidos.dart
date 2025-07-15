import 'package:bonelaria_militar/models/pedidos.dart';
import 'package:bonelaria_militar/screens/pedidos/pedido_cadastro_screen.dart'; // Você está usando a tela de cadastro aqui
import 'package:bonelaria_militar/services/pedido_service.dart';
import 'package:bonelaria_militar/utils/app_bar.dart';
import 'package:flutter/material.dart';
import 'pedido_tab_status.dart'; 

class PedScreen extends StatefulWidget {
  const PedScreen({super.key});

  @override
  State<PedScreen> createState() => _PedScreenState();
}

class _PedScreenState extends State<PedScreen> {
  List<Pedido> pedidos = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    carregarPedidos();
  }

  Future<void> carregarPedidos() async {
    if(!mounted) return;
    setState(() {
      _isLoading = true;
    });

    final lista = await PedidoService.buscarPedidos();
    
    if(!mounted) return;
    setState(() {
      pedidos = lista;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: const CustomAppBar(),
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
              child: _isLoading 
                ? const Center(child: CircularProgressIndicator()) 
                : TabBarView(
                children: [
                  PedidosTab(
                    pedidos: pedidos, 
                    statusDesejado: 'Aberto',
                    onPedidoAlterado: carregarPedidos,
                  ),

                  PedidosTab(
                    pedidos: pedidos, 
                    statusDesejado: 'Pendente',
                    onPedidoAlterado: carregarPedidos,
                  ),
                  
                  PedidosTab(
                    pedidos: pedidos, 
                    statusDesejado: 'Finalizado',
                    onPedidoAlterado: carregarPedidos,
                  ),
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
            );
            carregarPedidos(); 
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
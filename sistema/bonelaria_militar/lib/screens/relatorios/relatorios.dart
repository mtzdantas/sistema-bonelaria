import 'package:flutter/material.dart';
import 'gerar_conta_tab.dart';
import 'contas_pendentes_tab.dart';
import 'pagamentos_realizados_tab.dart';

class RelScreen extends StatelessWidget {
  const RelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Relatório de Pagamentos'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Gerar Conta'),
              Tab(text: 'Contas Pendentes'),
              Tab(text: 'Pagamentos'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            GerarContaTab(),
            ContasPendentesTab(),
            PagamentosRealizadosTab(),
          ],
        ),
      ),
    );
  }
}

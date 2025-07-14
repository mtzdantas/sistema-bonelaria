import 'package:flutter/material.dart';
import '../../models/pagamento.dart';
import '../../services/pagamento_service.dart';
import '../relatorios/pagamento_detalhes_screen.dart'; // importe sua tela de detalhes

class PagamentosRealizadosTab extends StatefulWidget {
  const PagamentosRealizadosTab({super.key});

  @override
  State<PagamentosRealizadosTab> createState() => _PagamentosRealizadosTabState();
}

class _PagamentosRealizadosTabState extends State<PagamentosRealizadosTab> {
  List<Pagamento> pagamentos = [];

  @override
  void initState() {
    super.initState();
    carregarPagamentos();
  }

  Future<void> carregarPagamentos() async {
    final lista = await PagamentoService.buscarPagamentos();
    setState(() {
      pagamentos = lista;
    });
  }

  void abrirDetalhesPagamento(Pagamento pagamento) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => PagamentoDetalhesScreen(pagamento: pagamento),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (pagamentos.isEmpty) {
      return const Center(child: Text('Nenhum pagamento realizado.'));
    }

    return ListView.builder(
      itemCount: pagamentos.length,
      itemBuilder: (context, index) {
        final pagamento = pagamentos[index];
        return Padding(
          padding: EdgeInsets.only(top: index == 0 ? 8 : 0), // padding somente no primeiro item
          child: Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 2,
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              leading: const Icon(Icons.payments_outlined, size: 28),
              title: Text(
                'Pagamento #${pagamento.idPagamento}',
                style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (pagamento.nomeCostureira != null)
                    Text('Costureira: ${pagamento.nomeCostureira!}', style: const TextStyle(fontSize: 14)),
                  Text('Valor: R\$ ${pagamento.valorPagamento.toStringAsFixed(2)}',
                      style: const TextStyle(fontSize: 14)),
                  Text('Forma: ${pagamento.formaPagamento}', style: const TextStyle(fontSize: 14)),
                ],
              ),
              onTap: () => abrirDetalhesPagamento(pagamento),
            ),
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import '../../models/pagamento.dart';
import '../../models/pedidos.dart';
import '../../models/funcionario.dart';
import '../../services/pedido_service.dart';
import '../../services/costureira_service.dart';

class PagamentoDetalhesScreen extends StatefulWidget {
  final Pagamento pagamento;

  const PagamentoDetalhesScreen({super.key, required this.pagamento});

  @override
  State<PagamentoDetalhesScreen> createState() => _PagamentoDetalhesScreenState();
}

class _PagamentoDetalhesScreenState extends State<PagamentoDetalhesScreen> {
  List<Pedido> pedidos = [];
  Funcionario? costureira;
  bool carregando = true;

  @override
  void initState() {
    super.initState();
    carregarDetalhes();
  }

  Future<void> carregarDetalhes() async {
    setState(() => carregando = true);
    try {
      final listaPedidos = await PedidoService.buscarPedidosPorConta(widget.pagamento.idContaAPagar);
      if (listaPedidos.isNotEmpty) {
        final idCostureira = listaPedidos.first.idFuncionario;
        final costureiras = await CostureiraService.buscarTodas();
        final encontrada = costureiras.firstWhere(
          (c) => c.idFuncionario == idCostureira,
          orElse: () => Funcionario(
            idFuncionario: 0,
            nome: 'Desconhecida',
            idEndereco: 0,
            cpf: '',
            telefone: '',
            email: '',
            pisoSalarial: 0,
            salario: 0,
            idFuncao: 0,
          ),
        );
        setState(() => costureira = encontrada);
      }
      setState(() => pedidos = listaPedidos);
    } catch (e) {
      debugPrint('Erro ao carregar detalhes do pagamento: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Erro ao carregar detalhes')),
      );
    } finally {
      setState(() => carregando = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pagamento #${widget.pagamento.idPagamento}'),
      ),
      body: carregando
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Costureira:',
                                style: TextStyle(color: Colors.grey[600], fontWeight: FontWeight.w500)),
                            const SizedBox(height: 4),
                            Text(costureira?.nome ?? widget.pagamento.nomeCostureira ?? 'Desconhecida',
                                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 12),
                            Text('Valor Pago:',
                                style: TextStyle(color: Colors.grey[600], fontWeight: FontWeight.w500)),
                            const SizedBox(height: 4),
                            Text('R\$ ${widget.pagamento.valorPagamento.toStringAsFixed(2)}',
                                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 12),
                            Text('Forma de Pagamento:',
                                style: TextStyle(color: Colors.grey[600], fontWeight: FontWeight.w500)),
                            const SizedBox(height: 4),
                            Text(widget.pagamento.formaPagamento,
                                style: const TextStyle(fontSize: 16)),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text('Pedidos vinculados:',
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  Expanded(
                    child: pedidos.isEmpty
                        ? const Center(child: Text('Nenhum pedido vinculado a esse pagamento.', style: TextStyle(fontSize: 16)))
                        : ListView.separated(
                            itemCount: pedidos.length,
                            separatorBuilder: (_, __) => const SizedBox(height: 8),
                            itemBuilder: (context, index) {
                              final pedido = pedidos[index];
                              return Card(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                elevation: 2,
                                child: ListTile(
                                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                  leading: const Icon(Symbols.receipt_long),
                                  title: Text('Pedido #${pedido.id}',
                                      style: const TextStyle(fontWeight: FontWeight.bold)),
                                  onTap: () {
                                    // abrir detalhes do pedido, se quiser
                                  },
                                ),
                              );
                            },
                          ),
                  ),
                ],
              ),
            ),
    );
  }
}

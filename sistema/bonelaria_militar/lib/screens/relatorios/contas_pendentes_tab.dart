import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../models/conta_a_pagar.dart';
import '../../services/conta_service.dart';
import '../../services/pagamento_service.dart';
import '../relatorios/conta_detalhes_screen.dart';

class ContasPendentesTab extends StatefulWidget {
  const ContasPendentesTab({super.key});

  @override
  State<ContasPendentesTab> createState() => _ContasPendentesTabState();
}

class _ContasPendentesTabState extends State<ContasPendentesTab> {
  List<ContaAPagar> contas = [];
  bool carregando = true;

  final formatadorReais = NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');

  @override
  void initState() {
    super.initState();
    carregarContas();
  }

  Future<void> carregarContas() async {
    setState(() {
      carregando = true;
    });
    try {
      final lista = await ContaService.buscarContasPendentes();
      setState(() {
        contas = lista;
      });
    } catch (e) {
      debugPrint('Erro ao carregar contas: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao carregar contas: $e')),
      );
    } finally {
      setState(() {
        carregando = false;
      });
    }
  }

  Future<void> confirmarPagamento(ContaAPagar conta) async {
  String? formaSelecionada;

  await showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            title: const Text('Confirmar Pagamento'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Valor: R\$ ${conta.valor.toStringAsFixed(2)}',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 24),
                const Text(
                  'Forma de Pagamento',
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 22, 20, 20), // Fundo mais escuro
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      isExpanded: true,
                      hint: const Text('Selecione forma'),
                      value: formaSelecionada,
                      items: const [
                        DropdownMenuItem(value: 'Pix', child: Text('Pix')),
                        DropdownMenuItem(value: 'Dinheiro', child: Text('Dinheiro')),
                        DropdownMenuItem(value: 'Boleto', child: Text('Boleto')),
                        DropdownMenuItem(value: 'Cartão de Crédito', child: Text('Cartão de Crédito')),
                        DropdownMenuItem(value: 'Transferência', child: Text('Transferência')),
                        DropdownMenuItem(value: 'Espécie', child: Text('Espécie')),
                      ],
                      onChanged: (value) {
                        setState(() {
                          formaSelecionada = value;
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
            actionsPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancelar'),
                  ),
                  ElevatedButton(
                    onPressed: formaSelecionada == null
                        ? null
                        : () async {
                            try {
                              await PagamentoService.registrarPagamento(
                                conta.idContaAPagar,
                                conta.valor,
                                formaSelecionada!,
                              );
                              Navigator.pop(context);
                              await carregarContas();
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Pagamento registrado com sucesso!')),
                              );
                            } catch (e) {
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Erro ao registrar pagamento: $e')),
                              );
                            }
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    child: const Text('Confirmar'),
                  ),
                ],
              ),
            ],
          );
        },
      );
    },
  );
}


  Future<void> abrirDetalhes(ContaAPagar conta) async {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => ContaDetalhesScreen(conta: conta),
    ),
  );
}



  @override
  Widget build(BuildContext context) {
    if (carregando) {
      return const Center(child: CircularProgressIndicator());
    }

    if (contas.isEmpty) {
      return const Center(child: Text('Nenhuma conta pendente encontrada.'));
    }

    return ListView.builder(
      itemCount: contas.length,
      itemBuilder: (context, index) {
        final conta = contas[index];
        return ListTile(
          title: Text(
            'Conta #${conta.idContaAPagar} - ${formatadorReais.format(conta.valor)}',
          ),
          subtitle: Text(
            'Vencimento: ${DateFormat('dd/MM/yyyy').format(conta.dataVencimento)}',
          ),
          onTap: () => abrirDetalhes(conta),
          trailing: IconButton(
            icon: const Icon(Icons.check, color: Colors.green),
            onPressed: () => confirmarPagamento(conta),
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import '../../supabase/supabase_client.dart';

class PedidoDetalhesScreen extends StatefulWidget {
  final int idPedido;

  const PedidoDetalhesScreen({super.key, required this.idPedido});

  @override
  State<PedidoDetalhesScreen> createState() => _PedidoDetalhesScreenState();
}

class _PedidoDetalhesScreenState extends State<PedidoDetalhesScreen> {
  List<Map<String, dynamic>> produtosDoPedido = [];
  double valorTotal = 0;

  @override
  void initState() {
    super.initState();
    carregarProdutosDoPedido();
  }

  Future<void> carregarProdutosDoPedido() async {
    final response = await SupabaseConfig.client
        .from('produto_pedido')
        .select(''' 
          quantidade_produto,
          valor_produto,
          produto (
            nome
          )
        ''')
        .eq('id_pedido', widget.idPedido);

    double soma = 0;

    final lista = (response as List).map((item) {
      final quantidade = item['quantidade_produto'];
      final valor = item['valor_produto'];
      soma += quantidade * valor;

      return {
        'nome': item['produto']['nome'],
        'quantidade': quantidade,
        'valor': valor,
      };
    }).toList();

    setState(() {
      produtosDoPedido = lista;
      valorTotal = soma;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes do Pedido'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: produtosDoPedido.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'Produtos do Pedido',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white, // Texto branco
                    ),
                  ),
                  const SizedBox(height: 12),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      columnSpacing: 32.0,
                      columns: const [
                        DataColumn(
                          label: Text(
                            'Produto',
                            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white), // Texto em branco
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Quantidade',
                            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white), // Texto em branco
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Valor (R\$)',
                            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white), // Texto em branco
                          ),
                        ),
                      ],
                      rows: produtosDoPedido.map((produto) {
                        return DataRow(
                          cells: [
                            DataCell(Row(
                              children: [
                                const SizedBox(width: 8),
                                Text(
                                  produto['nome'],
                                  style: const TextStyle(color: Colors.white), // Texto em branco
                                ),
                              ],
                            )),
                            DataCell(Text(
                              produto['quantidade'].toString(),
                              style: const TextStyle(color: Colors.white70), // Texto um pouco mais suave
                            )),
                            DataCell(Text(
                              produto['valor'].toStringAsFixed(2),
                              style: const TextStyle(color: Colors.white), 
                            )),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFF6A4D9B),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color(0xFF7A4F9B)), 
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Valor total do pedido:',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white, // Texto branco
                          ),
                        ),
                        Text(
                          'R\$ ${valorTotal.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white, // Texto branco
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

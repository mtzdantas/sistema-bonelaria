import 'package:flutter/material.dart';
import '../../supabase/supabase_client.dart';

class CadastroPedidoPage extends StatefulWidget {
  const CadastroPedidoPage({Key? key}) : super(key: key);

  @override
  _CadastroPedidoPageState createState() => _CadastroPedidoPageState();
}

class _CadastroPedidoPageState extends State<CadastroPedidoPage> {
  final _formKey = GlobalKey<FormState>();

  // Controllers
  int? _selectedCostureira;
  final List<Map<String, dynamic>> _custureiras = [];
  final List<Map<String, dynamic>> _produtos = [];
  DateTime _dataPedido = DateTime.now();
  bool salvando = false;

  // Itens do pedido
  List<_ItemPedido> _itens = [];

  @override
  void initState() {
    super.initState();
    _carregarCostureiras();
    _carregarProdutos();
  }

  Future<void> _carregarCostureiras() async {
    // Busca somente funcionarios cuja funcao.nome = 'Costureira'
    final resp = await SupabaseConfig.client
        .from('funcionario')
        .select('id_funcionario, nome, funcao(nome)')
        .eq('funcao.nome', 'Costureira');
    setState(() {
      _custureiras.clear();
      _custureiras.addAll((resp as List).map((e) => {
            'id': e['id_funcionario'],
            'nome': e['nome'],
          }));
    });
  }

  Future<void> _carregarProdutos() async {
    final resp = await SupabaseConfig.client
        .from('produto')
        .select('id_produto, nome');
    setState(() {
      _produtos.clear();
      _produtos.addAll((resp as List).map((e) => {
            'id': e['id_produto'],
            'nome': e['nome'],
          }));
    });
  }

  void _adicionarItem() {
    setState(() {
      _itens.add(_ItemPedido());
    });
  }

  void _removerItem(int i) {
    setState(() {
      _itens.removeAt(i);
    });
  }

  Future<void> _salvarPedido() async {
    if (!_formKey.currentState!.validate()) return;

    if (_selectedCostureira == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Selecione uma costureira.')),
      );
      return;
    }

    if (_itens.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Adicione pelo menos um item ao pedido.')),
      );
      return;
    }

    // Valida todos os itens
    for (final item in _itens) {
      if (item.produtoId == null ||
          item.quantidade <= 0 ||
          item.valor <= 0.0) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Preencha corretamente todos os campos dos itens.')),
        );
        return;
      }
    }

    setState(() {
      salvando = true;
    });

    try {
      // 1) Cria o pedido e retorna o ID
      final pedidoResp = await SupabaseConfig.client
          .from('pedido')
          .insert({
            'id_costureira': _selectedCostureira,
            'data': _dataPedido.toIso8601String().split('T').first,
            'status_pedido': 'Pendente',
          })
          .select('id_pedido')
          .single();

      final int idPedido = pedidoResp['id_pedido'];

      // 2) Prepara lista de itens para inserção em lote
      final itensParaInserir = _itens.map((item) => {
            'id_pedido': idPedido,
            'id_produto': item.produtoId,
            'quantidade_produto': item.quantidade,
            'valor_produto': item.valor,
          }).toList();

      await SupabaseConfig.client
          .from('produto_pedido')
          .insert(itensParaInserir);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Pedido cadastrado com sucesso!')),
      );
      Navigator.pop(context);
    } catch (e) {
      debugPrint('Erro ao salvar pedido: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao salvar pedido: $e')),
      );
    } finally {
      setState(() {
        salvando = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cadastrar Pedido')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Seleção da costureira
              DropdownButtonFormField<int>(
                decoration: const InputDecoration(labelText: 'Costureira'),
                items: _custureiras
                    .map((c) => DropdownMenuItem<int>(
                          value: c['id'] as int,
                          child: Text(c['nome'] as String),
                        ))
                    .toList(),
                onChanged: (v) => _selectedCostureira = v,
                validator: (v) =>
                    v == null ? 'Selecione uma costureira' : null,
              ),

              const SizedBox(height: 16),

              // Data (só exibição)
              TextFormField(
                initialValue:
                    '${_dataPedido.day}/${_dataPedido.month}/${_dataPedido.year}',
                decoration: const InputDecoration(
                  labelText: 'Data do Pedido',
                ),
                readOnly: true,
              ),

              const SizedBox(height: 24),
              const Text(
                'Itens do Pedido',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),

              // Lista de itens
              ..._itens.asMap().entries.map((entry) {
                final i = entry.key;
                final item = entry.value;
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: DropdownButtonFormField<int>(
                                decoration:
                                    const InputDecoration(labelText: 'Produto'),
                                items: _produtos
                                    .map((p) => DropdownMenuItem<int>(
                                          value: p['id'] as int,
                                          child: Text(p['nome'] as String),
                                        ))
                                    .toList(),
                                onChanged: (v) => setState(() => item.produtoId = v),
                                validator: (v) =>
                                    v == null ? 'Selecione um produto' : null,
                                value: item.produtoId,
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete,
                                  color: Colors.red),
                              onPressed: () => _removerItem(i),
                            ),
                          ],
                        ),
                        TextFormField(
                          decoration:
                              const InputDecoration(labelText: 'Quantidade'),
                          keyboardType: TextInputType.number,
                          onChanged: (v) =>
                              item.quantidade = int.tryParse(v) ?? 0,
                          validator: (v) {
                            final q = int.tryParse(v ?? '');
                            if (q == null || q <= 0) {
                              return 'Quantidade inválida';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 8),
                        TextFormField(
                          decoration:
                              const InputDecoration(labelText: 'Valor unitário'),
                          keyboardType:
                              const TextInputType.numberWithOptions(
                                  decimal: true),
                          onChanged: (v) =>
                              item.valor = double.tryParse(v) ?? 0,
                          validator: (v) {
                            final d = double.tryParse(v ?? '');
                            if (d == null || d <= 0) {
                              return 'Valor inválido';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                );
              }),

              TextButton.icon(
                onPressed: _adicionarItem,
                icon: const Icon(Icons.add),
                label: const Text('Adicionar Item'),
              ),

              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _salvarPedido,
                child: const Text('Salvar Pedido'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ItemPedido {
  int? produtoId;
  int quantidade = 0;
  double valor = 0.0;
}

import 'package:bonelaria_militar/models/pedidos.dart';
import 'package:bonelaria_militar/services/pedido_service.dart';
import 'package:bonelaria_militar/supabase/supabase_client.dart';
import 'package:flutter/material.dart';

class PedidoEdicaoScreen extends StatefulWidget {
  final Pedido pedido;

  const PedidoEdicaoScreen({super.key, required this.pedido});

  @override
  State<PedidoEdicaoScreen> createState() => _PedidoEdicaoScreenState();
}

class _ItemPedido {
  int? produtoId;
  String? produtoNome;
  int quantidade = 0;
  double valor = 0.0;

  _ItemPedido({this.produtoId, this.produtoNome, this.quantidade = 0, this.valor = 0.0});
}

class _PedidoEdicaoScreenState extends State<PedidoEdicaoScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = true;
  bool _isSaving = false;

  int? _selectedCostureira;
  String? _selectedStatus;
  final List<_ItemPedido> _itens = [];
  
  final List<Map<String, dynamic>> _costureiras = [];
  final List<Map<String, dynamic>> _produtos = [];
  final List<String> _statusOptions = ['Aberto', 'Pendente', 'Finalizado'];

  @override
  void initState() {
    super.initState();
    _carregarDadosIniciais();
  }

  Future<void> _carregarDadosIniciais() async {
    try {
      final costureirasResponse = await SupabaseConfig.client
          .from('funcionario')
          .select('id_funcionario, nome, funcao(nome)')
          .eq('funcao.nome', 'Costureira');

      final produtosResponse = await SupabaseConfig.client
          .from('produto')
          .select('id_produto, nome');

      final itensDoPedido = await PedidoService.buscarProdutosPorPedido(widget.pedido.id);

      _costureiras.addAll((costureirasResponse as List).map((e) => {'id': e['id_funcionario'], 'nome': e['nome']}));
      _produtos.addAll((produtosResponse as List).map((e) => {'id': e['id_produto'], 'nome': e['nome']}));

      _itens.addAll(itensDoPedido.map((ip) { 
          final produtoData = _produtos.firstWhere(
            (p) => p['nome'] == ip.nomeProduto, 
            orElse: () => {'id': null},
          );
          return _ItemPedido(
            produtoId: produtoData['id'],
            produtoNome: ip.nomeProduto, 
            quantidade: ip.quantidade,
            valor: ip.valor,
          );
        }
      ));
      
      _selectedCostureira = widget.pedido.idFuncionario;
      _selectedStatus = widget.pedido.status;

    } catch (e) {
      if(mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao carregar dados do pedido: $e')),
        );
      }
    } finally {
      if(mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _adicionarItem() {
    setState(() {
      _itens.add(_ItemPedido());
    });
  }

  void _removerItem(int index) {
    setState(() {
      _itens.removeAt(index);
    });
  }

  Future<void> _atualizarPedido() async {
    if (!_formKey.currentState!.validate() || _isSaving) return;

    if (_selectedCostureira == null || _selectedStatus == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Selecione a costureira e o status.')),
      );
      return;
    }

    if (_itens.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('O pedido deve ter pelo menos um item.')),
      );
      return;
    }

    setState(() => _isSaving = true);

    final itensParaSalvar = _itens.map((item) => ItemPedidoEdit(
      produtoId: item.produtoId,
      quantidade: item.quantidade,
      valor: item.valor,
    )).toList();

    final erro = await PedidoService.atualizarPedido(
      idPedido: widget.pedido.id,
      idCostureira: _selectedCostureira!,
      status: _selectedStatus!,
      itens: itensParaSalvar,
    );
    
    if (mounted) {
      if (erro == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Pedido atualizado com sucesso!')),
        );
        Navigator.pop(context, true);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(erro)),
        );
      }
      setState(() => _isSaving = false);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Pedido #${widget.pedido.id}'),
        centerTitle: true,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    DropdownButtonFormField<int>(
                      value: _selectedCostureira,
                      decoration: const InputDecoration(labelText: 'Costureira', border: OutlineInputBorder()),
                      items: _costureiras.map((c) => DropdownMenuItem<int>(
                        value: c['id'] as int,
                        child: Text(c['nome'] as String),
                      )).toList(),
                      onChanged: (v) => setState(() => _selectedCostureira = v),
                      validator: (v) => v == null ? 'Selecione uma costureira' : null,
                    ),
                    const SizedBox(height: 16),

                    DropdownButtonFormField<String>(
                      value: _selectedStatus,
                      decoration: const InputDecoration(labelText: 'Status do Pedido', border: OutlineInputBorder()),
                      items: _statusOptions.map((status) => DropdownMenuItem<String>(
                        value: status,
                        child: Text(status),
                      )).toList(),
                      onChanged: (v) => setState(() => _selectedStatus = v),
                      validator: (v) => v == null ? 'Selecione um status' : null,
                    ),
                    const SizedBox(height: 24),

                    const Text('Itens do Pedido', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: DropdownButtonFormField<int>(
                                      value: item.produtoId,
                                      decoration: const InputDecoration(labelText: 'Produto'),
                                      items: _produtos.map((p) => DropdownMenuItem<int>(
                                        value: p['id'] as int,
                                        child: Text(p['nome'] as String),
                                      )).toList(),
                                      onChanged: (v) => setState(() => item.produtoId = v),
                                      validator: (v) => v == null ? 'Selecione um produto' : null,
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.delete, color: Colors.red),
                                    onPressed: () => _removerItem(i),
                                  ),
                                ],
                              ),
                              TextFormField(
                                initialValue: item.quantidade.toString(),
                                decoration: const InputDecoration(labelText: 'Quantidade'),
                                keyboardType: TextInputType.number,
                                onChanged: (v) => item.quantidade = int.tryParse(v) ?? 0,
                                validator: (v) => (int.tryParse(v ?? '') ?? 0) <= 0 ? 'Quantidade inválida' : null,
                              ),
                              TextFormField(
                                initialValue: item.valor.toString(),
                                decoration: const InputDecoration(labelText: 'Valor unitário'),
                                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                                onChanged: (v) => item.valor = double.tryParse(v) ?? 0,
                                validator: (v) => (double.tryParse(v ?? '') ?? 0) <= 0 ? 'Valor inválido' : null,
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
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      onPressed: _isSaving ? null : _atualizarPedido,
                      child: _isSaving
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 3,
                              ),
                            )
                          : const Text('Atualizar Pedido'),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
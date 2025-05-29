import 'package:bonelaria_militar/models/insumo.dart';
import 'package:bonelaria_militar/supabase/supabase_client.dart';
import 'package:flutter/material.dart';

class ProdutoCadastroScreen extends StatefulWidget {
  const ProdutoCadastroScreen({super.key});

  @override
  State<ProdutoCadastroScreen> createState() => _ProdutoCadastroScreenState();
}

class _ProdutoCadastroScreenState extends State<ProdutoCadastroScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _categoriaController = TextEditingController();
  final _descricaoController = TextEditingController();
  final _quantidadeEstoqueController = TextEditingController();


  List<Insumo> todosInsumos = [];
  List<Map<String, dynamic>> insumosSelecionados = [];

  @override
  void initState() {
    super.initState();
    carregarInsumos();
  }

  Future<void> carregarInsumos() async {
    final response = await SupabaseConfig.client.from('insumos').select();
    final data = (response as List).map((e) => Insumo.fromMap(e)).toList();
    setState(() {
      todosInsumos = data;
    });
  }

  void adicionarInsumo() {
    setState(() {
      insumosSelecionados.add({'insumo': null, 'quantia': ''});
    });
  }

  void removerInsumo(int index) {
    setState(() {
      insumosSelecionados.removeAt(index);
    });
  }

  Future<void> salvarProduto() async {
    if (!_formKey.currentState!.validate()) return;

    try {
      final produtoInsert = await SupabaseConfig.client.from('produto').insert({
        'nome': _nomeController.text.trim(),
        'categoria': _categoriaController.text.trim(),
        'descricao': _descricaoController.text.trim(),
        'quantidade_estoque': int.tryParse(_quantidadeEstoqueController.text.trim()) ?? 0,
      }).select().single();


      final int produtoId = produtoInsert['id_produto'];

      for (var entry in insumosSelecionados) {
        final insumo = entry['insumo'] as Insumo;
        final quantia = double.tryParse(entry['quantia']) ?? 0;

        await SupabaseConfig.client.from('produto_insumo').insert({
          'id_produto': produtoId,
          'id_insumo': insumo.idInsumo,
          'quantia_insumo': quantia,
        });
      }

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Produto cadastrado com sucesso!')),
      );
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao salvar: $e')),
      );
    }
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _categoriaController.dispose();
    _descricaoController.dispose();
    _quantidadeEstoqueController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cadastrar Produto')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nomeController,
                decoration: const InputDecoration(labelText: 'Nome'),
                validator: (v) => v == null || v.isEmpty ? 'Informe o nome' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _categoriaController,
                decoration: const InputDecoration(labelText: 'Categoria'),
                validator: (v) => v == null || v.isEmpty ? 'Informe a categoria' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descricaoController,
                decoration: const InputDecoration(labelText: 'Descrição'),
                validator: (v) => v == null || v.isEmpty ? 'Informe a descrição' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _quantidadeEstoqueController,
                decoration: const InputDecoration(labelText: 'Quantidade em Estoque'),
                keyboardType: TextInputType.number,
                validator: (v) {
                  if (v == null || v.isEmpty) return 'Informe a quantidade';
                  if (int.tryParse(v) == null) return 'Quantidade inválida';
                  return null;
                },
              ),

              const SizedBox(height: 24),
              const Text('Insumos necessários', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              ...insumosSelecionados.asMap().entries.map((entry) {
                final i = entry.key;
                final item = entry.value;
                return LayoutBuilder(
                  builder: (context, constraints) {
                    final isSmall = constraints.maxWidth < 600;

                    if (isSmall) {
                      // Layout empilhado para telas pequenas
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          DropdownButtonFormField<Insumo>(
                            value: item['insumo'],
                            items: todosInsumos.map((insumo) {
                              return DropdownMenuItem(
                                value: insumo,
                                child: Text(insumo.nome),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                item['insumo'] = value;
                              });
                            },
                            validator: (v) => v == null ? 'Selecione um insumo' : null,
                            decoration: const InputDecoration(labelText: 'Insumo'),
                          ),
                          const SizedBox(height: 8),
                          TextFormField(
                            initialValue: item['quantia'],
                            decoration: const InputDecoration(labelText: 'Quantia'),
                            keyboardType: TextInputType.number,
                            onChanged: (value) => item['quantia'] = value,
                            validator: (v) {
                              if (v == null || v.isEmpty) return 'Informe a quantidade';
                              if (double.tryParse(v) == null) return 'Quantidade inválida';
                              return null;
                            },
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () => removerInsumo(i),
                            ),
                          ),
                          const Divider(),
                        ],
                      );
                    } else {
                      // Layout em linha para telas maiores
                      return Row(
                        children: [
                          Expanded(
                            flex: 4,
                            child: DropdownButtonFormField<Insumo>(
                              value: item['insumo'],
                              items: todosInsumos.map((insumo) {
                                return DropdownMenuItem(
                                  value: insumo,
                                  child: Text(insumo.nome),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  item['insumo'] = value;
                                });
                              },
                              validator: (v) => v == null ? 'Selecione um insumo' : null,
                              decoration: const InputDecoration(labelText: 'Insumo'),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            flex: 3,
                            child: TextFormField(
                              initialValue: item['quantia'],
                              decoration: const InputDecoration(labelText: 'Quantia'),
                              keyboardType: TextInputType.number,
                              onChanged: (value) => item['quantia'] = value,
                              validator: (v) {
                                if (v == null || v.isEmpty) return 'Informe a quantidade';
                                if (double.tryParse(v) == null) return 'Quantidade inválida';
                                return null;
                              },
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () => removerInsumo(i),
                          ),
                        ],
                      );
                    }
                  },
                );
              }),
              TextButton.icon(
                onPressed: adicionarInsumo,
                icon: const Icon(Icons.add),
                label: const Text('Adicionar Insumo'),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: salvarProduto,
                child: const Text('Salvar Produto'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

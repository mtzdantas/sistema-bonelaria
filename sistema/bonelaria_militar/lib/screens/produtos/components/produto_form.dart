import 'package:flutter/material.dart';
import 'package:bonelaria_militar/models/insumo.dart';
import 'package:bonelaria_militar/models/produto.dart';
import 'package:bonelaria_militar/services/produto_insumo_service.dart';
import 'package:bonelaria_militar/services/insumo_service.dart';

typedef ProdutoSubmitCallback = Future<void> Function({
  required String nome,
  required String categoria,
  required String descricao,
  required int quantidadeEstoque,
  required List<InsumoSelecionado> insumos,
});

class InsumoSelecionado {
  Insumo? insumo;
  String quantia;
  TextEditingController controller;

  InsumoSelecionado({this.insumo, this.quantia = ''})
      : controller = TextEditingController(text: quantia);
}

class ProdutoForm extends StatefulWidget {
  final Produto? produto;
  final ProdutoSubmitCallback onSubmit;

  const ProdutoForm({super.key, this.produto, required this.onSubmit});

  @override
  State<ProdutoForm> createState() => _ProdutoFormState();
}

class _ProdutoFormState extends State<ProdutoForm> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _categoriaController = TextEditingController();
  final _descricaoController = TextEditingController();
  final _quantidadeEstoqueController = TextEditingController();

  List<Insumo> todosInsumos = [];
  List<InsumoSelecionado> insumosSelecionados = [];

  @override
  void initState() {
    super.initState();
    carregarInsumos().then((_) {
      if (widget.produto != null) carregarProduto(widget.produto!);
    });
  }

  Future<void> carregarInsumos() async {
    final insumos = await carregarTodosInsumos();
    setState(() {
      todosInsumos = insumos;
    });
  }

  void carregarProduto(Produto produto) async {
    _nomeController.text = produto.nome;
    _categoriaController.text = produto.categoria;
    _descricaoController.text = produto.descricao;
    _quantidadeEstoqueController.text = produto.quantidadeEstoque.toString();

    final produtoComInsumos = await carregarProdutoComInsumos(produto.idProduto);

    if (produtoComInsumos == null) return;

    final relacionados = produtoComInsumos.insumosComQuantia.map((item) {
      final insumo = item['insumo'] as Insumo;
      final quantia = item['quantia'].toString();

      return InsumoSelecionado(
        insumo: todosInsumos.firstWhere((i) => i.idInsumo == insumo.idInsumo),
        quantia: quantia,
      );
    }).toList();

    setState(() {
      insumosSelecionados = relacionados;
    });
  }

  void adicionarInsumo() {
    setState(() {
      insumosSelecionados.add(InsumoSelecionado());
    });
  }

  void removerInsumo(int index) {
    setState(() {
      insumosSelecionados[index].controller.dispose(); // libera o controller
      insumosSelecionados.removeAt(index);
    });
  }

  void submit() {
    if (_formKey.currentState?.validate() != true) return;

    for (var item in insumosSelecionados) {
      item.quantia = item.controller.text.trim();
    }

    widget.onSubmit(
      nome: _nomeController.text.trim(),
      categoria: _categoriaController.text.trim(),
      descricao: _descricaoController.text.trim(),
      quantidadeEstoque: int.tryParse(_quantidadeEstoqueController.text.trim()) ?? 0,
      insumos: insumosSelecionados,
    );
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _categoriaController.dispose();
    _descricaoController.dispose();
    _quantidadeEstoqueController.dispose();
    for (var item in insumosSelecionados) {
      item.controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
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

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DropdownButtonFormField<Insumo>(
                  value: item.insumo,
                  items: todosInsumos.map((insumo) {
                    return DropdownMenuItem(
                      value: insumo,
                      child: Text(insumo.nome),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      item.insumo = value;
                    });
                  },
                  validator: (v) => v == null ? 'Selecione um insumo' : null,
                  decoration: const InputDecoration(labelText: 'Insumo'),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: item.controller,
                  decoration: const InputDecoration(labelText: 'Quantia'),
                  keyboardType: TextInputType.number,
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
          }),
          TextButton.icon(
            onPressed: adicionarInsumo,
            icon: const Icon(Icons.add),
            label: const Text('Adicionar Insumo'),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: submit,
            child: const Text('Salvar'),
          ),
        ],
      ),
    );
  }
}

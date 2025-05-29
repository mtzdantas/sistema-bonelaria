import 'package:bonelaria_militar/models/produto.dart';
import 'package:flutter/material.dart';
import '../../services/produto_service.dart'; // importando service
import '../produtos/components/produto_form.dart';

class ProdutoEdicaoScreen extends StatelessWidget {
  final Produto produto;

  const ProdutoEdicaoScreen({super.key, required this.produto});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Editar Produto')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ProdutoForm(
          produto: produto,
          onSubmit: ({
            required String nome,
            required String categoria,
            required String descricao,
            required int quantidadeEstoque,
            required List<InsumoSelecionado> insumos,
          }) async {
            await atualizarProduto(
              context: context,
              produto: produto,
              nome: nome,
              categoria: categoria,
              descricao: descricao,
              quantidadeEstoque: quantidadeEstoque,
              insumos: insumos,
            );
          },
        ),
      ),
    );
  }
}

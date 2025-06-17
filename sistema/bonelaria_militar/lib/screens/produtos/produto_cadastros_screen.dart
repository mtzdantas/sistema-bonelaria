import 'package:flutter/material.dart';
import 'package:bonelaria_militar/services/produto_service.dart';
import 'package:bonelaria_militar/screens/produtos/components/produto_form.dart';

class ProdutoCadastroScreen extends StatelessWidget {
  const ProdutoCadastroScreen({super.key});

  Future<void> _handleSubmit({
    required BuildContext context,
    required String nome,
    required String categoria,
    required String descricao,
    required int quantidadeEstoque,
    required List<InsumoSelecionado> insumos,
  }) async {
    final erro = await salvarProduto(
      nome: nome,
      categoria: categoria,
      descricao: descricao,
      quantidadeEstoque: quantidadeEstoque,
      insumos: insumos,
    );

    if (context.mounted) {
      if (erro == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Produto salvo com sucesso')),
        );
        Navigator.of(context).pop();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(erro)),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cadastrar Produto')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ProdutoForm(
          onSubmit: ({
            required nome,
            required categoria,
            required descricao,
            required quantidadeEstoque,
            required insumos,
          }) async {
            await _handleSubmit(
              context: context,
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

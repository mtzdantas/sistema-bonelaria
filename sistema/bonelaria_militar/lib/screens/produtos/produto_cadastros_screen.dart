import 'package:flutter/material.dart';
import 'package:bonelaria_militar/services/produto_service.dart';
import 'package:bonelaria_militar/screens/produtos/components/produto_form.dart';


class ProdutoCadastroScreen extends StatelessWidget {
  const ProdutoCadastroScreen({super.key});

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
            await salvarProduto(
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

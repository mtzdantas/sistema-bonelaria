import 'package:bonelaria_militar/supabase/supabase_client.dart';
import 'package:flutter/material.dart';
import '../../models/produto.dart';
import '../screens/produtos/components/produto_form.dart';

Future<String?> deletarProduto(int idProduto) async {
  // Verifica se o produto está em algum pedido
  final pedidos = await SupabaseConfig.client
      .from('produto_pedido')
      .select('id_produto_pedido')
      .eq('id_produto', idProduto)
      .limit(1);

  if ((pedidos as List).isNotEmpty) {
    return 'Não é possível excluir: existem pedidos com este produto.';
  }

  try {
    await SupabaseConfig.client
        .from('produto_insumo')
        .delete()
        .eq('id_produto', idProduto);

    await SupabaseConfig.client
        .from('produto')
        .delete()
        .eq('id_produto', idProduto);

    return null; // null = sucesso
  } catch (e) {
    return 'Erro ao excluir produto: $e';
  }
}

Future<void> salvarProduto({
  required BuildContext context,
  required String nome,
  required String categoria,
  required String descricao,
  required int quantidadeEstoque,
  required List<InsumoSelecionado> insumos,
}) async {
  try {
    final response = await SupabaseConfig.client
        .from('produto')
        .insert({
          'nome': nome,
          'categoria': categoria,
          'descricao': descricao,
          'quantidade_estoque': quantidadeEstoque,
        })
        .select('id_produto')
        .single();

    final idProduto = response['id_produto'];

    final dadosInsumos = insumos
        .where((i) => i.insumo != null)
        .map((i) => {
              'id_produto': idProduto,
              'id_insumo': i.insumo!.idInsumo,
              'quantia_insumo': double.parse(i.quantia),
            })
        .toList();

    if (dadosInsumos.isNotEmpty) {
      await SupabaseConfig.client.from('produto_insumo').insert(dadosInsumos);
    }

    if (!context.mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Produto salvo com sucesso')),
    );

    Navigator.of(context).pop();
  } catch (e) {
    debugPrint('Erro ao salvar produto: $e');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Erro ao salvar produto: $e')),
    );
  }
}

Future<void> atualizarProduto({
  required BuildContext context,
  required Produto produto,
  required String nome,
  required String categoria,
  required String descricao,
  required int quantidadeEstoque,
  required List<InsumoSelecionado> insumos,
}) async {
  try {
    await SupabaseConfig.client
        .from('produto')
        .update({
          'nome': nome,
          'categoria': categoria,
          'descricao': descricao,
          'quantidade_estoque': quantidadeEstoque,
        })
        .eq('id_produto', produto.idProduto);

    await SupabaseConfig.client
        .from('produto_insumo')
        .delete()
        .eq('id_produto', produto.idProduto);

    final dadosInsumos = insumos
        .where((i) => i.insumo != null)
        .map((i) => {
              'id_produto': produto.idProduto,
              'id_insumo': i.insumo!.idInsumo,
              'quantia_insumo': double.parse(i.quantia),
            })
        .toList();

    if (dadosInsumos.isNotEmpty) {
      await SupabaseConfig.client.from('produto_insumo').insert(dadosInsumos);
    }

    if (!context.mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Produto atualizado com sucesso')),
    );

    Navigator.of(context).pop();
  } catch (e) {
    debugPrint('Erro ao atualizar produto: $e');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Erro ao atualizar produto: $e')),
    );
  }
}
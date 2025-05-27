import '../supabase/supabase_client.dart';

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
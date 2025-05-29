import 'package:bonelaria_militar/models/produto_pedido.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProdutoPedidoService {
  static Future<List<ProdutoPedido>> buscarProdutosDoPedido(int idPedido) async {
    final response = await Supabase.instance.client
      .from('produto_pedido')
      .select('''
        quantidade_produto,
        valor_produto,
        produto(nome)
      ''')
      .eq('id_pedido', idPedido);

    return (response as List)
        .map((item) => ProdutoPedido.fromMap(item))
        .toList();
  }
}

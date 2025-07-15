import 'package:bonelaria_militar/models/pedidos.dart';
import 'package:bonelaria_militar/supabase/supabase_client.dart';
import 'package:bonelaria_militar/models/produto_pedido.dart';

class PedidoService {
  static Future<List<Pedido>> buscarPedidos() async {
  final response = await SupabaseConfig.client
    .from('pedido')
    .select('id_pedido, status_pedido, id_costureira, data, id_conta_a_pagar, funcionario(nome)');

  return (response as List).map((p) => Pedido.fromMap(p)).toList();
  }


  static Future<List<Pedido>> buscarPedidosPorConta(int idContaAPagar) async {
    final response = await SupabaseConfig.client
      .from('pedido')
      .select('*, funcionario(nome)')
      .eq('id_conta_a_pagar', idContaAPagar);

    return (response as List).map((p) => Pedido.fromMap(p)).toList();
  }

  static Future<List<Pedido>> buscarFinalizadosSemConta(int idCostureira) async {
    final response = await SupabaseConfig.client
        .from('pedido')
        .select('*, funcionario(nome)')
        .eq('id_costureira', idCostureira)   // confirme o nome da coluna no banco
        .eq('status_pedido', 'Finalizado')
        .filter('id_conta_a_pagar', 'is', null);  // busca onde é null

    return (response as List).map((p) => Pedido.fromMap(p)).toList();
  }

  static Future<double> calcularValorTotalPedidos(List<Pedido> pedidos) async {
    double total = 0;

    for (final pedido in pedidos) {
      final produtos = await buscarProdutosPorPedido(pedido.id);
      for (final produto in produtos) {
        total += produto.quantidade * produto.valor;
      }
    }

    return total;
  }

  static Future<List<ProdutoPedido>> buscarProdutosPorPedido(int idPedido) async {
    final response = await SupabaseConfig.client
        .from('produto_pedido')
        .select('quantidade_produto, valor_produto, produto(nome)')
        .eq('id_pedido', idPedido);

    return (response as List)
        .map((item) => ProdutoPedido.fromMap(item))
        .toList();
  }

  Future<String?> deletarPedido(int idPedido) async {
    try {
      final pedidoResponse = await SupabaseConfig.client
          .from('pedido')
          .select('id_conta_a_pagar')
          .eq('id_pedido', idPedido)
          .single(); 

      if (pedidoResponse['id_conta_a_pagar'] != null) {
        return 'Não é possível excluir: este pedido já está associado a uma conta a pagar.';
      }

      await SupabaseConfig.client
          .from('produto_pedido')
          .delete()
          .eq('id_pedido', idPedido);

      await SupabaseConfig.client
          .from('pedido')
          .delete()
          .eq('id_pedido', idPedido);

      return null; 

    } catch (e) {
      return 'Erro ao excluir pedido: $e';
    }
  }
}

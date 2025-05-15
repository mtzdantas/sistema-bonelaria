import '../supabase/supabase_client.dart';
import '../models/pedidos.dart';

class PedidoService {
  static Future<List<Pedido>> buscarPedidos() async {
    final response = await SupabaseConfig.client
      .from('pedido')
      .select('''
        *,
        funcionario(nome)
      ''');
    
    return (response as List).map((p) => Pedido.fromMap(p)).toList();
  }
}

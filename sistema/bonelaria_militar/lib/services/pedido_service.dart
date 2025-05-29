import 'package:bonelaria_militar/models/pedidos.dart';
import 'package:bonelaria_militar/supabase/supabase_client.dart';

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

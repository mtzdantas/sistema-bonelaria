import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/conta_a_pagar.dart';
import '../models/pedidos.dart';

class ContaService {
  static final _supabase = Supabase.instance.client;

  static Future<List<ContaAPagar>> buscarContasPendentes() async {
    final response = await _supabase
        .from('conta_a_pagar')
        .select()
        .eq('status_pagamento', 'Pendente')
        .order('data_vencimento', ascending: true);

    return (response as List)
        .map((e) => ContaAPagar.fromMap(e))
        .toList();
  }

  static Future<void> gerarContaParaPedidos(List<Pedido> pedidos, double valorTotal) async {
    final vencimento = DateTime.now().add(const Duration(days: 7));
    final insert = await _supabase
        .from('conta_a_pagar')
        .insert({
          'valor': valorTotal,
          'data_vencimento': vencimento.toIso8601String(),
          'status_pagamento': 'Pendente',
        })
        .select()
        .single();

    final idConta = insert['id_conta_a_pagar'];

    for (final pedido in pedidos) {
      await _supabase
          .from('pedido')
          .update({'id_conta_a_pagar': idConta})
          .eq('id_pedido', pedido.id); // CORRIGIDO
    }
  }
}

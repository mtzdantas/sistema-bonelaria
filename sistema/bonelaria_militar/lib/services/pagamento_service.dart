import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/pagamento.dart';

class PagamentoService {
  static final _supabase = Supabase.instance.client;

  static Future<List<Pagamento>> buscarPagamentos() async {
    final response = await _supabase.from('pagamento').select();
    return (response as List)
        .map((e) => Pagamento.fromMap(e))
        .toList();
  }

  static Future<void> registrarPagamento(
      int idConta, double valor, String forma) async {
    await _supabase.from('pagamento').insert({
      'id_conta_a_pagar': idConta,
      'valor_pagamento': valor,
      'forma_pagamento': forma,
    });

    await _supabase
        .from('conta_a_pagar')
        .update({'status_pagamento': 'Pago'})
        .eq('id_conta_a_pagar', idConta);
  }
}

import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/funcionario.dart';

class CostureiraService {
  static final _supabase = Supabase.instance.client;

  /// Supondo que o id_funcao das costureiras seja um valor fixo (ex: 2).
  static const int idFuncaoCostureira = 2;

  static Future<List<Funcionario>> buscarTodas() async {
    final response = await _supabase
        .from('funcionario')
        .select()
        .eq('id_funcao', idFuncaoCostureira);

    return (response as List)
        .map((e) => Funcionario.fromMapWithEndereco(e))
        .toList();
  }
}

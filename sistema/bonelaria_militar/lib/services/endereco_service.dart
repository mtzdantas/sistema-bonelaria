import 'package:bonelaria_militar/supabase/supabase_client.dart';

class EnderecoService {
  static final _client = SupabaseConfig.client;

  static Future<int> inserirEndereco({
    required String rua,
    required String bairro,
    required String numero,
    required String complemento,
  }) async {
    final response = await _client.from('endereco').insert({
      'rua': rua,
      'bairro': bairro,
      'numero': numero,
      'complemento': complemento,
    }).select().single();

    if (response['id_endereco'] == null) {
      throw Exception('Erro ao obter ID do endereço inserido');
    }

    return response['id_endereco'] as int;
  }
}

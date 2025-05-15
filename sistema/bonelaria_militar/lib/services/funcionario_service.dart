import '../supabase/supabase_client.dart';

class FuncionarioService {
  static final _client = SupabaseConfig.client;

  static Future<void> inserirFuncionario({
    required String nome,
    required String cpf,
    required String telefone,
    required String email,
    required int idEndereco,
    required String authUserId,
  }) async {
    final response = await _client.from('funcionario').insert({
      'nome': nome,
      'cpf': cpf,
      'telefone': telefone,
      'email': email,
      'id_endereco': idEndereco,
      'auth_user_id': authUserId,
      'piso_salarial': 0, // Apenas para preencher tabela
      'salario': 0, // Apenas para preencher tabela 
      'id_funcao': 2, // Apenas para preencher tabela
    });

    if (response != null && response.error != null) {
      throw Exception('Erro ao inserir funcionário: ${response.error!.message}');
    }
  }
}

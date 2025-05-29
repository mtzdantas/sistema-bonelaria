import 'package:bonelaria_militar/supabase/supabase_client.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  static final SupabaseClient _client = SupabaseConfig.client;

  Future<AuthResponse> login(String email, String password) async {
    return await _client.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  static Future<String?> cadastrarUsuario({
    required String email,
    required String senha,
  }) async {
    try {
      final response = await _client.auth.admin.createUser(
        AdminUserAttributes(
          email: email,
          password: senha,
          emailConfirm: true,
        ),
      );

      final userId = response.user?.id;
      if (userId == null) {
        throw Exception('Erro ao obter o ID do usuário');
      }

      return userId;
    } catch (e) {
      throw Exception('Erro ao criar usuário: $e');
    }
  }
}
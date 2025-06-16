import 'package:bonelaria_militar/models/insumo.dart';
import 'package:bonelaria_militar/supabase/supabase_client.dart';

Future<List<Insumo>> carregarTodosInsumos() async {
  final response = await SupabaseConfig.client.from('insumos').select();

  return (response as List).map((e) => Insumo.fromMap(e)).toList();
}

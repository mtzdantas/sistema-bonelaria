import 'package:bonelaria_militar/supabase/supabase_client.dart';
import 'package:bonelaria_militar/models/produto_insumo.dart';
import 'package:bonelaria_militar/models/produto.dart';

class ProdutoComInsumos {
  final Produto produto;
  final List<Map<String, dynamic>> insumosComQuantia;

  ProdutoComInsumos({
    required this.produto,
    required this.insumosComQuantia,
  });
}

Future<List<ProdutoComInsumos>> carregarProdutosComInsumos() async {
  final response = await SupabaseConfig.client
      .from('produto_insumo')
      .select('''
        *,
        produto(*),
        insumo:insumos(*)
      ''');

  final rawList = response as List;
  final agrupados = <int, ProdutoComInsumos>{};

  for (var item in rawList) {
    final produtoInsumo = ProdutoInsumo.fromMapWithRelations(item);

    final produtoId = produtoInsumo.idProduto;

    final insumoComQuantia = {
      'insumo': produtoInsumo.insumo!,
      'quantia': produtoInsumo.quantiaInsumo,
    };

    if (agrupados.containsKey(produtoId)) {
      agrupados[produtoId]!.insumosComQuantia.add(insumoComQuantia);
    } else {
      agrupados[produtoId] = ProdutoComInsumos(
        produto: produtoInsumo.produto!,
        insumosComQuantia: [insumoComQuantia],
      );
    }
  }

  return agrupados.values.toList();
}

Future<ProdutoComInsumos?> carregarProdutoComInsumos(int idProduto) async {
  final response = await SupabaseConfig.client
      .from('produto_insumo')
      .select('*, produto(*), insumo:insumos(*)')
      .eq('id_produto', idProduto);

  final rawList = response as List;
  if (rawList.isEmpty) return null;

  final agrupado = <int, ProdutoComInsumos>{};

  for (var item in rawList) {
    final produtoInsumo = ProdutoInsumo.fromMapWithRelations(item);
    final insumoComQuantia = {
      'insumo': produtoInsumo.insumo!,
      'quantia': produtoInsumo.quantiaInsumo,
    };

    if (agrupado.containsKey(idProduto)) {
      agrupado[idProduto]!.insumosComQuantia.add(insumoComQuantia);
    } else {
      agrupado[idProduto] = ProdutoComInsumos(
        produto: produtoInsumo.produto!,
        insumosComQuantia: [insumoComQuantia],
      );
    }
  }

  return agrupado[idProduto];
}

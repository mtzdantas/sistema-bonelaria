import 'package:bonelaria_militar/models/insumo.dart';
import 'package:bonelaria_militar/services/produto_insumo_service.dart';
import 'package:bonelaria_militar/screens/produtos/produto_editar_screen.dart';
import 'package:bonelaria_militar/services/produto_service.dart';
import 'package:flutter/material.dart';

class ProdutoCard extends StatelessWidget {
  final ProdutoComInsumos item;
  final VoidCallback onProdutoAlterado;

  const ProdutoCard({
    super.key,
    required this.item,
    required this.onProdutoAlterado,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      elevation: 3,
      child: ExpansionTile(
        title: Text(
          item.produto.nome,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text('Categoria: ${item.produto.categoria}'),
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 8, 16, 4),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Insumos necessários:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          ...item.insumosComQuantia.map((iq) {
            final insumo = iq['insumo'] as Insumo;
            final quantia = iq['quantia'];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ListTile(
                dense: true,
                contentPadding: const EdgeInsets.only(left: 8),
                title: Text(insumo.nome),
                subtitle: Text('Tipo: ${insumo.tipoDeInsumo} | Quantia: $quantia'),
              ),
            );
          }),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton.icon(
                  onPressed: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProdutoEdicaoScreen(produto: item.produto),
                      ),
                    );
                    onProdutoAlterado();
                  },
                  icon: const Icon(Icons.edit, color: Colors.blue),
                  label: const Text('Editar Produto'),
                ),
                const SizedBox(width: 8),
                TextButton.icon(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  label: const Text('Excluir Produto'),
                  onPressed: () async {
                    final confirma = await showDialog<bool>(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: const Text('Confirmar exclusão'),
                        content: Text('Excluir o produto "${item.produto.nome}"?'),
                        actions: [
                          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancelar')),
                          TextButton(onPressed: () => Navigator.pop(context, true), child: const Text('Excluir')),
                        ],
                      ),
                    );

                    if (confirma != true) return;

                    final mensagemErro = await deletarProduto(item.produto.idProduto);

                    if (!context.mounted) return;

                    if (mensagemErro != null) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(mensagemErro)));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Produto excluído com sucesso.')));
                      onProdutoAlterado();
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

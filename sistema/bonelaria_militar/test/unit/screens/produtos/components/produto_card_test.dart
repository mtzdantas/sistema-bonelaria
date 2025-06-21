import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bonelaria_militar/models/insumo.dart';
import 'package:bonelaria_militar/models/produto.dart';
import 'package:bonelaria_militar/screens/produtos/components/produto_card.dart';
import 'package:bonelaria_militar/services/produto_insumo_service.dart';

void main() {
  group('ProdutoCard Widget', () {
    testWidgets('exibe nome, categoria e insumos', (WidgetTester tester) async {
      final produto = Produto(
        idProduto: 1,
        nome: 'Produto Teste',
        categoria: 'Categoria A',
        descricao: '',
        quantidadeEstoque: 10,
      );

      final insumo = Insumo(
        idInsumo: 1,
        nome: 'Insumo Teste',
        tipoDeInsumo: 'Tipo X',
        quantidadeEstoque: 10,
      );

      final item = ProdutoComInsumos(
        produto: produto,
        insumosComQuantia: [
          {'insumo': insumo, 'quantia': 5},
        ],
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ProdutoCard(
              item: item,
              onProdutoAlterado: () {},
              onEditar: () {},
            ),
          ),
        ),
      );

      expect(find.text('Produto Teste'), findsOneWidget);
      expect(find.text('Categoria: Categoria A'), findsOneWidget);

      await tester.tap(find.byType(ExpansionTile));
      await tester.pumpAndSettle();

      expect(find.text('Insumo Teste'), findsOneWidget);
      expect(find.textContaining('Tipo: Tipo X'), findsOneWidget);
      expect(find.textContaining('Quantia: 5'), findsOneWidget);
    });

    testWidgets('botão editar é clicável (sem navegação)', (WidgetTester tester) async {
      final produto = Produto(
        idProduto: 1,
        nome: 'Produto Teste',
        categoria: 'Categoria A',
        descricao: '',
        quantidadeEstoque: 10,
      );

      final item = ProdutoComInsumos(produto: produto, insumosComQuantia: []);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ProdutoCard(
              item: item,
              onProdutoAlterado: () {},
              onEditar: () {
                // Callback vazio, não faz nada (para evitar navegação)
              },
            ),
          ),
        ),
      );

      // Expande o ExpansionTile para mostrar o botão de editar
      await tester.tap(find.byType(ExpansionTile));
      await tester.pumpAndSettle();

      // Agora tenta clicar no botão editar
      final editarFinder = find.byIcon(Icons.edit);
      expect(editarFinder, findsOneWidget); // garante que encontrou o botão

      await tester.tap(editarFinder);
      await tester.pumpAndSettle();
    });


    testWidgets('ao clicar em excluir, mostra o AlertDialog', (WidgetTester tester) async {
      final produto = Produto(
        idProduto: 1,
        nome: 'Produto Teste',
        categoria: 'Categoria A',
        descricao: '',
        quantidadeEstoque: 10,
      );

      final item = ProdutoComInsumos(produto: produto, insumosComQuantia: []);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ProdutoCard(
              item: item,
              onProdutoAlterado: () {},
            ),
          ),
        ),
      );

      await tester.tap(find.byType(ExpansionTile));
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.delete), findsOneWidget);

      await tester.tap(find.byIcon(Icons.delete));
      await tester.pumpAndSettle();

      expect(find.text('Confirmar exclusão'), findsOneWidget);
      expect(find.textContaining('Excluir o produto "Produto Teste"?'), findsOneWidget);
    });
  });
}

import 'package:bonelaria_militar/screens/funcionarios/funcionarios.dart';
import 'package:bonelaria_militar/screens/pedidos/pedidos.dart';
import 'package:bonelaria_militar/screens/produtos/produtos.dart';
import 'package:bonelaria_militar/screens/relatorios/relatorios.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    FuncScreen(),
    PedScreen(),
    ProdScreen(),
    RelScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Symbols.person_add),
            label: 'Funcionários',
          ),
          BottomNavigationBarItem(
            icon: Icon(Symbols.splitscreen_add),
            label: 'Pedidos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Symbols.outgoing_mail),
            label: 'Produtos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Symbols.search_insights),
            label: 'Relatórios',
          ),
        ],
      ),
    );
  }
}
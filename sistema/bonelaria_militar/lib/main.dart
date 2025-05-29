import 'package:bonelaria_militar/auth/views/login.dart';
import 'package:bonelaria_militar/screens/funcionarios/funcionarios.dart';
import 'package:bonelaria_militar/screens/pedidos/pedidos.dart';
import 'package:bonelaria_militar/screens/produtos/produtos.dart';
import 'package:bonelaria_militar/screens/relatorios/relatorios.dart';
import 'package:bonelaria_militar/supabase/supabase_client.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SupabaseConfig.init();

  runApp(const MyApp());
}
 
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override 
  Widget build(BuildContext context) { 
    return MaterialApp(
      title: 'Bonelaria Militar',
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginScreen(),
        '/funcionarios': (context) => const FuncScreen(),
        '/pedidos': (context) => const PedScreen(),
        '/produtos': (context) => const ProdScreen(),
        '/relatorios': (context) => const RelScreen(),
      },
    );
  }   
}

import 'package:flutter/material.dart';
import 'navigation/main_nav.dart';
import 'supabase/supabase_client.dart';
import 'auth/views/login.dart';
import 'screens/funcionarios/funcionarios.dart';
import 'screens/pedidos/pedidos.dart';
import 'screens/produtos/produtos.dart';
import 'screens/relatorios/relatorios.dart';

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
        '/login': (context) => LoginScreen(),
        '/funcionarios': (context) => FuncScreen(),
        '/pedidos': (context) => PedScreen(),
        '/produtos': (context) => ProdScreen(),
        '/relatorios': (context) => RelScreen(),
      },
    );
  }   
}

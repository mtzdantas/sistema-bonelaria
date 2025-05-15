import 'package:flutter/material.dart';
import 'auth/views/tela_login.dart';


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sistema de Confecção',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/login',
      routes: {
        '/login': (_) => const LoginScreen(),
        // Adicione mais rotas conforme forem implementadas
      },
    );
  }
}

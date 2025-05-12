import 'package:flutter/material.dart';
import 'navigation/main_nav.dart';
import 'supabase/supabase_client.dart';

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
      home: const MainNavigation(),
    );
  }   
}

import 'package:flutter/material.dart';
import '../../widgets/app_bar.dart';

class PedScreen extends StatelessWidget {
  const PedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      
      body: Center(
        child: Text('Pedidos'),
      )
    );;
  }
}

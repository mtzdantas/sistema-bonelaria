import 'package:flutter/material.dart';
import '../../utils/app_bar.dart';

class PedScreen extends StatelessWidget {
  const PedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: const CustomAppBar(),
      
      body: Center(
        child: Text('Pedidos'),
      )
    );;
  }
}

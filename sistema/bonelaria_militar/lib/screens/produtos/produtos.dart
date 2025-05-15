import 'package:flutter/material.dart';
import '../../utils/app_bar.dart';

class ProdScreen extends StatelessWidget {
  const ProdScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      
      body: Center(
        child: Text('Produtos'),
      )
    );
  }
}

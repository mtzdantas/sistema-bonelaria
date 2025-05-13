import 'package:flutter/material.dart';
import '../../utils/app_bar.dart';

class RelScreen extends StatelessWidget {
  const RelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      
      body: Center(
        child: Text('Relatórios'),
      )
    );
  }
}

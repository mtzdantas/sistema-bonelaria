import 'package:bonelaria_militar/utils/app_bar.dart';
import 'package:flutter/material.dart';

class RelScreen extends StatelessWidget {
  const RelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: const CustomAppBar(),
      
      body: const Center(
        child: const Text('Relatórios'),
      )
    );
  }
}

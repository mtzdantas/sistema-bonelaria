import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Row(
        children: const [
          Image(
            image: AssetImage('assets/logo.png'),
            width: 45,
            height: 45,
          ),
        ], 
      ),
      actions: [
        TextButton.icon(
          onPressed: () {
            // Implementar o logout do Supabase
            // Ver sobre: Supabase.instance.client.auth.signOut(); 
            // Navigator.pushReplacementNamed(context, '/login');
          },
          icon: const Icon(Icons.logout, color: Colors.white),
          label: const Text(
            'Sair',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
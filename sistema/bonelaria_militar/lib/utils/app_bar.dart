import 'package:flutter/material.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: const Row(
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
          onPressed: () async {
            await Supabase.instance.client.auth.signOut();

            if (!context.mounted) return;

            await Navigator.pushReplacementNamed(context, '/login');
          },
          icon: const Icon(Symbols.logout, color: Colors.white),
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
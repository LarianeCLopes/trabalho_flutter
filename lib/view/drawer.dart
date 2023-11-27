import 'package:flutter/material.dart';
import 'feriados.dart';

class NavDrawer extends StatelessWidget {
  const NavDrawer({super.key});

  void _navigateToFeriados(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Feriados()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            child: Center(
              child: Text(
                'Menu',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Cursos'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: const Icon(Icons.school),
            title: const Text('Professores'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: const Icon(Icons.calendar_today),
            title: const Text('Feriados'),
            onTap: () => _navigateToFeriados(context),
          ),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text('Logout'),
            onTap: () => {Navigator.of(context).pop()},
          ),
        ],
      ),
    );
  }
}

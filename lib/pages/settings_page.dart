import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/theme_notifier.dart';
import '../services/auth_service.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = AuthService; // apenas para referência
    final theme = context.watch<ThemeNotifier>();

    return Scaffold(
      appBar: AppBar(title: const Text('Configurações')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text('Usuario', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          FutureBuilder(
            future: AuthService.init(),
            builder: (_, snap) {
              if (snap.connectionState != ConnectionState.done) {
                return const CircularProgressIndicator();
              }
              final a = snap.data as AuthService;
              return ListTile(
                title: Text(a.email ?? 'Não logado'),
                subtitle: const Text('E-mail'),
                trailing: ElevatedButton(
                  onPressed: () async {
                    await a.logout();
                    if (Navigator.canPop(context)) {
                      Navigator.popUntil(context, ModalRoute.withName('/login'));
                    }
                    Navigator.pushNamedAndRemoveUntil(context, '/login', (_) => false);
                  },
                  child: const Text('Sair'),
                ),
              );
            },
          ),
          const Divider(),
          const Text('Tema', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: [
              for (final c in [
                Colors.deepPurple,
                Colors.indigo,
                Colors.blue,
                Colors.teal,
                Colors.green,
                Colors.orange,
                Colors.pink,
                Colors.red,
              ])
                GestureDetector(
                  onTap: () => context.read<ThemeNotifier>().setPrimaryColor(c),
                  child: Container(
                    width: 36, height: 36,
                    decoration: BoxDecoration(
                      color: c,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: theme.primaryColor == c ? Colors.black : Colors.white, width: 2,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

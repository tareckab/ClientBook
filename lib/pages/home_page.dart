import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Inicio')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ListTile(
            title: const Text('Clientes'),
            subtitle: const Text('Listar clientes , adicionar um novo cliente , atualizar um cliente e remover um cliente'),
            trailing: const Icon(Icons.content_paste_search_outlined),
            onTap: () => Navigator.pushNamed(context, '/items'),
          ),
          ListTile(
            title: const Text('Configurações'),
            subtitle: const Text('Usuário e cor primária do app'),
            trailing: const Icon(Icons.settings),
            onTap: () => Navigator.pushNamed(context, '/settings'),
          ),
          ListTile(
            title: const Text('Mapa (UPF)'),
            trailing: const Icon(Icons.map_outlined),
            onTap: () => Navigator.pushNamed(context, '/maps'),
          ),
          ListTile(
            title: const Text('Sobre'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Navigator.pushNamed(context, '/about'),
          ),
          
        ],
      ),
    );
  }
}

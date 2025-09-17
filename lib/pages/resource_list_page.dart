import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/user.dart';

class ResourceListPage extends StatefulWidget {
  const ResourceListPage({super.key});

  @override
  State<ResourceListPage> createState() => _ResourceListPageState();
}

class _ResourceListPageState extends State<ResourceListPage> {
  late Future<List<User>> _future;

  @override
  void initState() {
    super.initState();
    _future = _load();
  }

// Carregar Lista
  Future<List<User>> _load() async {
    final raw = await ApiService.listUsersRaw();
    return raw.map((m) => User.fromMap(m)).toList();
  }

  Future<void> _refresh() async {
    setState(() => _future = _load());
  }
// Remover Cliente
  Future<void> _confirmDelete(User u) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Remover cliente'),

      // menu para confirmar se é mesmo pra excluir

        content: Text('Tem certeza que deseja remover "${u.name}"?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancelar')),
          FilledButton(onPressed: () => Navigator.pop(context, true), child: const Text('Remover')),
        ],
      ),
    );
    if (ok == true) {
      await ApiService.deleteUser(u.id);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Cliente "${u.name}" removido.')),
      );
      _refresh();
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lista de Clientes')),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final created = await Navigator.pushNamed(context, '/item_form');
          if (created == true) _refresh();
        },
        child: const Icon(Icons.add),
      ),
      body: FutureBuilder<List<User>>(
        future: _future,
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}'));
          }
          final users = snapshot.data ?? [];
          if (users.isEmpty) return const Center(child: Text('Nenhum cliente.'));

          return RefreshIndicator(
            onRefresh: _refresh,
            child: ListView.separated(
              itemCount: users.length,
              separatorBuilder: (_, __) => const Divider(height: 1),
              itemBuilder: (_, i) {
                final u = users[i];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: u.avatar.isNotEmpty ? NetworkImage(u.avatar) : null,
                    child: u.avatar.isEmpty ? Text(u.name.isNotEmpty ? u.name[0] : '?') : null,
                  ),
                  title: Text(u.name),
                  subtitle: Text('${u.city}, ${u.country}'),
                  trailing: Wrap(spacing: 4, children: [
                    IconButton(
                      tooltip: 'Editar',
                      icon: const Icon(Icons.edit_outlined),
                      onPressed: () async {
                        final updated = await Navigator.pushNamed(
                          context, '/item_form',
                          arguments: u,
                        );
                        if (updated == true) _refresh();
                      },
                    ),
                    IconButton(
                      tooltip: 'Remover',
                      icon: const Icon(Icons.delete_outline),
                      onPressed: () => _confirmDelete(u),
                    ),
                  ]),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

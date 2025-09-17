import 'package:flutter/material.dart';
import '../models/user.dart';
import '../services/api_service.dart';

class UserFormPage extends StatefulWidget {
  const UserFormPage({super.key});

  @override
  State<UserFormPage> createState() => _UserFormPageState();
}

class _UserFormPageState extends State<UserFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _avatar = TextEditingController();
  final _country = TextEditingController();
  final _city = TextEditingController();

  User? _editing; // null = criando
  bool _loading = false;
  bool _init = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_init) return;
    _init = true;
    final arg = ModalRoute.of(context)!.settings.arguments;
    if (arg is User) {
      _editing = arg;
      _name.text = arg.name;
      _avatar.text = arg.avatar;
      _country.text = arg.country;
      _city.text = arg.city;
    }
  }

  @override
  void dispose() {
    _name.dispose();
    _avatar.dispose();
    _country.dispose();
    _city.dispose();
    super.dispose();
  }

  Future<void> _onSave() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _loading = true);
    try {
      final body = {
        'name': _name.text.trim(),
        'avatar': _avatar.text.trim(),
        'country': _country.text.trim(),
        'city': _city.text.trim(),
      };

      if (_editing == null) {
        await ApiService.createUser(body);
      } else {
        await ApiService.updateUser(_editing!.id, body);
      }
      if (!mounted) return;
      Navigator.pop(context, true); // sinaliza sucesso para recarregar a lista
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Erro: $e')));
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = _editing != null;
    return Scaffold(
      appBar: AppBar(title: Text(isEdit ? 'Editar cliente' : 'Novo cliente')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _name,
                decoration: const InputDecoration(
                  labelText: 'Nome', border: OutlineInputBorder()),
                validator: (v) =>
                    (v == null || v.trim().isEmpty) ? 'Informe o nome' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _avatar,
                decoration: const InputDecoration(
                  labelText: 'URL do avatar (opcional)',
                  border: OutlineInputBorder()),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _country,
                decoration: const InputDecoration(
                  labelText: 'País', border: OutlineInputBorder()),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _city,
                decoration: const InputDecoration(
                  labelText: 'Cidade', border: OutlineInputBorder()),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _loading ? null : _onSave,
                  child: _loading
                      ? const SizedBox(
                          width: 18, height: 18,
                          child: CircularProgressIndicator(strokeWidth: 2))
                      : Text(isEdit ? 'Salvar alterações' : 'Cadastrar'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

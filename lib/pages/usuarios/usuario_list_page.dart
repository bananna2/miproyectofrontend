// lib/pages/usuarios/usuario_list_page.dart
import 'package:flutter/material.dart';
import '../../models/usuario.dart';
import '../../services/usuario_api_service.dart';
import 'nuevo_usuario_page.dart';
import 'editar_usuario_page.dart';

class UsuarioListPage extends StatefulWidget {
  const UsuarioListPage({super.key});
  @override
  State<UsuarioListPage> createState() => _UsuarioListPageState();
}

class _UsuarioListPageState extends State<UsuarioListPage> {
  final _svc = UsuarioApiService();
  late Future<List<Usuario>> _fut;

  @override
  void initState() {
    super.initState();
    _refresh();
  }

  void _refresh() {
    setState(() {
      _fut = _svc.fetchUsuarios();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Usuario>>(
        future: _fut,
        builder: (ctx, snap) {
          if (snap.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snap.hasError) {
            return Center(child: Text('Error: ${snap.error}'));
          }
          final list = snap.data!;
          return ListView.builder(
            itemCount: list.length,
            itemBuilder: (_, i) => ListTile(
              title: Text(list[i].nombre),
              subtitle: Text(list[i].email),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => EditarUsuarioPage(usuario: list[i]),
                ),
              ).then((_) => _refresh()),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const NuevoUsuarioPage()),
        ).then((_) => _refresh()),
      ),
    );
  }
}

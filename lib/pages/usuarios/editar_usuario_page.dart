// lib/pages/usuarios/editar_usuario_page.dart
import 'package:flutter/material.dart';
import '../../models/usuario.dart';
import '../../services/usuario_api_service.dart';

class EditarUsuarioPage extends StatefulWidget {
  final Usuario usuario;
  const EditarUsuarioPage({super.key, required this.usuario});
  @override
  State<EditarUsuarioPage> createState() => _EditarUsuarioPageState();
}

class _EditarUsuarioPageState extends State<EditarUsuarioPage> {
  late TextEditingController _nombreCtrl;
  late TextEditingController _emailCtrl;
  late TextEditingController _passCtrl;
  final _svc = UsuarioApiService();

  @override
  void initState() {
    super.initState();
    _nombreCtrl = TextEditingController(text: widget.usuario.nombre);
    _emailCtrl = TextEditingController(text: widget.usuario.email);
    _passCtrl = TextEditingController(text: widget.usuario.contrasena);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Editar Usuario')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: _nombreCtrl, decoration: const InputDecoration(labelText: 'Nombre')),
            TextField(controller: _emailCtrl, decoration: const InputDecoration(labelText: 'Email')),
            TextField(controller: _passCtrl, decoration: const InputDecoration(labelText: 'Contraseña'), obscureText: true),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () async {
                final u = Usuario(
                  id: widget.usuario.id,
                  nombre: _nombreCtrl.text,
                  email: _emailCtrl.text,
                  contrasena: _passCtrl.text,
                );
                await _svc.actualizarUsuario(u);
                Navigator.pop(context);
              },
              child: const Text('Guardar'),
            ),
            TextButton(
              onPressed: () async {
                await _svc.eliminarUsuario(widget.usuario.id!);
                Navigator.pop(context);
              },
              child: const Text('Eliminar', style: TextStyle(color: Colors.red)),
            ),
          ],
        ),
      ),
    );
  }
}

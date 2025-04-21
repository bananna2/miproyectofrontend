// lib/pages/usuarios/nuevo_usuario_page.dart
import 'package:flutter/material.dart';
import '../../models/usuario.dart';
import '../../services/usuario_api_service.dart';

class NuevoUsuarioPage extends StatefulWidget {
  const NuevoUsuarioPage({super.key});
  @override
  State<NuevoUsuarioPage> createState() => _NuevoUsuarioPageState();
}

class _NuevoUsuarioPageState extends State<NuevoUsuarioPage> {
  final _nombreCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  final _svc = UsuarioApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nuevo Usuario')),
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
                await _svc.crearUsuario(Usuario(
                  nombre: _nombreCtrl.text,
                  email: _emailCtrl.text,
                  contrasena: _passCtrl.text,
                ));
                Navigator.pop(context);
              },
              child: const Text('Crear'),
            )
          ],
        ),
      ),
    );
  }
}

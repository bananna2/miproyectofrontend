// lib/pages/cuentas/nueva_cuenta_page.dart
import 'package:flutter/material.dart';
import '../../models/cuenta.dart';
import '../../services/cuenta_api_service.dart';

class NuevaCuentaPage extends StatefulWidget {
  const NuevaCuentaPage({super.key});
  @override
  State<NuevaCuentaPage> createState() => _NuevaCuentaPageState();
}

class _NuevaCuentaPageState extends State<NuevaCuentaPage> {
  final _numCtrl = TextEditingController();
  final _tipoCtrl = TextEditingController();
  final _svc = CuentaApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nueva Cuenta')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: _numCtrl, decoration: const InputDecoration(labelText: 'Número')),
            TextField(controller: _tipoCtrl, decoration: const InputDecoration(labelText: 'Tipo')),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () async {
                await _svc.crearCuenta(Cuenta(
                  numeroCuenta: _numCtrl.text,
                  saldo: 0.0,
                  tipoCuenta: _tipoCtrl.text,
                  usuarioId: 'usuario-id-por-defecto',
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

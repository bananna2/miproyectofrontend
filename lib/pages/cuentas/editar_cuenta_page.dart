// lib/pages/cuentas/editar_cuenta_page.dart
import 'package:flutter/material.dart';
import '../../models/cuenta.dart';
import '../../services/cuenta_api_service.dart';

class EditarCuentaPage extends StatefulWidget {
  final Cuenta cuenta;
  const EditarCuentaPage({super.key, required this.cuenta});
  @override
  State<EditarCuentaPage> createState() => _EditarCuentaPageState();
}

class _EditarCuentaPageState extends State<EditarCuentaPage> {
  late TextEditingController _saldoCtrl;
  final _svc = CuentaApiService();

  @override
  void initState() {
    super.initState();
    _saldoCtrl = TextEditingController(text: widget.cuenta.saldo.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Editar Cuenta')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text('Nro: ${widget.cuenta.numeroCuenta}'),
            TextField(controller: _saldoCtrl, decoration: const InputDecoration(labelText: 'Saldo')),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () async {
                final c = widget.cuenta;
                final updated = Cuenta(
                  id: c.id,
                  numeroCuenta: c.numeroCuenta,
                  saldo: double.parse(_saldoCtrl.text),
                  tipoCuenta: c.tipoCuenta,
                  usuarioId: c.usuarioId,
                );
                await _svc.actualizarCuenta(updated);
                Navigator.pop(context);
              },
              child: const Text('Guardar'),
            ),
            TextButton(
              onPressed: () async {
                await _svc.eliminarCuenta(widget.cuenta.id!);
                Navigator.pop(context);
              },
              child: const Text('Eliminar', style: TextStyle(color: Colors.red)),
            )
          ],
        ),
      ),
    );
  }
}

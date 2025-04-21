// lib/pages/cuentas/cuenta_list_page.dart
import 'package:flutter/material.dart';
import '../../models/cuenta.dart';
import '../../services/cuenta_api_service.dart';
import 'nueva_cuenta_page.dart';
import 'editar_cuenta_page.dart';

class CuentaListPage extends StatefulWidget {
  const CuentaListPage({super.key});
  @override
  State<CuentaListPage> createState() => _CuentaListPageState();
}

class _CuentaListPageState extends State<CuentaListPage> {
  final _svc = CuentaApiService();
  late Future<List<Cuenta>> _fut;

  @override
  void initState() {
    super.initState();
    _refresh();
  }

  void _refresh() {
    setState(() {
      _fut = _svc.fetchCuentas();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Cuenta>>(
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
              title: Text(list[i].numeroCuenta),
              subtitle: Text('Saldo: ${list[i].saldo}'),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => EditarCuentaPage(cuenta: list[i]),
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
          MaterialPageRoute(builder: (_) => const NuevaCuentaPage()),
        ).then((_) => _refresh()),
      ),
    );
  }
}

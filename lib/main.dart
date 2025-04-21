// lib/main.dart
import 'package:flutter/material.dart';
import 'pages/cuentas/cuenta_list_page.dart';
import 'pages/usuarios/usuario_list_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gestión Usuarios & Cuentas',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Gestión Usuarios & Cuentas'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Cuentas'),
              Tab(text: 'Usuarios'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            CuentaListPage(),
            UsuarioListPage(),
          ],
        ),
      ),
    );
  }
}

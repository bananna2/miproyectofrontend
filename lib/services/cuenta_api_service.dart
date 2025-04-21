// lib/services/cuenta_api_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/cuenta.dart';

class CuentaApiService {
  static const _base = 'http://10.0.2.2:8081';

  Future<List<Cuenta>> fetchCuentas() async {
    final res = await http.get(Uri.parse('$_base/api/cuentas/all'));
    if (res.statusCode == 200) {
      final List data = json.decode(res.body);
      return data.map((e) => Cuenta.fromJson(e)).toList();
    }
    throw Exception('Error al obtener cuentas ${res.statusCode}');
  }

  Future<Cuenta> crearCuenta(Cuenta c) async {
    final res = await http.post(
      Uri.parse('$_base/api/cuentas'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(c.toJson()),
    );
    if (res.statusCode == 200) {
      return Cuenta.fromJson(json.decode(res.body));
    }
    throw Exception('Error al crear cuenta ${res.statusCode}');
  }

  Future<Cuenta> actualizarCuenta(Cuenta c) async {
    final res = await http.put(
      Uri.parse('$_base/api/cuentas/${c.id}'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(c.toJson()),
    );
    if (res.statusCode == 200) {
      return Cuenta.fromJson(json.decode(res.body));
    }
    throw Exception('Error al actualizar cuenta ${res.statusCode}');
  }

  Future<void> eliminarCuenta(String id) async {
    final res = await http.delete(Uri.parse('$_base/api/cuentas/$id'));
    if (res.statusCode != 204) {
      throw Exception('Error al eliminar cuenta ${res.statusCode}');
    }
  }
}

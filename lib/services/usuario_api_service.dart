// lib/services/usuario_api_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/usuario.dart';

class UsuarioApiService {
  static const _base = 'http://10.0.2.2:8080';

  Future<List<Usuario>> fetchUsuarios() async {
    final res = await http.get(Uri.parse('$_base/api/usuarios/all'));
    if (res.statusCode == 200) {
      final List data = json.decode(res.body);
      return data.map((e) => Usuario.fromJson(e)).toList();
    }
    throw Exception('Error al obtener usuarios ${res.statusCode}');
  }

  Future<Usuario> crearUsuario(Usuario u) async {
    final res = await http.post(
      Uri.parse('$_base/api/usuarios'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(u.toJson()),
    );
    if (res.statusCode == 200) {
      return Usuario.fromJson(json.decode(res.body));
    }
    throw Exception('Error al crear usuario ${res.statusCode}');
  }

  Future<Usuario> actualizarUsuario(Usuario u) async {
    final res = await http.put(
      Uri.parse('$_base/api/usuarios/${u.id}'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(u.toJson()),
    );
    if (res.statusCode == 200) {
      return Usuario.fromJson(json.decode(res.body));
    }
    throw Exception('Error al actualizar usuario ${res.statusCode}');
  }

  Future<void> eliminarUsuario(String id) async {
    final res = await http.delete(Uri.parse('$_base/api/usuarios/$id'));
    if (res.statusCode != 204) {
      throw Exception('Error al eliminar usuario ${res.statusCode}');
    }
  }
}

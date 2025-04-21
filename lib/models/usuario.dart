// lib/models/usuario.dart
class Usuario {
  final String? id;
  final String nombre;
  final String email;
  final String contrasena;

  Usuario({
    this.id,
    required this.nombre,
    required this.email,
    required this.contrasena,
  });

  factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
    id: json['id'] as String?,
    nombre: json['nombre'],
    email: json['email'],
    contrasena: json['contrasena'],
  );

  Map<String, dynamic> toJson() => {
    if (id != null) 'id': id,
    'nombre': nombre,
    'email': email,
    'contrasena': contrasena,
  };
}


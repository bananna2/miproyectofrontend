// lib/models/cuenta.dart
class Cuenta {
  final String? id;
  final String numeroCuenta;
  final double saldo;
  final String tipoCuenta;
  final String usuarioId;

  Cuenta({
    this.id,
    required this.numeroCuenta,
    required this.saldo,
    required this.tipoCuenta,
    required this.usuarioId,
  });

  factory Cuenta.fromJson(Map<String, dynamic> json) => Cuenta(
    id: json['id'] as String?,
    numeroCuenta: json['numeroCuenta'],
    saldo: (json['saldo'] as num).toDouble(),
    tipoCuenta: json['tipoCuenta'],
    usuarioId: json['usuarioId'],
  );

  Map<String, dynamic> toJson() => {
    if (id != null) 'id': id,
    'numeroCuenta': numeroCuenta,
    'saldo': saldo,
    'tipoCuenta': tipoCuenta,
    'usuarioId': usuarioId,
  };
}

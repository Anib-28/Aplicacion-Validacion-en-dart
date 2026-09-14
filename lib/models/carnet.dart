import 'estudiante.dart';

class Carnet {
  final bool valido;
  final String mensaje;
  final int idCarnet;
  final String codigoCarnet;
  final String codigoQR;
  final DateTime fechaEmision;
  final DateTime fechaExpiracion;
  final String estado;
  final Estudiante? estudiante;

  Carnet({
    required this.valido,
    required this.mensaje,
    required this.idCarnet,
    required this.codigoCarnet,
    required this.codigoQR,
    required this.fechaEmision,
    required this.fechaExpiracion,
    required this.estado,
    this.estudiante,
  });

  factory Carnet.fromJson(Map<String, dynamic> json) {
    return Carnet(
      valido: json['valido'],
      mensaje: json['mensaje'],
      idCarnet: json['idCarnet'],
      codigoCarnet: json['codigoCarnet'],
      codigoQR: json['codigoQR'],
      fechaEmision: DateTime.parse(json['fechaEmision']),
      fechaExpiracion: DateTime.parse(json['fechaExpiracion']),
      estado: json['estado'],
      estudiante: json['estudiante'] != null
          ? Estudiante.fromJson(json['estudiante'])
          : null,
    );
  }
}

class Estudiante {
  final int idEstudiante;
  final String cedula;
  final String nombres;
  final String apellidos;
  final String carrera;
  final int semestre;
  final String? fotoUrl;
  final String estado;

  Estudiante({
    required this.idEstudiante,
    required this.cedula,
    required this.nombres,
    required this.apellidos,
    required this.carrera,
    required this.semestre,
    this.fotoUrl,
    required this.estado,
  });

  factory Estudiante.fromJson(Map<String, dynamic> json) {
    return Estudiante(
      idEstudiante: json['idEstudiante'],
      cedula: json['cedula'],
      nombres: json['nombres'],
      apellidos: json['apellidos'],
      carrera: json['carrera'],
      semestre: json['semestre'],
      fotoUrl: json['fotoUrl'],
      estado: json['estado'],
    );
  }
}

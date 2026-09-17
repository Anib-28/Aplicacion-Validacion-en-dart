import 'package:flutter/material.dart';

import '../models/carnet.dart';

class ResultadoCard extends StatelessWidget {
  final Carnet carnet;
  const ResultadoCard({super.key, required this.carnet});
  @override
  Widget build(BuildContext context) {
    final estudiante = carnet.estudiante;
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Icon(Icons.verified, size: 55),
            const SizedBox(height: 10),
            Text(
              carnet.mensaje,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            if (estudiante != null) ...[
              _fotoEstudiante(estudiante.fotoUrl),
              const SizedBox(height: 15),
              Text(
                '${estudiante.nombres} ${estudiante.apellidos}',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              const Divider(),
              const SizedBox(height: 10),
              _dato(Icons.badge, 'Cédula', estudiante.cedula),
              _dato(Icons.school, 'Carrera', estudiante.carrera),
              _dato(
                Icons.menu_book,
                'Semestre',
                estudiante.semestre.toString(),
              ),
              _dato(Icons.credit_card, 'Código de carnet', carnet.codigoCarnet),
              _dato(Icons.qr_code, 'Código QR', carnet.codigoQR),
              _dato(Icons.info, 'Estado', carnet.estado),
            ],
          ],
        ),
      ),
    );
  }

  Widget _fotoEstudiante(String? fotoUrl) {
    if (fotoUrl == null || fotoUrl.isEmpty) {
      return const CircleAvatar(
        radius: 60,
        child: Icon(Icons.person, size: 60),
      );
    }
    return ClipOval(
      child: Image.network(
        fotoUrl,
        width: 120,
        height: 120,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return const CircleAvatar(
            radius: 60,
            child: Icon(Icons.person, size: 60),
          );
        },
      ),
    );
  }

  Widget _dato(IconData icono, String titulo, String valor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icono, size: 22),
          const SizedBox(width: 10),
          Text('$titulo:', style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(width: 5),
          Expanded(child: Text(valor)),
        ],
      ),
    );
  }
}

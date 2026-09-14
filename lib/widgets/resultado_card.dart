import 'package:flutter/material.dart';

import '../models/carnet.dart';

class ResultadoCard extends StatelessWidget {
  final Carnet carnet;

  const ResultadoCard({super.key, required this.carnet});

  @override
  Widget build(BuildContext context) {
    final estudiante = carnet.estudiante;

    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Icon(Icons.verified, size: 60),

            const SizedBox(height: 10),

            Text(
              carnet.mensaje,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),

            const Divider(height: 30),

            if (estudiante != null) ...[
              if (estudiante.fotoUrl != null && estudiante.fotoUrl!.isNotEmpty)
                ClipRRect(
                  borderRadius: BorderRadius.circular(60),
                  child: Image.network(
                    estudiante.fotoUrl!,
                    width: 120,
                    height: 120,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(Icons.person, size: 100);
                    },
                  ),
                )
              else
                const Icon(Icons.person, size: 100),

              const SizedBox(height: 20),

              Text(
                '${estudiante.nombres} ${estudiante.apellidos}',
                style: const TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 15),

              _dato('Cédula', estudiante.cedula),

              _dato('Carrera', estudiante.carrera),

              _dato('Semestre', estudiante.semestre.toString()),

              _dato('Código de carnet', carnet.codigoCarnet),

              _dato('Código QR', carnet.codigoQR),

              _dato('Estado', carnet.estado),
            ],
          ],
        ),
      ),
    );
  }

  Widget _dato(String titulo, String valor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$titulo: ',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Expanded(child: Text(valor)),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../models/carnet.dart';
import '../widgets/resultado_card.dart';
import 'digital_carnet_screen.dart';

class ResultScreen extends StatelessWidget {
  final Carnet carnet;

  const ResultScreen({super.key, required this.carnet});

  // ============================================================
  // COLORES
  // ============================================================

  static const Color azul = Color(0xFF062B63);
  static const Color rojo = Color(0xFFE30613);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),

      // ========================================================
      // APP BAR
      // ========================================================
      appBar: AppBar(
        backgroundColor: azul,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,

        title: const Text(
          'Resultado',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),

      // ========================================================
      // CONTENIDO
      // ========================================================
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [
            // ==================================================
            // RESULTADO
            // ==================================================

            ResultadoCard(carnet: carnet),

            const SizedBox(height: 20),

            // ==================================================
            // VER CARNET DIGITAL
            // ==================================================
            SizedBox(
              width: double.infinity,
              height: 56,

              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DigitalCarnetScreen(carnet: carnet),
                    ),
                  );
                },

                style: ElevatedButton.styleFrom(
                  backgroundColor: azul,
                  foregroundColor: Colors.white,
                  elevation: 2,

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),

                icon: const Icon(Icons.badge_rounded, size: 26),

                label: const Text(
                  'Ver carnet digital',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
              ),
            ),

            const SizedBox(height: 14),

            // ==================================================
            // ESCANEAR OTRO
            // ==================================================
            SizedBox(
              width: double.infinity,
              height: 52,

              child: OutlinedButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                },

                style: OutlinedButton.styleFrom(
                  foregroundColor: azul,

                  side: const BorderSide(color: azul, width: 2),

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),

                icon: const Icon(Icons.qr_code_scanner_rounded),

                label: const Text(
                  'Escanear otro carnet',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // ==================================================
            // MENSAJE
            // ==================================================
            Container(
              width: double.infinity,

              padding: const EdgeInsets.all(15),

              decoration: BoxDecoration(
                color: Colors.white,

                borderRadius: BorderRadius.circular(15),

                border: Border.all(color: const Color(0xFFE0E4E9)),
              ),

              child: Row(
                children: [
                  const Icon(
                    Icons.verified_user_rounded,
                    color: azul,
                    size: 25,
                  ),

                  const SizedBox(width: 10),

                  Expanded(
                    child: Text(
                      carnet.valido
                          ? 'El código QR corresponde a un carnet registrado.'
                          : 'No se pudo verificar el carnet.',
                      style: const TextStyle(
                        color: Color(0xFF555555),
                        fontSize: 13,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

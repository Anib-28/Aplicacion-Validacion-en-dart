import 'package:flutter/material.dart';

import 'scanner_screen.dart';
import 'test_qr_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // ============================================================
  // COLORES DE LA APLICACIÓN
  // ============================================================

  static const Color azul = Color(0xFF062B63);
  static const Color azulClaro = Color(0xFF123F7A);
  static const Color rojo = Color(0xFFE30613);
  static const Color fondo = Color(0xFFF5F7FA);
  static const Color grisTexto = Color(0xFF5D6570);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: fondo,

      // ========================================================
      // APP BAR
      // ========================================================
      appBar: AppBar(
        backgroundColor: azul,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,

        title: const Text(
          'Carnet Estudiantil',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),

      // ========================================================
      // CONTENIDO
      // ========================================================
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 25, 20, 30),

          child: Column(
            children: [
              // ==================================================
              // ENCABEZADO
              // ==================================================

              _encabezado(),

              const SizedBox(height: 35),

              // ==================================================
              // DESCRIPCIÓN
              // ==================================================
              const Text(
                'Verificación de autenticidad',
                textAlign: TextAlign.center,

                style: TextStyle(
                  color: azul,
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                ),
              ),

              const SizedBox(height: 12),

              const Text(
                'Verifica de manera rápida y segura la '
                'autenticidad de un carnet estudiantil '
                'mediante su código QR.',
                textAlign: TextAlign.center,

                style: TextStyle(color: grisTexto, fontSize: 16, height: 1.5),
              ),

              const SizedBox(height: 35),

              // ==================================================
              // BOTÓN ESCANEAR
              // ==================================================
              _botonEscanear(context),

              const SizedBox(height: 15),

              // ==================================================
              // BOTÓN PRUEBA MANUAL
              // ==================================================
              _botonManual(context),

              const SizedBox(height: 35),

              // ==================================================
              // TARJETA INFORMATIVA
              // ==================================================
              _tarjetaInformativa(),

              const SizedBox(height: 25),

              // ==================================================
              // PIE
              // ==================================================
              const Text(
                'Sistema de verificación de carnets estudiantiles',
                textAlign: TextAlign.center,

                style: TextStyle(color: grisTexto, fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ============================================================
  // ENCABEZADO
  // ============================================================

  Widget _encabezado() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 20),

      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [azul, azulClaro],
        ),

        borderRadius: BorderRadius.circular(24),

        boxShadow: [
          BoxShadow(
            color: azul.withValues(alpha: 0.20),
            blurRadius: 15,
            offset: const Offset(0, 7),
          ),
        ],
      ),

      child: Column(
        children: [
          // ÍCONO
          Container(
            width: 92,
            height: 92,

            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,

              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.15),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),

            child: const Icon(Icons.badge_rounded, color: azul, size: 55),
          ),

          const SizedBox(height: 20),

          const Text(
            'CARNET ESTUDIANTIL',
            textAlign: TextAlign.center,

            style: TextStyle(
              color: Colors.white,
              fontSize: 23,
              fontWeight: FontWeight.w800,
              letterSpacing: 1,
            ),
          ),

          const SizedBox(height: 10),

          Container(
            width: 100,
            height: 4,

            decoration: BoxDecoration(
              color: rojo,
              borderRadius: BorderRadius.circular(10),
            ),
          ),

          const SizedBox(height: 12),

          const Text(
            'Sistema de verificación',
            textAlign: TextAlign.center,

            style: TextStyle(
              color: Colors.white70,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // BOTÓN ESCANEAR
  // ============================================================

  Widget _botonEscanear(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 58,

      child: ElevatedButton.icon(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ScannerScreen()),
          );
        },

        style: ElevatedButton.styleFrom(
          backgroundColor: azul,
          foregroundColor: Colors.white,

          elevation: 3,

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),

        icon: const Icon(Icons.qr_code_scanner_rounded, size: 27),

        label: const Text(
          'Escanear código QR',
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  // ============================================================
  // BOTÓN MANUAL
  // ============================================================

  Widget _botonManual(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 58,

      child: OutlinedButton.icon(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const TestQrScreen()),
          );
        },

        style: OutlinedButton.styleFrom(
          foregroundColor: azul,

          side: const BorderSide(color: azul, width: 2),

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),

        icon: const Icon(Icons.search_rounded, size: 25),

        label: const Text(
          'Probar código manualmente',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  // ============================================================
  // TARJETA INFORMATIVA
  // ============================================================

  Widget _tarjetaInformativa() {
    return Container(
      width: double.infinity,

      padding: const EdgeInsets.all(18),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius: BorderRadius.circular(18),

        border: Border.all(color: const Color(0xFFE0E4E9)),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),

      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          // ÍCONO
          Container(
            width: 48,
            height: 48,

            decoration: BoxDecoration(
              color: azul,
              borderRadius: BorderRadius.circular(14),
            ),

            child: const Icon(
              Icons.verified_user_rounded,
              color: Colors.white,
              size: 26,
            ),
          ),

          const SizedBox(width: 14),

          // TEXTO
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Text(
                  'Verificación segura',
                  style: TextStyle(
                    color: azul,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: 5),

                Text(
                  'El sistema comprueba si el código QR '
                  'corresponde a un carnet registrado.',
                  style: TextStyle(color: grisTexto, fontSize: 13, height: 1.4),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

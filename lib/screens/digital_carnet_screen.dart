import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../models/carnet.dart';

class DigitalCarnetScreen extends StatelessWidget {
  final Carnet carnet;

  const DigitalCarnetScreen({super.key, required this.carnet});

  // ============================================================
  // COLORES DEL CARNET
  // ============================================================

  static const Color azul = Color(0xFF062B63);
  static const Color azulClaro = Color(0xFF123F7A);
  static const Color rojo = Color(0xFFE30613);
  static const Color fondo = Color(0xFFF4F6F9);
  static const Color grisTexto = Color(0xFF555555);

  @override
  Widget build(BuildContext context) {
    final estudiante = carnet.estudiante;

    if (estudiante == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Carnet digital')),
        body: const Center(child: Text('No hay información del estudiante')),
      );
    }

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
          'Carnet digital',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),

      // ========================================================
      // CONTENIDO
      // ========================================================
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(14, 18, 14, 25),
          child: Center(child: _carnet(estudiante)),
        ),
      ),
    );
  }

  // ============================================================
  // CARNET COMPLETO
  // ============================================================

  Widget _carnet(dynamic estudiante) {
    return Container(
      width: double.infinity,

      constraints: const BoxConstraints(maxWidth: 430),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.14),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),

      clipBehavior: Clip.antiAlias,

      child: Column(
        children: [
          // ====================================================
          // CABECERA
          // ====================================================

          _cabecera(),

          // ====================================================
          // CONTENIDO PRINCIPAL
          // ====================================================
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 22, 20, 0),

            child: Column(
              children: [
                // FOTO + IDENTIDAD
                _fotoYIdentidad(estudiante),

                const SizedBox(height: 25),

                // NOMBRE
                _nombreEstudiante(estudiante),

                const SizedBox(height: 22),

                // DATOS
                _datosEstudiante(estudiante),

                const SizedBox(height: 12),

                // QR
                _seccionQR(),

                const SizedBox(height: 25),
              ],
            ),
          ),

          // ====================================================
          // DECORACIÓN INFERIOR
          // ====================================================
          _decoracionInferior(),
        ],
      ),
    );
  }

  // ============================================================
  // CABECERA
  // ============================================================

  Widget _cabecera() {
    return Container(
      height: 120,
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [azul, azulClaro, azul],
        ),
      ),

      child: Stack(
        children: [
          // Franja roja superior
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(height: 8, color: rojo),
          ),

          // Contenido de la cabecera
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 5),

                const Text(
                  'UNIVERSIDAD NACIONAL',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 21,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.5,
                  ),
                ),

                const Text(
                  'DE CHIMBORAZO',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 21,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.5,
                  ),
                ),

                const SizedBox(height: 10),

                // Línea roja
                Container(
                  width: 150,
                  height: 3,
                  decoration: BoxDecoration(
                    color: rojo,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),

                const SizedBox(height: 7),

                const Text(
                  'CARNET ESTUDIANTIL',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 2,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // FOTO + IDENTIDAD
  // ============================================================

  Widget _fotoYIdentidad(dynamic estudiante) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ======================================================
        // FOTO
        // ======================================================

        Expanded(
          flex: 5,
          child: AspectRatio(
            aspectRatio: 0.82,

            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFFE9EDF2),

                borderRadius: BorderRadius.circular(18),

                border: Border.all(color: azul, width: 4),

                boxShadow: [
                  BoxShadow(
                    color: azul.withValues(alpha: 0.15),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),

              clipBehavior: Clip.antiAlias,

              child: _foto(estudiante.fotoUrl),
            ),
          ),
        ),

        const SizedBox(width: 14),

        // ======================================================
        // BLOQUE DERECHO
        // ======================================================
        Expanded(
          flex: 5,
          child: Container(
            height: 170,

            decoration: BoxDecoration(
              color: azul,
              borderRadius: BorderRadius.circular(18),
            ),

            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 18),

            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.school_rounded, color: Colors.white, size: 38),

                const SizedBox(height: 10),

                const Text(
                  'ESTUDIANTE',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1,
                  ),
                ),

                const SizedBox(height: 10),

                Container(
                  width: 65,
                  height: 4,
                  decoration: BoxDecoration(
                    color: rojo,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),

                const SizedBox(height: 12),

                const Text(
                  'CARNET\nDIGITAL',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // ============================================================
  // FOTO
  // ============================================================

  Widget _foto(String? fotoUrl) {
    if (fotoUrl == null || fotoUrl.isEmpty) {
      return const Center(child: Icon(Icons.person, size: 95, color: azul));
    }

    return Image.network(
      fotoUrl,
      fit: BoxFit.cover,

      errorBuilder: (context, error, stackTrace) {
        return const Center(child: Icon(Icons.person, size: 95, color: azul));
      },
    );
  }

  // ============================================================
  // NOMBRE DEL ESTUDIANTE
  // ============================================================

  Widget _nombreEstudiante(dynamic estudiante) {
    return Column(
      children: [
        const Text(
          'ESTUDIANTE',
          style: TextStyle(
            color: rojo,
            fontSize: 12,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
          ),
        ),

        const SizedBox(height: 7),

        Text(
          '${estudiante.nombres} ${estudiante.apellidos}',
          textAlign: TextAlign.center,

          style: const TextStyle(
            color: azul,
            fontSize: 24,
            fontWeight: FontWeight.w800,
            height: 1.15,
          ),
        ),

        const SizedBox(height: 10),

        Container(
          width: 90,
          height: 4,

          decoration: BoxDecoration(
            color: rojo,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ],
    );
  }

  // ============================================================
  // DATOS DEL ESTUDIANTE
  // ============================================================

  Widget _datosEstudiante(dynamic estudiante) {
    return Container(
      width: double.infinity,

      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(
        color: const Color(0xFFF7F8FA),
        borderRadius: BorderRadius.circular(18),

        border: Border.all(color: const Color(0xFFE1E5EA)),
      ),

      child: Column(
        children: [
          _filaDato(
            icono: Icons.badge_outlined,
            titulo: 'Cédula',
            valor: estudiante.cedula,
          ),

          _separador(),

          _filaDato(
            icono: Icons.school_outlined,
            titulo: 'Carrera',
            valor: estudiante.carrera,
          ),

          _separador(),

          _filaDato(
            icono: Icons.menu_book_outlined,
            titulo: 'Semestre',
            valor: '${estudiante.semestre}',
          ),

          _separador(),

          _filaDato(
            icono: Icons.credit_card_outlined,
            titulo: 'Código',
            valor: carnet.codigoCarnet,
          ),
        ],
      ),
    );
  }

  // ============================================================
  // FILA DE DATOS
  // ============================================================

  Widget _filaDato({
    required IconData icono,
    required String titulo,
    required String valor,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 42,
          height: 42,

          decoration: BoxDecoration(
            color: azul,
            borderRadius: BorderRadius.circular(12),
          ),

          child: Icon(icono, color: Colors.white, size: 22),
        ),

        const SizedBox(width: 12),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                titulo,
                style: const TextStyle(
                  color: grisTexto,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),

              const SizedBox(height: 3),

              Text(
                valor,
                style: const TextStyle(
                  color: azul,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  height: 1.2,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ============================================================
  // SEPARADOR
  // ============================================================

  Widget _separador() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12),

      height: 1,

      color: const Color(0xFFDDE2E8),
    );
  }

  // ============================================================
  // SECCIÓN QR
  // ============================================================

  Widget _seccionQR() {
    return Column(
      children: [
        const Text(
          'CÓDIGO DE VERIFICACIÓN',
          style: TextStyle(
            color: azul,
            fontSize: 14,
            fontWeight: FontWeight.w800,
            letterSpacing: 1,
          ),
        ),

        const SizedBox(height: 6),

        const Text(
          'Escanea este código para verificar el carnet',
          textAlign: TextAlign.center,
          style: TextStyle(color: grisTexto, fontSize: 12),
        ),

        const SizedBox(height: 15),

        Container(
          padding: const EdgeInsets.all(14),

          decoration: BoxDecoration(
            color: Colors.white,

            borderRadius: BorderRadius.circular(18),

            border: Border.all(color: azul, width: 3),

            boxShadow: [
              BoxShadow(
                color: azul.withValues(alpha: 0.08),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),

          child: QrImageView(
            data: carnet.codigoQR,
            version: QrVersions.auto,
            size: 175,
            backgroundColor: Colors.white,
          ),
        ),

        const SizedBox(height: 10),

        Text(
          carnet.codigoQR,
          style: const TextStyle(
            color: azul,
            fontSize: 13,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
        ),
      ],
    );
  }

  // ============================================================
  // DECORACIÓN INFERIOR
  // ============================================================

  Widget _decoracionInferior() {
    return SizedBox(
      height: 60,

      child: Stack(
        clipBehavior: Clip.hardEdge,

        children: [
          // Azul izquierdo
          Positioned(
            left: -15,
            bottom: -12,

            child: Transform.rotate(
              angle: -0.18,

              child: Container(width: 190, height: 35, color: azul),
            ),
          ),

          // Rojo izquierdo
          Positioned(
            left: -10,
            bottom: 15,

            child: Transform.rotate(
              angle: -0.18,

              child: Container(width: 160, height: 7, color: rojo),
            ),
          ),

          // Azul derecho
          Positioned(
            right: -15,
            bottom: -12,

            child: Transform.rotate(
              angle: 0.18,

              child: Container(width: 190, height: 35, color: azul),
            ),
          ),

          // Rojo derecho
          Positioned(
            right: -10,
            bottom: 15,

            child: Transform.rotate(
              angle: 0.18,

              child: Container(width: 160, height: 7, color: rojo),
            ),
          ),
        ],
      ),
    );
  }
}

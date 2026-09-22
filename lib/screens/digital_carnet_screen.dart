import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../models/carnet.dart';

class DigitalCarnetScreen extends StatelessWidget {
  final Carnet carnet;

  const DigitalCarnetScreen({super.key, required this.carnet});

  // Colores principales del carnet
  static const Color azul = Color(0xFF062B63);
  static const Color rojo = Color(0xFFE30613);
  static const Color fondo = Color(0xFFF7F8FA);

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
      appBar: AppBar(
        backgroundColor: azul,
        foregroundColor: Colors.white,
        title: const Text(
          'Carnet digital',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Center(child: _carnet(estudiante)),
        ),
      ),
    );
  }

  Widget _carnet(dynamic estudiante) {
    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(maxWidth: 430),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          // CABECERA AZUL - ROJO - AZUL
          _cabecera(),

          Padding(
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
            child: Column(
              children: [
                // FOTO + BANNER
                _fotoYBanner(estudiante),

                const SizedBox(height: 28),

                // DATOS
                _dato('${estudiante.nombres} ${estudiante.apellidos}'),

                _dato('C.I. ${estudiante.cedula}'),

                _dato('Código ${carnet.codigoCarnet}'),

                _dato(estudiante.carrera),

                const SizedBox(height: 28),

                // QR
                _codigoQR(),

                const SizedBox(height: 30),
              ],
            ),
          ),

          // DECORACIÓN INFERIOR
          _decoracionInferior(),
        ],
      ),
    );
  }

  Widget _cabecera() {
    return SizedBox(
      height: 95,
      child: Row(
        children: [
          Expanded(child: Container(color: azul)),
          Expanded(child: Container(color: rojo)),
          Expanded(child: Container(color: azul)),
        ],
      ),
    );
  }

  Widget _fotoYBanner(dynamic estudiante) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // FOTO
        Expanded(
          flex: 5,
          child: AspectRatio(
            aspectRatio: 0.82,
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFFE9EDF2),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: azul, width: 4),
              ),
              clipBehavior: Clip.antiAlias,
              child: _foto(estudiante.fotoUrl),
            ),
          ),
        ),

        const SizedBox(width: 14),

        // BANNER
        Expanded(
          flex: 5,
          child: Container(
            height: 155,
            decoration: BoxDecoration(
              color: azul,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 14),
                  child: Text(
                    'CARNET\nESTUDIANTIL',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      height: 1.2,
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                Container(
                  height: 4,
                  margin: const EdgeInsets.symmetric(horizontal: 18),
                  color: rojo,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _foto(String? fotoUrl) {
    if (fotoUrl == null || fotoUrl.isEmpty) {
      return const Center(child: Icon(Icons.person, size: 90, color: azul));
    }

    return Image.network(
      fotoUrl,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return const Center(child: Icon(Icons.person, size: 90, color: azul));
      },
    );
  }

  Widget _dato(String texto) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 18),
      child: Column(
        children: [
          Container(width: double.infinity, height: 2, color: azul),
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              texto,
              style: const TextStyle(
                color: azul,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _codigoQR() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: azul, width: 4),
      ),
      child: QrImageView(
        data: carnet.codigoQR,
        version: QrVersions.auto,
        size: 175,
        backgroundColor: Colors.white,
      ),
    );
  }

  Widget _decoracionInferior() {
    return SizedBox(
      height: 55,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            bottom: 0,
            child: Transform.rotate(
              angle: -0.65,
              child: Container(width: 170, height: 25, color: azul),
            ),
          ),

          Positioned(
            left: 0,
            bottom: 18,
            child: Transform.rotate(
              angle: -0.65,
              child: Container(width: 150, height: 8, color: rojo),
            ),
          ),

          Positioned(
            right: 0,
            bottom: 0,
            child: Transform.rotate(
              angle: 0.65,
              child: Container(width: 170, height: 25, color: azul),
            ),
          ),

          Positioned(
            right: 0,
            bottom: 18,
            child: Transform.rotate(
              angle: 0.65,
              child: Container(width: 150, height: 8, color: rojo),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../models/carnet.dart';
import '../services/api_service.dart';
import 'result_screen.dart';

class ScannerScreen extends StatefulWidget {
  const ScannerScreen({super.key});

  @override
  State<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  final MobileScannerController controller = MobileScannerController();

  final ApiService apiService = ApiService();

  bool codigoDetectado = false;
  bool cargando = false;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future<void> procesarCodigo(String codigo) async {
    if (codigoDetectado || cargando) {
      return;
    }

    setState(() {
      codigoDetectado = true;
      cargando = true;
    });

    try {
      final Carnet? carnet = await apiService.obtenerCarnet(codigo);

      if (!mounted) return;

      if (carnet != null) {
        await Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ResultScreen(carnet: carnet)),
        );
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Carnet no encontrado')));
      }
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error de conexión:\n$e')));
    } finally {
      if (mounted) {
        setState(() {
          cargando = false;
          codigoDetectado = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Escanear código QR'),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          MobileScanner(
            controller: controller,
            onDetect: (capture) {
              final List<Barcode> barcodes = capture.barcodes;

              for (final barcode in barcodes) {
                final String? codigo = barcode.rawValue;

                if (codigo != null && codigo.isNotEmpty) {
                  procesarCodigo(codigo);
                  break;
                }
              }
            },
          ),

          Center(
            child: Container(
              width: 260,
              height: 260,
              decoration: BoxDecoration(
                border: Border.all(width: 3, color: Colors.white),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),

          if (cargando)
            Container(
              color: Colors.black54,
              child: const Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircularProgressIndicator(color: Colors.white),
                    SizedBox(height: 20),
                    Text(
                      'Verificando carnet...',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),

          if (!cargando)
            const Positioned(
              bottom: 60,
              left: 20,
              right: 20,
              child: Text(
                'Coloca el código QR dentro del recuadro',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  shadows: [Shadow(blurRadius: 4, color: Colors.black)],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

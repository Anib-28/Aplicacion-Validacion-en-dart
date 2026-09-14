import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScannerScreen extends StatefulWidget {
  const ScannerScreen({super.key});

  @override
  State<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  final MobileScannerController controller = MobileScannerController();

  bool codigoDetectado = false;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void procesarCodigo(String codigo) {
    if (codigoDetectado) {
      return;
    }

    codigoDetectado = true;

    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Código detectado: $codigo')));

    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          codigoDetectado = false;
        });
      }
    });
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

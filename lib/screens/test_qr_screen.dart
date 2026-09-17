import 'package:flutter/material.dart';

import '../models/carnet.dart';
import '../services/api_service.dart';
import '../widgets/resultado_card.dart';

class TestQrScreen extends StatefulWidget {
  const TestQrScreen({super.key});
  @override
  State<TestQrScreen> createState() => _TestQrScreenState();
}

class _TestQrScreenState extends State<TestQrScreen> {
  final TextEditingController codigoController = TextEditingController();

  final ApiService apiService = ApiService();
  String mensaje = '';
  bool cargando = false;
  Carnet? carnetEncontrado;
  Future<void> consultarCarnet() async {
    final codigo = codigoController.text.trim();
    if (codigo.isEmpty) {
      setState(() {
        mensaje = 'Ingresa un código QR';
        carnetEncontrado = null;
      });
      return;
    }
    setState(() {
      cargando = true;
      mensaje = '';
      carnetEncontrado = null;
    });
    try {
      final Carnet? carnet = await apiService.obtenerCarnet(codigo);
      if (!mounted) return;
      setState(() {
        cargando = false;
        if (carnet != null) {
          carnetEncontrado = carnet;
          mensaje = '';
        } else {
          carnetEncontrado = null;
          mensaje = 'Carnet no encontrado';
        }
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        cargando = false;
        carnetEncontrado = null;
        mensaje = 'Error de conexión:\n$e';
      });
    }
  }

  @override
  void dispose() {
    codigoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Probar carnet'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const SizedBox(height: 30),
            const Icon(Icons.qr_code, size: 80),
            const SizedBox(height: 20),
            const Text(
              'Ingresa el código del QR',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 25),
            TextField(
              controller: codigoController,
              decoration: const InputDecoration(
                labelText: 'Código QR',
                hintText: 'Ejemplo: QR-EST-0001',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: cargando ? null : consultarCarnet,
                child: cargando
                    ? const CircularProgressIndicator()
                    : const Text(
                        'Verificar carnet',
                        style: TextStyle(fontSize: 17),
                      ),
              ),
            ),
            const SizedBox(height: 30),
            if (carnetEncontrado != null)
              ResultadoCard(carnet: carnetEncontrado!)
            else
              Text(
                mensaje,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16),
              ),
          ],
        ),
      ),
    );
  }
}

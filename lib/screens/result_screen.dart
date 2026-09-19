import 'package:flutter/material.dart';

import '../models/carnet.dart';
import '../widgets/resultado_card.dart';

class ResultScreen extends StatelessWidget {
  final Carnet carnet;
  const ResultScreen({super.key, required this.carnet});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Resultado'), centerTitle: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            ResultadoCard(carnet: carnet),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.qr_code_scanner),
                label: const Text(
                  'Escanear otro carnet',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

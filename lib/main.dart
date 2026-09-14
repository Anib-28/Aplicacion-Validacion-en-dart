import 'dart:io';

import 'screens/home_screen.dart';

import 'package:flutter/material.dart';

import 'models/carnet.dart';
import 'services/api_service.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    final client = super.createHttpClient(context);

    client.badCertificateCallback = (
      X509Certificate cert,
      String host,
      int port,
    ) => true;

    return client;
  }
}

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(const CarnetEstudiantilApp());
}

class CarnetEstudiantilApp extends StatelessWidget {
  const CarnetEstudiantilApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Carnet Estudiantil',
      home: const HomeScreen(),
    );
  }
}

class PruebaApiScreen extends StatefulWidget {
  const PruebaApiScreen({super.key});
  @override
  State<PruebaApiScreen> createState() => _PruebaApiScreenState();
}

class _PruebaApiScreenState extends State<PruebaApiScreen> {
  final ApiService apiService = ApiService();
  String mensaje = 'Consultando carnet...';
  @override
  void initState() {
    super.initState();
    consultarCarnet();
  }

  Future<void> consultarCarnet() async {
    try {
      final Carnet? carnet = await apiService.obtenerCarnet('QR-EST-0001');
      if (!mounted) return;
      setState(() {
        if (carnet != null) {
          mensaje =
              'Conexión correcta\n\n'
              'Mensaje: ${carnet.mensaje}\n'
              'Carnet: ${carnet.codigoCarnet}\n'
              'Estudiante: ${carnet.estudiante?.nombres} '
              '${carnet.estudiante?.apellidos}\n'
              'Carrera: ${carnet.estudiante?.carrera}';
        } else {
          mensaje = 'Carnet no encontrado';
        }
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        mensaje = 'Error de conexión:\n$e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Prueba de API')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Text(
            mensaje,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }
}

import 'dart:io';

import 'package:flutter/material.dart';

import 'screens/home_screen.dart';
import 'screens/microsoft_login_test_screen.dart';

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
  // Permite utilizar el certificado HTTPS
  // de desarrollo de la API local.
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

      home: const MicrosoftLoginTestScreen(),
    );
  }
}

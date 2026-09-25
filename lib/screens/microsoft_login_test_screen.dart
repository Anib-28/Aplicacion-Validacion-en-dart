import 'package:flutter/material.dart';

import '../services/microsoft_auth_service.dart';
import 'home_screen.dart';

class MicrosoftLoginTestScreen extends StatefulWidget {
  const MicrosoftLoginTestScreen({super.key});

  @override
  State<MicrosoftLoginTestScreen> createState() =>
      _MicrosoftLoginTestScreenState();
}

class _MicrosoftLoginTestScreenState extends State<MicrosoftLoginTestScreen> {
  final MicrosoftAuthService _authService = MicrosoftAuthService();

  bool _cargando = false;
  String _mensaje = 'No has iniciado sesión.';

  Future<void> _iniciarSesion() async {
    setState(() {
      _cargando = true;
      _mensaje = 'Conectando con Microsoft...';
    });

    try {
      await _authService.iniciarSesion();

      if (!mounted) return;

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    } catch (e) {
      if (!mounted) return;

      setState(() {
        _mensaje = 'Error al iniciar sesión:\n\n$e';
        _cargando = false;
      });
    }
  }

  Future<void> _cerrarSesion() async {
    try {
      await _authService.cerrarSesion();

      if (!mounted) return;

      setState(() {
        _mensaje = 'Sesión cerrada correctamente.';
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        _mensaje = 'Error al cerrar sesión:\n\n$e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Prueba Microsoft')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.account_circle, size: 90),

            const SizedBox(height: 24),

            Text(
              _mensaje,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            ),

            const SizedBox(height: 32),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _cargando ? null : _iniciarSesion,
                child: _cargando
                    ? const SizedBox(
                        height: 22,
                        width: 22,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text('Iniciar sesión con Microsoft'),
              ),
            ),

            const SizedBox(height: 12),

            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: _cargando ? null : _cerrarSesion,
                child: const Text('Cerrar sesión'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

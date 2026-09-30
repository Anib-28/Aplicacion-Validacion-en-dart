import 'dart:convert';

import 'package:http/http.dart' as http;

class AppConstants {
  static const String baseUrl = 'https://192.168.100.99:7276';

  static const String appName = 'Carnet Estudiantil';

  static Future<Map<String, dynamic>> login({
    required String correo,
    required String contrasena,
  }) async {
    final url = Uri.parse('$baseUrl/api/Auth/login');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'correo': correo, 'contrasena': contrasena}),
    );

    final data = jsonDecode(response.body);

    if (response.statusCode == 200 ||
        response.statusCode == 401 ||
        response.statusCode == 400) {
      return data;
    }

    throw Exception('Error al iniciar sesión: ${response.statusCode}');
  }
}

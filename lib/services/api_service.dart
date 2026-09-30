import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/carnet.dart';
import '../utils/app_constants.dart';
import 'local_auth_service.dart';

class ApiService {
  final LocalAuthService _authService = LocalAuthService();

  Future<Carnet?> obtenerCarnet(String codigoQR) async {
    final accessToken = await _authService.obtenerToken();

    if (accessToken == null || accessToken.isEmpty) {
      throw Exception('No hay una sesión iniciada.');
    }

    final url = Uri.parse('${AppConstants.baseUrl}/api/Carnets/$codigoQR');

    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return Carnet.fromJson(data);
    }

    if (response.statusCode == 404) {
      return null;
    }

    if (response.statusCode == 401) {
      throw Exception('No autorizado. La sesión no es válida o ha expirado.');
    }

    throw Exception('Error al consultar el carnet: ${response.statusCode}');
  }
}

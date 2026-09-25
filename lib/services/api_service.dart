import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/carnet.dart';
import '../utils/app_constants.dart';
import 'microsoft_auth_service.dart';

class ApiService {
  final MicrosoftAuthService _authService = MicrosoftAuthService();

  Future<Carnet?> obtenerCarnet(String codigoQR) async {
    final accessToken = await _authService.obtenerAccessToken();

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
      throw Exception(
        'No autorizado. El token de acceso no es válido para la API.',
      );
    }

    throw Exception('Error al consultar el carnet: ${response.statusCode}');
  }
}

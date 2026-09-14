import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/carnet.dart';
import '../utils/app_constants.dart';

class ApiService {
  Future<Carnet?> obtenerCarnet(String codigoQR) async {
    final url = Uri.parse('${AppConstants.baseUrl}/api/Carnets/$codigoQR');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return Carnet.fromJson(data);
    }
    if (response.statusCode == 404) {
      return null;
    }
    throw Exception('Error al consultar el carnet: ${response.statusCode}');
  }
}

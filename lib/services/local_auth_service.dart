import 'package:shared_preferences/shared_preferences.dart';

class LocalAuthService {
  static const String _tokenKey = 'jwt_token';
  static const String _idUsuarioKey = 'id_usuario';
  static const String _correoKey = 'correo';
  static const String _rolKey = 'rol';

  Future<void> guardarSesion({
    required String token,
    required int idUsuario,
    required String correo,
    required String rol,
  }) async {
    final preferences = await SharedPreferences.getInstance();

    await preferences.setString(_tokenKey, token);
    await preferences.setInt(_idUsuarioKey, idUsuario);
    await preferences.setString(_correoKey, correo);
    await preferences.setString(_rolKey, rol);
  }

  Future<String?> obtenerToken() async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.getString(_tokenKey);
  }

  Future<int?> obtenerIdUsuario() async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.getInt(_idUsuarioKey);
  }

  Future<String?> obtenerCorreo() async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.getString(_correoKey);
  }

  Future<String?> obtenerRol() async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.getString(_rolKey);
  }

  Future<bool> existeSesion() async {
    final token = await obtenerToken();
    return token != null && token.isNotEmpty;
  }

  Future<void> cerrarSesion() async {
    final preferences = await SharedPreferences.getInstance();

    await preferences.remove(_tokenKey);
    await preferences.remove(_idUsuarioKey);
    await preferences.remove(_correoKey);
    await preferences.remove(_rolKey);
  }
}

import 'package:msal_auth/msal_auth.dart';

class MicrosoftAuthService {
  static final MicrosoftAuthService _instancia =
      MicrosoftAuthService._interno();

  factory MicrosoftAuthService() {
    return _instancia;
  }

  MicrosoftAuthService._interno();

  late final SingleAccountPca _msal;

  bool _inicializado = false;

  String? _accessToken;

  Future<void> inicializar() async {
    if (_inicializado) return;

    _msal = await SingleAccountPca.create(
      clientId: 'ccbd034b-da31-45b0-b4fd-fe0070a20a36',
      androidConfig: AndroidConfig(
        configFilePath: 'assets/msal_config.json',
        redirectUri: 'msauth://com.example.carnet_estudiantil/GYXQd%2FSeqBxcL%2BJtsebg54DZDM8%3D',
      ),
    );

    _inicializado = true;
  }

  Future<Account> iniciarSesion() async {
    await inicializar();

    final resultado = await _msal.acquireToken(
      scopes: const [
        'api://3d8faab6-f893-411a-bc5e-c17bead178c0/access_as_user',
      ],
    );

    _accessToken = resultado.accessToken;

    return resultado.account;
  }

  Future<String> obtenerAccessToken() async {
    await inicializar();

    final resultado = await _msal.acquireTokenSilent(
      scopes: const [
        'api://3d8faab6-f893-411a-bc5e-c17bead178c0/access_as_user',
      ],
      authority: 'https://login.microsoftonline.com/e666de0c-425e-4eac-abda-c579753e95f0',
    );

    _accessToken = resultado.accessToken;

    return _accessToken!;
  }

  Future<void> cerrarSesion() async {
    await inicializar();

    _accessToken = null;

    await _msal.signOut();
  }

  Future<Account> obtenerCuentaActual() async {
    await inicializar();

    return await _msal.currentAccount;
  }
}

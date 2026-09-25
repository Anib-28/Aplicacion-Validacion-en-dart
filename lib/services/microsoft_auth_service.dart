import 'package:msal_auth/msal_auth.dart';

class MicrosoftAuthService {
  late final SingleAccountPca _msal;

  bool _inicializado = false;

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
      scopes: const ['openid', 'profile', 'email'],
    );

    return resultado.account;
  }

  Future<void> cerrarSesion() async {
    await inicializar();

    await _msal.signOut();
  }

  Future<Account> obtenerCuentaActual() async {
    await inicializar();

    return await _msal.currentAccount;
  }
}

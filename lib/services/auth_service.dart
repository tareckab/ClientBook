import 'package:shared_preferences/shared_preferences.dart';


//Criar variavel e validar conta


class AuthService {
  final SharedPreferences _prefs;
  static const _kLoggedKey = 'logged';
  static const _kEmailKey = 'email';
  static const _kPassKey = 'pass';

  AuthService._(this._prefs);

  static Future<AuthService> init() async {
    final prefs = await SharedPreferences.getInstance();
    return AuthService._(prefs);
  }

  bool get isLogged => _prefs.getBool(_kLoggedKey) ?? false;
  String? get email => _prefs.getString(_kEmailKey);

  Future<void> logout() async {
    await _prefs.setBool(_kLoggedKey, false);
  }

  // Registro local simples
  Future<void> register(String email, String pass) async {
    await _prefs.setString(_kEmailKey, email);
    await _prefs.setString(_kPassKey, pass);
  }

  // Autenticação local (verifica contra o que foi salvo)

  // compara as variaveis para verificar se a conta cadastrada bate com o login
  Future<bool> login(String email, String pass) async {
    final savedEmail = _prefs.getString(_kEmailKey);
    final savedPass = _prefs.getString(_kPassKey);
    final ok = savedEmail == email && savedPass == pass;
    await _prefs.setBool(_kLoggedKey, ok);
    return ok;
  }
}
